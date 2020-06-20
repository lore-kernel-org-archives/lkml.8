Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37286C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 20:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04FDE2469D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 20:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O2v3CokR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgFTUoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 16:44:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40290 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbgFTUo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 16:44:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id n23so15217126ljh.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 13:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ctY1Wy9wIIIcbQLpOXjoHpHxkeNAAsK0lL/c72YppyU=;
        b=O2v3CokRst/vy3A+uiSf4+WOQv/7+8oGHSGKF44cG69xXPba/65IxO9vm/MuwdhUp5
         OmxmT5M1sIiAkW4E/K7YlcHIRMfawaAfHxCts8wS3g3EHM4wwyxK8/CAmOI+3Byv+bdf
         tWDCSaModGS2huVaIsqGxE2n4+E08fwbMEVKOdHw/Z/WcL0qaeIpJQJ5v2DpyLvALSCr
         F/Q4lu70nVdxlNYuA6CXpnFFRvTMvcXflkz/I0lA2bCZlwDxSxmVDrwtKhktGm02Rjn3
         Y2bcS67UG958vhQiVpGaldqjpisCJNCYm+jEIBMjUO6+kosucgpAY9iz1ffpf9cqgmHC
         mDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ctY1Wy9wIIIcbQLpOXjoHpHxkeNAAsK0lL/c72YppyU=;
        b=TMaSF23m9zzrBVxgbVFDmT7/vxsjSOQlUzmFrGTySTtTgUPxLgW90zRktzFBjwNyfj
         P0fmcCEsmHse/T/ckAsAMIPejOP7HhJioXRub5rkDnbAUlgj52d/87g+7KOtL6Tqwe3s
         SVQk6AJz7pypBr8mBDH26Q9cal2OUy0Ui+oIGHSLOjdZmBv/PD42VixGbNQOSkTQtRYz
         1LQ6Bx3Y7akHeEJnZ6h+a3r3+mOLbt9i2cWJbLa4nu43shCvzdcZ7IRgowv+nnHEfq6G
         HHJHCwJ++gX84T2qnXHJj8kCKGPfPl9jiGv4GT+DSyha8Ha6VwSNqWFABxnetLcqWMkx
         Q0XA==
X-Gm-Message-State: AOAM533wFOEXLWjaQdFQ8oZ7U2NPT3D1b2AajUU4HtEUwikM8F1I3EiR
        xcbq13kEcuvNYkxJC8rjtDUMmqnzfG899qVeZZU/uw==
X-Google-Smtp-Source: ABdhPJxBM1udCjVBlr0yRSi7Ob7TlqTZf8Wuo6lMRWikVhe0vp5cJc9bcgk6tgDNV0FWDPtXeY2aQNoyhRip/C3VkZw=
X-Received: by 2002:a2e:a40f:: with SMTP id p15mr5232818ljn.286.1592685807390;
 Sat, 20 Jun 2020 13:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200612120609.12730-1-paul@crapouillou.net>
In-Reply-To: <20200612120609.12730-1-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 20 Jun 2020 22:43:16 +0200
Message-ID: <CACRpkdZwFuiCfJNMrO3aH0eZnnmX__-5EjRnrR8tHh4gqSB=1w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ingenic: Add ingenic,jz4725b-gpio compatible string
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     od@zcrc.me,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 2:06 PM Paul Cercueil <paul@crapouillou.net> wrote:

> Add a compatible string to support the GPIO chips on the JZ4725B SoC.
> There was already a compatible string for the pinctrl node, but not for
> the individual GPIO chip nodes.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Patch applied.

Yours,
Linus Walleij
