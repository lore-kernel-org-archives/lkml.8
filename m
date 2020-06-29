Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F94C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED05820702
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UZ6FVKc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbgF2TXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732123AbgF2TWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:22:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42945C030F34
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:54:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g75so16034291wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=X9rfAlOxfe38VMX/oL2KWbXJmMAccAeFpKeQ6kbgS5I=;
        b=UZ6FVKc7frhOr+27BqHpUSAAlW/b6bGMLjuQl7IYNjpAn9UP9nwBkgtlMucNWw5P0M
         YTRq3+LIylKWY1EpNL4FD5Vuwel8piO0VIk6nUxpzG9Ls450pSl99qLEi2KfmUEV4fC3
         Q0HMPnnWRd7jZFkfC02SLQXuTxIeg1aAPTOqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=X9rfAlOxfe38VMX/oL2KWbXJmMAccAeFpKeQ6kbgS5I=;
        b=abdsggMxO0YZ8Pqga8Cb1+KTT2Ntz3U65lWasbm9CChwOUkSbykc1NEguRsF1Em7th
         iV/0SE8rM2jzzUBZDW5+oYpterjSbdWUJsbnHMNCu5cBzlMgrznlcpplYpZk0T+Z1o+s
         N+JaJXUlh8bKAxbeDlv2qz0Q9ARA5IVT96DzHvb5FMRif1h3wa7ljNprEGUzj4z/P+qK
         uA7mKnrzSAQbUwrDSdJZmEUUP95ioz3Qtb+foVMkf6YqQ+5aOLcaYh7C4PV9iPwL55QD
         kuQ4SdSfubT6eKK8OqE9UY7eEnUgafMHdywBf1WIEDX6LV3ZyjiqJw9AO6J2bAPHKoTy
         Xttw==
X-Gm-Message-State: AOAM530Js/HR98D7qhJvPAIMj6sqM/ZHQ6fS20h3vWk+rj2pdfITbwca
        ErB0zlHw7g9YCEe2srOSkex/4g==
X-Google-Smtp-Source: ABdhPJzEBOnJbI3F9fbCTkykHuYski3xJ+b+DkSQKsgVaDyTwA3/2FplB6F5M/HjmK7MhPF+FIuGjw==
X-Received: by 2002:a05:600c:c1:: with SMTP id u1mr17895281wmm.48.1593449664783;
        Mon, 29 Jun 2020 09:54:24 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e8sm396022wrp.26.2020.06.29.09.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 09:54:24 -0700 (PDT)
Subject: Re: [PATCH 1/4] pwm: bcm-iproc: Remove impossible comparison when
 validating duty cycle
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20200629124752.1018358-1-lee.jones@linaro.org>
 <20200629124752.1018358-2-lee.jones@linaro.org>
 <3470e941-aa86-11a8-674b-5258a08fedb1@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <76a657ca-d30e-c5f2-f057-1c1bb7c8e1bf@broadcom.com>
Date:   Mon, 29 Jun 2020 09:54:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3470e941-aa86-11a8-674b-5258a08fedb1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-06-29 9:45 a.m., Florian Fainelli wrote:
>
> On 6/29/2020 5:47 AM, Lee Jones wrote:
>> 'duty' here is an unsigned int, thus checking for <0 will always
>> evaluate to false.
>>
>> Fixes the following W=1 warning:
>>
>>   drivers/pwm/pwm-bcm-iproc.c:147:12: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
>>
>> Cc: Ray Jui <rjui@broadcom.com>
>> Cc: Scott Branden <sbranden@broadcom.com>
>> Cc: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
>> Cc: bcm-kernel-feedback-list@broadcom.com
>> Cc: linux-pwm@vger.kernel.org
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> And IPROC_PWM_DUTY_CYCLE_MIN is unused after remove this single use of
> the define, if you also remove it you can add:
>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
We actually made this same change internally recently but hadn't 
upstreamed it yet.

Tested-by: Scott Branden <scott.branden@broadcom.com>

