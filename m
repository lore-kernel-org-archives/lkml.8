Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF55C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 23:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348EB20674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 23:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Crfg0bOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbgCPXBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 19:01:37 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37645 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732855AbgCPXBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 19:01:36 -0400
Received: by mail-pj1-f66.google.com with SMTP id ca13so9481986pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 16:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fehKvZxYP/3rVzxI5Pgt4N8ta8jaYMBYM9KjLaH31Kk=;
        b=Crfg0bOF1Oi75XEGHY0i4RiQTv2sQAJyqJvMaySiM0ECjEc2KltQ+97LRnTGrAj+jH
         JAoTSyAnocqzYkIftQFbVyGTQUvOz2fNiqy2+6RlfK/IULqWuHJgqJ30hWzi2lwRSOAH
         JgnB+5han/zfdEctloxnVctym+PtFnZy6bItlwMF+CRcKrzvkyW7dVBHMxzLGmffYC4U
         hCiS1ZTFWbp/kfXqQrqIGSS9oy3d+y6kufMrteZ5CDOLc5cuoXfNTKBIEjycI2vDmROM
         Q8j+p9opGt1y0SWoK0/q3QGWLGYyC0dDm6ow4qkGAMDZaJTO12GXNdt1CoIzcK64wI/C
         PoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fehKvZxYP/3rVzxI5Pgt4N8ta8jaYMBYM9KjLaH31Kk=;
        b=Rc2mwRUKGlQWUkFmhCOzCsdAcepmXN0XJou/R5H2p4/acmhBTNiu6RXFAKm5K8wY9I
         vvz5gVXtejvgIjspjn8zw/wAXQfqEyOcBbka/woVI7bJT/wLZgLC8uoDtasBSNz5cBqn
         MQWW+U8k5HnVoBhVMv5EGiC+XpvqGYu8lBqm6MLBa29MiZ3DVfY/4N5FuSyupXbqEXJj
         hr3VbwY2sB2BAF7kEGJsZ6+nIXmTugRRnmq95bt0jdHQ66yxK5oqRvckCPaeSkvvjqm7
         bj7CFWsDiCEYms5rSAE+f6tZPNxzfgsh0tHKZF6GENloFbLTrE0R6UEXiN3nmEVuoYKA
         qyuQ==
X-Gm-Message-State: ANhLgQ0KKuxB7WJ6xYb+crS2b2l96RU10dt070B4X8GCCXa+jsM5yNF/
        TDFL55Yh1EySpGdcwEdpbS78qA==
X-Google-Smtp-Source: ADFU+vvjt+1MEHUInOGAMb6G1Vup3egEpYosrf5bJPKH87idMiQ9N1Nmevh8lGHncWJmkvssY2PRZA==
X-Received: by 2002:a17:902:8a8f:: with SMTP id p15mr1444666plo.45.1584399695133;
        Mon, 16 Mar 2020 16:01:35 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q8sm765927pje.2.2020.03.16.16.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 16:01:34 -0700 (PDT)
Date:   Mon, 16 Mar 2020 16:01:32 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] remoteproc: clean up notification config
Message-ID: <20200316230132.GC1135@builder>
References: <20200316225121.29905-1-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316225121.29905-1-elder@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16 Mar 15:51 PDT 2020, Alex Elder wrote:

> Rearrange the config files for remoteproc and IPA to fix their
> interdependencies.
> 
> First, have CONFIG_QCOM_Q6V5_MSS select QCOM_Q6V5_IPA_NOTIFY so the
> notification code is built regardless of whether IPA needs it.
> 
> Next, represent QCOM_IPA as being dependent on QCOM_Q6V5_MSS rather
> than setting its value to match QCOM_Q6V5_COMMON (which is selected
> by QCOM_Q6V5_MSS).
> 
> Drop all dependencies from QCOM_Q6V5_IPA_NOTIFY.  The notification
> code will be built whenever QCOM_Q6V5_MSS is set, and it has no other
> dependencies.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> v2: - Fix subject line
>     - Incorporate a change I thought I had already squashed
> 
> Dave,
>     I noticed some problems with the interaction between the IPA and
>     remoteproc configs, and after some discussion with Bjorn we came
>     up with this, which simplifies things a bit.  Both Kconfig files
>     are in net-next now, so I'm sending this to you.
> 
>     Two other things:
>     - I will *not* be implementing the COMPILE_TEST suggestion until
>       after the next merge window.
>     - I learned of another issue that arises when ARM64 is built
>       with PAGE_SIZE > 4096.  I intend to fix that in the next day
>       or so.
> 
>       					-Alex
> 
>  drivers/net/ipa/Kconfig    | 2 +-
>  drivers/remoteproc/Kconfig | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
> index b8cb7cadbf75..9f0d2a93379c 100644
> --- a/drivers/net/ipa/Kconfig
> +++ b/drivers/net/ipa/Kconfig
> @@ -1,9 +1,9 @@
>  config QCOM_IPA
>  	tristate "Qualcomm IPA support"
>  	depends on ARCH_QCOM && 64BIT && NET
> +	depends on QCOM_Q6V5_MSS
>  	select QCOM_QMI_HELPERS
>  	select QCOM_MDT_LOADER
> -	default QCOM_Q6V5_COMMON
>  	help
>  	  Choose Y or M here to include support for the Qualcomm
>  	  IP Accelerator (IPA), a hardware block present in some
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 56084635dd63..ffdb5bc25d6d 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -128,6 +128,7 @@ config QCOM_Q6V5_MSS
>  	select MFD_SYSCON
>  	select QCOM_MDT_LOADER
>  	select QCOM_Q6V5_COMMON
> +	select QCOM_Q6V5_IPA_NOTIFY
>  	select QCOM_RPROC_COMMON
>  	select QCOM_SCM
>  	help
> @@ -169,9 +170,6 @@ config QCOM_Q6V5_WCSS
>  
>  config QCOM_Q6V5_IPA_NOTIFY
>  	tristate
> -	depends on QCOM_IPA
> -	depends on QCOM_Q6V5_MSS
> -	default QCOM_IPA
>  
>  config QCOM_SYSMON
>  	tristate "Qualcomm sysmon driver"
> -- 
> 2.20.1
> 
