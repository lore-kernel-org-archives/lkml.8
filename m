Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD94DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A305420716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OdjHNcMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbgHQT6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbgHQT6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 15:58:14 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CD2C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 12:58:13 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so16157683wrl.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 12:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1Fr1vGlBQgBU5JqTKUEkaACpNt2y5GGO5BLw70RmP5w=;
        b=OdjHNcMPoVQpT4ZCVjrTsGSk9o+xrFUGPX3XR33lWf413eHVN2REanM6skhqrVleyc
         UujDCnvMMm0yDMfWw0iHvYrAvgPslWUzPJTV1Xo2gnThEXE8CAa1hetp7hWBZeDNpG55
         dAP3L7s8GUm5QHnBJQ2jW6eUTRXiVwxoZM+V1JB/5EafxxyFlSu8WboCwiLQZHRbLOMT
         MDZJSvThe+07w1uIuvRiXzckaFGvpXOPGGLnPbndP7NCpyRGCyBCREvXawLbPqWVB2Y4
         0z2SYLpRFKqu/soDJyXrJd/Q/vpnxX6iFjB+6HOVlm2/sJOV3JTG6RvRZOIAhRxViZ2M
         vCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1Fr1vGlBQgBU5JqTKUEkaACpNt2y5GGO5BLw70RmP5w=;
        b=EjZ+Q6u2W2mYR1qUGAilwmBurLOZrozZoC2yEyJcKt5HuvziGjEJhF6TuZc3ynMjCy
         o+CS6/Afx+QDjd4geSoAyVlmvmT9LHVdNteLjpDymlRXlzMBfrYu5/pHF4UQSixRBr7k
         M/hxFHHXVbmJKemQ999FQ83aIf1EzGj1aeODKEZtNO0zkOSuQiMUkERxWH53X7KDdO/A
         TGLqWjyymq0ccagH5NxfiaVPchhgAqzWMsDyvI2j/NwG/h5G0WawAXj2BROAKx5dfclU
         ZspTSV/S/N0ITJB240lXwxTcsicInln3nEmTZcw6EF1kOcgIYhBABtoH6xCPnE5/BxWV
         oekQ==
X-Gm-Message-State: AOAM532yopXjpbr0T1kRPVslRfy3QDscQrFN1mG5RZx5JFqgQynLA1Yi
        tuKiBEJCNFmaYh7mubxnL4fwHBrIOimbIg==
X-Google-Smtp-Source: ABdhPJxPZwwaHApAf1EPzVQXLzhlP3XUz7hTUa//zes0+W2OIbOTsi0Gh++M8SYDc5/ldYx4eox1LA==
X-Received: by 2002:a5d:414d:: with SMTP id c13mr11670567wrq.78.1597694291919;
        Mon, 17 Aug 2020 12:58:11 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id l21sm29105322wmj.25.2020.08.17.12.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 12:58:11 -0700 (PDT)
Date:   Mon, 17 Aug 2020 20:58:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     David Miller <davem@davemloft.net>
Cc:     kuba@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/30] Rid W=1 warnings in Networking
Message-ID: <20200817195809.GX4354@dell>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
 <20200814.204242.2048284550886688191.davem@davemloft.net>
 <20200817092611.GW4354@dell>
 <20200817.120256.1925874893882136188.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200817.120256.1925874893882136188.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020, David Miller wrote:

> From: Lee Jones <lee.jones@linaro.org>
> Date: Mon, 17 Aug 2020 10:26:11 +0100
> 
> > Are there any more sub-groups that I need to be aware of, besides
> > wireless?  Or can everything else be grouped together?
> 
> Netfilter, mac802154, usually the Intel and Mellanox driver
> maintainers take things in directly then send pull request to me...
> 
> There are probably several other examples.

Okay, I'll bear that in mind.  Thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
