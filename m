Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126A9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F4B20829
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JNmEf5rw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgEROJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgEROJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:09:28 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1F6C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 07:09:27 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id n5so10634114wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 07:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KP1W2Itm/+ybI6CcKF2T7q86qg0QdOvp+lK7UryjN2U=;
        b=JNmEf5rwJZJTr3vmTU+JXBnKh939INhFXQISR4gZuwZuwNupLRBzf58/B385vN8CHT
         yAfEk+7buu6f8M6Z72fr0I46EKkUNOnbKCtWZ+F7Arox8Bqaq+sbNbEjR2iBIaQN9yr5
         gEieuiOZK80sU81Aw6EV7G5+HB+Yd8A5GGNYnTZ/NZYFAUoVGSKqOsT9++GZV5IDShCi
         KWr5whkVMdxzwp/VgAlUvpzBSqlKMHsfbLf/Vdx0iJulRNme1RDydeGFKU2yWukycvuC
         H9KvUAG4zcbPJP3X1O5kf/zXTEcZoJRJeS+9yoKUytzw0Yc++ZRyVy6FuCkHCNFTUSE7
         RDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KP1W2Itm/+ybI6CcKF2T7q86qg0QdOvp+lK7UryjN2U=;
        b=g+4a4S+jQz3E/+SDMN6jfezJ+a73W9cHgi5sBhlaqp0gdwQZHQEDKbUQ8Qk1L9vDMz
         INyDEVQHqsEM3VKcpXjbIi5vzsREJWjUHdOLIn0UYWencosJ0OV6vI7z28L/jTBtEqWL
         9BXeL+IXX5KU/zm00kY4YZ5GADa2c1zZj9Xe/Zsg2eBH8ChReuQyG3KuIHfbZRLx6ZLg
         ea1jLVDUUX9/myW0BCp2c1yOE2oDRGQidUIiBBVXJAgRGOxriZBCHIv93a8tAr2MvexL
         WG1Px84xC18W/R10X1ijXQzM8iFtrEjoka2pUddk0iG7sLFUn+WsshPyREAgRqxNfvJx
         6z9Q==
X-Gm-Message-State: AOAM530qmC5nPwol9IXSGD55vus4ae2IqSgK9PvM9SWRXr8cyhoBOW+D
        uvGGBybcWE8WOAALpkDd2fHCR0KzrAk=
X-Google-Smtp-Source: ABdhPJznBYMlOTMQy1fWtCi9cSlyOljLSD8C50+NxP2y+5UPsZXyZPC/g2hVtKCHqIb31GNdQ8+Tsw==
X-Received: by 2002:a05:600c:2dd7:: with SMTP id e23mr19309184wmh.96.1589810965999;
        Mon, 18 May 2020 07:09:25 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8? ([2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8])
        by smtp.googlemail.com with ESMTPSA id s11sm16348361wrp.79.2020.05.18.07.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 07:09:25 -0700 (PDT)
Subject: Re: [PATCH 09/10] timer-riscv: Fix undefined riscv_time_val
To:     Palmer Dabbelt <palmer@dabbelt.com>, wangkefeng.wang@huawei.com,
        tglx@linutronix.de
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        hulkci@huawei.com
References: <mhng-0c491e9e-41fd-4f76-a048-55c03d9359f0@palmerdabbelt-glaptop1>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <66121f9a-48f3-d3a5-7c96-d71397e12aed@linaro.org>
Date:   Mon, 18 May 2020 16:09:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <mhng-0c491e9e-41fd-4f76-a048-55c03d9359f0@palmerdabbelt-glaptop1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2020 23:14, Palmer Dabbelt wrote:
> On Sun, 10 May 2020 19:20:00 PDT (-0700), wangkefeng.wang@huawei.com wrote:
>> ERROR: modpost: "riscv_time_val" [crypto/tcrypt.ko] undefined!
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>  drivers/clocksource/timer-riscv.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clocksource/timer-riscv.c
>> b/drivers/clocksource/timer-riscv.c
>> index c4f15c4068c0..071b8c144027 100644
>> --- a/drivers/clocksource/timer-riscv.c
>> +++ b/drivers/clocksource/timer-riscv.c
>> @@ -19,6 +19,7 @@
>>
>>  u64 __iomem *riscv_time_cmp;
>>  u64 __iomem *riscv_time_val;
>> +EXPORT_SYMBOL(riscv_time_val);
>>
>>  static inline void mmio_set_timer(u64 val)
>>  {
> 
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> Adding the clocksource maintainers.  Let me know if you want this
> through my
> tree, I'm assuming you want it through your tree.

How can we end up by an export symbol here ?!


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
