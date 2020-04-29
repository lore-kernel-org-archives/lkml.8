Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213A9C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F107C20731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d4DwmoXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgD2Amd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 20:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726274AbgD2Amc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 20:42:32 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C43C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 17:42:32 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s10so183280plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 17:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xst1wgRgah/fir7yJGkgxtghdkNU2fPxNqKGkIiu6i8=;
        b=d4DwmoXTG7vYVCmWsd7KDYAZ5TqkGT9nmHYvU6SEkV1OdY74xNq1JD1fdHqX+e6KIJ
         aFYjfHP9OKtnXTu4UXF7iPumSAIjOvUdlVEOJABd9uV6IglsSwuuxfiRHc3mJR9lDIy5
         oax4SAS+cOzM8/xKbwp4wKM2lpMAJaGZm/fn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xst1wgRgah/fir7yJGkgxtghdkNU2fPxNqKGkIiu6i8=;
        b=Mm3ANSWgZbS64h9kaUpxiTJMXuGdjDrlD+3Tm04Ax4BjJoDFQnHnw9bAS4fuVW66wl
         oz0B4EDTfFJh3qE/9Yy8gxT6grlbcRxE3jdTjls8GTolWRVwyUjDXDFmU4Ptw8PgU+6I
         t2PpbKfRWXN/fCRtKx+Qbe0VDKkmJcRXwRXbebYho0d66LIjLD8rIRPYm/CYMAkabAa8
         LBW/qsJVnSHlG6DoE83xUk7OKhrqyoFNN8xZBINmMo9w92cBOVUpJF6ahwMuqywhNvwt
         QG1w/O8mMmrjCuVP493BhSKmKaVm8WUs3h6aG21kwcHlii4Geiyk0B6bRk7+aHLN3t5Z
         a+Bg==
X-Gm-Message-State: AGi0PuaIO9nrAvunSDq5Aee59v+x8ZpNEhxv3p1sN8j83Ijn9cJ5h26V
        jn5dls3z1rftx+bw1+Ic/Ns4xydkWHo=
X-Google-Smtp-Source: APiQypIDidUrrIYJAhtCRCXUSNJzx8BbbpcS7yYbwl6/Benr9w1+JeCHu4mrnBrH8UmErE9eQiZFeA==
X-Received: by 2002:a17:902:8604:: with SMTP id f4mr31539962plo.68.1588120951661;
        Tue, 28 Apr 2020 17:42:31 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id m3sm14733412pgt.27.2020.04.28.17.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 17:42:30 -0700 (PDT)
Date:   Tue, 28 Apr 2020 17:42:30 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/17] arm64: dts: sdm845: Add OPP tables and
 power-domains for venus
Message-ID: <20200429004230.GO4525@google.com>
References: <1588080785-6812-1-git-send-email-rnayak@codeaurora.org>
 <1588080785-6812-14-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1588080785-6812-14-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 07:03:01PM +0530, Rajendra Nayak wrote:
> Add the OPP tables in order to be able to vote on the performance state of
> a power-domain.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 40 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index e6f1af1..67e3b90 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -3294,14 +3294,50 @@
>  			};
>  		};
>  
> +		venus_opp_table: venus-opp-table {
> +			compatible = "operating-points-v2";
> +
> +			opp-100000000 {
> +				opp-hz = /bits/ 64 <100000000>;
> +				required-opps = <&rpmhpd_opp_min_svs>;
> +			};
> +
> +			opp-200000000 {
> +				opp-hz = /bits/ 64 <200000000>;
> +				required-opps = <&rpmhpd_opp_low_svs>;
> +			};
> +
> +			opp-320000000 {
> +				opp-hz = /bits/ 64 <320000000>;
> +				required-opps = <&rpmhpd_opp_svs>;
> +			};
> +
> +			opp-380000000 {
> +				opp-hz = /bits/ 64 <380000000>;
> +				required-opps = <&rpmhpd_opp_svs_l1>;
> +			};
> +
> +			opp-444000000 {
> +				opp-hz = /bits/ 64 <444000000>;
> +				required-opps = <&rpmhpd_opp_nom>;
> +			};
> +
> +			opp-533000000 {
> +				opp-hz = /bits/ 64 <533000000>;
> +				required-opps = <&rpmhpd_opp_turbo>;
> +			};
> +		};

move OPP table inside the 'venus' node (like 'rpmhpd_opp_table',
'gpu_opp_table' or 'gmu_opp_table').
