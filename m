Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA607C2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85B4F208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O61jTEnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505988AbgDPLAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505958AbgDPK7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 06:59:51 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE321C03C1AA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 03:52:19 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e25so802116ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 03:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YqF+/z+LBaU8X8GuG/beRb7kQZb2oP+PKGTiqRFntc4=;
        b=O61jTEnjgd/MFLC0C7gD3v1f1K7hyNHbLJ95BLTIPmXhpMdq8JPWImgV01LKxrHzWm
         igTpaZEUPXh7MExhOaBMX5tEjxpldqlveCYsKibvzkrPDDL06Ziieaj1qJ7z+ZUrqp4i
         uCjsUClcCcMwMaVHft8rA5XJkEcLdYMkYvKfZMSVYCDsQdNkPVGCCxjxIUv8h0nKSeJm
         Uk69cVP7q6OIVern4CJxyHsctCSRUd7O8kNGCbCe7tflbdhqHJwibVNgjk7z6H6Uhf9M
         hYPA9tDCf6KamVuL+lF+bE9gSfx38ZsvU3mkfA6aWhuQxlie52caYXgMBN7Vg0SIRZn+
         uJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YqF+/z+LBaU8X8GuG/beRb7kQZb2oP+PKGTiqRFntc4=;
        b=rsKO2tN5Vo9XZLgnQT1giHY4rT5f5Su1iWZj7so86AMAaKfjnViSJaCs+NeHDKGNC2
         +e4OFlkxtZso+SvhjqgtJLdh4T4LIHFyaBDnn6JnpFD/8PdmYVHEOmb4vuscCg42OGRV
         rEMo9f7i/xBjfPNOp0sprP/jXjcj+4YQHKJxW53CxbW96uHF+x/wrvKBmNpngzcTapr4
         SyDg1HUQgags9ktykuCHPdfoWvLo1sgg7U7+Tu3olmfUTqNICdyKUngKINKKawhzmuV4
         VQy7pyLzucjdsHOwNiD8+LaW7CxsFgYlTIJUYMkX1fQ+sd0Fdjydc3oY1FFZBKDvpWMF
         Nf+g==
X-Gm-Message-State: AGi0PuYaoeCOgW4iBZhkuWfzUybL3Nrgqbk/Z0kLzI5tG9vdIOUUqMwr
        8Lu9N+er0WYJi6bgDXBBezIX5WpFM51O5ZUMM6sR1qJl
X-Google-Smtp-Source: APiQypJDV4zLPL0CbEVbqxkKUu4/iTCpV9lW81D7Y7R39PbjZq6AW9MqfediIKTHTI1HTYan1cmCNF4yfqCv5rHzELk=
X-Received: by 2002:a2e:8805:: with SMTP id x5mr2581058ljh.223.1587034338213;
 Thu, 16 Apr 2020 03:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586359676.git.mchehab+huawei@kernel.org> <d8b0656cb3f1eacb10ca6168babb235d59a853a1.1586359676.git.mchehab+huawei@kernel.org>
In-Reply-To: <d8b0656cb3f1eacb10ca6168babb235d59a853a1.1586359676.git.mchehab+huawei@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 12:52:07 +0200
Message-ID: <CACRpkda+5VET+dyyQZk4GKjKCDNDYMP43VXL=0u5FOhEd0C=ww@mail.gmail.com>
Subject: Re: [PATCH 29/35] MAINTAINERS: dt: fix pointers for ARM Integrator,
 Versatile and RealView
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 5:46 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:

> There's a conversion from a plain text binding file into 4 yaml ones.
> The old file got removed, causing this new warning:
>
>         Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/arm/arm-boards
>
> Address it by replacing the old reference by the new ones
>
> Fixes: 2d483550b6d2 ("dt-bindings: arm: Drop the non-YAML bindings")
> Fixes: 33fbfb3eaf4e ("dt-bindings: arm: Add Integrator YAML schema")
> Fixes: 4b900070d50d ("dt-bindings: arm: Add Versatile YAML schema")
> Fixes: 7db625b9fa75 ("dt-bindings: arm: Add RealView YAML schema")
> Fixes: 4fb00d9066c1 ("dt-bindings: arm: Add Versatile Express and Juno YAML schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
