Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB4AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B4C206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l1lvLll8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgC3Czl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:55:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbgC3Czl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=NhjPp0hAekGuC1qMQCQiEBENS7NjExpXR6hbG7ha91E=; b=l1lvLll8MgZ41EmxSijmHg5b/N
        /F8icc0CCuHzvqbo+GyvQyfk+7lqelwE7fv5PGDungOmB0e/JKJ5kF6k97WGjYs95T6YeWR0cbD8m
        bVTDvStxXLR/TSgVGIbOPJwGPD2G/BhoROH6vu0FBp5mCWbrrYWjAswhTyfjcGCq2x8ptN80UEL7o
        qy+idSxaDYmgZkTyyvyTWgszI8SqvJCP15bBU4R4JsJeeEjaclm3U+rveJjCEkppRR/fxhw4Jdu0g
        mVN1298GVPRBmbmaS+kBxErnhAKlyvbCEhfBj1jDc356vVFDZxZJ7N7UeS1BX6fLISh4X1u7N8Os5
        qbkP4hyQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIkaS-00066h-On; Mon, 30 Mar 2020 02:55:40 +0000
Subject: Re: why does "mem auto-init: clearing system memory may take some
 time..." takes about 14 sec under 5.4.17 but only few msec under 5.5.1?
To:     =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <c7a23250-6b23-2a9e-88c8-924c34fb9139@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a8e02d42-a16a-c665-6a55-1c43818fa48c@infradead.org>
Date:   Sun, 29 Mar 2020 19:55:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c7a23250-6b23-2a9e-88c8-924c34fb9139@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/20 9:52 AM, Toralf Förster wrote:
> I do wonder (and I'm surprised) about increased boot speed according to dmesg for thi9s hardend Gentoo Linux system:
> Linux mr-fox 5.5.1 #1 SMP Sat Feb 1 18:25:21 CET 2020 x86_64 Intel(R) Xeon(R) CPU E5-1650 v3 @ 3.50GHz GenuineIntel GNU/Linux
> 
> Under 5.4.17 I do have usually 14 sec to wait:
> 
> [    0.497171] mem auto-init: stack:byref_all, heap alloc:on, heap free:on
> [    0.497171] mem auto-init: clearing system memory may take some time...
> [    0.501549] Calgary: detecting Calgary via BIOS EBDA area
> [    0.501550] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
> [   14.083235] Memory: 131812972K/134101088K available (12291K kernel code, 1400K rwdata, 1912K rodata, 1272K init, 2040K bss, 2288116K reserved, 0K cma-reserved)
> [   14.083342] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=12, Nodes=1
> [   14.083350] Kernel/User page tables isolation: enabled
> [   14.083403] rcu: Hierarchical RCU implementation.
> [   14.083404] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [   14.083414] NR_IRQS: 4352, nr_irqs: 928, preallocated irqs: 16
> 
> but with 5.5.1 there's no wait?:
> 
> [    0.000000] mem auto-init: stack:byref_all, heap alloc:on, heap free:on
> [    0.000000] mem auto-init: clearing system memory may take some time...
> [    0.000000] Memory: 131812876K/134101088K available (12291K kernel code, 1412K rwdata, 1936K rodata, 1260K init, 2012K bss, 2288212K reserved, 0K cma-reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=12, Nodes=1
> [    0.000000] Kernel/User page tables isolation: enabled
> [    0.000000] rcu: Hierarchical RCU implementation.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [    0.000000] NR_IRQS: 4352, nr_irqs: 928, preallocated irqs: 16
> [    0.000000] random: get_random_bytes called from start_kernel+0x4a8/0x659 with crng_init=0
> 
> Do I miss something? (The kernel config was derived via "make oldconfig").

Hi > Toralf,

Curious/odd.

Do you have the kernel .config files for 5.4.17 and 5.5.1?
Looks like it would have to be a config difference AFAICT.

-- 
~Randy

