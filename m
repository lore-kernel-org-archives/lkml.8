Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6570DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2634321481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0nVzEt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgIGJSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 05:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgIGJSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:18:33 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8456C061573;
        Mon,  7 Sep 2020 02:18:32 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mm21so6441291pjb.4;
        Mon, 07 Sep 2020 02:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kpwNni5DZsL81VsUzOEF6fgBNL8irinRHr++pS6DIH4=;
        b=O0nVzEt0to+Hpt5DmVNSrpKsB5pOnDvRJ8682q1tjqS9v/Qx3Bmbmcd8+okOLCi3Ci
         FjWoetYIYjZznCRSXunkH7DUavf55Gq7vRf958XI9iG/HYsQIrNfJpNlhebrFk0nL8sn
         Zht4yGQs7+PF5kJyNUh2Fn+CjmW4Vpp8DIzMgswenMi9y9jHnEeEoBy6OnYMcDqxYgkb
         0rmPSbRH8mKBId82tj1AdNhjksNhIqlXe7b0dbwEFqxCNq1T4a04DRFhs5vXccFg99Bo
         L/DoH3fIdmoqbfxRybBFcOB09axnPvtjZ2ivlNSmNFMInppDv8rhq+A27pmtroCDe0vq
         SwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kpwNni5DZsL81VsUzOEF6fgBNL8irinRHr++pS6DIH4=;
        b=gShmH+QYEUqHpHRvyx6jEZOhig8ArpMUK2xOlAhKjbammZNjZ58TaxboqOCNbiL7tS
         po/O8xkzIQEsWcW3XhdiAEQPhWxJMMLW8KYF2tFomGg5B4yXao/C4nEg6GEYrkIldi5K
         NgvP3ZVShi1JysBOCQKFnoNzLeXKQzauK3DpnA0FDA9yu4dZImYQHjEb32Z9sbrdbX4x
         4tJdV57IHjj/4XWYk+6wcADoGwGooUxHePgK53q9Dp3pJBUDjJaiqKEFhUOnHyvh6Fw4
         04g7Nb26gplIDfhmX5Bek6LHs/bUNNcq/yfP0QM25yvkqGe5AWlrEVIHfu5/jqenM655
         ioSA==
X-Gm-Message-State: AOAM530GeSuiZC+ICzerfbGmQX2oZtO4glfYKzO7NF4wFVpYenKtFr7k
        gSSwyj2iPCFa+BXriALfb7UbEcDRosc84w==
X-Google-Smtp-Source: ABdhPJz8OyFdACQ/fUoHKevIftBWifFC0ICyCifnJiqsqaCt6U+OjFvMmXblon5SpVeKNm99E3VMxA==
X-Received: by 2002:a17:902:8bc7:: with SMTP id r7mr17695124plo.92.1599470312191;
        Mon, 07 Sep 2020 02:18:32 -0700 (PDT)
Received: from gmail.com ([106.201.26.241])
        by smtp.gmail.com with ESMTPSA id h1sm5934980pji.52.2020.09.07.02.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 02:18:31 -0700 (PDT)
Date:   Mon, 7 Sep 2020 14:46:21 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
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
Message-ID: <20200907091621.GA30377@gmail.com>
References: <20200806072256.585705-1-vaibhavgupta40@gmail.com>
 <20200907075559.GN2352366@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200907075559.GN2352366@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 09:55:59AM +0200, Daniel Vetter wrote:
> On Thu, Aug 06, 2020 at 12:52:54PM +0530, Vaibhav Gupta wrote:
> > Linux Kernel Mentee: Remove Legacy Power Management. 
> > 
> > The original goal of the patch series is to upgrade the power management
> > framework of radeonfb fbdev driver. This has been done by upgrading .suspend()
> > and .resume() callbacks.
> > 
> > The upgrade makes sure that the involvement of PCI Core does not change the
> > order of operations executed in a driver. Thus, does not change its behavior.
> > 
> > During this process, it was found that "#if defined(CONFIG_PM)" at line 1434 is
> > redundant. This was introduced in the commit
> > 42ddb453a0cd ("radeon: Conditionally compile PM code").
> 
> I do wonder whether it wouldn't be better to just outright delete these,
> we have the drm radeon driver for pretty much all the same hardware ...
> -Daniel
> 
Hello Daniel,
I don't have any problem in either way. My priority is to get rid of the
legacy .suspend and .resume pointers from "struct pci_driver" . Hence, modifying
every driver that is using them.

Vaibhav Gupta
> > 
> > ------------
> > 
> > Before 42ddb453a0cd:
> > $ git show 65122f7e80b5:drivers/video/aty/radeon_pm.c | grep -n "#ifdef\|#if\|#else\|#endif\|#elif\|#ifndef"
> > 
> > Based on output in terminal:
> > 
> > 547:#ifdef CONFIG_PM
> >        |-- 959:#ifdef CONFIG_PPC_PMAC
> >        |-- 972:#endif
> >        |-- 1291:#ifdef CONFIG_PPC_OF
> >        |-- 1301:#endif /* CONFIG_PPC_OF */
> >        |-- 1943:#ifdef CONFIG_PPC_OF
> >                    |-- 2206:#if 0 /* Not ready yet */
> >                    |-- 2508:#endif /* 0 */
> >        |-- 2510:#endif /* CONFIG_PPC_OF */
> >        |-- 2648:#ifdef CONFIG_PPC_PMAC
> >        |-- 2654:#endif /* CONFIG_PPC_PMAC */
> >        |-- 2768:#ifdef CONFIG_PPC_PMAC
> >        |-- 2774:#endif /* CONFIG_PPC_PMAC */
> >        |-- 2791:#ifdef CONFIG_PPC_OF__disabled
> >        |-- 2801:#endif /* CONFIG_PPC_OF */
> > 2803:#endif /* CONFIG_PM */
> > 
> > ------------
> > 
> > After 42ddb453a0cd:
> > $ git show 42ddb453a0cd:drivers/video/aty/radeon_pm.c | grep -n "#ifdef\|#if\|#else\|#endif\|#elif\|#ifndef"
> > 
> > Based on output in terminal:
> > 
> > 547:#ifdef CONFIG_PM
> >        |-- 959:#ifdef CONFIG_PPC_PMAC
> >        |-- 972:#endif
> >        |-- 1291:#ifdef CONFIG_PPC_OF
> >        |-- 1301:#endif /* CONFIG_PPC_OF */
> >        |-- 1430:#if defined(CONFIG_PM)
> >                    |-- 1431:#if defined(CONFIG_X86) || defined(CONFIG_PPC_PMAC)
> >                    |-- 1944:#endif
> >                    |-- 1946:#ifdef CONFIG_PPC_OF
> >                                |-- 1947:#ifdef CONFIG_PPC_PMAC
> >                                |-- 2208:#endif
> >                    |-- 2209:#endif
> >                    |-- 2211:#if 0 /* Not ready yet */
> >                    |-- 2513:#endif /* 0 */
> >        |-- 2515:#endif /* CONFIG_PPC_OF */
> >        |-- 2653:#ifdef CONFIG_PPC_PMAC
> >        |-- 2659:#endif /* CONFIG_PPC_PMAC */
> >        |-- 2773:#ifdef CONFIG_PPC_PMAC
> >        |-- 2779:#endif /* CONFIG_PPC_PMAC */
> >        |-- 2796:#ifdef CONFIG_PPC_OF__disabled
> >        |-- 2806:#endif /* CONFIG_PPC_OF */
> > 2808:#endif /* CONFIG_PM */
> > 
> > ------------
> > 
> > This also affected the CONFIG_PPC_OF container (line 1943 at commit 65122f7e80b5)
> > 
> > The patch-series fixes it along with PM upgrade.
> > 
> > All patches are compile-tested only.
> > 
> > Test tools:
> >     - Compiler: gcc (GCC) 10.1.0
> >     - allmodconfig build: make -j$(nproc) W=1 all
> > 
> > Vaibhav Gupta (2):
> >   video: fbdev: aty: radeon_pm: remove redundant CONFIG_PM container
> >   fbdev: radeonfb:use generic power management
> > 
> >  drivers/video/fbdev/aty/radeon_base.c | 10 ++++---
> >  drivers/video/fbdev/aty/radeon_pm.c   | 38 ++++++++++++++++++++-------
> >  drivers/video/fbdev/aty/radeonfb.h    |  3 +--
> >  3 files changed, 35 insertions(+), 16 deletions(-)
> > 
> > -- 
> > 2.27.0
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
