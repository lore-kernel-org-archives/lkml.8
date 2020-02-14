Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2F0C3B194
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 05:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026C9217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 05:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ci47GPh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgBNFbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 00:31:37 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33903 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgBNFbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 00:31:37 -0500
Received: by mail-pl1-f194.google.com with SMTP id j7so3300049plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 21:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YdqrLZVIKkHcEkn+zhvQwPNs8H6GA9I6SUHidN4E340=;
        b=Ci47GPh4Cs+sq3SNG5sbvk0b3C1x2gsg/VKR5MjnIsgZAFd+aCcm7tjveuVzwDpQtr
         LHnevje4mPZsv+muBZCNruOAyiGHhSimhKO4PS3kc0LUbbCYgzL8KFOU0x3qUjeGU3Kf
         0y/eHfQBzb7a6MIbbz8XOy+suHzKZxYx5C6B7lgM1K1Q6TtaIYykGpjGwb5aZ6NPEmqc
         patkW8o/aBYaTwkdqH6o0Oo5NUj4yzCwZecduucHqQbKHEGGFwsegSok/DDBRmNgZapW
         pT+rvYEVS69CP63n+xf33k4FmO9z3fP+zp0h8i4xGYNJ2yivPgX8TAj42dLyNkJ1RBtz
         dJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YdqrLZVIKkHcEkn+zhvQwPNs8H6GA9I6SUHidN4E340=;
        b=MzR7QE0rUmqfuczeSMPDNAJX79WDIxe2Sv7rQbTexAzG7kZTV67wfkF765Tdp3XObK
         cbTkIRGoZGW5ZJYLHiSisJsVPLy4LzA5NGBNqQgOBwfi4IGgykZ6I0OB38HEgJYvm7vK
         mVIG9I2JqBomg04R0hIuM+nDQBG0asAvFfsFYPn7+qFr03LubsYNI7wH7TDvw0R5h0Pr
         gX1cCSxBWu/WD19xhqhJfptzr50QmC1fvQV7tHSoCSIsxDPZuEOcNGRB8aQQynny4Zcs
         S8zASgi8I5AuLoGRbCGELe6I+3XGtjWfcoFEchnUAFvaW7z6Q1xupJvR6965nSjNW3Fs
         b11g==
X-Gm-Message-State: APjAAAWQVOHh1SWtu2n5OkJAxd1zvC93d60bROIC8mXLdx1JmuTgetEa
        S8lXxhAxhRXtHjrW8rUWLQOmYg==
X-Google-Smtp-Source: APXvYqysymrbCVfw+33GsQE95mppqlPT8olpDd2YiCPAlZ81G3bDAgPaNfEXQdRpmnJUNYDGFxv6mg==
X-Received: by 2002:a17:902:9042:: with SMTP id w2mr1575102plz.269.1581658295695;
        Thu, 13 Feb 2020 21:31:35 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k9sm4313340pjo.19.2020.02.13.21.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 21:31:35 -0800 (PST)
Date:   Thu, 13 Feb 2020 21:31:33 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: msm8916: Properly deal with ETMv4 power
 management
Message-ID: <20200214053133.GW3948@builder>
References: <20200211183011.24720-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211183011.24720-1-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11 Feb 10:30 PST 2020, Mathieu Poirier wrote:

> Properly deal with ETMv4 power management by adding the
> "coresight-loses-context-with-cpu" property.  Otherwise tracer
> configuration is lost when CPUs enter deep idle states, resulting
> in the failure of the trace session.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Applied

Thanks,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 8686e101905c..846c5b4a53e8 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -1363,6 +1363,7 @@
>  
>  			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>  			clock-names = "apb_pclk", "atclk";
> +			arm,coresight-loses-context-with-cpu;
>  
>  			cpu = <&CPU0>;
>  
> @@ -1381,6 +1382,7 @@
>  
>  			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>  			clock-names = "apb_pclk", "atclk";
> +			arm,coresight-loses-context-with-cpu;
>  
>  			cpu = <&CPU1>;
>  
> @@ -1399,6 +1401,7 @@
>  
>  			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>  			clock-names = "apb_pclk", "atclk";
> +			arm,coresight-loses-context-with-cpu;
>  
>  			cpu = <&CPU2>;
>  
> @@ -1417,6 +1420,7 @@
>  
>  			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>  			clock-names = "apb_pclk", "atclk";
> +			arm,coresight-loses-context-with-cpu;
>  
>  			cpu = <&CPU3>;
>  
> -- 
> 2.20.1
> 
