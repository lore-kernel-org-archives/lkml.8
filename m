Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712AAC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 19:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F959206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 19:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rU/rB2J7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbgEVTiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 15:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730918AbgEVTiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 15:38:20 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C59C08C5C0
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 12:38:18 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k13so11288886wrx.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 12:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hpXaudKgcoJBGQ0g6uxVzYm/+QRXhqSUmA+R6+93KsY=;
        b=rU/rB2J7Mdt9KXpIYF0r/2PTHbz2uOVQ2NK26cJGrv+R3kPgTVw2zzlxWY/w5lYDYk
         cHOos1Rj8THnNbuv/g5cnIhM6vg75q5jArRdYdRLx8jcf5bYik7iNFewTqNNmL56rIZL
         sqxbaY4+dev8uEM2QOpvBOQbzXEEdD8u1GDZ2CXLuWzX9ATDQlaME+NMvKHMF1giG0yB
         b5SxBMRCFVdNgp+kPP+38NcoPrGMSj2zhd6fdXSCUDX4d0gObUbGpj7GITR4nWIj4DTF
         qPQ6H2nbPfwg9RFsZCw8cdHJR3mnXXdov2ex2dVNx8ayqNusqJK54CPW0fR6OcTial3j
         NMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hpXaudKgcoJBGQ0g6uxVzYm/+QRXhqSUmA+R6+93KsY=;
        b=P/aRMtvEtJE+2RwhGE3lN7D0ZUnArolwbDqgtuf4ZFLhqs5sP23rvKpY7Gv7Mhqjkr
         m0qOWIurn+eWcREbSTHE/DOWNIzkmJwbuCrmyy4uQWl1cshm6LBdj7Ct8mnlHDaXtcWq
         JPk/SMyRCr2zoXTTASHm/Db7COCtnJvEPHmK/pDCB2sbCdZ18NN5za8vBw4A45dPiy0t
         oBbA1ZOU+SrD1DSovY9441LdjjmD4df9nRfLMrQwLMPWyRKPlDYUNjoWdxFdTmgPpyw7
         vFlyg2SpFA8FAiOg0125axzJoeIzSdswtnmRQ9pBoTQg+L+rwzeNmfHjBrDMlvzrsJMg
         XqzQ==
X-Gm-Message-State: AOAM531FT2U1kPB6a6UnqSyV+sOVuufjpK8CNIkKn3ZEaumTJjIVh7sp
        NW/B0hCrjGxMXLuz/ig4MKtxVjjZRHQd3Q==
X-Google-Smtp-Source: ABdhPJxEhOmC/akkcwQuLjNWKRMW/+unLHtosQ6iW22D5aOnV69Tm7M6WvnFN63OyUiN/55666tTJw==
X-Received: by 2002:a05:6000:14b:: with SMTP id r11mr4894259wrx.124.1590176296966;
        Fri, 22 May 2020 12:38:16 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a82f:eaec:3c49:875a? ([2a01:e34:ed2f:f020:a82f:eaec:3c49:875a])
        by smtp.googlemail.com with ESMTPSA id v24sm10846635wmh.45.2020.05.22.12.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 12:38:16 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: timer: Add renesas,em-sti bindings
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200519081101.28973-1-geert+renesas@glider.be>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <50e3cf79-adb6-ba96-1c05-c88f54ccea86@linaro.org>
Date:   Fri, 22 May 2020 21:38:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519081101.28973-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2020 10:11, Geert Uytterhoeven wrote:
> Document Device Tree bindings for the Renesas EMMA Mobile System Timer.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
