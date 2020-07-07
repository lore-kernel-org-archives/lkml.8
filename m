Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84C0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90EB420720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nshsoOrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgGGWMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbgGGWMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:12:36 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5E4C061755;
        Tue,  7 Jul 2020 15:12:36 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k23so44830086iom.10;
        Tue, 07 Jul 2020 15:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U4CnpBDELPfqZ1fbnb3srfTvu3fBxT8MeUyNFAnMTQQ=;
        b=nshsoOrgwi7Nfp1mYN1cvUbjPvB6hNNg4IfFIdAhm0SbH+9kP46hKneJOxm4qXEPk7
         CIqy+u4vEmAEod2DP9mEqisAxrhXJOwB4/3PZ2JnSA7Xq0nC2z01CA+eyLNOmUOHYJJ5
         WEnDJZMeN7NFoiwPflSN2yGrpb3oiJNxxgOmDUiMgTQyW0k57ij6y2k3DHie2DKQT5nO
         wNwkU3tVUI8dnLQzjyL6tvKdysd9pWwh6yA1BxjN4PYB0139zjp6zX42ENzFWn0lI9bV
         OXwE4rOpHg+7h8f8qGk3stQXQfhR95AG5ghtmwBqnyzBpHN/w60XbZVVLj5Fgg29q3Wf
         oaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U4CnpBDELPfqZ1fbnb3srfTvu3fBxT8MeUyNFAnMTQQ=;
        b=N/ft5GkVUNAG5FGmUJPtGk3Mqs+7xZXYoQ8mQBHBXziKpdQSyX9SRAM64aDj0vsj0U
         BR+nfNV8iflWznqXRvXpRyoH4RsD/CS+sdxI4k2//yKnYMFq0DlhhE73D6RBHUm6Bf4V
         0mKDAOEotmICW9Vm/n/zyn9PBhUl0PCzjdDXSrdERRm4biSnESF8Khg54O7zYWzmRXr7
         9kC4t996hQG4UbRB4Tx10DxfO2I1SAUxGscxk+V4UHG7F8mjrvY3HmzdoWncfMq0Oe5n
         ubvIxrs+AeF77Ze5e8vjlirBG5E3+Lu6LKBlQnbhmYxTX2CWUmZz6O02rM2LmRy9eVN9
         Gt4w==
X-Gm-Message-State: AOAM532mP6EcKtKC7rIoumKyQwuVAyNcWtoOY5npXeRhS8WPxb//V5VR
        QccHmxOkIuchetYKNgajhoFpbLlja0kLhYRXc2k=
X-Google-Smtp-Source: ABdhPJwYWDqXpQ3fjMT49ImNn7ATEM0gyBe4WlkeyxbhzDewpc5BWoAHkb/Wq0RHXXSGSy7q/2Qq0UXrlSfF4P/7FGk=
X-Received: by 2002:a6b:b2d1:: with SMTP id b200mr32012038iof.137.1594159955956;
 Tue, 07 Jul 2020 15:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAFXsbZrVZjiyO_G6z6T82t0xT36Zi2gGo0kPnt6n58R-rO3TVg@mail.gmail.com>
 <7f627cb8-2eae-cdc9-09fc-e3e612b5632a@gmail.com>
In-Reply-To: <7f627cb8-2eae-cdc9-09fc-e3e612b5632a@gmail.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Tue, 7 Jul 2020 15:12:25 -0700
Message-ID: <CAFXsbZpq9iY4E+TfMduipfeUr8cUZd4-EVO=+7b3WuOS5fF3cQ@mail.gmail.com>
Subject: Re: [PATCH] ARM64: dts: update MDIO speed and preamble for zii-ultra device
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 2:59 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Hi Chris,
>
> On 7/4/2020 6:26 PM, Chris Healy wrote:
> > Update MDIO configuration with zii-ultra device to fully utilize
> > MDIO endpoint capabilities.  Device supports 12.5MHz clock and
> > doesn't require MDIO preamble.
> >
> > Signed-off-by: Chris Healy <cphealy@gmail.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> > index 6a55165bd76a..98aa67a4c040 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> > @@ -132,6 +132,8 @@
> >          #address-cells = <1>;
> >          #size-cells = <0>;
> >          status = "okay";
> > +        suppress-preamble = <1>;
>
> suppress-preamble is defined as a boolean, so you can remove the "= <1>"
> part entirely.

Good point, I'll make the necessary change.

> --
> Florian
