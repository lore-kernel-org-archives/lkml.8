Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BCDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 09:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70A9D20885
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 09:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBiV2Qte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgHLJcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 05:32:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34411 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726755AbgHLJcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 05:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597224771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=McgSm4gZG0IJUDrzxF8YLSNKil+nQCTSx4aOJLvpZXU=;
        b=GBiV2QtezXRBlNuQkXT6zj5dolK+YcbsxZlkQLKTJX6ZqPUuGjEQxZQ0gJv9rfuYkBjEd9
        vfHiBg7WyE9RcULxNsD/p4nT3B2kpNsI34PzQcAuYESWdPWDBVf0e3b1dB3oEGP1r/9ron
        kcKq0bX5wHgPNvKvZOomu2Gy+ZPHyVo=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-RlO8wxyhMMi2tpqFBOJtug-1; Wed, 12 Aug 2020 05:32:49 -0400
X-MC-Unique: RlO8wxyhMMi2tpqFBOJtug-1
Received: by mail-pf1-f200.google.com with SMTP id r25so1379806pfg.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 02:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=McgSm4gZG0IJUDrzxF8YLSNKil+nQCTSx4aOJLvpZXU=;
        b=VeLn5Gb5+p8PJZBZkVVIhvGs/GEnSMjM7yYKt3kIIdb9nWIHlMA2UAGhyFiT/bR8OQ
         t0OLA9wddtSbjFr+Y/k1aAAH6LSV5vVV6V5VZDXO0PQeQoV7wfeVb0vnb/X5lKEBP8Yt
         Hl2I5FbKBSvaLQvLqNRohscn/elYHdrE52CoCyoi8lyI+ZTWYgPtcDMm8qAvFR4aRpzI
         J+Z11MZb1Xbi4ohrHeMmONNQUyfNQXxuErVdktNyKMInG1cFnB+uLzEaquxIPLbd2ral
         EBt6vm54vFCxnoFj8MCjAqbjpOsUq8VtiSzByoKGe/+VB2uyhWmCfbX/77ki/A/aYgKD
         OgAw==
X-Gm-Message-State: AOAM53298oQYLBtTgRo0sGoksp9SRuRk/BN777mBaNhsHPkhcAvOHrj5
        rdylea5gijBisePY0Qxbso2KlZRgzSbe5qHv0JYUzNdaVNsum3HG2y7rnbk2ep3QqOsrtCOdplP
        xEeUdjr+5MKgudNA6z5zVIpcE
X-Received: by 2002:a65:614f:: with SMTP id o15mr4297313pgv.321.1597224768560;
        Wed, 12 Aug 2020 02:32:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx911sIO9/OZXyBonuONBWz+oLANJEAcEjx1Ld7BQlkUUtIu6DFXuiWv8TKBtMS/vO+GeEdAw==
X-Received: by 2002:a65:614f:: with SMTP id o15mr4297295pgv.321.1597224768283;
        Wed, 12 Aug 2020 02:32:48 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y196sm1854702pfc.202.2020.08.12.02.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 02:32:47 -0700 (PDT)
Date:   Wed, 12 Aug 2020 17:32:34 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: change virtual mapping way for
 compression pages
Message-ID: <20200812093234.GA759@xiangao.remote.csb>
References: <20200812051711.2147716-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812051711.2147716-1-daeho43@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 02:17:11PM +0900, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> By profiling f2fs compression works, I've found vmap() callings have
> unexpected hikes in the execution time in our test environment and
> those are bottlenecks of f2fs decompression path. Changing these with
> vm_map_ram(), we can enhance f2fs decompression speed pretty much.
> 
> [Verification]
> Android Pixel 3(ARM64, 6GB RAM, 128GB UFS)
> Turned on only 0-3 little cores(at 1.785GHz)
> 
> dd if=/dev/zero of=dummy bs=1m count=1000
> echo 3 > /proc/sys/vm/drop_caches
> dd if=dummy of=/dev/zero bs=512k
> 
> - w/o compression -
> 1048576000 bytes (0.9 G) copied, 2.082554 s, 480 M/s
> 1048576000 bytes (0.9 G) copied, 2.081634 s, 480 M/s
> 1048576000 bytes (0.9 G) copied, 2.090861 s, 478 M/s
> 
> - before patch -
> 1048576000 bytes (0.9 G) copied, 7.407527 s, 135 M/s
> 1048576000 bytes (0.9 G) copied, 7.283734 s, 137 M/s
> 1048576000 bytes (0.9 G) copied, 7.291508 s, 137 M/s
> 
> - after patch -
> 1048576000 bytes (0.9 G) copied, 1.998959 s, 500 M/s
> 1048576000 bytes (0.9 G) copied, 1.987554 s, 503 M/s
> 1048576000 bytes (0.9 G) copied, 1.986380 s, 503 M/s
>

The reason why I raised up this was that I once observed vmap() vs
vm_map_ram() on arm64 kirin platform as well. it indeed had some
impact (~10%) but not as huge as this. Anyway, such description
with test environment looks ok.

Thanks,
Gao Xiang

 

