Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65115C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44C642073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qWkMe3M1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgGUMxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgGUMxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 08:53:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B5DC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 05:53:36 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f139so2744070wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 05:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AGWVlCbvUr0eIufY2rS/elykwxV4Zim+632lJgyVEn4=;
        b=qWkMe3M18JlSQlCm+UcsVVDxBxDCG9VMdtRRUhKpUjMNsVQR54huS28ETPgdc3Fi+o
         woL+tlVY9AXbU15V8K+A+TbiSlY06iDk++KE+lP4yG5RSJ7eueo1g/W4kHZEK86QF7aD
         qf6bHzl3wUYi/FQiEHKvmL94TNcXOjcaRxKSqlnftHHG/jGSlH9zOnDGuV0/5pqHtEvK
         Op3CBfk3zdabXmuxfhQ7E3rxR11rQ3FV7IIuZyQMQSSqEnZeGu69Su6XZo7otKsObpR0
         z85d14lsshn7Bk81CA0OXWw9TTDoFcnxKQVVpP5b3BZnC2PNXwyH8t4EC12CKtWlCRY2
         H83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AGWVlCbvUr0eIufY2rS/elykwxV4Zim+632lJgyVEn4=;
        b=WEL9znVW5r4FzrDD8i1OeEnP15JnZvJ6+TH2a2KEcwDW5ZC1gZgymoSMF6tpZEjRD1
         SCF6DUpS0OwwDNN24UmJ0sZDMbzYCVs11LDlFMy5GjX/RqvsAZXyHwpevic/q8SBuoO+
         LEiYosormCn7Xhbg8+EqSdsEVtjFBEGcUYgs3LZTMyEfyxXhoOIrJqXizeONVXNsMFrg
         IM9jJ7RuyNjaNhx9sxTe4wIYCUsIwBttIo+h/sdrET8WouNrEFMABDDNwq7txTvHhSxI
         G7NOodNdF2n9eDYoB4VlRMMWSe2ZS5XTmtZ6CNRswDPVqSdHU91OBV5VXRnj7ywXE0Zf
         WCTg==
X-Gm-Message-State: AOAM530O0ZZ/him+NEbD8j7WSWwNXHSXQjDQexXgUOl+4Hs5EAC8B3UP
        3REyitJZ71lvXm4QgLUmjSF06w==
X-Google-Smtp-Source: ABdhPJxZoAWaXIC1JED/HvUyGEMlDHNNaHojI1cqxB1Q8x2XxnfiBwmkwYtashw6bU69S8/aIqGnLQ==
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr3812152wmc.72.1595336014514;
        Tue, 21 Jul 2020 05:53:34 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c144:5385:c824:85ce? ([2a01:e34:ed2f:f020:c144:5385:c824:85ce])
        by smtp.googlemail.com with ESMTPSA id c136sm3471685wmd.10.2020.07.21.05.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 05:53:33 -0700 (PDT)
Subject: Re: [PATCH v10 0/2] Add support for the OST in Ingenic X1000.
To:     =?UTF-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        tglx@linutronix.de, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, paul@crapouillou.net
References: <20200720173134.22826-1-zhouyanjie@wanyeetech.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6aca88ad-1e20-97da-effe-fa5a4cec789c@linaro.org>
Date:   Tue, 21 Jul 2020 14:53:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720173134.22826-1-zhouyanjie@wanyeetech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2020 19:31, 周琰杰 (Zhou Yanjie) wrote:
> v9->v10:
> Fix errors which case "make dt_binding_check" failed.
> 
> 周琰杰 (Zhou Yanjie) (2):
>   dt-bindings: timer: Add Ingenic X1000 OST bindings.
>   clocksource: Ingenic: Add support for the Ingenic X1000 OST.
> 
>  .../devicetree/bindings/timer/ingenic,sysost.yaml  |  63 +++
>  drivers/clocksource/Kconfig                        |  12 +-
>  drivers/clocksource/Makefile                       |   1 +
>  drivers/clocksource/ingenic-sysost.c               | 539 +++++++++++++++++++++
>  include/dt-bindings/clock/ingenic,sysost.h         |  12 +
>  5 files changed, 626 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
>  create mode 100644 drivers/clocksource/ingenic-sysost.c
>  create mode 100644 include/dt-bindings/clock/ingenic,sysost.h

Applied, thanks

  -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
