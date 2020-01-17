Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F248DC33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA11720748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="sfIxgB7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgAQJc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:32:59 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41116 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgAQJcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:32:51 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so25752668ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 01:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FlrrQ/nssXV3OvXK75kddNho6rYCmJKAPSJyNmFq/w0=;
        b=sfIxgB7U1bB9LTHv0aHc7+QPCc3l8aYtittaJhGCf65F4xYxO3R+NyNy7CBNHdyLGp
         uMwnKyb0dIEMTY7wxolA0Reylx3j0aNQDjR5xJdjPg0xM/WiO27fLuMH/GkWsLvSI+DN
         iXoFD3iOr9AcURuzFrX3i3T/lG9a6+XXG9VJfSX1VT5+4j76mU+al5u048Crn9z26bbt
         KWdiosskdzObfWZYDQ5ckAF7/hPZ7OLqLW3+q+3sl+grqKpCTrus8UssWJ8X/ilZp2Yj
         lT+OZNAbPsUpJfmqA9JaeSgVDb4PL0+EUdbH8znbwp8c0STIJvyAD7iVTTy98f/myk1O
         fbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FlrrQ/nssXV3OvXK75kddNho6rYCmJKAPSJyNmFq/w0=;
        b=XKHjvbjpoF+WeIeWSVC1eezOl4D3fowNhGvge7mgQK5Wjs5DUdcl8djSMlSNRkYuU4
         sb97RxEX9p9nPLbhD0zuAeAHViV1OmUeMlVtvVUGxeuWza37FMVCtCYNCKl3WpURB1CP
         Vha9V1Cj30y8VxlN4yS1rXkg9xSOFwsj/BgRx57vqyPEpV2qNBaVcge3oy/ZEFNsCF43
         pZldeJim2/DOGt7qkmC5uG7Mm0/myiZvnUNeuYxaukWF8V3iGP/qZVmUYUqhfehoyXfD
         gwfbhsTEx5iJZEbafPaSlAjhyzNQeygQIu7gVRTiPLpuPZbjOEdOFe9TDjv0gpg13OFU
         neIw==
X-Gm-Message-State: APjAAAWWkBrYu7sHCqXdWUVe0q4q5h9CFwzmpjTRK/T+b7SGDCCFQ5Bj
        6IPoSle4ocbydY0IOTyHWHtj9eFLoL61Cw==
X-Google-Smtp-Source: APXvYqzgGR4ExJ+km0xQAR1IChwYbjGAZZkFrIRdRT9Cl7m98qU9fIismOpqDd/0unVYDWccrg14LQ==
X-Received: by 2002:a2e:858b:: with SMTP id b11mr4984229lji.135.1579253569462;
        Fri, 17 Jan 2020 01:32:49 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:671:f22f:7825:2eb6:5778:a5ff? ([2a00:1fa0:671:f22f:7825:2eb6:5778:a5ff])
        by smtp.gmail.com with ESMTPSA id h19sm12050355ljl.57.2020.01.17.01.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 01:32:48 -0800 (PST)
Subject: Re: [PATCH AUTOSEL 4.19 104/671] ARM: dts: r8a7743: Fix sorting of
 rwdt node
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
References: <20200116165502.8838-1-sashal@kernel.org>
 <20200116165502.8838-104-sashal@kernel.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <3a84e4dc-1d2a-3809-ffac-33d75eb73351@cogentembedded.com>
Date:   Fri, 17 Jan 2020 12:32:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200116165502.8838-104-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 16.01.2020 19:45, Sasha Levin wrote:

> From: Biju Das <biju.das@bp.renesas.com>
> 
> [ Upstream commit 383f6024981d32425fa453bf2e66b546fdbc1314 ]
> 
> Watchdog node is incorrectly placed on r8a7743 SoC dtsi. This patch fixes
> the sorting order.
> 
> Fixes: b5beb5d4c81c358f50a8310108 ("ARM: dts: r8a7743: Add watchdog support to SoC dtsi")
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/arm/boot/dts/r8a7743.dtsi | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

    I doubt that the DT node reordering is worth merging into the -stable 
kernels...

MBR, Sergei
