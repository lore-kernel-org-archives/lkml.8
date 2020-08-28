Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EC6C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071702078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCFPhCXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgH1L60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729295AbgH1L51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 07:57:27 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4011C06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 04:57:26 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id t9so544940pfq.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 04:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=he/1Y5Z3SlUXhKbC55WmYLfVqWvQ3/UHR/4S+KYdVOA=;
        b=jCFPhCXHofmlgkGJnYDXPFJNqBvZU7QtO+9+GO8EZSuInkwY0980++VLGNSUU73qjc
         TD/JoChxAwl0YuZPu5FpTv5Z/MDmkruFiyMa4QTI6hl3hxGnZv2tGlXCWNXpb7FqYlBk
         etcR+mEUuP1aEX/unZ9Hz6AubebPdHiN4bbfKas3/Jfg1ihh4YVL5qFBQvM41yjZnqkb
         SRdDMpg21Ozuioj4YZHV0lG6vPDcQRo570/0kWaGoBe4gbiTaqVJdbVALEmt6cfGiPJF
         Qbpm93IPBj+fOiQEf52torUMGzbU2jqd1Zygi8QgTQ74vi4J50m2f6Hff164DkR9tIzb
         LUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=he/1Y5Z3SlUXhKbC55WmYLfVqWvQ3/UHR/4S+KYdVOA=;
        b=CV8v45lvo8l6zd79ELf+DZsbktwkhTDjJ4vfAxlvMXePZeOkUI3tXFw6xRuRvAi4hB
         trZP6kV3Y951oW2Be3SyWuBUZDReXOZZ58Yy2kRWRmrETvoYkyBw9hXzjI8YMEFlPsF0
         jZCZgyInrdrlV5Trjf+RIl8Sy26krRxcX3TYebzorM/AXNBIKxOXXIouKcSslBc3do1l
         9R4dA92OpRkunKr7nPPCTzbCQstb+HZYmEt7vQy/EK8miC/2VZd6p2UXyopWiegCRsH5
         rHN+EOsnfr1w0zLpsVk9IEVh5p08yPb2ECPleYeaYMvKT1Dfdpwj3Bf5/mE5vp/BcSmq
         EO6g==
X-Gm-Message-State: AOAM5313TewI/DpGQOqknsBfaWfn8p0B9QC2PL2EVnVBhWZ2bNUcccra
        FT4O828FRQeInjsnTAjQhVp2
X-Google-Smtp-Source: ABdhPJzK7GZyhXHBIKF1Skcpwd8jWllhXrq6DetBSfYkudsvOrJ4CpdNkylyF4haLgFaUSYh4pix+A==
X-Received: by 2002:a62:2704:: with SMTP id n4mr1021505pfn.246.1598615846151;
        Fri, 28 Aug 2020 04:57:26 -0700 (PDT)
Received: from mani ([2409:4072:6d87:4cd4:5db4:99cb:1fe6:fc86])
        by smtp.gmail.com with ESMTPSA id d10sm1229146pjg.0.2020.08.28.04.57.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Aug 2020 04:57:25 -0700 (PDT)
Date:   Fri, 28 Aug 2020 17:27:18 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, afaerber@suse.de, robh+dt@kernel.org,
        cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 07/10] dt-bindings: reset: s700: Add binding constants
 for mmc
Message-ID: <20200828115718.GB9143@mani>
References: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
 <1595180527-11320-8-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595180527-11320-8-git-send-email-amittomer25@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 0719, Amit Singh Tomar wrote:
> This commit adds device tree binding reset constants for mmc controller
> present on Actions S700 Soc.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>

I think Stephen should queue this one too but he is not in CC. Can you please
resend it?

Thanks,
Mani

> ---
> Changes since v6:
> 	* No change.
> Changes since v5:
>         * Added Mani's Reviewed-by: tag.
> Changes since v4:
>         * No change.
> Changes since v3:
>         * No change.
> Changes since v2:
>         * No change.
> Changes since v1:
>         * No change.
> Changes since RFC:
>         * added Rob's acked-by tag
> ---
>  include/dt-bindings/reset/actions,s700-reset.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/dt-bindings/reset/actions,s700-reset.h b/include/dt-bindings/reset/actions,s700-reset.h
> index 5e3b16b8ef53..a3118de6d7aa 100644
> --- a/include/dt-bindings/reset/actions,s700-reset.h
> +++ b/include/dt-bindings/reset/actions,s700-reset.h
> @@ -30,5 +30,8 @@
>  #define RESET_UART4				20
>  #define RESET_UART5				21
>  #define RESET_UART6				22
> +#define RESET_SD0				23
> +#define RESET_SD1				24
> +#define RESET_SD2				25
>  
>  #endif /* __DT_BINDINGS_ACTIONS_S700_RESET_H */
> -- 
> 2.7.4
> 
