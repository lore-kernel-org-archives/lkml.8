Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB42C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9992720855
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JgXSMR43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgIJGsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 02:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbgIJGsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:48:25 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D78C06179A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 23:48:24 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y6so439970plt.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 23:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=bQnqX/rlzM1UmPvQJGJAQl6NaLfzBoroCNr/nnHi2Ug=;
        b=JgXSMR43xSUTYNrB/REE6v5K4BfU03eWuedT0fwgerY4m6zCwKHNymlFyaQ0PtLLtU
         cT2juiYwqeTcP6varaw5+Ofk0kDHEP0pBm2mNq7jzEvovNG/BarKfSdx+exGHz1t87Cx
         Y7CqyAO+vjm2RZ+OgvTMEAWuC8TNmTv4L7ZeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=bQnqX/rlzM1UmPvQJGJAQl6NaLfzBoroCNr/nnHi2Ug=;
        b=TSMOpEvVCp72XCM70Fks+bpRc++t8Gq33BA7lLOqb2ecHqQpS3SYfcS/r4bX8LRpli
         /G3j4LFZLFwwXvoX+L3YYbpV0ZJFP2LAou0mLuk70ZkpGNEVXBEvLCX///G2bT5FKruP
         4I0a3A8YCkYn8RRgSCXWtH22vMNdFWXhWdR3bCwALd2E1bp1AvhPltOvuIDjoovEbf4D
         BBR63WFGyReWTYXNzSvcftXjY7vUvH7SZmMUiiugbUFcaqQ5afmn2LdEB9GbaK481W0w
         yF7Q61KgTSF39diuZhK4079ALypORPwEcmLO8o1AlF8st/wKvXObd4epJyP2lZ9aEsC6
         qCgw==
X-Gm-Message-State: AOAM533n1jE+z8FlpnGZdNQa/aCV/NU4zXzvtcrMuwsz6ciF9NXqUEL3
        lnAURz/m+xYy1cgHzQwgviYIGsI6beKqXA==
X-Google-Smtp-Source: ABdhPJzrZEV6C1M0RYWREZm1MafBEawU/5OG9WzYmsU1/LeeCa2nEH9z8hIxZZ0ZiyQu7YoUhOT59Q==
X-Received: by 2002:a17:90a:a081:: with SMTP id r1mr3958987pjp.115.1599720503579;
        Wed, 09 Sep 2020 23:48:23 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id d77sm4690415pfd.121.2020.09.09.23.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 23:48:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200910004902.2252694-2-swboyd@chromium.org>
References: <20200910004902.2252694-1-swboyd@chromium.org> <20200910004902.2252694-2-swboyd@chromium.org>
Subject: Re: [PATCH v3 01/10] dt-bindings: phy: qcom,qmp-usb3-dp: Add DP phy information
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Date:   Wed, 09 Sep 2020 23:48:21 -0700
Message-ID: <159972050159.2295844.14715100754744266014@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-09-09 17:48:53)
> This binding only describes the USB phy inside the USB3 + DP "combo"
> phy. Add information for the DP phy and describe the sub-nodes that
> represent the DP and USB3 phys that exist inside the combo wrapper.
> Remove reg-names from required properties because it isn't required nor
> used by the kernel driver.
>=20
> Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
> Cc: Chandan Uddaraju <chandanu@codeaurora.org>
> Cc: Vara Reddy <varar@codeaurora.org>
> Cc: Tanmay Shah <tanmay@codeaurora.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Manu Gautam <mgautam@codeaurora.org>
> Cc: Sandeep Maheswaram <sanm@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Jonathan Marek <jonathan@marek.ca>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Rob Clark <robdclark@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml    | 91 +++++++++++++++++--
>  1 file changed, 81 insertions(+), 10 deletions(-)

I noticed that I didn't document the new compatible string I'm using,
qcom,sc7180-qmp-usb3-dp-phy, ugh.

Should I copy the whole file over and make a new document for the new
compatible string? That feels like the better solution vs. making this
binding have min/max stuff where it fails to enforce the DP part of the
phy. We can delete this binding once the kernel tree isn't using it,
right?

Rob H?

>=20
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.y=
aml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
> index ef8ae9f73092..4154f5748d39 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
> @@ -17,13 +17,15 @@ properties:
>        - qcom,sdm845-qmp-usb3-phy
>    reg:
