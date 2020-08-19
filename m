Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35665C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 22:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E79052078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 22:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFUbxE5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHSWIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 18:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgHSWIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 18:08:36 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC7AC061757;
        Wed, 19 Aug 2020 15:08:36 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so27101516ljg.13;
        Wed, 19 Aug 2020 15:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QRPA5r6A792vgu7L2xso4haqi9Meln0z35JzsRxIX1U=;
        b=VFUbxE5as5MRNGN3HpPJ5HHpZtN5/sa2FqMEJI7zPplNACsRP4hD0Dr791JSLNK8fv
         k5SBVDGjqZirLkXw1/YJ/UMPwcYYk91G1CqC0xLXi1MGWKo1l9VoneEEz38vTsKfTOqu
         Hj5NmyEs3sdyRKl2T9qqohmsbaDTDxsYpG5Q51nbS1e7vQ1cLBkYUYbmx0bs3nWz/ZcD
         Jft05s5lLO1IMjbEL60ChsWquOUlJ4XDPjKd6offWjN+CoyKmVv6lxynCNAjUCxVUecn
         mDfq3cRWLUGYb8ga2QnMQMnUIVeSdsWWmA+i4AJAGJ1Z+OPvlGetObMwz/5K/QwhKvxk
         H/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRPA5r6A792vgu7L2xso4haqi9Meln0z35JzsRxIX1U=;
        b=brs0fdLrwSa/lYGP+MWV3pzukGu1QkVk01zSYXxCr8+dc9EHgIqIznF2dkrImq+4oW
         63wTLZ5oEiHT8lOTgOXMDRUOpyM5ECRa0I6zncnYP8nvJ2sbS81YakrM2B8lNRYYDhs8
         2oB/BE0d5GPMssJRPKtgWt/usb9iL/jPVqQ47XjLykQZfx/3xEwDe0hVUtEfZiZL46AH
         gje6OwmXifpqQnZpyCggMinLt0sD5Z2yFRkFnd4sATSzZPtKCVOexVaA4MPcTJbh16Uz
         YJQFDMLudRwWuVOmlElM7XGiZBx6+KrQ5FBDKMzdMNJ2Kv89I4AUyCyEucU+vtdyZwq8
         zg5w==
X-Gm-Message-State: AOAM5307t6tVy6WuGBPLU67MwxmiJmsFvHfKlBfp5nPiDj8C322wJ2b/
        +/G+YekVcvGnp+6MPSdOh30MZ7yjulLtiOsFH4WM2xa8
X-Google-Smtp-Source: ABdhPJzCqr+QXSEyqWgeRwzpjb8GtFJmLprLj/wkClavtr5xcbY4074z8nl5npP5BKl+3BHUgUb4aw+GF78drL/eoPo=
X-Received: by 2002:a2e:80d3:: with SMTP id r19mr150402ljg.310.1597874914921;
 Wed, 19 Aug 2020 15:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200817022746.3115005-1-cphealy@gmail.com>
In-Reply-To: <20200817022746.3115005-1-cphealy@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 19 Aug 2020 19:08:24 -0300
Message-ID: <CAOMZO5D=g-_+gmZ+=tDvEOZNqW9zBFTkKOWamzSoFWgm_fvkAQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vfxxx: Add syscon compatible with ocotp
To:     Chris Healy <cphealy@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Sun, Aug 16, 2020 at 11:28 PM Chris Healy <cphealy@gmail.com> wrote:
>
> From: Chris Healy <cphealy@gmail.com>
>
> Add syscon compatibility with Vybrid ocotp node. This is required to
> access the UID.
>
> Signed-off-by: Chris Healy <cphealy@gmail.com>

Would a Fixes tag be appropriate here so that it can be backported to
older stable kernels?
