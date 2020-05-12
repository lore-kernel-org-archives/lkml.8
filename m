Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5C6C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBF22075E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgELJjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:39:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:43596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgELJjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:39:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4CE94AF8D;
        Tue, 12 May 2020 09:39:03 +0000 (UTC)
To:     Steven Price <steven.price@arm.com>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
From:   Jan Beulich <jbeulich@suse.com>
Subject: your "x86: mm: convert dump_pagetables to use walk_page_range" change
Message-ID: <d573dc7e-e742-84de-473d-f971142fa319@suse.com>
Date:   Tue, 12 May 2020 11:39:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven,

in the description of this change you say:

"The effective permissions are passed down the chain using new fields in
 struct pg_state."

I don't see how this works, and I suppose this part of the change is
(part of) the reason why a W+X warning has magically disappeared in
5.6.x (compared to 5.5.x) when running a 32-bit kernel under Xen.

Quoting the relevant piece of code:

	if (level > 0) {
		new_eff = effective_prot(st->prot_levels[level - 1],
					 new_prot);
	} else {
		new_eff = new_prot;
	}

	if (level >= 0)
		st->prot_levels[level] = new_eff;

The generic framework calls note_page() only for leaf pages or holes
afaics. The protections for a leaf page found at a level other than
the numerically highest one have no meaning at all for a mapping at
a later address mapped with a numerically higher level mapping.
Instead it's the non-leaf page tables for that specific address
which determine the effective protection for any particular mapping.

To take an example, suppose the first present leaf page is found
at level 4. st->prot_levels[] will be all zero at this time, from
which it follows that new_eff will be zero then, too.

I don't think the intended effect can be achieved without either
retaining the original behavior of passing the effective protection
into note_page(), or calling note_page() also for non-leaf pages
(indicating to it which case it is, and adjusting it accordingly).

Am I overlooking something?

Additionally I'd like to note that note_page()'s "unsigned long val"
parameter isn't wide enough for 32-bit PAE PTEs, and hence the NX
flag will always be seen as clear in new_prot in such configs.

Jan
