Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204ECC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F416420752
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbgELNJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:09:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:45150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbgELNJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:09:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1F03EAC9F;
        Tue, 12 May 2020 13:09:58 +0000 (UTC)
Subject: Re: your "x86: mm: convert dump_pagetables to use walk_page_range"
 change
To:     Steven Price <steven.price@arm.com>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <d573dc7e-e742-84de-473d-f971142fa319@suse.com>
 <d95d756d-e940-d81e-d6ca-e45054df72c4@arm.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <5167a60e-8264-fc69-fb21-cd7f13592488@suse.com>
Date:   Tue, 12 May 2020 15:09:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d95d756d-e940-d81e-d6ca-e45054df72c4@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.05.2020 15:02, Steven Price wrote:
> On 12/05/2020 10:39, Jan Beulich wrote:
>> Additionally I'd like to note that note_page()'s "unsigned long val"
>> parameter isn't wide enough for 32-bit PAE PTEs, and hence the NX
>> flag will always be seen as clear in new_prot in such configs.
> 
> Ah, interesting. I'm not sure what type is actually guaranteed to be 
> correct. pgprotval_t is x86 specific, but it might be necessary to 
> extend it to other architectures. I think I got the "unsigned long" from 
> the generic page.h (and because it happens to work on most 
> architectures) - but hadn't noticed that that file was specifically only 
> for NOMMU architectures.

Well, it's pteval_t (still x86-specific I guess) unless the call
sites could/would be switched to use pte_flags(). As per
https://lists.xenproject.org/archives/html/xen-devel/2020-05/msg00549.html
the use of pte_val() has another bad effect, but as described
there it might also be Xen specific code which is broken here.

> I'll see if I can come up with fixes, but if you've got anything ready 
> already then please jump in.

No, I don't. I lack the time right now to make a change potentially
affecting multiple architectures.

Jan
