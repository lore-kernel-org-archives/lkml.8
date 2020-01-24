Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A20C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330E220838
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R1+ERlRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390897AbgAXSRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:17:05 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45270 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387407AbgAXSRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:17:05 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so1106634pls.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 10:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8GOUlU1dUUOuhJch2P/ExKUgd2fIeYy+G6rt1qy6jLM=;
        b=R1+ERlRZU9Ah8MrQTR3M1rnLe4Dzto7r2NOpLWs6uMjfb7r0ODwmFXu5hZJuJ8Ahjk
         jbksvHKSehXQD9izfu9/51CbjojukSHw6csATmgZIUoqEaFEUBLi+qMlgvZ4EqBVNc9E
         GNvJIF+K0Dz24/xX8r2LYxkn2MP3y9oJbWotxV4SFWYFnMp7DFoN2pc+W60ZbSExgwtw
         Iq+TArS2Kuvw9GUvHLByPeMWTam2i+G9fTj9QGZEeN9TlCForVmg5R/C6dWKz96k9VZX
         8acbXq33xTZh0GAv0GKBN9vLpvGY2K674kUzY5WUCbToQSZe+TVet01RDLKI5yGa75tF
         tokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8GOUlU1dUUOuhJch2P/ExKUgd2fIeYy+G6rt1qy6jLM=;
        b=cJhHaXOG8hEMvd4HndU3omQaDFtibVN8kgjStvPw9I6zanHsuKnCQb6KN4KVmvPgtI
         WrJoXYoKhpKxkeAg6aFsgRLB/6UHTewMXQ0/7BeFb8j9qKE9t6ttPsdWYeXjM7HQDYSs
         rAxEZjoIZ2Ug90vhD336eMs7JKGhzXIJakQ70tr210/N53M2K7sOpdhim4Wjc80LQPja
         Qk0XX/FeZebSh8cicfICaxErqLEBc92nBaUyuSQOLkZxNOn3Xz1U6EppLafe7g0VFmjM
         RYLy3bz7FMi4QKj1HJxyYugTKDCiqfN58vCIqA5KHliqHsjFKFHu3p79MJdojMhn6MQ6
         0IzA==
X-Gm-Message-State: APjAAAVb7DNhX5oaPATUA9/ewmVK6SzYsAM1FxP9ZGYo+6Ovcxby0+ux
        z7YGPMq6mdXw9aCDIGA8XE8VEw==
X-Google-Smtp-Source: APXvYqyb6oK9L02e/30p7WCm7eAAliDcEOrRt9pFaqipsKNdMSbDlYQgPoEjXdnfrnBxF/+Ak1PXFg==
X-Received: by 2002:a17:90a:d156:: with SMTP id t22mr526439pjw.108.1579889824359;
        Fri, 24 Jan 2020 10:17:04 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z14sm7124542pgj.43.2020.01.24.10.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 10:17:03 -0800 (PST)
Date:   Fri, 24 Jan 2020 10:16:29 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, vinod.koul@linaro.org,
        psodagud@codeaurora.org, tsoni@codeaurora.org,
        jshriram@codeaurora.org, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sm8250: Add sm8250 dts file
Message-ID: <20200124181629.GT1908628@ripper>
References: <1579217994-22219-1-git-send-email-vnkgutta@codeaurora.org>
 <1579217994-22219-8-git-send-email-vnkgutta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579217994-22219-8-git-send-email-vnkgutta@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16 Jan 15:39 PST 2020, Venkata Narendra Kumar Gutta wrote:
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
[..]
> +	clocks {
> +		xo_board: xo-board {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <38400000>;
> +			clock-output-names = "xo_board";
> +		};
> +
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32000>;
> +			#clock-cells = <1>;

This should be 0.

> +		};
> +	};
> +
[..]
> +	smem: qcom,smem {

Please drop the "qcom," from the node name.

> +		compatible = "qcom,smem";
> +		memory-region = <&smem_mem>;
> +		hwlocks = <&tcsr_mutex 3>;
> +	};
> +

Regards,
Bjorn
