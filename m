Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E26C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D152C2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BJL0tpth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgERXZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 19:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgERXZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:25:25 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E17C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:25:25 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t40so534016pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QVj3nKP5hVtsFAiZ/rRDQZNLBRTHzKzhnx5Wf/64tWM=;
        b=BJL0tpthaxkWDwWPe/c0HBJCwfPLNka5lv5YeMvjFA2PknXthQh5APJ6GxH9NeB6FQ
         uysBb/W9wQrmTFs7iAqn5/N1fFPgOTtaNH2tPS0497QTeJXiadpdGoaJzESLIlxJ0Lzc
         7hdhcG+yaNw8b5NBlNfxl4X+72GvVQHMTEiCymuzCgDSiYqkDVCFo32rUG89oFVI7glj
         h9pJuxHVgGFu4aYIGOwe27/uRybA6cyxuATU07vQ0PbgfxszkYfbwoEkW7FKRraGYRZT
         FRoIUJiXIvS/3FLrUv2SDVCbyjtrY/yImGeWFs6Rz6d+YCH0a1wuBBbojDtjV4Zs0lFb
         7BiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QVj3nKP5hVtsFAiZ/rRDQZNLBRTHzKzhnx5Wf/64tWM=;
        b=X7bYH42AirUoZ4ArqdTd5SlJoOViih1BEtoYpbhfjWR97D6W5CKD3Qp2Ang4Wo0brd
         cOL08uEWbR8d6NrXLK2wWRsPRlDtQXHv5765OOQtcFAcfftDi/rmQ2C8ipmmr4nvPwsM
         Cztvhf8NiN6oa6vkaZYbmlK5nzijq6rzn9qcx2452wUsPiD+tvnjWMT6iKMICtGKsaCa
         U70IoEavJwC7rqyl/CwrN+6MKdrrM26Ztw1mTwtk4oDK7Xh1r0AU6tySqRGTt6pYo/Du
         wX1a/163eLa0oB8OWSEpDypOPYa6SX+RByv9Orgg3GS5fln3lWvgFxu4ogDKJzH7BSFG
         /++Q==
X-Gm-Message-State: AOAM531ag/6Y3kacQ8QhODEEnMUNEipn/nTg8MpaPgT3DfFu7hAoRmGL
        v0ptTq1IQBXMJn8SrWcy6rTp6g==
X-Google-Smtp-Source: ABdhPJyPioMHQTi0LewvbyOFTMF+xVG03puGiL/AuNe3V8kLdR52K9tEwVHad/53xErvf7okGmWGbQ==
X-Received: by 2002:a17:90a:bd93:: with SMTP id z19mr1942252pjr.109.1589844324967;
        Mon, 18 May 2020 16:25:24 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id co16sm478114pjb.55.2020.05.18.16.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 16:25:24 -0700 (PDT)
Date:   Mon, 18 May 2020 16:24:02 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     agross@kernel.org, evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-mtp: enable IPA
Message-ID: <20200518232402.GM2165@builder.lan>
References: <20200518214834.9630-1-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518214834.9630-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18 May 14:48 PDT 2020, Alex Elder wrote:

> Enable IPA on the SDM845 MTP.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index 1372fe8601f5..2f942daeb9d1 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -448,6 +448,11 @@
>  	clock-frequency = <400000>;
>  };
>  
> +&ipa {
> +	status = "okay";
> +	modem-init;

modem-init tells the IPA driver that the modem will load the ipa_fws
firmware, but the MTP is assumed to run "LA" firmware where it's the
Linux-side's job to do this.

Regards,
Bjorn

> +};
> +
>  &mdss {
>  	status = "okay";
>  };
> -- 
> 2.20.1
> 
