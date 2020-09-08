Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50184C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3F92087C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599584707;
	bh=h3cv+RDjlk7wmtLDNSrx814csKm6m7ct3iSQIbcOg/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dY+eHppRbFZ3yNF6klnmg2joZbm6o4tBbPmfJMaVYyFnQlrzEh18Zejqrv91pie3K
	 4/bqG87iyxrdP6ZRszmG+g4OYhlPjMULDzA/zYTPfa6QZuIE8N9Q29Uvvybzup4IWf
	 LahlyvjlAidJw9HvQf+JPGIQlTlGGr7Rj/8DA09U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbgIHRFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731838AbgIHQTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:19:44 -0400
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D07F821D24
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599566219;
        bh=h3cv+RDjlk7wmtLDNSrx814csKm6m7ct3iSQIbcOg/E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IbjSqtIF1TJJuBu197Ffb0ftjzwrp79UjzhpZGFfYZQpPM4sW2yH/p0uJnTCwnLI9
         Gc5uwheqxkQOIqwi/2gvYq07TlJD03asJMUVwx5qRErkhjFwvOL4vU26B9skjfZpul
         7mizF9BQQCTsu8WVBP5h1HJHW7p0cYOcZ/te/4wI=
Received: by mail-vk1-f172.google.com with SMTP id q124so3975538vkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 04:56:58 -0700 (PDT)
X-Gm-Message-State: AOAM532zJkMyhHlaRoyOtubX4cFnc7B5M6c0p60+zb2JOeoOruEjygq0
        vSRnfCONjQMUNFv//Qat4ogqtFEx9l0TyZUVPldTmg==
X-Google-Smtp-Source: ABdhPJxvKv+NiIR52wR1XowSSPT+PZ4GJxVsBTin1GaHc/2WNVEmYNU5vtdL9uz3C8HX7BrRbPPW5oa4vjLLPudWWH8=
X-Received: by 2002:a1f:2507:: with SMTP id l7mr3434112vkl.35.1599566218024;
 Tue, 08 Sep 2020 04:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org> <20200908075716.30357-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20200908075716.30357-3-manivannan.sadhasivam@linaro.org>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Tue, 8 Sep 2020 17:26:47 +0530
X-Gmail-Original-Message-ID: <CAHLCerMXWsYX85RWYXqb7Ch9KXFsiR0H-Y-L-y68wdtyPFNnvA@mail.gmail.com>
Message-ID: <CAHLCerMXWsYX85RWYXqb7Ch9KXFsiR0H-Y-L-y68wdtyPFNnvA@mail.gmail.com>
Subject: Re: [PATCH 2/7] arm64: dts: qcom: sm8250: Add cpufreq hw node
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 1:27 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> Add cpufreq HW device node to scale 4-Silver/3-Gold/1-Gold+ cores
> on SM8250 SoCs.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


Reviewed-by: Amit Kucheria <amitk@kernel.org>


> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index e7d139e1a6ce..aafb46a26a9c 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -87,6 +87,7 @@
>                         reg = <0x0 0x0>;
>                         enable-method = "psci";
>                         next-level-cache = <&L2_0>;
> +                       qcom,freq-domain = <&cpufreq_hw 0>;
>                         L2_0: l2-cache {
>                               compatible = "cache";
>                               next-level-cache = <&L3_0>;
> @@ -102,6 +103,7 @@
>                         reg = <0x0 0x100>;
>                         enable-method = "psci";
>                         next-level-cache = <&L2_100>;
> +                       qcom,freq-domain = <&cpufreq_hw 0>;
>                         L2_100: l2-cache {
>                               compatible = "cache";
>                               next-level-cache = <&L3_0>;
> @@ -114,6 +116,7 @@
>                         reg = <0x0 0x200>;
>                         enable-method = "psci";
>                         next-level-cache = <&L2_200>;
> +                       qcom,freq-domain = <&cpufreq_hw 0>;
>                         L2_200: l2-cache {
>                               compatible = "cache";
>                               next-level-cache = <&L3_0>;
> @@ -126,6 +129,7 @@
>                         reg = <0x0 0x300>;
>                         enable-method = "psci";
>                         next-level-cache = <&L2_300>;
> +                       qcom,freq-domain = <&cpufreq_hw 0>;
>                         L2_300: l2-cache {
>                               compatible = "cache";
>                               next-level-cache = <&L3_0>;
> @@ -138,6 +142,7 @@
>                         reg = <0x0 0x400>;
>                         enable-method = "psci";
>                         next-level-cache = <&L2_400>;
> +                       qcom,freq-domain = <&cpufreq_hw 1>;
>                         L2_400: l2-cache {
>                               compatible = "cache";
>                               next-level-cache = <&L3_0>;
> @@ -150,6 +155,7 @@
>                         reg = <0x0 0x500>;
>                         enable-method = "psci";
>                         next-level-cache = <&L2_500>;
> +                       qcom,freq-domain = <&cpufreq_hw 1>;
>                         L2_500: l2-cache {
>                               compatible = "cache";
>                               next-level-cache = <&L3_0>;
> @@ -163,6 +169,7 @@
>                         reg = <0x0 0x600>;
>                         enable-method = "psci";
>                         next-level-cache = <&L2_600>;
> +                       qcom,freq-domain = <&cpufreq_hw 1>;
>                         L2_600: l2-cache {
>                               compatible = "cache";
>                               next-level-cache = <&L3_0>;
> @@ -175,6 +182,7 @@
>                         reg = <0x0 0x700>;
>                         enable-method = "psci";
>                         next-level-cache = <&L2_700>;
> +                       qcom,freq-domain = <&cpufreq_hw 2>;
>                         L2_700: l2-cache {
>                               compatible = "cache";
>                               next-level-cache = <&L3_0>;
> @@ -2076,6 +2084,20 @@
>                                 };
>                         };
>                 };
> +
> +               cpufreq_hw: cpufreq@18591000 {
> +                       compatible = "qcom,sm8250-epss";
> +                       reg = <0 0x18591000 0 0x1000>,
> +                             <0 0x18592000 0 0x1000>,
> +                             <0 0x18593000 0 0x1000>;
> +                       reg-names = "freq-domain0", "freq-domain1",
> +                                   "freq-domain2";
> +
> +                       clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
> +                       clock-names = "xo", "alternate";
> +
> +                       #freq-domain-cells = <1>;
> +               };
>         };
>
>         timer {
> --
> 2.17.1
>
