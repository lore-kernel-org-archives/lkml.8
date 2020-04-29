Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5486BC83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C9720737
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DTjNQ7Wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgD2ACh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 20:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbgD2ACh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 20:02:37 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1973C03C1AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 17:02:36 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s20so135083plp.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 17:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2CAsXRsVnnRH9qykwpG2jwLytTUSsYDhGBBWnzkIxmo=;
        b=DTjNQ7WxIVv2kyEoi/eKDWmVq5xuFqq0y6FkjXCUixLdc69SpYY8WlYvK6j2DP+hIp
         kKoLIfvWwIyFNV54LtzyVPm1zJdEc2g7YclLi9Nys+e1e5B9UHo/svUPYwWL8ccXf29K
         dBcBnQxM+AoLbwkJVQtFVJvk3tn1xwWymj1C0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2CAsXRsVnnRH9qykwpG2jwLytTUSsYDhGBBWnzkIxmo=;
        b=qA9tMcF44Z9Bg9yXWvEm7g2lS67rf4OqtEm5Hf9rRpelHVgA0XK7m1w+io/N1QNgzv
         iGeAyYrCBzemeJhhWRgWPStJixXqMyCvO8Xofl/qDtIZndSCV2yfBdcQ5RcgAptxz3k/
         lKGbI4/TJxEOL7uFuNW3PrE8YNO9PBovJzaXUxMiho6S/3Hut0GMEIszI4fV0SEWv6p2
         h2bVIkb4L0ZRDqoagoTGB3XtA4RGWQ/0z1/Wcsw+PKqROuaVRLen02tBAtdzedcK6FAG
         bw0ca5/1ufDYkVQJF5jr5yU8m02MXHwbtWM6sJWQHtg/mU79A23c5quNKRbBHxXgdPvp
         48zg==
X-Gm-Message-State: AGi0Puap8xqkyR+9+fbVS9LV4LKpCEdZXXBalUfvPR50XPMsl1Qs+e3L
        Tgzvn6PU5E6NT6m+DchzQe3qzw==
X-Google-Smtp-Source: APiQypJN8NM0JFwAkbfJokHfThEo4TBASYABj2DhRSML0C5dUS1OInUj/x3ZZkfBdRogU3C9Jh6QdQ==
X-Received: by 2002:a17:90a:ee84:: with SMTP id i4mr35744pjz.71.1588118556209;
        Tue, 28 Apr 2020 17:02:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id h197sm16715015pfe.208.2020.04.28.17.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 17:02:35 -0700 (PDT)
Date:   Tue, 28 Apr 2020 17:02:34 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v3 03/17] arm64: dts: sdm845: Add OPP table for all qup
 devices
Message-ID: <20200429000234.GK4525@google.com>
References: <1588080785-6812-1-git-send-email-rnayak@codeaurora.org>
 <1588080785-6812-4-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1588080785-6812-4-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajendra,

On Tue, Apr 28, 2020 at 07:02:51PM +0530, Rajendra Nayak wrote:
> qup has a requirement to vote on the performance state of the CX domain
> in sdm845 devices. Add OPP tables for these and also add power-domains
> property for all qup instances.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 115 +++++++++++++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 8f926b5..36b9fb1 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -804,6 +804,25 @@
>  			clock-names = "core";
>  		};
>  
> +		qup_opp_table: qup-opp-table {
> +			compatible = "operating-points-v2";
> +
> +			opp-19200000 {
> +				opp-hz = /bits/ 64 <19200000>;
> +				required-opps = <&rpmhpd_opp_min_svs>;
> +			};
> +
> +			opp-75000000 {
> +				opp-hz = /bits/ 64 <75000000>;
> +				required-opps = <&rpmhpd_opp_low_svs>;
> +			};
> +
> +			opp-100000000 {
> +				opp-hz = /bits/ 64 <100000000>;
> +				required-opps = <&rpmhpd_opp_svs>;
> +			};
> +		};
> +

Judging from SDM845 (which has more OPP tables) the convention seems to be
to add OPP tables to the nodes that use them, which seems reasonable and
keeps them out of the device list.

Unfortunately this convention isn't completely suitable for cases like this
(and the DSI OPPs later in this series), where the same OPP table is used by
multiple devices. A possible compromise would be to add the table to the
node of the first device that uses them.

