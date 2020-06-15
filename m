Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A0FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E603C206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USX+nXWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbgFORTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 13:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgFORTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:19:50 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880D9C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:19:50 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ga6so122931pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qat0VxBbx1qTyHGu7NwCLTW4AxGPNYRNU1RfuxjjVJk=;
        b=USX+nXWSBpUOlORPUb6eV1pZjK+NfQousCJT4ZEH1BnGmGJH0S84P3VN2A8tDZvpHX
         ysxEvqnu4TTIyohsI5TCKKVVBGecKlT0z67LieLp8C2XCL4CBwnaLY00XKdFPtHMpE2i
         IYhi00382FYJ3uofwQPLtMZXdV+WycvkBv/3c4fZiAvwrwMTdIa1qcILHeV+GStLtBM0
         uylHjcYoC5p85SjVuxbW8aYugfW4cl35x4bfOCw42Uo80pLuYsKL52SRgtMkOcq5c/bv
         jTdDMD6uvZ+6UfAy4GmaFXBlzzniP2Yl8vdGAf12mTm00pUUc1IqI26aR5vuyt3teNYI
         HYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qat0VxBbx1qTyHGu7NwCLTW4AxGPNYRNU1RfuxjjVJk=;
        b=bX362wjtGqV53tqIFechI3J9/BD9qnWNtr9/jrZOKFajiofCjBrXNtsYzM6py8Ek0R
         z5SN6xZHw1nA++aWsL3VmzN2m6gi/hKBW8OvSZGcmWiS57tKIX1yTRm5vlm1hRPeOirH
         VZomeWa3jGvTth4gwsVnayKh1JIsLNPWP+4mmw83v1EiUbBwxAHih8yKpuMjw268R0cP
         8AcSB7JxRcKc3shmSVytTGeJfI4xxwHgrsA9dJF4Mz/h8dpfc8ru73tBDVRdGTKzC5vv
         ENctlDqZT8kz4/4lDynDsoNDOwl4CeJuneYuydez03+VsU9v6WNQReBTV8An6xX+vnkW
         iwRg==
X-Gm-Message-State: AOAM533WUOWOrlSAnpUUN5vk3QNMc6JQH6Jc+bUlR3bDnjhxHFjKP+iW
        su3mg6aPSLUQe1dmALjggy5meg==
X-Google-Smtp-Source: ABdhPJxsE8dB2Arh93h5l5pzvxY+LujvncHPdhLaxAIyxb4NTVE8BH9zgp7aNlPwFLC1D1gT4RXogQ==
X-Received: by 2002:a17:90a:1a8a:: with SMTP id p10mr336840pjp.236.1592241589912;
        Mon, 15 Jun 2020 10:19:49 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c194sm14225592pfc.212.2020.06.15.10.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 10:19:49 -0700 (PDT)
Date:   Mon, 15 Jun 2020 11:19:47 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        mike.leach@linaro.org, Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sc7180: Add support for context
 losing replicator
Message-ID: <20200615171947.GB225607@xps15>
References: <cover.1591708204.git.saiprakash.ranjan@codeaurora.org>
 <5072d94849cfaee46748d26ac997212fb2d783c2.1591708204.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5072d94849cfaee46748d26ac997212fb2d783c2.1591708204.git.saiprakash.ranjan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 07:00:30PM +0530, Sai Prakash Ranjan wrote:
> Add "qcom,replicator-loses-context" property to the replicator
> in Always-on domain in SC7180 SoC to enable coresight replicator
> driver to handle this variation of replicator designs.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
> 
> Depends on coresight replicator change here:
>  - https://git.linaro.org/kernel/coresight.git/commit/?h=next-v5.8-rc1&id=1b6cddfb7ebb5ed293124698f147e914b15315a1
> 
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 9b38867740ca..0cbe322a30c9 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1784,6 +1784,7 @@
>  
>  			clocks = <&aoss_qmp>;
>  			clock-names = "apb_pclk";
> +			qcom,replicator-loses-context;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  
>  			out-ports {
>  				port {
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
