Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131C8C54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF7920735
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ESyNECAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgCXUkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:40:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43512 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbgCXUky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:40:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id f206so9920263pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 13:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DNS5ExX8y9nbqENL8Pciki0+IneKtxixT5InmuTvr5k=;
        b=ESyNECAqooVvEvJ/jx+V2AoktrCxCT7+Ze/ETg1ChLKtElds4qd8cPvkk2uzFpMvm+
         HetnTl6bLKvmLh3rt0NOVQLuVcBLWsvjDfgkJ2+MbzvHG/MTV7P7BTmif7pYCrHCPZDC
         xt1R46wklDThHxRF0Bz0OMw8zs/SCxZR1o8eXRl58/AN2r7bbpUtfHLfnAV3cR6u7Guv
         lnGNcR4t0/XcNGaXJ/3AHRHy/WSooHIylmCDn409Qdjuds0+gSZX38VSAje2m2d8Qki1
         vlxHNiM0dp17zvxW4IoQEciarKBa0RCEgtgh3zKWsc9qV9K6KloPNTSPmZeMJbdzeOOG
         cSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DNS5ExX8y9nbqENL8Pciki0+IneKtxixT5InmuTvr5k=;
        b=TiUL38ZuqaOjQaOEwyokij2eTHRw683XFyoA/pQE17OPxc/8pTj2T5cATKSzDINBdb
         SG6A6cKO3sKFAdeh5vRwxF5LSF8MBm4fIKpXWTSE3yC74sr6ue8mH60ULQUqLFSNQs5e
         CBl51no6K1u50x9u/vCROld6VGng/PhqF8wTH3RS+tA4zbF6zUnXZrO6F7Zy2yplCLpG
         iMCI9PZ91cG9FUUc9JmsfoWVFIjA3f19YU6amMNwqaQXq3+9ozV+JZE3BDKXw0mQltOc
         8jqOpG+5M9afax0ieCiPfOEAyGjkNwyfV80pmzusMFfcamYGZgjbprPFnF9tn82AjQOF
         0Xfg==
X-Gm-Message-State: ANhLgQ2e/eiWHjd1HVZuoJhcJB51+4IYi4aIVm5I/2hm/XdQuV6yCyAf
        vY8ILNXCjfe9W9K3Z9NcyazUCQ==
X-Google-Smtp-Source: ADFU+vskycRbybCedRoaSNzMX1cBTJb6NpF8BtdkiH/6HISDI0YfxLPwTYQuoWjaa0ZZR84b8Fb6jQ==
X-Received: by 2002:a63:c44b:: with SMTP id m11mr14130606pgg.313.1585082451266;
        Tue, 24 Mar 2020 13:40:51 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g7sm2969252pjl.17.2020.03.24.13.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 13:40:50 -0700 (PDT)
Date:   Tue, 24 Mar 2020 13:40:48 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     gregkh@linuxfoundation.org, davem@davemloft.net,
        smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, hemantk@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v3 7/7] net: qrtr: Do not depend on ARCH_QCOM
Message-ID: <20200324204048.GD119913@minitux>
References: <20200324061050.14845-1-manivannan.sadhasivam@linaro.org>
 <20200324061050.14845-8-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324061050.14845-8-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23 Mar 23:10 PDT 2020, Manivannan Sadhasivam wrote:

> IPC Router protocol is also used by external modems for exchanging the QMI
> messages. Hence, it doesn't always depend on Qualcomm platforms. One such
> instance is the QCA6390 WLAN device connected to x86 machine.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  net/qrtr/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/qrtr/Kconfig b/net/qrtr/Kconfig
> index 8eb876471564..f362ca316015 100644
> --- a/net/qrtr/Kconfig
> +++ b/net/qrtr/Kconfig
> @@ -4,7 +4,6 @@
>  
>  config QRTR
>  	tristate "Qualcomm IPC Router support"
> -	depends on ARCH_QCOM || COMPILE_TEST
>  	---help---
>  	  Say Y if you intend to use Qualcomm IPC router protocol.  The
>  	  protocol is used to communicate with services provided by other
> -- 
> 2.17.1
> 
