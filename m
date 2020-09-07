Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFC3C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFCC92145D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ahlN06GL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgIGH4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbgIGH4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:56:04 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283EFC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 00:56:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x23so3481867wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 00:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=3k0z39QYWIe/UY6EeGOX5LkXyhspBlH5cO5WQ/J5ViE=;
        b=ahlN06GLnzA9rOV4Xi2uqvVT1PEbPo9vjwo5QkVmZdciublt9X3jqlpA+43hVvscoD
         dbSn4ZR1e1Hjyj7pWfskGgAUcc2oDXP8xZD9Sz1u4Nay5BBkQmEqn7RZhgO3sOR4CBem
         nRL2H6VesekZfv772O8OZba9JFQLCJIUIEMB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=3k0z39QYWIe/UY6EeGOX5LkXyhspBlH5cO5WQ/J5ViE=;
        b=HxRYUXv0ZQbff2t9ZoovJ1hSdv9H4t73JOnEkKqQWsU1uIP+o5Xvu84Mm7l78kDfFn
         au40yIP66HGYCkPZ6RaFFm4SR0K6LBynv+5BkjE7yMjyGoJI5xZyCC63SUCQsVEKXAny
         5+/Rnl4gxZqNa8k1ubr+ndERO3T6DPnmOW32tfQE4wmA/+VZu1kRLyGZmIi4gngie/1F
         Ww0ZySxQoYu6x+CjAGD/YWcgWaoUXa63zrqqDssPFeTRb5n70wP/TtwcWZjJK94E96Gf
         9QEt5U2fZjeKacAFI8hzQK1cyo5GOvGhH+/8VFUWt/wlc7mm/3jo/+EkU4eB6XHNbTUi
         syzQ==
X-Gm-Message-State: AOAM530Cnr8FYERbUSrg9mcCUrrN+eEz6vuf5MrWG0NOb5fqHjqfUP5Z
        5R4xqEtNJ7rQTOPmyine6G7+QQ==
X-Google-Smtp-Source: ABdhPJxFZJ8XJ1CLC+QmdlYHF7G9rGRpD842F2k869iPGYdjhpkwEkztDb5WNmJNAoIZyZlDHm95wg==
X-Received: by 2002:a1c:2dc6:: with SMTP id t189mr1545774wmt.92.1599465361880;
        Mon, 07 Sep 2020 00:56:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q4sm26403992wru.65.2020.09.07.00.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 00:56:01 -0700 (PDT)
Date:   Mon, 7 Sep 2020 09:55:59 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v1 0/2] video: fbdev: radeonfb: PCI PM framework upgrade
 and fix-ups.
Message-ID: <20200907075559.GN2352366@phenom.ffwll.local>
Mail-Followup-To: Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thierry Reding <treding@nvidia.com>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20200806072256.585705-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806072256.585705-1-vaibhavgupta40@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 12:52:54PM +0530, Vaibhav Gupta wrote:
> Linux Kernel Mentee: Remove Legacy Power Management. 
> 
> The original goal of the patch series is to upgrade the power management
> framework of radeonfb fbdev driver. This has been done by upgrading .suspend()
> and .resume() callbacks.
> 
> The upgrade makes sure that the involvement of PCI Core does not change the
> order of operations executed in a driver. Thus, does not change its behavior.
> 
> During this process, it was found that "#if defined(CONFIG_PM)" at line 1434 is
> redundant. This was introduced in the commit
> 42ddb453a0cd ("radeon: Conditionally compile PM code").

I do wonder whether it wouldn't be better to just outright delete these,
we have the drm radeon driver for pretty much all the same hardware ...
-Daniel

> 
> ------------
> 
> Before 42ddb453a0cd:
> $ git show 65122f7e80b5:drivers/video/aty/radeon_pm.c | grep -n "#ifdef\|#if\|#else\|#endif\|#elif\|#ifndef"
> 
> Based on output in terminal:
> 
> 547:#ifdef CONFIG_PM
>        |-- 959:#ifdef CONFIG_PPC_PMAC
>        |-- 972:#endif
>        |-- 1291:#ifdef CONFIG_PPC_OF
>        |-- 1301:#endif /* CONFIG_PPC_OF */
>        |-- 1943:#ifdef CONFIG_PPC_OF
>                    |-- 2206:#if 0 /* Not ready yet */
>                    |-- 2508:#endif /* 0 */
>        |-- 2510:#endif /* CONFIG_PPC_OF */
>        |-- 2648:#ifdef CONFIG_PPC_PMAC
>        |-- 2654:#endif /* CONFIG_PPC_PMAC */
>        |-- 2768:#ifdef CONFIG_PPC_PMAC
>        |-- 2774:#endif /* CONFIG_PPC_PMAC */
>        |-- 2791:#ifdef CONFIG_PPC_OF__disabled
>        |-- 2801:#endif /* CONFIG_PPC_OF */
> 2803:#endif /* CONFIG_PM */
> 
> ------------
> 
> After 42ddb453a0cd:
> $ git show 42ddb453a0cd:drivers/video/aty/radeon_pm.c | grep -n "#ifdef\|#if\|#else\|#endif\|#elif\|#ifndef"
> 
> Based on output in terminal:
> 
> 547:#ifdef CONFIG_PM
>        |-- 959:#ifdef CONFIG_PPC_PMAC
>        |-- 972:#endif
>        |-- 1291:#ifdef CONFIG_PPC_OF
>        |-- 1301:#endif /* CONFIG_PPC_OF */
>        |-- 1430:#if defined(CONFIG_PM)
>                    |-- 1431:#if defined(CONFIG_X86) || defined(CONFIG_PPC_PMAC)
>                    |-- 1944:#endif
>                    |-- 1946:#ifdef CONFIG_PPC_OF
>                                |-- 1947:#ifdef CONFIG_PPC_PMAC
>                                |-- 2208:#endif
>                    |-- 2209:#endif
>                    |-- 2211:#if 0 /* Not ready yet */
>                    |-- 2513:#endif /* 0 */
>        |-- 2515:#endif /* CONFIG_PPC_OF */
>        |-- 2653:#ifdef CONFIG_PPC_PMAC
>        |-- 2659:#endif /* CONFIG_PPC_PMAC */
>        |-- 2773:#ifdef CONFIG_PPC_PMAC
>        |-- 2779:#endif /* CONFIG_PPC_PMAC */
>        |-- 2796:#ifdef CONFIG_PPC_OF__disabled
>        |-- 2806:#endif /* CONFIG_PPC_OF */
> 2808:#endif /* CONFIG_PM */
> 
> ------------
> 
> This also affected the CONFIG_PPC_OF container (line 1943 at commit 65122f7e80b5)
> 
> The patch-series fixes it along with PM upgrade.
> 
> All patches are compile-tested only.
> 
> Test tools:
>     - Compiler: gcc (GCC) 10.1.0
>     - allmodconfig build: make -j$(nproc) W=1 all
> 
> Vaibhav Gupta (2):
>   video: fbdev: aty: radeon_pm: remove redundant CONFIG_PM container
>   fbdev: radeonfb:use generic power management
> 
>  drivers/video/fbdev/aty/radeon_base.c | 10 ++++---
>  drivers/video/fbdev/aty/radeon_pm.c   | 38 ++++++++++++++++++++-------
>  drivers/video/fbdev/aty/radeonfb.h    |  3 +--
>  3 files changed, 35 insertions(+), 16 deletions(-)
> 
> -- 
> 2.27.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
