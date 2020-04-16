Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14A4C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0E5B20732
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHqKNAsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392605AbgDPOAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895979AbgDPNkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:40:16 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AAFC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 06:40:16 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id q17so16064189qtp.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vQ85kk+e5kLMqfj1rRbLwyKAs7ixIlJ9Ovt4gHCLOZM=;
        b=iHqKNAsxPEqnI8xcUZ6uXkxSDGBlBbB8WKdi9dw84yatIflHS8NXbm2DOgxhTdyIIK
         9qwus4vbY5T8VjMDtwKpZp4ihk5NUwBLghA4F2peLYCHTj+MJN3MozHoK+D7oDg43oKd
         4sjL1CO7osXGVqm3iaJySUqaMQwaksZH3MBT7l0BJ17e7wrnaTdIgRdmydnLSZpq1Y7Z
         0+tk/Zy72nYSTJxBYOMDOiD6xxy0D6dI6nVfkSREmLKEhGmn5y53CM8K2aC5h2EBXudS
         z5mRX1RQSo68nJ+o1yQ5Brin1GzY1UmOm9PcTcUvTjgU7IY8f6UVm2IlRWlCHsVEHg2S
         O4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vQ85kk+e5kLMqfj1rRbLwyKAs7ixIlJ9Ovt4gHCLOZM=;
        b=hHCila0nY01bkMhNKeUXeBg7svtz1LveDu15vd1RBBBdI2xqahBjVsCGQWN4P5Z1Qm
         GVuVd/7R99E2PU9+H3CRHZZdAOTCLhmRm/V8lv1RES98eN58L+2NOtlsmlINBpWMR/iW
         ISOSALDl5/FCvsdEVlkq0rAREHNfblqdOmUj3BkKeafkbu6mlZoPK3l8a25WLvgG09vP
         gRUAO0vZc+/N+qlmyItL5LNOLGn15gPfQqgPBA8/VKsVGaEu+wzdt35EfEY1NpeGVrHp
         yOM7719VBdlz3cUIfGvl0C5Nx0ydnmAUjq3T4kUqnNIxpkrEdGuP3EOxwIDQ4Ha6d1VZ
         UVBQ==
X-Gm-Message-State: AGi0PuaCcUAeDGmvYQIvkDgQsC+tX175EAE31WXvEZUB7FQ9m8K4ai/c
        tuKOxioCYeqwT9Y8nh2UAQsfNw==
X-Google-Smtp-Source: APiQypKLs9TewfDa6pgGm0Dcy3RXiiLr4P9Ch5H5VYYpmX81kKNvHNKJWoPar0UvooyVFERzu0hzDg==
X-Received: by 2002:ac8:39e5:: with SMTP id v92mr26385594qte.224.1587044415233;
        Thu, 16 Apr 2020 06:40:15 -0700 (PDT)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id a62sm14859102qkb.134.2020.04.16.06.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 06:40:14 -0700 (PDT)
Subject: Re: [Patch v10 0/9] Introduce Thermal Pressure
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
References: <20200222005213.3873-1-thara.gopinath@linaro.org>
 <CAP=VYLqWfqOZT6ec9cKyKOsOhu7HhVn2f_eU+ca006i4CV8R-w@mail.gmail.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <51cdde9e-f124-8e19-693c-4accc6f2e948@linaro.org>
Date:   Thu, 16 Apr 2020 09:40:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAP=VYLqWfqOZT6ec9cKyKOsOhu7HhVn2f_eU+ca006i4CV8R-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/20 11:57 AM, Paul Gortmaker wrote:
> On Fri, Feb 21, 2020 at 7:52 PM Thara Gopinath <thara.gopinath@linaro.org>
> wrote:
> 
>> Thermal governors can respond to an overheat event of a cpu by
>> capping the cpu's maximum possible frequency. This in turn
>> means that the maximum available compute capacity of the
>> cpu is restricted. But today in the kernel, task scheduler is
>> not notified of capping of maximum frequency of a cpu.
>> In other words, scheduler is unaware of maximum capacity
>> restrictions placed on a cpu due to thermal activity.
>> This patch series attempts to address this issue.
>>
> 
> I'm just seeing this now via -rc1 and "make oldconfig".
> 
> I'd suggest taking some of the above info and using it to
> create a Kconfig help text for the new option that was added.
Hi Paul,

I will send a patch adding some details to the Kconfig text.

-- 
Warm Regards
Thara
