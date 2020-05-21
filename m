Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768D8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47577207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljg05M5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgEUURv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUURv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:17:51 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E76C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:17:50 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u1so6659634wmn.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=huWgXpbDzdljKw3GvlKFMkS9v32YlszvZUodY9Vu2AM=;
        b=ljg05M5aahcskGiy83jjBBWZfs2xI5NxpP4k2fna2chn8rGXb6cpKB3Ef+xrCKF9yn
         fQC/P/qaZ+2l4SQYIMEb6qRa2UXz12dYEOnRQiH85v1UTuSC4oBFApfWrfv4jSTQp6P2
         yoDl/ib6de/OZOfk7HfYqAUJjl1/u8UWS/W/QSGfCiDmKzeNUB/Z8Ib6P50jRUSQVjDM
         YPfTI5HF8oUlAEgikI2fUumFbbtOfwWNlHE++B0GUji8XWMBv5r+YmHiQ+N90tOpsCSv
         TYp8Gv596H0ws+AtWZyXGaNYXCgld6k3Tm8qzgYs52/rlQa/zjGouo+MPG/6WsSbm+SO
         rogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=huWgXpbDzdljKw3GvlKFMkS9v32YlszvZUodY9Vu2AM=;
        b=PfbUoNZa8xOjrKy4+cAvnZsAGUCpPc002jKe9rsrWU7fs2knxGEHVEDPe/ZEfWYf7C
         YJkDpIhJNuMbE2GC62psHL+X9cjZhT8OjkufjpdWrhEjq+kKyDzNwPYEQYfvuQixSS3D
         zXjevnZQRVQhakD6HheTIYDwMhhsqUDBGpCT7QGpP11SKEMC+hnmk1tLsLbJ1rjKZ/vR
         m6kTFENUHyQduRhadDrdOXSMLNYgNMfZiJ8kpdM9Gss+/GrQUXJo0bx5Ej2KxqFs09/a
         fKLwTiFW4m5AYuNbu9BaYWKoFF7pkFV0agTiDP4VpKHgmpkgxsZHeiMeqyA4tp5zhMod
         0ezg==
X-Gm-Message-State: AOAM531hXlWWVBX6mjkfGcY0IQ2tBKjJfN5oFF0VY7Ze+LRTjXrgtTmX
        UYKfIHU28UuFMdYG4DtpNk5gJzOuTyDeVXNecNo=
X-Google-Smtp-Source: ABdhPJwFCX6ZTfZC+CYhpgpI3DM3w4YWTm9Ir6r9l2PdlZuiYiDYb0T2GXm6T8zhCVnCb/vwD8/q+rFFDW8SaepTFM4=
X-Received: by 2002:a7b:cf05:: with SMTP id l5mr10778996wmg.100.1590092269456;
 Thu, 21 May 2020 13:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s>
 <20200520234520.22563-9-sstabellini@kernel.org> <83c1120f-fe63-dc54-7b82-15a91c748de8@xen.org>
 <alpine.DEB.2.21.2005211247461.27502@sstabellini-ThinkPad-T480s>
In-Reply-To: <alpine.DEB.2.21.2005211247461.27502@sstabellini-ThinkPad-T480s>
From:   Julien Grall <julien.grall.oss@gmail.com>
Date:   Thu, 21 May 2020 21:17:38 +0100
Message-ID: <CAJ=z9a24gHgS1yrpzLmW35zPSR6F6NUvYJUyJ9p1+oLp7THD8w@mail.gmail.com>
Subject: Re: [PATCH 09/10] xen/arm: introduce phys/dma translations in xen_dma_sync_for_*
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 at 21:08, Stefano Stabellini <sstabellini@kernel.org> wrote:
>
> On Thu, 21 May 2020, Julien Grall wrote:
> > > @@ -97,8 +98,7 @@ bool xen_arch_need_swiotlb(struct device *dev,
> > >                        phys_addr_t phys,
> > >                        dma_addr_t dev_addr)
> > >   {
> > > -   unsigned int xen_pfn = XEN_PFN_DOWN(phys);
> > > -   unsigned int bfn = XEN_PFN_DOWN(dev_addr);
> > > +   unsigned int bfn = XEN_PFN_DOWN(dma_to_phys(dev, dev_addr));
> > >             /*
> > >      * The swiotlb buffer should be used if
> > > @@ -115,7 +115,7 @@ bool xen_arch_need_swiotlb(struct device *dev,
> > >      * require a bounce buffer because the device doesn't support coherent
> > >      * memory and we are not able to flush the cache.
> > >      */
> > > -   return (!hypercall_cflush && (xen_pfn != bfn) &&
> > > +   return (!hypercall_cflush && !pfn_valid(bfn) &&
> >
> > I believe this change is incorrect. The bfn is a frame based on Xen page
> > granularity (always 4K) while pfn_valid() is expecting a frame based on the
> > Kernel page granularity.
>
> Given that kernel granularity >= xen granularity it looks like it would
> be safe to use PFN_DOWN instead of XEN_PFN_DOWN:
>
>   unsigned int bfn = PFN_DOWN(dma_to_phys(dev, dev_addr));

Yes. But is the change worth it though? pfn_valid() is definitely
going to be more expensive than the current check.

Cheers,
