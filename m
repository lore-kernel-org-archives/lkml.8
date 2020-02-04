Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404ADC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1339220674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cG81154L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgBDRCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:02:37 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42452 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBDRCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:02:37 -0500
Received: by mail-vs1-f67.google.com with SMTP id b79so11790187vsd.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 09:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tbyhy2j9tl7lmdNZyQW97ifEWRaHT4auclOyiJhATrA=;
        b=cG81154LPl6MHpTi4K0mfvhqs8a7wrBNf08IQEhTRcKMO8cBXjk/69NkI4v5yGZDU1
         BN4jB3aRGY2vhXNVlTk5CJsvASg/55gcEfY1wmEX2HR5LLta90Ea9vB3mGkoWTakKO54
         2XdBgvH8iy/T9ZJnPkLGhWxyUEnPpaf3TrA/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tbyhy2j9tl7lmdNZyQW97ifEWRaHT4auclOyiJhATrA=;
        b=Gkzj3KzfbDWuTNlzRUdO3wIAeAnfcgLf1LQdX96InIZ7hRAuaoBnYrhScjs3AMEmSq
         O3CED3BDcdWY1uw4IvV9ddw2EBfP3f2cgThctWqiWPt6WWDhrWRzpbPUUm8qfyhm17wZ
         cXfbHqPqgA29UiUC4NqkU1cN7M8Qhbg5ty488fs9BEmkGX/sJOc3P2Pb5dJ8Sjx1fWeh
         OJgBhc70zbtzzjiHOrwUkKjFAave3r0Eshy2GwTZE8kN2oeDKgRcJdDaNq9UW/idIfic
         Mpc5/qWLVZ2brUgTUBhPyZvrngtKf7Cee3pMJ9buUnWJhykukFkxyIVHuTqG7Rtr9sbc
         u7bQ==
X-Gm-Message-State: APjAAAUDuJ3rjlZr1/h37i4X1YJ81XVjq4VmZJ8rWBca3QWn0LeoifQK
        Hd9ZsD9mSsc3E2c0xHEr3vJhIQ7xR+M=
X-Google-Smtp-Source: APXvYqzq7dtpm6P8/EeleQLLGpEx5iF5sCV7E7zxY66lQ3Ef04jopvfZY4rY7KMpVlkABU0PruKKfQ==
X-Received: by 2002:a67:1983:: with SMTP id 125mr18918334vsz.63.1580835754235;
        Tue, 04 Feb 2020 09:02:34 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id a126sm6600475vsc.15.2020.02.04.09.02.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 09:02:33 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id 59so6984199uap.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 09:02:33 -0800 (PST)
X-Received: by 2002:ab0:5c8:: with SMTP id e66mr17743329uae.120.1580835752473;
 Tue, 04 Feb 2020 09:02:32 -0800 (PST)
MIME-Version: 1.0
References: <1580305919-30946-1-git-send-email-sanm@codeaurora.org>
 <1580305919-30946-9-git-send-email-sanm@codeaurora.org> <5e38c092.1c69fb81.4fbb2.d9df@mx.google.com>
In-Reply-To: <5e38c092.1c69fb81.4fbb2.d9df@mx.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Feb 2020 09:02:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xi=SFAjz9dAJsz-UXNPpGoC+FT5j77t+r5xCNfGMgViQ@mail.gmail.com>
Message-ID: <CAD=FV=Xi=SFAjz9dAJsz-UXNPpGoC+FT5j77t+r5xCNfGMgViQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] arm64: dts: qcom: sc7180: Update QUSB2 V2 Phy
 params for SC7180 IDP device
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 3, 2020 at 4:53 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Sandeep Maheswaram (2020-01-29 05:51:59)
> > Overriding the QUSB2 V2 Phy tuning parameters for SC7180 IDP device.
> >
> > Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sc7180-idp.dts | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> > index 388f50a..826cf02 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> > @@ -276,9 +276,11 @@
> >         vdda-pll-supply = <&vreg_l11a_1p8>;
> >         vdda-phy-dpdm-supply = <&vreg_l17a_3p0>;
> >         qcom,imp-res-offset-value = <8>;
> > -       qcom,hstx-trim-value = <QUSB2_V2_HSTX_TRIM_21_6_MA>;
> > -       qcom,preemphasis-level = <QUSB2_V2_PREEMPHASIS_5_PERCENT>;
> > +       qcom,preemphasis-level = <QUSB2_V2_PREEMPHASIS_15_PERCENT>;
> >         qcom,preemphasis-width = <QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT>;
> > +       qcom,bias-ctrl-value = <0x22>;
> > +       qcom,charge-ctrl-value = <3>;
> > +       qcom,hsdisc-trim-value = <0>;
>
> Actually, I'd prefer it uses /bits/ 8 here if it's just 8 bits.

I have been giving the opposite advice and I thought in general Rob H
suggests against adding "/bits/ 8" unless it's absolutely needed (like
for an array).

One example from
<http://lore.kernel.org/r/97cd8c1d98d7406347e4e48f4c7383a394a2ae93.1451997697.git.oreste.salerno@tomtom.com>

> > + lp_intrvl = /bits/ 8 <0x0A>;
>
> If the size is not 32-bits, you need to state that in the description.
> There is not really much point in making these 8-bit though.

-Doug
