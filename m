Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9A4C2BB84
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0754A2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="g2D2qGtM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbgIDPJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729942AbgIDPJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:09:51 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302AFC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:09:51 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id w16so6825464oia.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pDK/W863J4Emn1hkynlvhr7fPRAsMPX6ZEbd3sQLo0I=;
        b=g2D2qGtM/WYDLwSvJbX+jaBrlLxeXrw2h98Bytw/9YXLeUUNpuxEO0G+yMcVkqL9x/
         FvUlngKXsRsMh06LU8Xd53alpdZRFlk3k52a9TlqoBfXqdfWI7a/SnOaOlK4BQ3MdrNL
         4zFI3UYoeh5EdMI2FN+JcKkDhVH1eSLLQ2ux0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pDK/W863J4Emn1hkynlvhr7fPRAsMPX6ZEbd3sQLo0I=;
        b=l2VolrPyv9thuO+qHliPyuOhg7hQwAbvwGE6q3UNTaJrJ9ijObnvi/4LfTMWpFCbyl
         cNRusfVmCBImhE72kmEugZdMyuOG/l8uWEXT8yAY3kuWicdQyKuIXPXvoUinL1N2qkG5
         1zYyN4fDnnlGtbEOaIxjIxzVX4EeQ+JAU1w7uSv9phUzrVEQ8VXGEp5JnRmWonDMh2Tu
         E5xciBbBevPE/UNnl7A1rwrw9OHvpz0ce9sp2aY3FQNuTUM34DT5oQcvYTvjzenXG3YV
         DdyJqiQjv3CB3i/XqDVLEdQv2jJ0PVB83Eh6aWU8EYRq62I8el/zEntI/BCwlCjv6TXU
         ZyEQ==
X-Gm-Message-State: AOAM533U49HnsmN6Aw8Ap62v723yd4jRNvPl31nWzF0McXpXBZzTtCpV
        ygtMBCtmwndY7Y3D+o1BJLSeSXQuWFyoY3SOqddsLA==
X-Google-Smtp-Source: ABdhPJxPJzpMyfCwWQaTqMdDuKLDqebC6uSpZLg67V6hw4kRA3DJgPwgwnTtpUQIMpeD2MqRoBLl3L7TtNrQm9/xMXE=
X-Received: by 2002:aca:ea44:: with SMTP id i65mr5577999oih.14.1599232190594;
 Fri, 04 Sep 2020 08:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200904130605.vs5tnfhgnemnz6pt@smtp.gmail.com>
In-Reply-To: <20200904130605.vs5tnfhgnemnz6pt@smtp.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 4 Sep 2020 17:09:39 +0200
Message-ID: <CAKMK7uG+qXLn4Om6oZhyYkKk=Cb57CNSzpJv=rLCds6xpk+dhg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add entry for VKMS
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Trevor Woerner <twoerner@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 3:06 PM Melissa Wen <melissa.srw@gmail.com> wrote:
>
> Add myself as maintainer of VKMS driver
>
> Signed-off-by: Melissa Wen <melissa.srw@gmail.com>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Congrats!
-Daniel

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 01fb9ee6b951..d4277824a01c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5640,6 +5640,7 @@ F:        drivers/gpu/drm/udl/
>
>  DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
>  M:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> +M:     Melissa Wen <melissa.srw@gmail.com>
>  R:     Haneen Mohammed <hamohammed.sa@gmail.com>
>  R:     Daniel Vetter <daniel@ffwll.ch>
>  L:     dri-devel@lists.freedesktop.org
> --
> 2.28.0
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
