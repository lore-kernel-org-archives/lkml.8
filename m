Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80A5C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C76D0206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbgELNC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:02:58 -0400
Received: from foss.arm.com ([217.140.110.172]:54684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgELNC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:02:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E887630E;
        Tue, 12 May 2020 06:02:56 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D35A3F71E;
        Tue, 12 May 2020 06:02:56 -0700 (PDT)
Subject: Re: your "x86: mm: convert dump_pagetables to use walk_page_range"
 change
To:     Jan Beulich <jbeulich@suse.com>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <d573dc7e-e742-84de-473d-f971142fa319@suse.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <d95d756d-e940-d81e-d6ca-e45054df72c4@arm.com>
Date:   Tue, 12 May 2020 14:02:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d573dc7e-e742-84de-473d-f971142fa319@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2020 10:39, Jan Beulich wrote:
> Steven,

Hi Jan,

> in the description of this change you say:
> 
> "The effective permissions are passed down the chain using new fields in
>   struct pg_state."
> 
> I don't see how this works, and I suppose this part of the change is
> (part of) the reason why a W+X warning has magically disappeared in
> 5.6.x (compared to 5.5.x) when running a 32-bit kernel under Xen.
> 
> Quoting the relevant piece of code:
> 
> 	if (level > 0) {
> 		new_eff = effective_prot(st->prot_levels[level - 1],
> 					 new_prot);
> 	} else {
> 		new_eff = new_prot;
> 	}
> 
> 	if (level >= 0)
> 		st->prot_levels[level] = new_eff;
> 
> The generic framework calls note_page() only for leaf pages or holes
> afaics. The protections for a leaf page found at a level other than
> the numerically highest one have no meaning at all for a mapping at
> a later address mapped with a numerically higher level mapping.
> Instead it's the non-leaf page tables for that specific address
> which determine the effective protection for any particular mapping.
> 
> To take an example, suppose the first present leaf page is found
> at level 4. st->prot_levels[] will be all zero at this time, from
> which it follows that new_eff will be zero then, too.
> 
> I don't think the intended effect can be achieved without either
> retaining the original behavior of passing the effective protection
> into note_page(), or calling note_page() also for non-leaf pages
> (indicating to it which case it is, and adjusting it accordingly).
> 
> Am I overlooking something?

Sadly I don't think you are - you're reasoning seems correct. It looks 
like the computation of effective permissions will need to be done in 
ptdump.c rather than dump_pagetables.c - as it's only ptdump.c that 
deals with the non-leaf entries as you point out.

> Additionally I'd like to note that note_page()'s "unsigned long val"
> parameter isn't wide enough for 32-bit PAE PTEs, and hence the NX
> flag will always be seen as clear in new_prot in such configs.

Ah, interesting. I'm not sure what type is actually guaranteed to be 
correct. pgprotval_t is x86 specific, but it might be necessary to 
extend it to other architectures. I think I got the "unsigned long" from 
the generic page.h (and because it happens to work on most 
architectures) - but hadn't noticed that that file was specifically only 
for NOMMU architectures.

I'll see if I can come up with fixes, but if you've got anything ready 
already then please jump in.

Steve
