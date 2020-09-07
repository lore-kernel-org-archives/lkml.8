Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19046C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A1C207C3
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NaTzQpnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgIGLxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbgIGLui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:50:38 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FCBC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 04:50:37 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u4so14898451ljd.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 04:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OprOp2em24X5m4o3PUof0yAN4YU+uTpPGAtCtWvXlNA=;
        b=NaTzQpnWPET6m3hR4pMK+Fv+kYVcmvBc6HSvONrngdeQJAY5jSkF4I7Rh04pSSR5JH
         f3s0qTUgVu8be6iyHOy5mo9ylnHUElRgWhD/DigPwM7XyshB28wNYN7Z+Zs1cZ3Wwc/P
         muwbagslDBfXwYh1+Fb6Lh8Nl0efiAfVx3EWChUD1IgdKa86sd+l7Y04ox7i7MY4jwty
         HGLaf1ULo8tpy3SATPrT9caiKm+MvfFuAbhI/acNo40ltH6M1kNuSjyeu6rRY3MUPB9R
         uRaP0Qb09D7AbVkgl5uDt/qBs/jUl3yFSUjc8BpBcqOQBKmFXWO+SBJEL9ziVzUmJDsQ
         OzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OprOp2em24X5m4o3PUof0yAN4YU+uTpPGAtCtWvXlNA=;
        b=IBPfbGl1awHUNCaW8XquRPrLvNwxj5RPOl2u0U9zTtKwKfR0Z1ajD0ibjT56OtqEA2
         2s1NMK/DW700MrQpAibSDMsSfpQ2b8XzzMJt2C5Gzpe+GkdWi4FbDiglOTf14Dyky0wz
         aI3Gg90bEXT2OCV9KGPWWqml9pAIAsmbsU/wL12LRILTXeJvrE9PEvn128i1pvYR33mF
         6VrlIOYh2p2fNDrBuqF0zQn+FtkptsukygZurYJhdMeinAKgdTcEgKSH8utSM6GE4XSY
         3UMaRmBBepmUlNGlobW3xU3zft6ZKLsmWurX8JKckzkNHHcA9KmXWETSR9Vy1uq1dGZc
         cXcQ==
X-Gm-Message-State: AOAM5302sSo54TVi6tnPFppN+2y82TONnBof+p/58KkZaGTcquJN2oev
        ZrBD70osGk6giH4m3f1OWXLEBFZe+qi3acd77VpMnQ==
X-Google-Smtp-Source: ABdhPJwvpzbst+CDx7Bzy8imZV6B8N4xGrr79yQL6ltKSsY4hsLQN+7461X7PW78zu3yPdvlRnWCw9G/oLrn1pHgrlU=
X-Received: by 2002:a2e:9d04:: with SMTP id t4mr10548159lji.293.1599479433311;
 Mon, 07 Sep 2020 04:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200812195020.13568-1-dmurphy@ti.com> <20200812195020.13568-7-dmurphy@ti.com>
 <CACRpkdY1pCcUONFhEXeyXa3f+JFB=Wg1nSB-qRJF5njM=L+CVw@mail.gmail.com> <f253bf11-3422-4f49-fce3-ac6b51d91c25@ti.com>
In-Reply-To: <f253bf11-3422-4f49-fce3-ac6b51d91c25@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 7 Sep 2020 13:50:22 +0200
Message-ID: <CACRpkdbSWdkZzHZ65jqz3=u=zLH1xivx_7+kwKDvK+58FKP0Ww@mail.gmail.com>
Subject: Re: [PATCH v33 6/6] ARM: dts: ste-href: Add reg property to the
 LP5521 channel nodes
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 8:39 PM Dan Murphy <dmurphy@ti.com> wrote:

> > I don't knof if I should just apply these two patches or if there are
> > dependencies that need to go in first. I guess yes?
>
> I believe all dependencies have been met for these

OK I applied this patch to the Ux500 tree!

Yours,
Linus Walleij
