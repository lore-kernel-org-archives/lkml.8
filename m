Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB216C2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97B9A20767
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aN6LfMf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbgDMOIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730285AbgDMOIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:08:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2386DC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 07:08:51 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f13so10237117wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 07:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EOjjtmiSBry9sWf71C/iCFNq7MksgHVjzrQLc6ngrDY=;
        b=aN6LfMf7c1/78sc1j3yHc6/q7n/6Gr9qwFHzOGxLMZK3tsVvoc0+7N4KxTmQoj9KSp
         IgdnQtO1kg3PAyn1GxvUnr9nqBFlbVyqvydryKf0GppHMi9yv2tOg40Lzfajv6OUdIeV
         FGGsVz5LkXKgjcM0ngQjnUlsUfCyx9idTaWLB980gM9nN6K/f2+QTwPWoPy/vYViyyIM
         Zp3G1fgo63UFYBImjby3R3SFUebQCexOpUAXGxy/N8k3g22R4NF4vfH/cA/7CuzrnEEp
         jHk9pbuGCNG3npJBuKzHesUPvu+caEZJmD1vpyQkjJZ/HQQV++9zONklY1HEEqWn6kiK
         5dLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOjjtmiSBry9sWf71C/iCFNq7MksgHVjzrQLc6ngrDY=;
        b=Sx0S55GNMRApXJfBEKIcF5nQixrSJ71WAcBK1dLIX6lZx78DxW9uJzQZZx+NKAueVV
         fDWh6dFJ0sXSyooTOD27wjjvqz8WQG+fjvZ7KvvJa0gxm+leKKLqm32SScb/zDZ/QTPh
         JKK/5+rkwdzCCFvJdv9p/4JQo4SSC1QLOr2uzbFsE+yxsHDLnv22kh0RrspuOXd9NWcq
         UFv13nLu8YjGI6gHN8+o60vNofei45TWfsDozjsNoCUQ99n5hpEomCGm8iwdgsG+kUbF
         SltlK3ycq9+gUkJlB5CepHABeJnaOwVPh7oXlFkYlxi3FazUFKAjE930oFm0NRDL+WPV
         gGQQ==
X-Gm-Message-State: AGi0Pub5AYrCG2hvyD/VNLbdIv6d5wRQ2J3kbWlizWZsW2F2L/DCshHN
        LCixSkWRjqFHVioedtZYnxfCQJordaHBLNJ1gLsmtw==
X-Google-Smtp-Source: APiQypL79byYSl0+g7iFCftAmFHwg4Q6R884B+OgwhqBafAtbxh6J/bmKWXIfY0ohGdvGPFMgV1tWUBwq2uk3W+XxFI=
X-Received: by 2002:adf:f844:: with SMTP id d4mr282394wrq.362.1586786929901;
 Mon, 13 Apr 2020 07:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200411141740.14584-1-tangbin@cmss.chinamobile.com>
In-Reply-To: <20200411141740.14584-1-tangbin@cmss.chinamobile.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 13 Apr 2020 10:08:38 -0400
Message-ID: <CADnq5_MD6LkOEJC-hKKQSAmFAHY7LMZ2WU_ER-ttNrP20AxoQA@mail.gmail.com>
Subject: Re: [PATCH] drm/dp_mst: Fix drm_dp_mst_topology.c selftest
 compilation warning
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 5:29 AM Tang Bin <tangbin@cmss.chinamobile.com> wrote:
>
> The struct drm_dp_desc contains struct drm_dp_dpcd_ident, and the struct
> drm_dp_dpcd_ident contains the array, so zero-initialization requires a
> more couple of braces. In the ARM compiler environment, the compile
> warning pointing it out:
>     drivers/gpu/drm/drm_dp_mst_topology.c: In function 'drm_dp_mst_dsc_aux_for_port':
>     drivers/gpu/drm/drm_dp_mst_topology.c:5494:9: warning: missing braces around initializer [-Wmissing-braces]
>       struct drm_dp_desc desc = { 0 };
>

This seems to vary based on compilers.  Maybe a memset would be better.

Alex

> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 70c4b7a..4d8d1fd 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -5494,7 +5494,7 @@ struct drm_dp_aux *drm_dp_mst_dsc_aux_for_port(struct drm_dp_mst_port *port)
>  {
>         struct drm_dp_mst_port *immediate_upstream_port;
>         struct drm_dp_mst_port *fec_port;
> -       struct drm_dp_desc desc = { 0 };
> +       struct drm_dp_desc desc = { { { 0 } } };
>         u8 endpoint_fec;
>         u8 endpoint_dsc;
>
> --
> 2.7.4
>
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
