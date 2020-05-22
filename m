Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC0AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79830206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="xos9xnl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgEVJKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 05:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgEVJKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 05:10:48 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69807C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 02:10:47 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m18so11747530ljo.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 02:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9ofTQmEmfXkUcuVidw/3/uTdX1nNZlN27Kc/a5adlBE=;
        b=xos9xnl9YZMdIx1d5mCEq3WAxSwvc5UCDqkmUO2+7x7I2+vGVPF21hwGBtxoXZCbzN
         BfTzYnkM3jf1GNsGMpQwEhZJU19G76BgsR6WIkEl8q8ipZmtiT3LJZ5dylbF6sPZvy/g
         iPD32Jwa+lXfjf9Z+JcRgthh+JjV/VaPn5w8qYW4qmZxbnjKhEaS6EVD1kwklB7PIOrU
         VVV3ngvcL9YBwXPHqqtmnNfpJC+FTzpzuGe4RsqkkeXWDTqNFR6M3t10HoO2emoGSdv8
         tR623mcE5V6xS7Em0K0KHrKx8XzwmkbnL6Aek+bllgxrfNKJZ7HYyZyZ/80/A7wWMmJx
         UXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9ofTQmEmfXkUcuVidw/3/uTdX1nNZlN27Kc/a5adlBE=;
        b=UXVr5cXeGTHQpiaCnof/LsdVtWN4Eg/VtDbIYVTlWL5ueBtiouuGh5ewUUfqJV7Lyx
         RrTqDRaeJaucLDCQJ4QY8vn85CaZ+7YOspFNeZlfg1fSl9pakbHea7PQ9YQzo0Do+Fm8
         WwYf4q8KQEbc1J8NKrg0kmxuFSLrTANZ4SKY8O+JvSAj5lbS9zVgRr7OBmEnnP0EnWXw
         DmPV29kpyFFiFZjhOh0Ey2ks3eUoFq1rcoLb3Z00Oi9YEP4v1dEoXfuCNOQs0j+fcRiP
         Q3JSbkI1nclqUrQRWusgUz83VJB4fhLj6v8n7FyVGXTSUsGq+Ewwv47jcrEPr0gpOwtJ
         4IQQ==
X-Gm-Message-State: AOAM531YcGp0n7tVfaH3dciWwi1QN39CnSNmJnq0zCZX3h4mDXKOkE00
        DV6R/e3q6HRx3X9Hh/z9K3YwKQ==
X-Google-Smtp-Source: ABdhPJwx2PlbH43Qr+B81OY6kvWskKdV/Ban2ix6W7cw/0cV2HmXGusEjLn7mThOr7LFWA4sajYdwA==
X-Received: by 2002:a2e:851a:: with SMTP id j26mr6763722lji.287.1590138644148;
        Fri, 22 May 2020 02:10:44 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:469e:f842:7427:5f3b:8fe0:cf58? ([2a00:1fa0:469e:f842:7427:5f3b:8fe0:cf58])
        by smtp.gmail.com with ESMTPSA id u3sm2297273lfq.59.2020.05.22.02.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 02:10:43 -0700 (PDT)
Subject: Re: [PATCH] usb: bdc: Fix return value of bdc_probe()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
References: <1590135456-11176-1-git-send-email-yangtiezhu@loongson.cn>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <94e58d73-0691-ddbc-3c75-1c7ee87d1216@cogentembedded.com>
Date:   Fri, 22 May 2020 12:10:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1590135456-11176-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 22.05.2020 11:17, Tiezhu Yang wrote:

> When call function devm_platform_ioremap_resource(), we should use IS_ERR()
> to check the return value

    Already done.

> and return PTR_ERR() if failed.

   Yes, else the deferred probing doesn't work.

> Fixes: 893a66d34298 ("usb: bdc: use devm_platform_ioremap_resource() to simplify code")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
[...]

MBR, Sergei
