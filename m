Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A5BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E371206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DIizX0es"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgHCIZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgHCIZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:25:00 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EEDC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 01:25:00 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a5so23365262wrm.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 01:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=idno4XA8cyFxWToJkaA+wyHL6pf3C4NEsthkMu6eKrE=;
        b=DIizX0esDlRGwFEkVKmrfd9GB9tB45pOEX3X2zXslub6Z2+O8utOXdqcr5nQ/Oa2Zr
         qtDmg3vVY5gz7a0B5axSSwjHiudMITKOUM74BbyU9hsICaPu+1LFFu3AYhyE9TyuARBH
         GvuSes6pSGu2yftPCeqqaMsKqEtQaeiIFz3pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=idno4XA8cyFxWToJkaA+wyHL6pf3C4NEsthkMu6eKrE=;
        b=etSg2jYHHxJE9NBcPB+6fN354nTfkwWyK2Dsv2eggIevdmVRabGyo6S6dsh+1ZC7Ma
         dpNdtkJ5QzV3C3CnV3ajspVAfW7Uh7QSo01kvH4/qTIPk9UdsJZDeltxe0IZw57vF/8k
         4byFKzOUJf1y+mqJlmxSwCosjEizS4eESqwU48SMQvoA7UxF3tPtbql0dl2rIoReMOdk
         4ZfABMwipfQBX1GUT84vtWKTFpq1fK3x0+18N0jFLnONO9ul1StLVnff5+nIoWAK1YBs
         xwS028D+atTHUYZ/XZNKx24T3lYSy2f5EoW29qLBgO3Tsv/iJMVZ7tDK4q6EJ2L0jDHf
         yHvw==
X-Gm-Message-State: AOAM531pwO/ZiN477wlefgL9ddHXUvRxKeBY58LKjfwUxtLnvBegpL1F
        MhcJecilaucNnUvfFkOoV5MSNs6xeTfLiFGZfayRyQ==
X-Google-Smtp-Source: ABdhPJyMr8Qvm79z3JxDUYSbnhyiu1LPeKjwbT1/t95HT7mmACCwcVs3ic5l8CuEVZXehyw2+vldMmejt18EJU2jItw=
X-Received: by 2002:adf:e486:: with SMTP id i6mr13791882wrm.258.1596443098745;
 Mon, 03 Aug 2020 01:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200731084023.2678931-1-cychiang@chromium.org>
 <20200731084023.2678931-2-cychiang@chromium.org> <20200731182712.GA531472@bogus>
In-Reply-To: <20200731182712.GA531472@bogus>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Mon, 3 Aug 2020 16:24:32 +0800
Message-ID: <CAFv8NwLCkHBVE-JcaDLOrRs6U_MhS4_n1oBicNG1DjQxh-d3UQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ASoC: qcom: dt-bindings: Add sc7180 machine bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Dylan Reid <dgreid@chromium.org>,
        Patrick Lai <plai@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Takashi Iwai <tiwai@suse.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rohit kumar <rohitkr@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 1, 2020 at 2:27 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, 31 Jul 2020 16:40:22 +0800, Cheng-Yi Chiang wrote:
> > Add devicetree bindings documentation file for sc7180 sound card.
> >
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> >  .../bindings/sound/qcom,sc7180.yaml           | 113 ++++++++++++++++++
> >  1 file changed, 113 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> >
>
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> Documentation/devicetree/bindings/sound/qcom,sc7180.example.dts:32.24-41.15: Warning (unit_address_vs_reg): /example-0/sound/dai-link@0: node has a unit name, but no reg or ranges property
> Documentation/devicetree/bindings/sound/qcom,sc7180.example.dts:43.24-52.15: Warning (unit_address_vs_reg): /example-0/sound/dai-link@1: node has a unit name, but no reg or ranges property
>
>
> See https://patchwork.ozlabs.org/patch/1339316
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
>
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
>
> Please check and re-submit.
>
I have passed this in v2 patch, but removed reg in v3 patch since it
is not used.
In v4, I have added back reg = <0> and reg = <1> into the example, and
reg property into schema to fix this error.
Since reg property is not used in the driver, I am not sure whether I
should add it in the schema.
Please let me know which is preferred. Thanks!
