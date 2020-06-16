Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BABC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39BB62098B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ceofJhQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgFPLds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728333AbgFPLc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:32:58 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BC6C08C5C9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 04:32:52 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id k13so11202283vsm.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 04:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1C4xlbOuF8hLryefQXY445HSGUPqVPlV2H+ODb1eYxA=;
        b=ceofJhQisogT8djGC+30R6rH9kr18j8pEGv0o3E7GDSHGgQsSPhVHRc6HbNfK958xu
         Itwe4tAW3ORMqnAngeF8gkzFFaOMZ+PuMRuNbeq1hm9SVEJcJNck70qMbwnLCKDIMlNK
         /jgfIu08OHf/QouS/AlteiIEFOgmx33pDwImiI0lLCz+ZVTubelWtLR6UiwyA/uYTrPL
         56pr8YjveJBuLa0t/dg3sUzoeT7Pms0qMYcEYTQvVfjf7+kznUMrxFnXAwL3Mvy4ajRD
         ZW/bUsx8bXFvw78umR4r3LHiGZaV/Rg2LKkR8p3RWfvImjI/zmJOBvmLpVJxu6zHMuJ0
         f0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1C4xlbOuF8hLryefQXY445HSGUPqVPlV2H+ODb1eYxA=;
        b=S5eFPwK52vfblOJzb5wy0dGqDgCv145Gp50xpWY8wsALOKEc2umrrcx1IllfurwkRS
         mqdrfKbxGazaxjHzplqFXybfGct/o8J91cL3RRzG5l04cz8443XjaMa81YGHPyzbldX2
         jXleXFy3WecHb9YAA/+eTvKnTOAF9CmRyIfUGdwuQj+fBgvveVGRUVf58J0tg/90ZTjh
         GQFn00Rpq0veRTv36+fsnOB89jI/LYpWqcsYsqTa6mdehxFwPq/p5ILeFUG8l0Kc9Tqu
         e+tAjfmJqDov3oEutQxUcyL1YUItECR+yxpipm676dnwL0RW32Zi7kJizFQG2DoTR8DM
         Bj1Q==
X-Gm-Message-State: AOAM532xu/1Bpj0XM7Dj6VlrBYzDT+X6v5VzzQwisfGLIDSfd0pC3IRy
        YRMPM6asfZVIxKzJBQxES4+vQQd3kk5Vqyaxe2pu2A==
X-Google-Smtp-Source: ABdhPJw63noGBljzHWsWI4sYYIst23+5lAqRC5OLkTcOQ4G7Dp0cAbxMHpwylGBv2AxyVk8ZHK1Du/uSYKkWqtndx84=
X-Received: by 2002:a67:db88:: with SMTP id f8mr1115288vsk.165.1592307171958;
 Tue, 16 Jun 2020 04:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <1591691846-7578-1-git-send-email-ppvk@codeaurora.org> <1591691846-7578-3-git-send-email-ppvk@codeaurora.org>
In-Reply-To: <1591691846-7578-3-git-send-email-ppvk@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 16 Jun 2020 13:32:15 +0200
Message-ID: <CAPDyKFr8Ge617QchXG1cMgZUvPZ+fRUpJamv173h1faz7-0baw@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] dt-bindings: mmc: sdhci-msm: Add interconnect BW
 scaling strings
To:     Pradeep P V K <ppvk@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-mmc-owner@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        matthias@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jun 2020 at 10:38, Pradeep P V K <ppvk@codeaurora.org> wrote:
>
> Add interconnect bandwidth scaling supported strings for qcom-sdhci
> controller.
>
> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index b8e1d2b..3b602fd 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -54,6 +54,21 @@ Required properties:
>  - qcom,dll-config: Chipset and Platform specific value. Use this field to
>         specify the DLL_CONFIG register value as per Hardware Programming Guide.
>
> +Optional Properties:
> +* Following bus parameters are required for interconnect bandwidth scaling:
> +- interconnects: Pairs of phandles and interconnect provider specifier
> +                to denote the edge source and destination ports of
> +                the interconnect path.
> +
> +- interconnect-names: For sdhc, we have two main paths.
> +               1. Data path : sdhc to ddr
> +               2. Config path : cpu to sdhc
> +               For Data interconnect path the name supposed to be
> +               is "sdhc-ddr" and for config interconnect path it is
> +               "cpu-sdhc".
> +               Please refer to Documentation/devicetree/bindings/
> +               interconnect/ for more details.
> +
>  Example:
>
>         sdhc_1: sdhci@f9824900 {
> @@ -71,6 +86,9 @@ Example:
>
>                 clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
>                 clock-names = "core", "iface";
> +               interconnects = <&qnoc MASTER_SDCC_ID &qnoc SLAVE_DDR_ID>,
> +                               <&qnoc MASTER_CPU_ID &qnoc SLAVE_SDCC_ID>;
> +               interconnect-names = "sdhc-ddr","cpu-sdhc";
>
>                 qcom,dll-config = <0x000f642c>;
>                 qcom,ddr-config = <0x80040868>;
> --
> 1.9.1
>
