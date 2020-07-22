Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA461C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E10B206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iAS4i7Tg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgGVQt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 12:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgGVQt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 12:49:59 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5588C0619E0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 09:49:58 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x5so1964520wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 09:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c2nAerlR11FC4bc73llJS+KYZxx6imSwhCd66cb6xO8=;
        b=iAS4i7TglEthtM/HZoQ129NxIbAtlHbTqcU68I1QgUbrfqibKhoXmm4OOKNTANCwwO
         dDsDzmsdKb1tq45zSfE32cuCYKQQti6f+rkD6mNU0uEzCnoNmuKSt3ZdSw0z9drysK/p
         FA4OVFOefwYD7WqHRBtaiA6S2O/ku6Ov4e6Fznk+jppwkjQm9YwjBqkEubIq9JkkT9cV
         0UcJyzCM4ZYWSHbV8kNK4BWo+SkGwTNZQXKwnJDfGZ/XwA7Zd6CqpmSSDvG+fb31YdnK
         nUthXh+VCOPiFxtW76Skle8eGPMLQ0vYPTZP0SjRb10yjIaPbmX/2NaZE0VSmwbboM4V
         00nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c2nAerlR11FC4bc73llJS+KYZxx6imSwhCd66cb6xO8=;
        b=fHn+bniys09bF7BMgOaw/hdC9iEl+wa9ybZMNH85/Zqu/OR4JKcUI3i+TZt6clojL5
         hAoEPmiWRNBZkCIR7yqXlsb9pWVVqjqXSTSh4cxkjoMucz1m9YQS+8sPXrWn7XpJNHu4
         tTYYZKz9hP6fmadibMO4aNRQvMfdEhZbSuF9mxdSDExTemny3pgpP+ZlwRoIuDbvFtyS
         T2/84r+3taqI+d2Tf17nbU3IfqnvEajWK68PnF9uGCYqTiDNt7b+uALLcc7wFAgvjPUF
         gdWQN0c4v1OxdnEwoyMq6PpQ277zLS4ii7aRgPygy2HSUMnKYz+uycTiDj10CYM1kSmR
         xchQ==
X-Gm-Message-State: AOAM533nnZmsMRih7kPUjC/by6l/jzzFd4yzRBo5OTMka1YhE/gM4x2o
        ACxpjCiKVLnHD4Y0NcNSzf6lKg==
X-Google-Smtp-Source: ABdhPJzy1AZnXOnkwBJorSdXJuVH0ao3cr5xpLz10DDOsUZL37/6MCteU3K8UfOKE0lSMg3jHPcIyw==
X-Received: by 2002:a1c:18e:: with SMTP id 136mr457537wmb.93.1595436597304;
        Wed, 22 Jul 2020 09:49:57 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:dca7:8d30:33fa:daac? ([2a01:e34:ed2f:f020:dca7:8d30:33fa:daac])
        by smtp.googlemail.com with ESMTPSA id p8sm667819wrq.9.2020.07.22.09.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 09:49:56 -0700 (PDT)
Subject: Re: [PATCH v10 0/2] Add support for the OST in Ingenic X1000.
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        tglx@linutronix.de, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, paul@crapouillou.net
References: <20200720173134.22826-1-zhouyanjie@wanyeetech.com>
 <6aca88ad-1e20-97da-effe-fa5a4cec789c@linaro.org>
 <0ace68b6-9d75-8b8f-c108-89863cb6d03d@wanyeetech.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8129fbbf-652d-5429-4b8a-63038cd42ccb@linaro.org>
Date:   Wed, 22 Jul 2020 18:49:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0ace68b6-9d75-8b8f-c108-89863cb6d03d@wanyeetech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2020 18:47, Zhou Yanjie wrote:
> Hello Daniel,
> 
> 在 2020/7/21 下午8:53, Daniel Lezcano 写道:
>> On 20/07/2020 19:31, 周琰杰 (Zhou Yanjie) wrote:
>>> v9->v10:
>>> Fix errors which case "make dt_binding_check" failed.
>>>
>>> 周琰杰 (Zhou Yanjie) (2):
>>>    dt-bindings: timer: Add Ingenic X1000 OST bindings.
>>>    clocksource: Ingenic: Add support for the Ingenic X1000 OST.
>>>
>>>   .../devicetree/bindings/timer/ingenic,sysost.yaml  |  63 +++
>>>   drivers/clocksource/Kconfig                        |  12 +-
>>>   drivers/clocksource/Makefile                       |   1 +
>>>   drivers/clocksource/ingenic-sysost.c               | 539
>>> +++++++++++++++++++++
>>>   include/dt-bindings/clock/ingenic,sysost.h         |  12 +
>>>   5 files changed, 626 insertions(+), 1 deletion(-)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
>>>   create mode 100644 drivers/clocksource/ingenic-sysost.c
>>>   create mode 100644 include/dt-bindings/clock/ingenic,sysost.h
>> Applied, thanks
> 
> 
> I'm very sorry, I found some typos in this series, do I need to send a
> v11 to fix these typos?

As your convenience, V11 or patches on top of V10. But please do it
quickly as I'm preparing the PR.

Thanks

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
