Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2A8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FF532074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZyTh3aA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgFEQaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgFEQaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:30:03 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3558C08C5C2;
        Fri,  5 Jun 2020 09:30:03 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r10so5344001pgv.8;
        Fri, 05 Jun 2020 09:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jp+khy4Vp8GGvY8bqZxPwhAW/ULre+6+z57jAzVL3Rw=;
        b=GZyTh3aA/LcvC8yvPdlgRzqmKfPYtofKcQx/FQG4U827xjARIiLSFMXiZrw3i/aKKZ
         3Me1m2ly3uuxLPHjGvX6TAd3stkgKgJYiQtzrwiWCR28XaNwvL6yCZqEQaA1fyQkoXs9
         KPIJ+WUjqPeLRaU2axFDYD1+3NTV5Z0K+npNZwT5gJghRfsAcRXmqEze+wILLn8jVKKt
         J1dCcP8sP69zrylG8lm/0TcSWf62GWQMKLEkS9ffO3SoxSmS8RxzS4d0VQ0CTuGkyjHG
         vGqumUVhgHHXVuy2xgG6zPOA7Q8ImVFc3krlz/9YQYJOD+UawvzAQxWIP3QheMSkUTQh
         zQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jp+khy4Vp8GGvY8bqZxPwhAW/ULre+6+z57jAzVL3Rw=;
        b=nWdmA0ykaljvnniI//3lb262jYvaPe5jXb7LnxF+vvjjgVMMzsBYOkjh23oMMTfQ/S
         OEVZR3ja48pciq93ZOmnYuceoCkuHQmdLtX0+YIfeoorimUZlwrUM40qt1hwtKLLOxPb
         +s29KI8mGm0oEQqZUxxI5d3mbzLHW4E08/pXsOPQLfcVg2QjzXMlpzUvboigNajIpdpP
         7MhkRHgQKrvK+ghhQjsGC8tbQ1819YOg+Y7Ko1dShvV/wvecu4QKbKF3b+LGGBT6g1R2
         YoVO2eOQ7V+uv44hcUHTXZJ64ZH3OZDo/tNxC+rTKpx3PD73/G3q99y6Rr+RgxssDhok
         TJMw==
X-Gm-Message-State: AOAM530+eegs70H7dzRci7MuyDjlcTtTR5YEXriVz3ORDo+NoN1ttUWI
        MGL5KSS+wxRxsimKROBV+2A=
X-Google-Smtp-Source: ABdhPJzuqr4892KcwVWXDf3CTv6Q3Gu6P33N/sWh8wtfqRU3R4dkh7iKT1p8XGVoxwUux/mq3iNDiw==
X-Received: by 2002:a63:6f04:: with SMTP id k4mr10390354pgc.313.1591374603313;
        Fri, 05 Jun 2020 09:30:03 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e25sm119363pfd.17.2020.06.05.09.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 09:30:02 -0700 (PDT)
Subject: Re: [PATCH net 1/4] net: dp83869: Fix OF_MDIO config check
To:     Dan Murphy <dmurphy@ti.com>, andrew@lunn.ch, hkallweit1@gmail.com,
        davem@davemloft.net, kuba@kernel.org
Cc:     linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc
References: <20200605140107.31275-1-dmurphy@ti.com>
 <20200605140107.31275-2-dmurphy@ti.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6b2ae90e-45d9-e744-53d7-59f9242c3d52@gmail.com>
Date:   Fri, 5 Jun 2020 09:30:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200605140107.31275-2-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/2020 7:01 AM, Dan Murphy wrote:
> When CONFIG_OF_MDIO is set to be a module the code block is not
> compiled. Use the IS_ENABLED macro that checks for both built in as
> well as module.
> 
> Fixes: 01db923e83779 ("net: phy: dp83869: Add TI dp83869 phy")
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
