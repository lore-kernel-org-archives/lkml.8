Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA2CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 14:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F2A7205CB
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 14:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m3RvS7W1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgHAO1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 10:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgHAO1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 10:27:45 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE06C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 07:27:45 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id v15so13757142lfg.6
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFX3q5UL/Hekj1Owrf1DlrLYV1j+LXmw4rViBH4wBA0=;
        b=m3RvS7W1RMIL7cIUF/3oGEnko2s0QlxcPiKEWwofhtIxpE1+qlBQSh5JhXkMo5E1bj
         tMGKBKPrEnDTY8rkKLiA9xqA6g4RsyuVDoEHdoGGLEC+o8cbU2pO+it0l8ZYhpd+9qVt
         GNcBM4ewwLtLPM7mLA5mtNiloJxl9rxL4480BgpKuW6V6z4NdUgTtlHPCwM5S/8/NTXh
         ro5xhj5HGhSRljkaCuLbwrXTAxhQ2NxEt9HyAGGgAMONfWfD/eoWNh0mQjQJGac2ki4p
         ZL8UwPAd45dsSpy9e1NrQ/fcthLHkik0/YAtDL5jZuS9BrpxcIZRxGPfRhlVJgWa9PGw
         fDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFX3q5UL/Hekj1Owrf1DlrLYV1j+LXmw4rViBH4wBA0=;
        b=VMECM+ABZajDteBKxVdYYmgn53bOC18Qc4Dnf+zd/fHssBk9a622mMFTlA65VAxicb
         Jt62IJ6S0RJt7+lydVlFx8bBVkWxJViu9CmRcozCiu3Zlv4525PHgsgvKIpdXG75Wsim
         rjuoL3XVHxNSvACBSXAr+EIty9HKGAjzYAQZsti4GFpQhS+yYEbjDAH3YF58Zyy3eI6G
         QUtCGbRANdmK3+NCDsk15uAcQd/ePLs1K4vsj1MO9uwxH3C3tpC7UY5uIldioJmSGMOH
         /8M4O8HDhzdCt7H3UhrcpvCZ2kNdHd5HtkmWvo6AOVTRjsdOpJl39SKiIyF7JIXZ6j66
         KWYg==
X-Gm-Message-State: AOAM531XJljhDoiQxPK4XAZJHEPKIWYqZe0i5wK1gJo+R+BZubNFIIoS
        7LS7BweBpe+j5O2H0xprmXCu2L7QqPHk9pfmjBqYXQ==
X-Google-Smtp-Source: ABdhPJyCsygFe37NY/t6SmyWsmcsVwZV/zyocjXdCnPbtYirvRY3A/8Zv0rdYuwoHTtlhA5YN9mBudELMfm1uUYdesU=
X-Received: by 2002:ac2:5e26:: with SMTP id o6mr4425871lfg.194.1596292063603;
 Sat, 01 Aug 2020 07:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200801120216.8488-1-bernard@vivo.com>
In-Reply-To: <20200801120216.8488-1-bernard@vivo.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 1 Aug 2020 16:27:32 +0200
Message-ID: <CACRpkdasUurLu_zvUQ7jwyGDsGhFqeDA9oJ0qsTHVOXx0NT2rQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: remove return value of function drm_panel_add
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 1, 2020 at 2:02 PM Bernard Zhao <bernard@vivo.com> wrote:

> The function "int drm_panel_add(struct drm_panel *panel)"
> always returns 0, this return value is meaningless.
> Also, there is no need to check return value which calls
> "drm_panel_add and", error branch code will never run.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Makes sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
