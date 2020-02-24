Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3868C11D2D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A046020726
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wOJl5Cgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgBXKAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:00:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39723 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgBXKAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:00:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so799293wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 02:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5kMWKYrh992GZWTACf9amzemAuduDOlF955KN5EwvQw=;
        b=wOJl5CgbQy6U3aWnwofJi51rIVWN4K+Ld9+tffFieiVlVfi2/dHqXF40Cq3T1kb4Hd
         JUNcqOCZ8LswILeUgNcr8bP9l5VvdXg6prdZboDZ0FklYR/nEO/5G5+SLS2xyvII0M8O
         MyPUv37S1xPx4szsummDjBD7YuBDtftwpdc1a/douez9IdwrT/1qWH81PPr5mWk5S5ZX
         Dr6JVrft/D6igiJSAztEKvVYmr3wkssu/UxOPrnYXEYS1jrqH3t1kEYNrzRLZy50NY+k
         2LTdsT4gZ8wC7Xunm8aJACAx3yBq5deU3CkCN7mubwdZRtAB9YKvzKBmufAgRjdi8ydd
         L/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5kMWKYrh992GZWTACf9amzemAuduDOlF955KN5EwvQw=;
        b=ESjUYaheMTCX3XM36zTqLWhozBy+ui7ekgBq20v8w/ZZ5M7wSWzmet0/R8XX1pz7rf
         ILMShMPjbcZTypPVQQUq7CNfI5UFA7D58tvhe5yOWEIFwewgnT25/xyw0JWM0N6cavV9
         xNDcAt9eqZoNL+0HhCaGi1tg8po9nyPC3Pjgqyi2A2/ZyulOScou85b3zuA3mFDoCqnA
         Qo6HN6aSZiQIGjCwWXOu8bKUcv/FBkW9VwvNwq6cCBBkQN5BUMfFASPL9ZWP5yP6RH/y
         +vCy+11l5FjWW0bU//goty1v5U0q70/b16VJW/Bf+5rFd2fpYi9ng+Eng0ro0PvCDNM5
         IDXA==
X-Gm-Message-State: APjAAAXhLD3m90f/PZ1Ei9J7gaHpmXiVJS9CtaoUcyz1g6vA7fhVAOOj
        JmeABLZcqaaSYm51T82w5ynIYQ==
X-Google-Smtp-Source: APXvYqw+eVT/ekOFVzqh6k7LzKVEDiUtf7y1cMrybh2fcleVG3PtFkiVzf5QhVfc93XqXI91aPlTag==
X-Received: by 2002:a5d:45ca:: with SMTP id b10mr9472914wrs.250.1582538406847;
        Mon, 24 Feb 2020 02:00:06 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id v1sm11105968wrp.16.2020.02.24.02.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 02:00:06 -0800 (PST)
Date:   Mon, 24 Feb 2020 10:00:37 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        David Lechner <david@lechnology.com>,
        Tony Lindgren <tony@atomide.com>,
        Roger Quadros <rogerq@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v2] mfd: syscon: Use a unique name with regmap_config
Message-ID: <20200224100037.GK3494@dell>
References: <20200127231208.1443-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200127231208.1443-1-s-anna@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2020, Suman Anna wrote:

> The DT node full name is currently being used in regmap_config
> which in turn is used to create the regmap debugfs directories.
> This name however is not guaranteed to be unique and the regmap
> debugfs registration can fail in the cases where the syscon nodes
> have the same unit-address but are present in different DT node
> hierarchies. Replace this logic using the syscon reg resource
> address instead (inspired from logic used while creating platform
> devices) to ensure a unique name is given for each syscon.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> v2: Fix build warning reported by kbuild test bot
> v1: https://patchwork.kernel.org/patch/11346363/
> 
>  drivers/mfd/syscon.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Waiting for Arnd to review.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
