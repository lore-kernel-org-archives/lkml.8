Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38851C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 154EC204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OD6CK52y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHQWZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgHQWZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:25:54 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83CFC061389;
        Mon, 17 Aug 2020 15:18:58 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g15so4351026plj.6;
        Mon, 17 Aug 2020 15:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IC+PLCb5BjjrXT4nXK1CE0auHVxv7INrZUJfLM7s8b0=;
        b=OD6CK52yqlmbuPU8ShWjTmv4dQV5QdmDq4dADEWii8Heu1Da/BEe7At9MszRnoWCOx
         hUaieFOvUxFCRy+B9DdomVp+HqDXZDPA3BWKjnN1mVJfh6Xnf4JqT5ISkGLcCxGIx0m2
         vwAcYUpDSo10bFh+ZI7oHpopC4o0DvT63jh5aoU3x+RN1CCHy7ufqeihU/pBIG8sWwxt
         GeCdXS/kMnuQpx0d3wq9sFOC914V1nqt6cI+it2iU/zmCyhwKCIsj2Qkb+KTF3fBrZiP
         +M9Iz6ERW7HgndpieUliURMrXbK7GZ6VWZFOUGuDHf0EcPsCqo4bqIottMTyxt0ZesXT
         KYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IC+PLCb5BjjrXT4nXK1CE0auHVxv7INrZUJfLM7s8b0=;
        b=O8A7ZFZbIe1esNmPGumd4IxWSgBBsKLHIaEzCCqiDABAAGioYrDtMv9ftjDbb3jJO1
         7gt4wU1D+l5KrQqKS9l0Mw9Jd0waJFPGtT+D81P0CB6shssis2Wa/eNzj5mfyYLICUGl
         VLUbt/BneJtPcPPw+njok48wUV91ieqrAC1mxumriV/05LPaKficXbeAvB2eK0ZO/IEe
         vYJZ8jQ/MC8xF00NGf8yaUEmGAVM1NOR36X9WWw8F/+5TEPIbcZ6ANoigClFfX9/HlLG
         uwSu0mvjsveGBDdqroxHPXbeJfe2TpxrZGxSjQD150d4gO6oq0tPWRVRHlN+jejbxXfg
         7ueg==
X-Gm-Message-State: AOAM530X/iWi6pzDiXTeixxk4nvXIbddY5xHNU8C3vesnxKFlgGLrbbO
        N61ryzrfwkZcWHDnOXZJlR7+xJnnMoc=
X-Google-Smtp-Source: ABdhPJzd5z+TE/voo9ADy7aHL82gwXxsBXcvXOFCGJrwqsqSaKtsgR7Wd9hBDKiXtMq2vaUdyX07IQ==
X-Received: by 2002:a17:902:b28a:: with SMTP id u10mr13206624plr.195.1597702737909;
        Mon, 17 Aug 2020 15:18:57 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.25.175])
        by smtp.gmail.com with ESMTPSA id 198sm20828568pfz.120.2020.08.17.15.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 15:18:57 -0700 (PDT)
Subject: Re: [PATCH] of/fdt: Remove duplicate check in
 early_init_dt_scan_memory()
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200814225637.702584-1-arch0.zheng@gmail.com>
 <CAL_JsqJ7eK3HB_E8OeSbs=xVLYrvOcXD9GxpKr2N4dXZWnBP+g@mail.gmail.com>
From:   Qi Zheng <arch0.zheng@gmail.com>
Message-ID: <f2d32b47-cf84-4e09-a8a1-08a323ddd134@gmail.com>
Date:   Tue, 18 Aug 2020 06:18:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJ7eK3HB_E8OeSbs=xVLYrvOcXD9GxpKr2N4dXZWnBP+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/18 上午2:21, Rob Herring wrote:
> On Fri, Aug 14, 2020 at 4:57 PM Qi Zheng <arch0.zheng@gmail.com> wrote:
>>
>> When the value of the first reg is not NULL, there will be
>> two repeated checks. So modify it.
> 
> I prefer the way it was. I'm sure the compiler is smart enough to
> throw out the 2nd check. Plus, 'linux,usable-memory' being present is
> the exception, so usually 'reg' will be NULL.

I got it, and thanks for your review.
Please ignore this patch.

> 
>> Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
>> ---
>>   drivers/of/fdt.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index 4602e467ca8b..f54412c00642 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -1002,10 +1002,11 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
>>                  return 0;
>>
>>          reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
>> -       if (reg == NULL)
>> +       if (reg == NULL) {
>>                  reg = of_get_flat_dt_prop(node, "reg", &l);
>> -       if (reg == NULL)
>> -               return 0;
>> +               if (reg == NULL)
>> +                       return 0;
>> +       }
>>
>>          endp = reg + (l / sizeof(__be32));
>>          hotpluggable = of_get_flat_dt_prop(node, "hotpluggable", NULL);
>> --
>> 2.25.1
>>
