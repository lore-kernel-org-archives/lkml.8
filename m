Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A95C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D040822B47
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uHKltIvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgH0ImG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgH0ImE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 04:42:04 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFADCC06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:41:35 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m22so5487484ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KNHfAA9c1rW26r8b3XpKfnc6lco5EHJf/DqyF4IQnJE=;
        b=uHKltIvyd+elQaC/FxlGXQPhY77dqRUJIAEshJY+kg7O7GiZ2doChKLmnuCNsojyFv
         XWtsBL+iSbkK8CgZnUZuhHi54H4Q0uzVSCYcroegnfH74cq2za0N2HiVhVHCXBNoh116
         h4qfeqqTJzbzVWBB5jB7eTXxVmkvRDGOW3chqmma9sG9zaIMxeonKjXa53Y1iNSR9PPJ
         NR3KdQfWrGh18axOYUFKhyF+SmJiwliOuOIoKNHIMQ1USfBBeRImeR0HQMDgd8KCR//y
         53hpVgiCHZS26XCIRnvHZtNmo/JGqXyH4gCWXsocXsa2NvlLXYUJMxdHybQf8sl9Ou7E
         YY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KNHfAA9c1rW26r8b3XpKfnc6lco5EHJf/DqyF4IQnJE=;
        b=iBuaVQMF4RWm9q9S3MJrKP2Qu4k1pr7kBDz0fUsdAgh0rGzTeHUHZaQJVJOcGJJM+f
         qyNQw/6DrNlD5JQrHkWp5u8z5JxmZsjwaOD1492oGiksJ6pQJxhqugSo8T7NgvEL6yyz
         aBBixs+d8JO6FfhiBegZinko0fEI5e/gx8aOXnRhU8maN0Reg0ztEY/jxxHe+W20ks0s
         FDeAzKsDL77dRqSV74hGvnFoRWf+EyR7DA38WfkFuZigDpYr6QepuccDlgig92976AdH
         TRwugVjsgAJkNUl0HYf/DeSJOesZf2MqF68uWH0O9iglkFeYES0w81vtWexmy1bO6XGC
         iNxw==
X-Gm-Message-State: AOAM532imoDCUSXwu+QI4zAprDmtX6ZOVMmLKM5rML1j+7I5n78EB+FV
        mPaqwsDLOVbN92ORw5qcYhaIugLGlIhAZoneaD3reQ==
X-Google-Smtp-Source: ABdhPJyoexWx0lQntuDJb/srGDOvASDiz+F6QURT3uDs8tPb+ypjy3GzKHexyWtdLFyvuDKYcfrpblkjhfpNDVWMtWA=
X-Received: by 2002:a2e:558:: with SMTP id 85mr1888049ljf.293.1598517694135;
 Thu, 27 Aug 2020 01:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1596461275.git.cristian.ciocaltea@gmail.com>
In-Reply-To: <cover.1596461275.git.cristian.ciocaltea@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Aug 2020 10:41:23 +0200
Message-ID: <CACRpkdaE0HZVN6QxMpA5+509iZ8kZ7A5S5XwuiRoyM=0dpGGSw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add Actions Semi S500 pinctrl support
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 4:21 PM Cristian Ciocaltea
<cristian.ciocaltea@gmail.com> wrote:

> This patchset adds pinctrl support for Actions Semi S500 SoC.
>
> Pinmux functions are only accessible for pin groups while pinconf
> parameters are available for both pin groups and individual pins.
>
> The pinctrl driver has been verified using RoseapplePi, the SBC for
> which an initial support has been provided via:
> https://lore.kernel.org/lkml/cover.1592123160.git.cristian.ciocaltea@gmail.com/

No comments on the v2 patch set for more than 2 weeks so patches
applied. If people find issues we can make incremental
patches.

Thanks!
Linus Walleij
