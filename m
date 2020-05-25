Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AD4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D51BB20723
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jaoRXRcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390260AbgEYLlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 07:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388696AbgEYLln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:41:43 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EF7C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:41:42 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v16so20442477ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DwdjF0Ue67Sj/Pl5fSyKVWCmeyW6oEYcnXakGvQJHew=;
        b=jaoRXRcLC5ll4JhxX10uEVRJ41Q5RkA27cdh9uS3nKRej2LciDH6hzpvyUxipgi+U5
         gGEs5JM0h649U0962y9zxwKiEK9IhGlqgX9hr+iZfj4D9okOridFVnkhOZQT9aM6uKp4
         wKs53j3bIOKcr8Cg+1W/pbSgpwMmYbKoWrSO++MBe/+ieemSnRvP6HPyGTivWuWuHGZo
         Plou4TMB0zl9fqMtOdpZQTGHdysntDU7bfqdaQ8DkkpDH45NuPn/1WIJV2SzMCSdzEsK
         ZtssI9eE1l2buaJ6jL6BgbIWWKZGocl6SR3LjWdyBx5G3MiwEBjEsP/yXjSqn3zIz+so
         vYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DwdjF0Ue67Sj/Pl5fSyKVWCmeyW6oEYcnXakGvQJHew=;
        b=TZRsAIQ3kWot+8V13rOksj6Zl0jIYCAE2AZvndzUT7xjPV/km0wkn7GSOOcKGCUB/P
         MWnTefzNKZSVwCOsKQdDxx93cmGWBM9ryli9nIk4c9XILYJ9RQTS9/M5Rz7dXJKKBSC9
         xmeo78AFbejEMEkhdjenc90Ey5GtBqEssxlP7AqR49yeDz5pvPB4jwFnODOIkvC01NKB
         nAgH+JHzg/o985RWvFgZ4P6funKuJkBVKMYTEgveMtsQ/1zG3wE8vq4yT7I0SDH/Dvhj
         ZN1JftoI3I4SmWL0XJi487S7bg0oIcNWXJKgfoQgksfsUykMSp8njhQ3+kb6oTum2sqc
         GQ9Q==
X-Gm-Message-State: AOAM5300bapgZaA/QAi4A97DD+2XMg5Htg3Qz/6C37nOpon0bFpcp6HX
        6Jg06hArT0Qfj8p8Kvjo6DorXGpmBdr0PJUMrF/6i+J3
X-Google-Smtp-Source: ABdhPJzmAF2fPYPuX08EOV6Ek1vROzWyd4lTeFHVNjZzIF6Goyz2gdDExdfIB4Roq7kbyBarCt6itfaazrSXen7+9BU=
X-Received: by 2002:a05:651c:32d:: with SMTP id b13mr3226363ljp.283.1590406900778;
 Mon, 25 May 2020 04:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <1590234326-2194-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1590234326-2194-1-git-send-email-yangtiezhu@loongson.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 13:41:29 +0200
Message-ID: <CACRpkdYOrdXDMq8MJ2dPQSUf--zaX_tWZd9RYR2FQPHc0pujJQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: Fix return value about devm_platform_ioremap_resource()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 1:45 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> When call function devm_platform_ioremap_resource(), we should use IS_ERR()
> to check the return value and return PTR_ERR() if failed.
>
> Fixes: 4b024225c4a8 ("pinctrl: use devm_platform_ioremap_resource() to simplify code")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Patch applied!

Yours,
Linus Walleij
