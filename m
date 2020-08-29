Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C4CC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5666C20757
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vc4KGL09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgH2SXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 14:23:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45908 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728265AbgH2SXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 14:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598725382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N69O3JqyfpO6Q53TakcsJx0INILeQLhb/WtKXvbJ2/M=;
        b=Vc4KGL09Kh2h/Rk+/7nCg9tUU6rgQHz82PJtZbjnDtcFGzPNA4jFxbp2x/oKQUU1ddY/3O
        yo6FUyp2BNk0a1afGECgHbNn98goiejFGVrctb6twNN45An+biakhDKHQZXl4pLOBz84vr
        O37pJvZdOjgIf40QnnJR7S0RAhpVyhk=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-fc1_9Yf6OGamUUdgL48m0Q-1; Sat, 29 Aug 2020 14:23:00 -0400
X-MC-Unique: fc1_9Yf6OGamUUdgL48m0Q-1
Received: by mail-oi1-f198.google.com with SMTP id k8so507660oig.14
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 11:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=N69O3JqyfpO6Q53TakcsJx0INILeQLhb/WtKXvbJ2/M=;
        b=mvlNV9GRyHP9FOo5VEEZ+FgFLeZ5+75PN3q4+Y3jWy932jpnyFOjGMThDXe4+hg3Uq
         2M88XWUvxRCOPWqx/MvYFvr82r3McQ0OVWNfwF3hWazd9RPkUVO1m8VaVnh6tMXBFT4y
         PkhwASx0K7uJPK5YQXfJmJkjvPc6GZlh7+wRS/ArxQ0tZRKBAbPRo+wviWq5Dts1INvf
         Td7yVt2Y3HbIU3Y9N9A+Z8hr5BpALxNEHOSHfVWU9+YEXFrt8hjudj1n4FOvg+MoHiMx
         sgRVgrXXbCh8FpxmqeNbBAuVjjVFhxak26VVmSsFkZQd1XvHVVvb0ZNh1yVlFlT266H7
         Gtgg==
X-Gm-Message-State: AOAM531hkiut2aKFFeZ8hgIZYjeCGjSqiphPHXIEJ17JvFCdBPaue4OM
        mRWBp2TV4tigObmjnqaGFojoFCv3TSqbi59gnLcCywfbBDRUY5Qjg+K2yrNIXKngoCLvZW/W2kQ
        TROgLZOIeBjZvdGozQMt6Vf/2
X-Received: by 2002:a9d:639a:: with SMTP id w26mr2826532otk.140.1598725379845;
        Sat, 29 Aug 2020 11:22:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfvqvnO7qYG7NhZTrLentt/UvP0D6ejA0xcVnGUrQPxMb7j+hwr/GXqLIEun2PD7UmeYZmxA==
X-Received: by 2002:a9d:639a:: with SMTP id w26mr2826528otk.140.1598725379640;
        Sat, 29 Aug 2020 11:22:59 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t5sm453405oic.20.2020.08.29.11.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 11:22:59 -0700 (PDT)
Subject: Re: [PATCH] regmap: soundwire: remove unsed header mod_devicetable.h
To:     Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20200829103939.4007097-1-vkoul@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <fabb9c26-febc-1767-54b1-7a71a643517f@redhat.com>
Date:   Sat, 29 Aug 2020 11:22:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200829103939.4007097-1-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/29/20 3:39 AM, Vinod Koul wrote:
> mod_devicetable.h does not seem to be required for this file, so
> remove it.
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/base/regmap/regmap-sdw.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
> index 50a66382d87d..c92d614b4943 100644
> --- a/drivers/base/regmap/regmap-sdw.c
> +++ b/drivers/base/regmap/regmap-sdw.c
> @@ -2,7 +2,6 @@
>  // Copyright(c) 2015-17 Intel Corporation.
>  
>  #include <linux/device.h>
> -#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/soundwire/sdw.h>

This looks ok because mod_devicetable.h is #include-ed in soundwire/sdw.h

Tom

>  #include "internal.h"

