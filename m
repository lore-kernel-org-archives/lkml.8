Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A5BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 02:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2BF820659
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 02:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2FcAITD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgENCkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 22:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725895AbgENCkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 22:40:20 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC01C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 19:40:19 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id s9so1293351lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 19:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4cErI3AscpNO2jykaWdRgxSDShuBARQicHYOzOkFX0=;
        b=B2FcAITDo8OkHtW3DZIV1grkQJEgpVzfrgtp/B4KO+r0+kVVTEKA5QPhZSmo9nYnJE
         oADABPqGsbNupidK8+8SNhVQoDPHaTV+bo9PpZ5Z4udffLQDL0vO+GBzvy8BVkpiJFmq
         W4U98ognAFTPWJZOaiTdbiJpgVb6lU6CWvmlbycvoAjNF0/FAk5brvEc6gwxqhZUV4bW
         pkux2Xu5Wz+C8sipIYZqPLzsGszAVdWrt5EsCwU9slksUIRqa0d/kzXYOL9XAtF6vasB
         CEaP4R19egNzfMHOEfu+OXnO2Sd19pjXXK5T1/73tpSA9aWJDH7MkzbLCyLBuEIRuywl
         mjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4cErI3AscpNO2jykaWdRgxSDShuBARQicHYOzOkFX0=;
        b=J9mVFXC1FND6+bCzHXRQ7H2hr/yEVJXZCpKYKOD7NTqY5pdf4HMuQT5oD8VnZ1dOqs
         6QjWW0YKuU004zuV4KQ8AzKREcTa59h+GUygTp6JfbK8l6Yt/Z3PeiAK+BsujkFz5w6T
         NUjux08ytv3QDm5zur+qG3ohddWFhF6AaEBs4j6vtYQatvaT8ebre4BmzqZBAB5SzVCk
         caMab61H2FWb+v+MH31X3oolrxlUNQU6bBDH06AMoVr4kZQTQCP4E5IImTWJJLbFkKRc
         sdAg2zFlnRpfOwtMV34qbgCKLh5UvIxrAh8FicDFtzb/5caxI8pg0/3P69kV/gbs89h1
         7iJA==
X-Gm-Message-State: AOAM530Tip+HKUTWSPH3p6O3cQIEm0slDc21NuidSYw5ddyPScNl2hMT
        OIWkmxv6S0WdnZSDE9m02zLXgzaV3HdZ3x+/nAA=
X-Google-Smtp-Source: ABdhPJykFjdGurpWwc8+7/0JB93hVc0BVhXikueHs05N38p4BgNJAr9FiqZ/ZNaYTXcIraPsA0gJlt3IUDxXjvHlfU8=
X-Received: by 2002:a19:4b57:: with SMTP id y84mr1607420lfa.214.1589424018105;
 Wed, 13 May 2020 19:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200513150007.1315395-1-lkundrak@v3.sk> <20200513150007.1315395-3-lkundrak@v3.sk>
 <CAOMZO5B582=tZ_YBCyVYFtGh=z5hZKFxP7XoUHEmH3jZsk2uYQ@mail.gmail.com>
In-Reply-To: <CAOMZO5B582=tZ_YBCyVYFtGh=z5hZKFxP7XoUHEmH3jZsk2uYQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 13 May 2020 23:41:31 -0300
Message-ID: <CAOMZO5BdiXCVXs+8jP7PoRvgKd1sxCu4KhjvJBvL=Qig2WOs4g@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/etnaviv: Don't ignore errors on getting clocks
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 2:09 PM Fabio Estevam <festevam@gmail.com> wrote:

> The binding doc Documentation/devicetree/bindings/gpu/vivante,gc.yaml
> says that only the 'reg' clock could be optional, the others are
> required.

arch/arm/boot/dts/dove.dtsi only uses the 'core' clock.
arch/arm/boot/dts/stm32mp157.dtsi uses 'bus' and 'core'

Maybe the binding needs to be updated and it seems that using
devm_clk_get_optional() like you propose is safe.
