Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAC0C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7841620714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uypQw7Qc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgCYJgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:36:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33078 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbgCYJgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:36:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id w25so1660773wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 02:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z9rb6WBN7Zh30OE3Lv3ItlTTqXEFkd0qF4z14T+iEOM=;
        b=uypQw7QcenZxieaz2/hIh0cqlrkUPk8WGVYkD9++x2DAxyDhPLlUEoC2aIvt4ECFoZ
         UhFWvo2CjCrodS/e3wWOBhwT6jkBuH3RqLSj5FvRyOIWYqNoSxb9KvfrPCNRVLk64aWC
         p97chqEJ8GKmaGMMiiETG+TMNPLAAuJ7zw7+L8N7LxuLfZwREmyzUoGfg5x2KKDCsxEm
         3yOCTAOmklQpWQIaclc4Cgp2A1k/MgLeatkI6owp7OnQlHW4SmfJ8SmglBaIfISd84Qh
         /e381DpNRE4bOTVFi0zNTsPrq62jtLcAVAUlZoPXK57m1ftb7YJaAm7ARp1QXIl7jsOc
         rhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z9rb6WBN7Zh30OE3Lv3ItlTTqXEFkd0qF4z14T+iEOM=;
        b=PBPeDe457PSS2yop3YuHRtfYSYmgmcAz8aJhEL3aoQJn+L0iFYoylJb3f2cu1kefsf
         oaRQkTd2+j9LKdKh4lQv4zpFyrkNZ+nUa+hGc595INVgHPNp+oNv7NucjMfVoY6a8Zsu
         K49kF6C6A7DvZDbbk+RVR6oI6SEq0cwYRgry9l6GWSCs+hNj8n6vrJL/SMFr2LvstMQu
         EAlLU55O8u6mRfYwJExyAXoQ3jDw8sETgvHJFumv/BsE0/Z0BU8AFX+uIRAx71qs1DRe
         KW43/sZq9cGCeTKHC0L3cCUJIZk2lHThYhHBC5MvxNj4pBiJPzu2MFrAyzbE6J0t3NQ+
         uaEA==
X-Gm-Message-State: ANhLgQ385ZrF/aK6ORfaGj4FUOh4nckU6SaTCGk689XTdBRX7/g5P7Ps
        KvziwOaya4WlUysTts3eXNebLzYdjuA=
X-Google-Smtp-Source: ADFU+vvP6hCwMlcNUmmGJQPfWYxHvynKPywK+JysUdQWpbL7zcwVWhEWxo+VGHfr4XjxtCV+5qmHtA==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr2498370wma.36.1585128993390;
        Wed, 25 Mar 2020 02:36:33 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id f207sm8722444wme.9.2020.03.25.02.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 02:36:32 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvmem: core: use is_bin_visible for permissions
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200324171600.15606-1-srinivas.kandagatla@linaro.org>
 <20200324171600.15606-4-srinivas.kandagatla@linaro.org>
 <PSXP216MB04380BBC9B7488DEC47ACB6A80F10@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9cb61517-a27f-59e3-d274-1aa0331e7137@linaro.org>
Date:   Wed, 25 Mar 2020 09:36:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <PSXP216MB04380BBC9B7488DEC47ACB6A80F10@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/03/2020 23:05, Nicholas Johnson wrote:
> I was wondering if we can export nvmem_dev_group instead of this
> nvmem_sysfs_get_groups() to fetch it.

Nope, nvmem_sysfs_get_groups() has a dummy stub for not selecting 
CONFIG_NVMEM_SYSFS.

--srini
