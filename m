Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607A2C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8C5208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SDgD4Mjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgCEFTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 00:19:32 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44532 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgCEFTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 00:19:31 -0500
Received: by mail-pg1-f193.google.com with SMTP id n24so1152562pgk.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 21:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xz0vKiIHUnBC6KaRjuHnnW/6amnzPB0TTTrzomiuqwo=;
        b=SDgD4Mjfq/Dgym5JoDng77rvx/8OVbSyd6rxOr/CI82fCJOpITTLS1w0A+Vw3Yk8hM
         TPaOcm+zqlADV2F9QCgy6Sp+y32QikANzXSHv2WoARs2kIqeKWotF61Wb1MFvqKK+Dkm
         8FoZ2rD5hgD2moitfA/3U8D+wsIpebCkJ5PTzRe7seTTUdVPdU7B5ZYgZevQm5oO1JwB
         nh66oHOrYa07uf2dA7xjCa7BudLjGep3a2aJmM2vU6V7swTP9xZRDqfyADox8fByw5oW
         qgDJFaDJ0jOAozhMknHsfFlMRAs0qHHaKpyM+7JKMYT4SortoD754O8SKHenZ6+WfzHE
         3mjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xz0vKiIHUnBC6KaRjuHnnW/6amnzPB0TTTrzomiuqwo=;
        b=ptBozK0BJRTiwDVdw56xc+QAfVV/W0yw4X4o01nebWxndPqQMxDsZPdPhEdKmMp0tZ
         kpMS6wlUUDkqgiGbES4kGuO4UxxlNg/03wkSRQfM5ji7eymJhVDsSeiOqRHzK45BZuZN
         yxP0ke02FBbPTfXsfJigOfImbfQII1mzTlaPbu50dbzVnnTEFWAcUkKVPORqfdA6JIfc
         gsKdpW+UVIBQ6lIezH2HJXq3MRm3w2kkICkL09PpclSdt/lz/cKJoSXhy5HhBDQIcFDW
         /4DNnazlrFr7GGwWOqyPvHbaEoQvPNeMpgnfdb5Oi7ZIgULH+lEfqA9jomHF9Bw93bqm
         U7Fw==
X-Gm-Message-State: ANhLgQ3MOCZFuQR8DxwnkP5bqHNtvzIWRSwvKf1bNT74gcXPDU5SanAx
        gYZI2TUxK/Sqvi8ebZxnBkhkyw==
X-Google-Smtp-Source: ADFU+vua2MMsBnzheRLXdTg7xrcI8uSK6QVnZ1MrY5/ScWJb2rqjOWfQoOFxS3iaAeNCQhG1TCwhMg==
X-Received: by 2002:a63:f744:: with SMTP id f4mr6023135pgk.345.1583385570426;
        Wed, 04 Mar 2020 21:19:30 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w19sm22592050pgm.27.2020.03.04.21.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 21:19:29 -0800 (PST)
Date:   Wed, 4 Mar 2020 21:19:27 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajeshwari <rkambl@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sanm@codeaurora.org,
        sivaa@codeaurora.org
Subject: Re: [PATCH 1/1] arm64: dts: qcom: sc7180: Added critical trip point
 Thermal-zones node
Message-ID: <20200305051927.GE857139@builder>
References: <1583324635-8271-1-git-send-email-rkambl@codeaurora.org>
 <1583324635-8271-2-git-send-email-rkambl@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583324635-8271-2-git-send-email-rkambl@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04 Mar 04:23 PST 2020, Rajeshwari wrote:

> To enable kernel critical shutdown feature added critical trip point to

s/added/add/
s/point/points/

> all non CPU sensors to perform shutdown in orderly manner.
> 
> Signed-off-by: Rajeshwari <rkambl@codeaurora.org>
> ---

No need to provide a cover-letter for a single patch.

>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 78 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index b8a72cf..7e5f14f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1956,6 +1956,12 @@
>  					hysteresis = <2000>;
>  					type = "hot";
>  				};
> +
> +				aoss0_crit: aoss0_crit {
> +                                        temperature = <110000>;
> +                                        hysteresis = <2000>;
> +                                        type = "critical";
> +                                };

The indentation of all but the initial line is off. Same with below
hunks as well. Please correct this.

Regards,
Bjorn
