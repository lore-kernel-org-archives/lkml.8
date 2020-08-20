Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URG_BIZ,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D99C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D04E208C7
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZmZfB2nv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f5yGnKX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbgHTRJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730448AbgHTRIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:08:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB86CC061342
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:07:19 -0700 (PDT)
Date:   Thu, 20 Aug 2020 19:07:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597943235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1jlvtjajrYXjF/1spfrNL4IaV3D7DPvsLkUvhddqIoA=;
        b=ZmZfB2nvVJyg4zXwM8VWNcoTwzukQ5Yga7nuhM0yTBPOCLRYACUkA8NtraPFH0RKjZmxkS
        CvxJlhOyfLO8c/CgGgFqRp1S8dyq6vwOYR3qr/zxiUyD/2DsUyNMS7qHRt3nlj1edEdpyQ
        o6K95FIkVrtMOZ34upntnyM8YPjO4uQ5a2on5QayTP68rDAH1CSGtiGVDHRLdrNk7sdMRF
        qHuOlNQNln5fOaza9nRuSqE1UKJIQD3RrLew5MizgC6lEHNK1Nl2OP/gnZ1lOg8eHzRgj/
        fmYOFT4z6TyYBRbHJdDbrjbg03sICy2LQ2Ko++GLkzjTRcLjgum9WN7/aSLv4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597943235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1jlvtjajrYXjF/1spfrNL4IaV3D7DPvsLkUvhddqIoA=;
        b=f5yGnKX71cuEFvCE8bDQJFc79TQ3ypU/os8nwaj9GsAVwGbRGgbGYD4gREAYAwPNqYgdtp
        bRsn/tN0BK7faIBQ==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: v5.9-rc1 commit reliably breaks pci nvme detection
Message-ID: <20200820170729.GA4116@lx-t490>
References: <20200817135011.GA2072@lx-t490>
 <20200817155658.GB1221871@dhcp-10-100-145-180.wdl.wdc.com>
 <d077aec4-d79b-b52e-cdd9-bcc89fbbde5f@fb.com>
 <2356f514-9408-6a6f-871d-046984963533@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2356f514-9408-6a6f-871d-046984963533@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 09:35:38AM -0600, Jens Axboe wrote:
> On 8/17/20 9:58 AM, Jens Axboe wrote:
> > On 8/17/20 8:56 AM, Keith Busch wrote:
> >> On Mon, Aug 17, 2020 at 03:50:11PM +0200, Ahmed S. Darwish wrote:
> >>> Hello,
> >>>
> >>> Below v5.9-rc1 commit reliably breaks my boot on a Thinkpad e480
> >>> laptop. PCI nvme detection fails, and the kernel becomes not able
> >>> anymore to find the rootfs / parse "root=".
> >>>
> >>> Bisecting v5.8=>v5.9-rc1 blames that commit. Reverting it *reliably*
> >>> fixes the problem and makes me able to boot v5.9-rc1.
> >>
> >> The fix is staged in the nvme tree here:
> >>
> >>   http://git.infradead.org/nvme.git/commit/286155561ecd13b6c85a78eaf2880d3baea03b9e
> >
> > That would have been nice to have in -rc1...
>
> And now we're getting very close to shipping items for -rc2, and it's still
> not in. Can we please get the nvme pull request out for -rc2?
>

I keep wondering that myself. Completely breaking the boot like this is
really not nice -- and for x86-64 laptops no less :-(

The fix is really small and isolated. "Urgent pull requests", containing
only a fix or two, were created *exactly* for this reson...

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
