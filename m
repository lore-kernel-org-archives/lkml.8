Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3A0C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E0DC206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Gzz92IMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbgGOIQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbgGOIQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:16:53 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6C8C08C5DB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:16:53 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s9so1534137ljm.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I5qZejAIQq++nnd7O7LL3lalpe7lhmzwl0tFbvuobuo=;
        b=Gzz92IMQX2sC0iZHXUrf4B54p2Nu5HGb/sJFPOgQq/1UflTk9/FKdYY4lLrTSNXu0w
         PZN0c2ABgKSbYHv6Pk3shycPo/BkbFCLufjq+5DxgjtfF6Y44ScQw0h3wcp2SDV5hze0
         mJ2CokvBuuotOUOH2z2rRknfxowQNuJvGIIbapp+TCfchXKrHXUVJ+ikCKtPEly8PAFu
         mWsTFK2Ois6xOffKQEnyDkNZoCDqzhkzRnmW5AKy2HcZdHHjLVEbTkkurQKD1wK2d+EY
         eSfpJaCrVpm8ocppmWIqUU0veC6tkc/CyNJLg+RKJfRNVvZG+LapQef0T6N81JNR0Khq
         Ud+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I5qZejAIQq++nnd7O7LL3lalpe7lhmzwl0tFbvuobuo=;
        b=PdyYTqIhye4B9v8L4JawvfbBfpnLwYW6//mHPDcV8IpML9shM9ee5yQi2NdTm9IIEt
         WTWPyLnUDiAcQC8ycotgLmgDufZwJBEIPkCZeh2UGp9IBtvK7dajiXX7sdbnH8g9Kb7F
         G6ygT7mVexjWtr5s6l9JgiU6nNvFbI84jFActnrUBknqLS/XzvD/TovZ5eeACBGTVDMJ
         KjnVF8N39AlI45tWvQNoQkunTNorUXKPfv1Ri/jYrJ/au57Iz4ioKgcJZJrSiYUsjwO3
         9s5KwIsz+RGHL6jCpoNdEcH56YSVqY849l5mom4Y3pOSuT2qT8/S/uWvZyajwwIzb2PL
         yZrA==
X-Gm-Message-State: AOAM533IyylJgOuHT04tOvjHlFet1sd4VXc3PC5pIe+1821x9liSaLx6
        ZJVM4BPZaaqn+l+fv92S0DsQ/yAMLe0=
X-Google-Smtp-Source: ABdhPJxqAFU9d9qG0B2IeCGOTGsnjaqirHnR+hmZdY7Fok6nHXNjd8zVRcxq89X/7K/8CQUFnp9PAQ==
X-Received: by 2002:a2e:850b:: with SMTP id j11mr4605072lji.30.1594801011614;
        Wed, 15 Jul 2020 01:16:51 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:42dd:3c8c:7d45:c199:bbef:e36? ([2a00:1fa0:42dd:3c8c:7d45:c199:bbef:e36])
        by smtp.gmail.com with ESMTPSA id w24sm338403lfl.17.2020.07.15.01.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 01:16:50 -0700 (PDT)
Subject: Re: [PATCH V2 2/2] dt-bindings: arm: renesas: Document beacon-rzg2m
To:     Adam Ford <aford173@gmail.com>, linux-renesas-soc@vger.kernel.org
Cc:     aford@beaconembedded.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200714123419.3390-1-aford173@gmail.com>
 <20200714123419.3390-2-aford173@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <c2e52f87-b2cf-ca36-7780-5e206f065d40@cogentembedded.com>
Date:   Wed, 15 Jul 2020 11:16:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714123419.3390-2-aford173@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 14.07.2020 15:34, Adam Ford wrote:

> Beacon EmbeddedWorks in introducing a development kit based on the

    s/in/is/?

> Renesas RZ/G2M platform.  This patch adds the entry to the bindings
> list.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:	New to series
> 
> diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
> index d8fd25bccbf5..0d4dabb4a164 100644
> --- a/Documentation/devicetree/bindings/arm/renesas.yaml
> +++ b/Documentation/devicetree/bindings/arm/renesas.yaml
> @@ -118,6 +118,7 @@ properties:
>           items:
>             - enum:
>                 - hoperun,hihope-rzg2m # HopeRun HiHope RZ/G2M platform
> +              - beacon,beacon-rzg2m # Beacon EmbeddedWorks RZ/G2M Kit

    Why the vendor-prefixes.yaml file calls it Compass Electronics Group?

[...]

MBR, Sergei
