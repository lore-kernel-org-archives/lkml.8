Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5095C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB49F20848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fy5hwIsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgCEMuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:50:52 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35152 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgCEMuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:50:52 -0500
Received: by mail-vk1-f193.google.com with SMTP id r5so1571050vkf.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 04:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+maOR+AepgKRd4QlRgZ+R5o7Ks/CO7J6rgykLOQhg3o=;
        b=Fy5hwIsSVhanXjlLscLM66eenX+BCtRtAYQCsCxjZKETTFVL603yeJm9AFRLD+sAAS
         2wCyCE5SzA4P6OHNlMe8oMswbyXdzcCCcwhvas/r/37ooGvLGxcOmm2m7x59fDE1LGlo
         fUDuYL5anWHgBbi+EgIpIN9dzRwP7IDMZRBne7yKfT51oHStdbSTwPcNjC+cxCMqCnJd
         wFbVHtcPnf3cR45aDau0mW4usFyVX06o29igp6GHGzgyWrkBrrNRt5s3KTIexsRyLZy8
         f1GgC2pag/n7Sno/FT+PEJx3l/sXaGnM1cdS4fSX0XqZOqiQDbYcttOuEvpS2XCqeVVD
         MZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+maOR+AepgKRd4QlRgZ+R5o7Ks/CO7J6rgykLOQhg3o=;
        b=TTJqaOV4M1Y9GBXBBifSvzqPa95BTGGXYL6NCYTq7UIfTYsSBCnvlLX14C9iGoExWp
         TbnV/HFZ0B3rXwaGltnOyLwDkTk0sO23jVQQAoijzYZcvQne4uiGRnWTCWDNh4vwX9DM
         uDqcLi5TFJlCTCMTHfZyOtUJrdPDxWUbl34X7WdCh7nXOM2ruI2G4j4jJqpG66sWmQnd
         4ebuMItwpnLA8sZ9r/aDSw+VbhFOguIreWDi0cHejYJPXrNDdS+6L5d67jdu5yF493Jp
         sx+E3H+DPv7Z5ASuwE2jUlcg2VATts2YRVWjL1f7o1Yp67UcZLtihoxURbGVjeJWOogX
         tBpQ==
X-Gm-Message-State: ANhLgQ3BZR6+RE1ihjMIqv8DfQUFUZi6W8zlh89ePVC1FFAJvtQNLdMh
        c2uSIz13sl4dERqmz03a1HfrY0TJpZ1ZqW8Y2aZ3WQ==
X-Google-Smtp-Source: ADFU+vsfx2UzBfGovuaSXLUze7lcuI9cYphDPyIxas1YBiaNucPu3Q6rG2VUsSQJWjDBQnBGc8WRyzuMSoSg7SJIEcM=
X-Received: by 2002:ac5:c94f:: with SMTP id s15mr3982555vkm.79.1583412651049;
 Thu, 05 Mar 2020 04:50:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582528977.git.amit.kucheria@linaro.org>
 <59d24f8ec98e29d119c5cbdb2abe6d4644cc51cf.1582528977.git.amit.kucheria@linaro.org>
 <20200224184003.GA3607@bogus>
In-Reply-To: <20200224184003.GA3607@bogus>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 5 Mar 2020 18:20:40 +0530
Message-ID: <CAHLCerP1_xESMbLuSBsVz1XkrA0j_okbX+SxbefVSo4ttvX_fg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/3] dt-bindings: thermal: Add yaml bindings for
 thermal zones
To:     Rob Herring <robh@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 12:10 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, 24 Feb 2020 12:55:37 +0530, Amit Kucheria wrote:
> > As part of moving the thermal bindings to YAML, split it up into 3
> > bindings: thermal sensors, cooling devices and thermal zones.
> >
> > The thermal-zone binding is a software abstraction to capture the
> > properties of each zone - how often they should be checked, the
> > temperature thresholds (trips) at which mitigation actions need to be
> > taken and the level of mitigation needed at those thresholds.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  .../bindings/thermal/thermal-zones.yaml       | 302 ++++++++++++++++++
> >  1 file changed, 302 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node

This one isn't due to my patch, I believe.

> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-zones.example.dt.yaml: thermal-sensor@c263000: interrupt-names: ['uplow'] is too short
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-zones.example.dt.yaml: thermal-sensor@c263000: interrupts: [[0, 506, 4]] is too short
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-zones.example.dt.yaml: thermal-sensor@c265000: interrupt-names: ['uplow'] is too short
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-zones.example.dt.yaml: thermal-sensor@c265000: interrupts: [[0, 507, 4]] is too short

Fixed. Just for my information, did the check somehow figure out that
this (incomplete) example needed the qcom-tsens.yaml binding (based on
compatible string?) and then apply those rules to throw this error?

Regards,
Amit
