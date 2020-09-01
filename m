Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35824C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 23:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12B4C206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 23:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKAmennB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIAXEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 19:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgIAXET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 19:04:19 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995DAC061244;
        Tue,  1 Sep 2020 16:04:19 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z15so1318556plo.7;
        Tue, 01 Sep 2020 16:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0fSZJUxiqJof83RkUahqF8Xv7vH8SKKWXcceMWzjGHM=;
        b=CKAmennBR0rRU7kotj7sTJdSJC7DsKDJKXVbgPY/QktvjKbLxJH5uwvwW6CKCMLP5q
         Fyoo/Qb80A5cQoMcdbqKn2/KlNuSvCclPUEvcqRamLZ18nSoYVhCAgLOE3uKkDk78PfM
         575x0f8XdtyhpXuj7Di2rTE0zlvPKBqrljvU/xQc3KDQrjdluGV8QVlg0y03U5pCtL64
         ExjZjA0FM6VXF22wLSX0K1IqeG/Z5gylKfoZqXuZpyNkWGX8Ozcp5HX+Q+roJVkfoxef
         3fRtu15pso3vvj16tHIoeWZ+TLr5FK/IDnXGmG0LYRsY0L0F3l+62WKVsnco+Gk1PS9u
         pnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0fSZJUxiqJof83RkUahqF8Xv7vH8SKKWXcceMWzjGHM=;
        b=r1324pYo5kRTCJZElGkLfPboruRP8RKfVoduC1P6/DCrTOUPMurvB4DyF1LfyXq7BU
         TdgMKNfBi2aF5UUZc39wT6GeHsIaqpK4K1S/2LsOEMER/z3sgi2BCJBwUsXI+hTYpEB7
         suM8vL/sz+KnH7JuyeXFOftIpxUGdHk4KuU1eSvDE4hpfmPjfvNgBFDtNcCdBvR/Q5sb
         CTC6ghw2PRJXRIcO7tFYWsv89jYTJXiOJZg+rPTd+ge3ulAybt5ZV/qncT0vZbIqY4W8
         qxTpkCVgux7rBNilPg+UuBY39zVz0HzFpFgoVsWO8613ApB47WkMrVW5lJ9z309Uuh1E
         44YA==
X-Gm-Message-State: AOAM532Nv5tV9ta37H+sPsuBd9qvCI+jH/DXQnEi8znzC5z3Xyx+zQFU
        /LJe+2E5ms8hj2sBtW2nQA4=
X-Google-Smtp-Source: ABdhPJydWYEkD7wS07elWV4L+tBP+R0/2Ehs0rnPIjLnLCg8M7rO+gQNbJguN+UwAimlQdgXBsomHg==
X-Received: by 2002:a17:902:aa4c:: with SMTP id c12mr3368983plr.183.1599001458882;
        Tue, 01 Sep 2020 16:04:18 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id k20sm3314851pfu.197.2020.09.01.16.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 16:04:17 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] ARM: dts: NSP: Fix SP804 compatible node
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20200828142018.43298-1-andre.przywara@arm.com>
 <20200828142018.43298-4-andre.przywara@arm.com>
 <73b35bcd-0e8c-0f62-ed2b-e0c64261f930@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c97c1472-c308-27e2-ce68-30bc82b96aae@gmail.com>
Date:   Tue, 1 Sep 2020 16:04:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <73b35bcd-0e8c-0f62-ed2b-e0c64261f930@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/2020 10:12 AM, Florian Fainelli wrote:
> On 8/28/20 7:20 AM, Andre Przywara wrote:
>> The DT binding for SP804 requires to have an "arm,primecell" compatible
>> string.
>> Add this string so that the Linux primecell bus driver picks the device
>> up and activates the clock.
>>
>> Fixes: a0efb0d28b77 ("ARM: dts: NSP: Add SP804 Support to DT")
>> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> This looks fine, however there is a ccbtimer1 instance that you missed,
> can you resubmit with it included?
> 
> With that:
> 
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Andre are you going to resubmit a patch with the second instance 
(ccbtimer1) fixed as well, or should I take care of that while applying 
the patch? Either way is fine, just let me know.
-- 
Florian
