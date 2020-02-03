Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F55EC3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A292082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bVcdqWYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgBCSfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:35:16 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37869 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729061AbgBCSfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:35:16 -0500
Received: by mail-ua1-f67.google.com with SMTP id h32so5719214uah.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 10:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=opEKTCgEyzNySp8NgE/YRaLRspNXo0xH4Ilo0G3sH6g=;
        b=bVcdqWYsw56zW7nr9YoFlMnqcxjJDVj4/ok84BJS1e8Yb8dBneL7jgN610vLEkKq8a
         INkAkqv0Gm0TTiPCevDSoZcm0AI2vPcC3Ia+jWEpSfGElrgc/84lkQ8E/TslqqrzS4hM
         /7qmk6g9qZNpsUtt5mpdv3R6s5vF52G3k+kak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=opEKTCgEyzNySp8NgE/YRaLRspNXo0xH4Ilo0G3sH6g=;
        b=sNttEK8S7LgAP0zJLOyGRq6MdAQjW5KX/WKZUVWMy71qhEkN9eucaGF4NYEIyXJHtz
         kLmfMrwIRmO+aMj8+4XZ6SKvY47InKeazdUzxNIKyLIiR6igFwEmlIfL8tjWhJxYjO5f
         5b4NFdnW/pW97I0OGOlu7IRHQy32adLIOqvNu3ZwktkCcHYdHv8Hj/WF6wVYd1etU/+D
         4If34cCSecvUFZkO925/hM7oLDCP5/ZvLUXJ9FxKTeWoCgkI3d55x4uIJzr7HKu5d7mI
         JdRG3RoaCJRjmhl1MAhiSSGjoAgCvciR65p8t244Db3VQC82tenIPwqGGwOv+ApMv/38
         caVA==
X-Gm-Message-State: APjAAAUyxFmWIp/VJIMvYQYZvN9n/HV2J4D5pDp5vuq+InAcIUJUW9dz
        9MfxcHQ7YK6U4RIKzGW1aiac5Z29Gww=
X-Google-Smtp-Source: APXvYqzRg1/r+WOtlW5cKP7P/zW2x97tFm/6PRXZZds22JV0K4w4t6Ul+6zVMXu/kuaW5189sHQQyA==
X-Received: by 2002:ab0:72d0:: with SMTP id g16mr14069847uap.11.1580754913911;
        Mon, 03 Feb 2020 10:35:13 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id y186sm6366697vkc.47.2020.02.03.10.35.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 10:35:13 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id b69so4137653vke.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 10:35:12 -0800 (PST)
X-Received: by 2002:a1f:c686:: with SMTP id w128mr15117676vkf.34.1580754912485;
 Mon, 03 Feb 2020 10:35:12 -0800 (PST)
MIME-Version: 1.0
References: <20200130211231.224656-1-dianders@chromium.org>
 <20200130131220.v3.7.I513cd73b16665065ae6c22cf594d8b543745e28c@changeid>
 <CAL_JsqLj8WbP=oXAovyVFOc-58eFr5xS5EJK=kpAK-eT7_TyNw@mail.gmail.com>
 <CAD=FV=X=vAM7HZmA7pCm707rb8u+ogEqPUu_F_ueiS9GwbVwuw@mail.gmail.com> <20200203162954.DE0AD2086A@mail.kernel.org>
In-Reply-To: <20200203162954.DE0AD2086A@mail.kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 3 Feb 2020 10:35:00 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VmvgjUqRzFYNbb_w7QGq0+H9jnT=aS1Zq=PR7ybgSLyA@mail.gmail.com>
Message-ID: <CAD=FV=VmvgjUqRzFYNbb_w7QGq0+H9jnT=aS1Zq=PR7ybgSLyA@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] dt-bindings: clock: Fix qcom,gpucc bindings for sdm845/sc7180/msm8998
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Harigovindan P <harigovi@codeaurora.org>,
        =?UTF-8?Q?open_list=3AOPEN_FIRMWARE_AND_FLATTENED_DEVICE_TREE_BINDINGS_=3C?=
         =?UTF-8?Q?devicetree=40vger=2Ekernel=2Eorg=3E=2C_Matthias_Kaehlcke_=3Cmka=40chromium?=
         =?UTF-8?Q?=2Eorg=3E=2C_Kalyan_Thota_=3Ckalyan=5Ft=40codeaurora=2Eorg=3E=2C_Mark_Rutland_?=
         =?UTF-8?Q?=3Cmark=2Erutland=40arm=2Ecom=3E=2C_linux=2Dclk_=3Clinux=2Dclk=40vger=2Ekernel=2Eorg?=
         =?UTF-8?Q?=3E=2C_Kristian_H=2E_Kristensen_=3Choegsberg=40chromium=2Eorg=3E=2C_Michael_?=
         =?UTF-8?Q?Turquette_=3Cmturquette=40baylibre=2Ecom=3E=2C_linux=2Dkernel=40vger=2Ekerne?=
         =?UTF-8?Q?l=2Eorg?= <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Mon, Feb 3, 2020 at 8:29 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Doug Anderson (2020-01-31 08:48:37)
> > Hi,
> >
> > On Fri, Jan 31, 2020 at 8:43 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Thu, Jan 30, 2020 at 3:12 PM Douglas Anderson <dianders@chromium.org> wrote:
> > > >
> > > > The qcom,gpucc bindings had a few problems with them:
> > > >
> > > > 1. When things were converted to yaml the name of the "gpll0 main"
> > > >    clock got changed from "gpll0" to "gpll0_main".  Change it back for
> > > >    msm8998.
> > > >
> > > > 2. Apparently there is a push not to use purist aliases for clocks but
> > > >    instead to just use the internal Qualcomm names.  For sdm845 and
> > > >    sc7180 (where the drivers haven't already been changed) move in
> > > >    this direction.
> > > >
> > > > Things were also getting complicated harder to deal with by jamming
> > > > several SoCs into one file.  Splitting simplifies things.
> > > >
> > > > Fixes: 5c6f3a36b913 ("dt-bindings: clock: Add YAML schemas for the QCOM GPUCC clock bindings")
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > > >
> > > > Changes in v3:
> > > > - Added pointer to inlude file in description.
> > > > - Everyone but msm8998 now uses internal QC names.
> > > > - Fixed typo grpahics => graphics
> > > > - Split bindings into 3 files.
> > > >
> > > > Changes in v2:
> > > > - Patch ("dt-bindings: clock: Fix qcom,gpucc...") new for v2.
> > > >
> > > >  .../devicetree/bindings/clock/qcom,gpucc.yaml | 72 -------------------
> > > >  .../bindings/clock/qcom,msm8998-gpucc.yaml    | 66 +++++++++++++++++
> > > >  .../bindings/clock/qcom,sc7180-gpucc.yaml     | 72 +++++++++++++++++++
> > > >  .../bindings/clock/qcom,sdm845-gpucc.yaml     | 72 +++++++++++++++++++
> > > >  4 files changed, 210 insertions(+), 72 deletions(-)
> > > >  delete mode 100644 Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> > > >  create mode 100644 Documentation/devicetree/bindings/clock/qcom,msm8998-gpucc.yaml
> > > >  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-gpucc.yaml
> > > >  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sdm845-gpucc.yaml
> > >
> > > I'm not seeing any differences in sdm845 and sc7180. Do those really
> > > need to be separate? It doesn't have to be all combined or all
> > > separate.
> >
> > They are the same, other than pointing to a different #include file.
> > I debated whether to put them in one file (arbitrarily named after one
> > SoC or the other) or to put them in individual files.  I got the
> > impression from Stephen that he'd prefer them to be separate files
> > even in the case that they were 99% identical, but I certainly could
> > have misunderstood.
> >
> > I'll do whatever you guys agree to.  If you want them in one file I'll
> > probably name it "qcom,sdm845-gpucc.yaml" just because that SoC is
> > earlier, unless someone tells me otherwise.
> >
>
> I'd prefer them to be split out and point at the include file so we know
> what numbers are valid. It provides clarity and helps avoid the back and
> forth of combining and splitting the files. We suffer the same problem
> on the driver side, and we've long given up trying to combine SoCs when
> they're otherwise fairly similar.

Thanks for clarifying!  Rob: I hope it's OK that I've gone ahead and
sent out v4 leaving this alone.  I knew you were interested in getting
the other bindings patch out sooner rather than later and I was hoping
to get both series out together so I could context switch to a few
other things early this week.  Apologies if this was moving too
fast...

-Doug
