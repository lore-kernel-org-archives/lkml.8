Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77483C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 12:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D7D2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 12:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVQMpnYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgBCMIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 07:08:01 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35410 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgBCMIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 07:08:01 -0500
Received: by mail-qt1-f195.google.com with SMTP id n17so10036694qtv.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 04:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=L1c5lgLuw2ECGPDrXg4aSf9b2Bg+sntoPL3y7q3+QiE=;
        b=sVQMpnYU0XjkIXuXQBSc1YysHsPZzRcW2ftSEBSS2QNq33O7fadqaPewYRPjgSqmYw
         JW8RJg27uIVBILGRXzo/V5yW3crq4mplohNFUeBR9HGHmJBXRm7PHACZrlSKEbfOE6SB
         f9fiEhB+ylxM6b2OI6foIKQKfsmYKI3jfXQyUf/pgJjRbEaMiF9WBFErOHXFo7ysxuVH
         z943qXogIMZnJYJ/kIiwMb+dEXrthDny8TnOy2s0JjPeBtWigMRAX0Qv6uv2Vnr1ZaPo
         LtBZWi7a/EMjgEuDOyS1N6ICYSypKrNfNMpBvCa79ikyqDo5GGDyfwQ6diBGTFsHWhTZ
         jjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=L1c5lgLuw2ECGPDrXg4aSf9b2Bg+sntoPL3y7q3+QiE=;
        b=S4O15/7/oGeKVpvV1fM/HmYq07wzhJvyishhmsUwU1dcHzgjLJbM5SNpLZasEjwse2
         nnaVyKuGyzVElKYny6VVm83Nl81TtqHKkabDyCqmGxCk1WSun3hYdaLWoplN9nEclN+n
         goWBx5kjf+iVmxYlAw7Hc2WXwJL5APH8hJBUrpvyr8o8ewftYSpX/aIYEsJzWtJxLOLg
         eBmSuU2aZ4dc0qVGsYdpqSPJXezLeFWphOoy2xohgALisUN7U2DCU8LQ+YdLIuhyypR3
         AdirL0ui4U33p8x0p2bGifpoWkQMQIFsPU3sOmj5CARB7o1TJhT4AcO6syAXH8e9io2Y
         +zuA==
X-Gm-Message-State: APjAAAXUTDwF+XyWwMGaFXv0UI+TBKLz6uhwUC8UxD6UeWXuBa0qWB2D
        Q6J9N59R/m1tNxY2PsMllTjpKQ==
X-Google-Smtp-Source: APXvYqxYIXxQRoZSysJQ80/1mXlNFamqZsrZgLUWv4O5zXdER2TYVQrwnByZR4NL1wd7wJX1Hu7rgA==
X-Received: by 2002:ac8:4092:: with SMTP id p18mr23133342qtl.19.1580731679969;
        Mon, 03 Feb 2020 04:07:59 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id m21sm9043990qka.117.2020.02.03.04.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 04:07:59 -0800 (PST)
Subject: Re: [Patch v9 7/8] sched/fair: Enable tuning of decay period
To:     Randy Dunlap <rdunlap@infradead.org>, mingo@redhat.com,
        peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
 <1580250967-4386-8-git-send-email-thara.gopinath@linaro.org>
 <4eb10687-1a62-cee3-7285-3f50cc023071@infradead.org>
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5E380D1D.7020500@linaro.org>
Date:   Mon, 3 Feb 2020 07:07:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <4eb10687-1a62-cee3-7285-3f50cc023071@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/28/2020 06:56 PM, Randy Dunlap wrote:
> Hi,
> 
> On 1/28/20 2:36 PM, Thara Gopinath wrote:
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index e35b28e..be4147b 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -4376,6 +4376,11 @@
>>  			incurs a small amount of overhead in the scheduler
>>  			but is useful for debugging and performance tuning.
>>  
>> +	sched_thermal_decay_shift=
>> +			[KNL, SMP] Set decay shift for thermal pressure signal.
>> +			Format: integer between 0 and 10
>> +			Default is 0.
>> +
> 
> That tells an admin [or any reader] almost nothing about this kernel parameter
> or what it does.  And nothing about what unit the value is in.
> Does the value 0 disable this feature?

Thanks for the review. 0 does not disable "thermal pressure" feature. 0
means the default decay period for averaging PELT signals (which is
usually 32 but configurable) will also be applied for thermal pressure
signal. A shift will shift the default decay period.

You are right. It needs more explanation here. I will fix it and send v10.

> 
>>  	skew_tick=	[KNL] Offset the periodic timer tick per cpu to mitigate
>>  			xtime_lock contention on larger systems, and/or RCU lock
>>  			contention on all systems with CONFIG_MAXSMP set.
> 
> 
> thanks.
> 


-- 
Warm Regards
Thara
