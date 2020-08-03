Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EC7C433E3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6A49204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZA0wsa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgHCMeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729518AbgHCMeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:34:02 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE83BC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 05:34:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y206so7739190pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 05:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uM2vZnd6apiHVlprtfwpHKfrja9VsUva5BQDdDFeOqI=;
        b=GZA0wsa4JHDCBaPz1RKHDehOq/1VUdU66+kj/avxY9pSBZ6SwPyRxoTRf5xwNIZIap
         Ry3e6JKGWp9kAAQF5HcIef+9j0cmFJ06CDwK2r/m0IsFyh7f2ouyt+pN7gdh+y6SH0xo
         Ko0Vr7zZPTLwXo51JIYczfh6Oy22JldW2lce4JGo2BKa10FR6HcoQ8o/r/rFQ5MJI8qV
         NaK+vvZ2Dxdo+fEHfONbFc0jAppOuNd4/7toRnGO17uUxUEtvunzAM8N/NvGAZtfO13/
         kY5EbJIF4hu0u2C9CDsgMd5p4ScqYIdwaplaRue3snb9wtpUtoUiBYljOtaPHQ2smzDQ
         WQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uM2vZnd6apiHVlprtfwpHKfrja9VsUva5BQDdDFeOqI=;
        b=YDc3eciZYB9voWg78JnSmM2l6aO5Ikxwe/w2NRvUjYNMxESJrA2Q6PFBRhEZO1j1Gl
         8BsCjygkSF4Kc1VhbI1wINdvRCyyAo3JrcHRfK9Przw5ufZIBNgO1Agrx6pIkc/hTggu
         60LkDrj6yVq9Akb+JlOoTjbERmHyq3rnVdm2KRTfTNjnNmHT8nYO2tRXAiUTZoiheea9
         T1Eh7vVPQ/auc6UAQnZAaHr0Cp3YdNVnZIvzCjpHiiuBFV36brOZurMk3zi136Iyu1Hv
         hddSd9AYZOd1B5GbbL+89v6cxlPvsXTpY68r3fcaiqLwX6LeQfnpPpXiB42Lud2fm3Et
         2mdQ==
X-Gm-Message-State: AOAM530Uh/3YKDjxumDDS7oEMMOI6RwjEr1cJ3JdnoOgiKtto8egzN3D
        BbQ1qBW74h22CxemAJov+zbfBhyx
X-Google-Smtp-Source: ABdhPJyaViM3LU7p5/mxDQhYnuEqgP2PPPQDiqH/iqONh4OFFNM4c3G1wP1TLHilRKlev3rO9g1xUQ==
X-Received: by 2002:aa7:94b5:: with SMTP id a21mr15523274pfl.237.1596458042235;
        Mon, 03 Aug 2020 05:34:02 -0700 (PDT)
Received: from [0.0.0.0] ([101.32.42.91])
        by smtp.gmail.com with ESMTPSA id r202sm9649046pfc.127.2020.08.03.05.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 05:34:01 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Fix the logic about active_balance in
 load_balance()
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org
References: <20200802045141.130533-1-arch0.zheng@gmail.com>
 <c9afe264-d453-1676-77c9-b29db3481107@arm.com>
From:   Qi Zheng <arch0.zheng@gmail.com>
Message-ID: <9b584a64-b419-e7ea-249e-6fed9db804c0@gmail.com>
Date:   Mon, 3 Aug 2020 20:33:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c9afe264-d453-1676-77c9-b29db3481107@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

I understand, thank you for your review and very detailed explanation.

Yours,
Qi Zheng

On 2020/8/3 下午3:36, Dietmar Eggemann wrote:
> On 02/08/2020 06:51, Qi Zheng wrote:
>> I think the unbalance scenario here should be that we need to
>> do active balance but it is not actually done. So fix it.
>>
>> Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
>> ---
>>   kernel/sched/fair.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 2ba8f230feb9..6d8c53718b67 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9710,7 +9710,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>>   	} else
>>   		sd->nr_balance_failed = 0;
>>   
>> -	if (likely(!active_balance) || voluntary_active_balance(&env)) {
>> +	if (likely(!active_balance) && voluntary_active_balance(&env)) {
>>   		/* We were unbalanced, so reset the balancing interval */
>>   		sd->balance_interval = sd->min_interval;
>>   	} else {
>>
> 
> Active balance is potentially already been done when we reach this code.
> 
> See 'if (need_active_balance(&env))' and 'if (!busiest->active_balance)'
> further up.
> 
> Here we only reset sd->balance_interval in case:
> (A) the last load balance wasn't an active one
> (B) the reason for the active load balance was:
>      (1) asym packing
>      (2) capacity of src_cpu is reduced compared to the one of dst_cpu
>      (3) misfit handling
> 
> (B) is done to not unnecessarily increase of balance interval, see
> commit 46a745d90585 ("sched/fair: Fix unnecessary increase of balance
> interval").
> 
