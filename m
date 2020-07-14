Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F149C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 05:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E3C221E7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 05:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594706051;
	bh=PGNl7z3XN8kXFxiyWD/XEmUz1dGjT5aK6XHKZlH/jxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sZopoBZZ9Wfm2l3M9R6sUJ6lmeMm9ZjJ6y2HjGYOzyCR0sGBC4YGTr3fXoQiwpIU4
	 KerU/xnBN+LM+dFV1MBP8ubnyGD8ipuz03e/LYlEcShKgOTjqEEUs2YNgP9FhjfShX
	 v7GNjA34zQPIkgfCR+SKG04EFU4U50DQWYoYiNow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgGNFyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 01:54:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgGNFyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 01:54:09 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 128C221D93;
        Tue, 14 Jul 2020 05:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594706048;
        bh=PGNl7z3XN8kXFxiyWD/XEmUz1dGjT5aK6XHKZlH/jxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GDLAC7iejZJYIToBQQk8NgXwr43j55sW04H3EcqRFhRLXMVLVAU/yqCFrGu/f7mLh
         xKdpTis1BPpszvfyYN0XrVfY/o266JbUcR04tteLejC3Duoxd71SA/cVltIuPdQyCZ
         00T6D3gzbRSaXiqBKxTVsQC+Be5PbiYjCQIt1rDU=
Date:   Mon, 13 Jul 2020 22:54:07 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Nathan Royce <nroycea+kernel@gmail.com>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: F2FS Segmentation Fault
Message-ID: <20200714055407.GA94278@google.com>
References: <CALaQ_hosk7627nTx97+xSSsGiN-qt=pTGNW4DZn4TOcAeRSC8g@mail.gmail.com>
 <20200714000347.GA19314@google.com>
 <CALaQ_hriyvF8yaSihvGEN1U2jufCQ5sj=aknN+1xB=4EbkBWaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALaQ_hriyvF8yaSihvGEN1U2jufCQ5sj=aknN+1xB=4EbkBWaQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13, Nathan Royce wrote:
> On Mon, Jul 13, 2020 at 7:03 PM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > Hi Nathan,
> >
> > Could you try to say "N" here to move forward to fix the corrupted metadata?
> >
> > Thanks,
> *****
> Do you want to restore lost files into ./lost_found/? [Y/N] N
> Info: Write valid nat_bits in checkpoint
> [FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18eca] in NAT
> [FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18ecb] in NAT
> [FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18ecc] in NAT
> [FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18ee3] in NAT
> [FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18ee4] in NAT
> [FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18ee5] in NAT
> [FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18f78] in NAT
> [FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18f79] in NAT
> [FIX] (nullify_nat_entry:2273)  --> Remove nid [0x18f7a] in NAT
> [FIX] (nullify_nat_entry:2273)  --> Remove nid [0x4d621] in NAT
> [FIX] (nullify_nat_entry:2273)  --> Remove nid [0x4d622] in NAT
> [FIX] (nullify_nat_entry:2273)  --> Remove nid [0x7fa32] in NAT
> [FIX] (nullify_nat_entry:2273)  --> Remove nid [0x7fa33] in NAT
> Info: Write valid nat_bits in checkpoint
> 
> Done.
> *****
> 
> *****
> Info: Fix the reported corruption.
> Info: Force to fix corruption
> Info: Segments per section = 1
> Info: Sections per zone = 1
> Info: sector size = 512
> Info: total sectors = 124168159 (60628 MB)
> Info: MKFS version
>   "Linux version 5.1.15.a-1-hardened (builduser@slave-1) (gcc version
> 9.1.0 (GCC)) #1 SMP PREEMPT Thu Jun 27 11:33:04 CEST 2019"
> Info: FSCK version
>   from "Linux version 4.19.13-dirty (nater@devx64) (gcc version 8.2.1
> 20181127 (GCC)) #2 SMP PREEMPT Mon Dec 31 00:15:50 CST 2018"
>     to "Linux version 4.19.13-dirty (nater@devx64) (gcc version 8.2.1
> 20181127 (GCC)) #2 SMP PREEMPT Mon Dec 31 00:15:50 CST 2018"
> Info: superblock features = 0 :
> Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
> Info: total FS sectors = 124168152 (60628 MB)
> Info: CKPT version = 63f2b4a
> Info: checkpoint state = 281 :  allow_nocrc nat_bits unmount
> Info: No error was reported
> *****
> I'm now booted in from my SDHC card. So it "seems" I'm good to go.
> But with the actions taken and the files I've seen displayed during
> the fsck, I'm thinking I'm going to reinstall all packages.
> Assuming the issue was related to the power outage, I do wonder why
> there weren't any fsck issues at bootup at that time. I hadn't had any
> disk issues before with that card.
> At least now I know the issue would be resolved by not saving the lost
> files and I can continue on my merry way.

I suspect the last power outage caused the FTL in the card firmware to point
the f2fs NAT table area to somewhere wrong flash cells. It may be possible
that we can't see any filesystem corruption easily, since it can corrupt
data area in higher possibility; this doesn't lead filesystem inconsistency.

I guess you use "-a" for fsck at boot up, which means scanning the disk when
runtime f2fs detects any inconsistent data. But that is true, only when the disk
guarantees SYNC_CACHE at least. Unfortunately, IMHO, such the flash card doesn't
support it gracefully, and thus, we can't rely on SYNC_CACHE which should be the
baseline to guarantee filesystem consistency. I think it'd be good to run "-f",
if sudden power cut happens in this case.

Thanks,
