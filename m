Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD00C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 20:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B2421532
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 20:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p8GqvDhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbgFUUUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 16:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730604AbgFUUUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 16:20:37 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B136C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 13:20:37 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e18so7158870pgn.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 13:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=LAjnugIsc4VHWdbrPS4xRmq7Vwv6xC2kO9meZ+2Ku74=;
        b=p8GqvDhyZf83WoUCjI4UwDke37CtlmnLL40lIARH49jrrv9ugM7snEa4tgKiLAAwaK
         4irrYKWnEO29LpKeNCAeJ4382veELzBbpUlgd4qi7s1/cRGrNz+8zfoBAc431D/cEALq
         H4a9zUhVG9GkBxhgA+nb9lgX7sJ/7uN9wz908UptIF//PK6D+e1++k2833TGswatuPSM
         2hF+Mv9po41cWzhRpqyUP/jZg71colkoyG3xI6h/Xewn12XwcmhIDseu3Jen7PPTRUkD
         jxRcbwRHRX74QV6gM4Vwk5BGyGHDIIxI+SXT9k/FUKrkuT2Rt2P9HVRuy64WLsIN6/qs
         iVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=LAjnugIsc4VHWdbrPS4xRmq7Vwv6xC2kO9meZ+2Ku74=;
        b=uldt8TeUm8yYBu3Iv4eJmYFY8hBmzBi+fR1qiUfPOFNpALtUPmdU0K9W6jUqVdPE8p
         fWxwCSAM7jimBt0Dra21V+FG8lRecZayGBxYwnP4QL3bf5ZiCT0SlLatZnaNct+w+jkN
         uDU3pjK6elGJIDfnF0DfRws49X0rWvGehPs5oQAeZJtg936Q3/gI4YbhgCS3ZNKwj1y3
         7I9+9tT5kE189T6eZ67M5HOXx2TlmyOk9R2udssq/R6k411Qnz3Q/DlWiWhBhgj8yC8i
         uO0Cfg16oavGpFb2FTxJJyAqdCNrGLsSayeEkoJhsYm3NolksrwqBn9PSzvcedTOFAJz
         aegg==
X-Gm-Message-State: AOAM530CegsDcC+OYQzN5HuLLWisty2PSaiJPjmeZ0HEU6TY1A/i2oj/
        UjjrKg8cZm7yrNe8/UJYfx+VCg==
X-Google-Smtp-Source: ABdhPJy3uKqgOP8ckSCgjJ4/b1zv/v3fqBpHsf8qbfCQukftd+7CRc16PVTQ+oq0doNlQM2yw7fL6A==
X-Received: by 2002:a05:6a00:1592:: with SMTP id u18mr17298748pfk.26.1592770836678;
        Sun, 21 Jun 2020 13:20:36 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id y3sm12039140pff.37.2020.06.21.13.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 13:20:36 -0700 (PDT)
Date:   Sun, 21 Jun 2020 13:20:35 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Guenter Roeck <linux@roeck-us.net>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dma-pool: Fix too large DMA pools on medium systems
In-Reply-To: <c0889f5c-34ae-2314-6530-a9240e0901f2@roeck-us.net>
Message-ID: <alpine.DEB.2.22.394.2006211308500.195301@chino.kir.corp.google.com>
References: <20200608132217.29945-1-geert@linux-m68k.org> <20200620200936.GA106151@roeck-us.net> <CAMuHMdX3mBDm9iHk+jhbGfmo+dbix=3tp5z2ewyddWxM1tdqGQ@mail.gmail.com> <c0889f5c-34ae-2314-6530-a9240e0901f2@roeck-us.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jun 2020, Guenter Roeck wrote:

> >> This patch results in a boot failure in some of my powerpc boot tests,
> >> specifically those testing boots from mptsas1068 devices. Error message:
> >>
> >> mptsas 0000:00:02.0: enabling device (0000 -> 0002)
> >> mptbase: ioc0: Initiating bringup
> >> ioc0: LSISAS1068 A0: Capabilities={Initiator}
> >> mptbase: ioc0: ERROR - Unable to allocate Reply, Request, Chain Buffers!
> >> mptbase: ioc0: ERROR - didn't initialize properly! (-3)
> >> mptsas: probe of 0000:00:02.0 failed with error -3
> >>
> >> Configuration is bamboo:44x/bamboo_defconfig plus various added drivers.
> >> Qemu command line is
> >>
> >> qemu-system-ppc -kernel vmlinux -M bamboo \
> >>      -m 256 -no-reboot -snapshot -device mptsas1068,id=scsi \
> >>      -device scsi-hd,bus=scsi.0,drive=d0,wwn=0x5000c50015ea71ac -drive \
> >>      file=rootfs.ext2,format=raw,if=none,id=d0 \
> >>      --append "panic=-1 slub_debug=FZPUA root=/dev/sda  mem=256M console=ttyS0" \
> >>      -monitor none -nographic
> >>
> >> canyonlands_defconfig with sam460ex machine and otherwise similar command line
> >> fails as well.
> >>
> >> Reverting this patch fixes the problem.
> > 
> > This looks like the minimum value of 128 KiB is not sufficient, and the
> > bug is in the intention of 1d659236fb43c4d2 ("dma-pool: scale the
> > default DMA coherent pool size with memory capacity")?
> > Before, there was a single pool of (fixed) 256 KiB size, now there are
> > up to three coherent pools (DMA, DMA32, and kernel), albeit of smaller
> > size (128 KiB each).
> > 
> > Can you print the requested size in drivers/message/fusion/mptbase.c:
> > PrimeIocFifos()?
> 
> 172928 bytes
> 
> > Does replacing all SZ_128K by SZ_256K in my patch help?
> 
> Yes, it does.
> 

The new coherent pools should auto expand when they are close to being 
depleted but there's no guarantee that it can be done fast enough.  
Switching the min size to be the previous min size (256KB) seems like the 
best option and it matches what 
Documentation/admin-guide/kernel-parameters.txt still stays.

I'll also send a patch to point in the right direction when this happens.
