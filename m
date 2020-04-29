Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE6EC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47DED2074A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MfYvGkg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgD2AwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 20:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbgD2AwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 20:52:21 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007BEC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 17:52:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mq3so66926pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 17:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rN6lzh1HO7SQ5a1mJWUzVv7pQ/WYiEXJe4nN1cTa5qQ=;
        b=MfYvGkg0E36KkDEUNVqNoMHi4kvTBkFhVPDMvs9JK86Ojx9aJWa7Pg/QX9KT4cZo8x
         vp+NJ3MbB39Q7sc2/bFpuOq6mR2ppSAAw8TIbfe52vt3vnOXuBJPzk+RsoyK+4jMO8Bh
         8BWgeEw0zmhh7uvFJxmfp8wa1ARMXdqAHBMWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rN6lzh1HO7SQ5a1mJWUzVv7pQ/WYiEXJe4nN1cTa5qQ=;
        b=YDd/zc3m9Doe/Z9V8ViH2u/u780x9A7wGFWoMpwuEAfTUjA3iuaOhDt1pzFvPWMLhG
         XwxX0kfeYby6aksvy5BzPQ+sco6G8+I9CtC7Joh+FOb0J1nL9e2UO6j5enLcHCBN8I6F
         AphiNwugHD1x/+mBrF4/BUCnVtqAdE8Zgx8rcSlXnOJUlB91wbgU1ZIKiRJjloo9l3dW
         vTYXUoqpA+oOi/UyMPAAW/d8mAUCBfJop+HlxLhXt5WvSRt7bjMFHC6PI9ymR5U8IydS
         QC2jbBD3LmMM2FNkKdsG3SocJ6zssBU4YNL7DUQubAKS42Z+18q7VhYeUPmc6AcKFAmd
         l+9A==
X-Gm-Message-State: AGi0PuanmBISW4Ai/ag9IGoR9SSayd1MEJj8yq9uTcnfRt52QfsHx58A
        LG2Ve8vUpbfRuKUF6QWjc1F65g==
X-Google-Smtp-Source: APiQypJ3CMyOvb8iG4oSBSb6yTfenmSgIpnIcDpYDhZ0ot1VO0Sx06ThIhO9CBG26qDIlXxW/OVNJg==
X-Received: by 2002:a17:902:690b:: with SMTP id j11mr32585184plk.145.1588121540569;
        Tue, 28 Apr 2020 17:52:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id o1sm3114190pjs.35.2020.04.28.17.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 17:52:20 -0700 (PDT)
Date:   Tue, 28 Apr 2020 17:52:19 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 16/17] arm64: dts: sdm845: Add qspi opps and
 power-domains
Message-ID: <20200429005219.GQ4525@google.com>
References: <1588080785-6812-1-git-send-email-rnayak@codeaurora.org>
 <1588080785-6812-17-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1588080785-6812-17-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 28, 2020 at 07:03:04PM +0530, Rajendra Nayak wrote:
> Add the power domain supporting performance state and the corresponding
> OPP tables for the qspi device on sdm845
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 67e3b90..1843123 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -3017,6 +3017,30 @@
>  			status = "disabled";
>  		};
>  
> +		qspi_opp_table: qspi-opp-table {
> +			compatible = "operating-points-v2";
> +
> +			opp-19200000 {
> +				opp-hz = /bits/ 64 <19200000>;
> +				required-opps = <&rpmhpd_opp_min_svs>;
> +			};
> +
> +			opp-100000000 {
> +				opp-hz = /bits/ 64 <100000000>;
> +				required-opps = <&rpmhpd_opp_low_svs>;
> +			};
> +
> +			opp-150000000 {
> +				opp-hz = /bits/ 64 <150000000>;
> +				required-opps = <&rpmhpd_opp_svs>;
> +			};
> +
> +			opp-300000000 {
> +				opp-hz = /bits/ 64 <300000000>;
> +				required-opps = <&rpmhpd_opp_nom>;
> +			};
> +		};

move OPP table inside the 'qspi' node (like 'rpmhpd_opp_table',
'gpu_opp_table' or 'gmu_opp_table').
