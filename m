Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AA6C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8301521D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAxTeZYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgBZCQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 21:16:23 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54156 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgBZCQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 21:16:23 -0500
Received: by mail-pj1-f68.google.com with SMTP id n96so579858pjc.3;
        Tue, 25 Feb 2020 18:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y8tea9QEMr0iNCjcooNustc07FFjz5OLLARL8p+OKU0=;
        b=AAxTeZYs7StrnRAz7zTUOcTj/eVOM8S5GJpuv2sfSKJvdowIHcle/pyJgBKWzO4k1k
         253V7sTzYfxtmLIWstH6rR7ykht8aVTV4hfdc5s2x3BwDxUPq4iNwH9Lfa5CrQz+bdRB
         gnRaBrj3RnNZBRgO0gU/kRKMc2bhRe7BzCdWAL32M+hrRU24cJX+TAa4Fx2HlKGUYsm4
         fFO2rd/EkDAEqQGos59MItNM1iOJOzBQ0bAGGNYGwS9JIvggLqkaQ/GVs5YHupn0OvQ6
         uHbxcbRga6MEa/CxLmrrsYznqfLeNawiFKSuEqPpNTkTkVbVbJAQUZbxuSL5yTPehR+t
         9Cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y8tea9QEMr0iNCjcooNustc07FFjz5OLLARL8p+OKU0=;
        b=kcrx8z0TM6GkgEW+vFKHqTdiI4b6y23d4lH4+n3twPmpKEFXKqfb8ybqVFPmCLG9m9
         b7ete2UE2ondJGs6aEaktfneIIb+R1ytemdNYWBF5e8jHA634DXM1WgwcHYNqZyDi69V
         TwqljVUCia4Mv5Z9FNLsxIuhiQJwIPlpOywJfNk9hcp7Pw2P27UEWZIy5NbZ0fFOqU4j
         N0XOxUw/RBO2cvGH1jPW319Dn6HamZRAWlzN/p8juqGnDQT5WcQZbOS35+bCit1Mvo/5
         9jEvODfwl6+54IV2x3btmnh7gbEifn5ecP3fQVTxkAFrKKg0AkC5iU1izblYqlPp+pPA
         DKrA==
X-Gm-Message-State: APjAAAXRFw3d0wlilcWEWpBq4hscZ23K3LuVAGY14sBKzzH4j6Z/st3l
        /0s4SoCccpPQ05vXtfPvTFhcqVxQ
X-Google-Smtp-Source: APXvYqwN64XLm4UBZIiSsolCHUzAopIGIZIYT9ipIlQaRoboFPbd6+E2cEjuKJ3Wp0RDIBQIhs6DXg==
X-Received: by 2002:a17:90a:e996:: with SMTP id v22mr2390374pjy.53.1582683381992;
        Tue, 25 Feb 2020 18:16:21 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a36sm302764pga.32.2020.02.25.18.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 18:16:21 -0800 (PST)
Subject: Re: [PATCH 3/3] hwmon: (ina2xx) Add support for ina260
To:     Franz Forstmayr <forstmayr.franz@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20200224232647.29213-1-forstmayr.franz@gmail.com>
 <20200224232647.29213-3-forstmayr.franz@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a78bbb40-9a0c-8acc-841e-7a51447d4dbc@roeck-us.net>
Date:   Tue, 25 Feb 2020 18:16:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224232647.29213-3-forstmayr.franz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/20 3:26 PM, Franz Forstmayr wrote:
> Add initial support for INA260 power monitor with integrated shunt.
> Registers are different from other INA2xx devices, that's why a small
> translation table is used.
> 
> Signed-off-by: Franz Forstmayr <forstmayr.franz@gmail.com>

I think the chip is sufficiently different to other chips that a separate
driver would make much more sense than adding support to the existing driver.
There is no calibration, registers are different, the retry logic is
not needed. A new driver could use the with_info API and would be much
simpler while at the same time not messing up the existing driver.

Guenter
