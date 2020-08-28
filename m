Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7F2C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D485C2071B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dH60LbKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgH1JNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgH1JNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:13:16 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48B3C06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 02:13:15 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id r13so527854ljm.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 02:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N7L8i60F9eXa/fO1dPmqcITFGbW2CQuVMKnRYG3BInQ=;
        b=dH60LbKjFFEyhbG5y4eZJdfG4cUxHykDgQ5LR4pLNxDH5aBrVYI6KOlAk0ltt6Mu6p
         78ZmCZEsbS+UAVFhdntM6BwqJDiQpTpi6fWBHqrJwtSc1h0Ri8gplUdZhcEFdk5Ecwst
         RstftHmffI0hLIZqOjubXCnbWEcW5X7jTpbWldVVFWUT/j5HvzZGVqsS+KYo5lULRo42
         kV6eLi3Mlq0f0w4fyUXHa8y5hTiHncJll9IHEgJGQMiQIC8mVtpWbmfuPzdlw3FD6Esb
         RJU+WyGCDHQF1Ufes5/iI1Nin0RcyW9Fv828TVzU5tzpbLZsY6NoQr47Re9sd1U30G8T
         a7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N7L8i60F9eXa/fO1dPmqcITFGbW2CQuVMKnRYG3BInQ=;
        b=dMRu9V0lazcYKAB6yVuLfYfkB2jQUYhHGlncc8NpLdMajGLExPYmx8rINEuPGRbk8s
         gaaFuUWERvjbigV9J3Inq47hW7HQpW3fqvF6SK+9r37IL+oSolOrqN6E6bl5k+8tDrrc
         2uSBWOl2ND1ZLwGpkOjV3Pgkshw8U/OsUNllDTd9x8N6R3MlJI9ZBsKP51mFtLVOpR78
         +KdfTq7z87GUA/MlEp54ekvQ80AqWxlyLJCfbgmrWoaphgo7lqU1O5px5stCZzKGPGSI
         NsR6AEmduguk75oFiFWJS9wk72cpkbe92xkMO1bSxDj7QvZNsuwJTPWvdpq/J4x5X2ri
         4dNg==
X-Gm-Message-State: AOAM530XEqhjDtESA+8Sir1Ndqw7+ESEtL9MA3ddywlOiXkw9KfyfsG3
        rSyOWpRwmMe2aXQw2WtS9mD4MEuW4fbl3Y8iWrNxXA==
X-Google-Smtp-Source: ABdhPJw9cJHM/dgA5WuWt8DXsMACRAKO75fJ1GThCdcY+CTeCwz+H023UQbAlPsfoDgX0D7pCTVP4BQrmaMIIZwHbls=
X-Received: by 2002:a2e:81d9:: with SMTP id s25mr430626ljg.104.1598605994230;
 Fri, 28 Aug 2020 02:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <1597218741-24899-1-git-send-email-Anson.Huang@nxp.com> <20200818021251.GA2143309@bogus>
In-Reply-To: <20200818021251.GA2143309@bogus>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 11:13:03 +0200
Message-ID: <CACRpkdZ+KXuD8P9_EzUubUf8KFieWXXZL9feoVaDusPDPU-YvA@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: gpio: Convert vf610 to json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, NXP Linux Team <Linux-imx@nxp.com>,
        Stefan Agner <stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Aug 18, 2020 at 4:12 AM Rob Herring <robh@kernel.org> wrote:
> On Wed, 12 Aug 2020 15:52:21 +0800, Anson Huang wrote:
> > Convert the vf610 gpio binding to DT schema format using json-schema.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> > changes since V1:
> >       - fix reg property to pass build;
> >       - add "additionalProperties: false".
> > ---
> >  .../devicetree/bindings/gpio/gpio-vf610.txt        | 63 -----------------
> >  .../devicetree/bindings/gpio/gpio-vf610.yaml       | 81 ++++++++++++++++++++++
> >  2 files changed, 81 insertions(+), 63 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-vf610.txt
> >  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
> >
>
> Applied, thanks!

With the increasing number of nice GPIO yaml bindings I'm starting to
think we should create a Documentation/devicetree/bindings/gpio/common.yaml
and try to extract out commonalities, but your intuition is gonna be better
than mine about this, do you think it's worth it?

BR,
Linus Walleij
