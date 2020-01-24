Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6297C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68292075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PwFi6D0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391825AbgAXTHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:07:10 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43707 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387973AbgAXTHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 14:07:10 -0500
Received: by mail-qk1-f194.google.com with SMTP id j20so3098206qka.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 11:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=U8mFFao/dTdehuT9CIZw7gKLbyB2Qe+0qd2+PVIWGKA=;
        b=PwFi6D0XFgccT4RaFx73Pvx/g9iFb10hhGxp0SrZRTBaI9g0AyL0LTfW2ZbBTMTQTA
         r8TVe94w/Xd1PGw+TXC14YG8JT+LHK8gIrII0iC6jBx4IcAm24ZMhGZgB4ZeQ8DFogBO
         MnaVg//3kABgGRvXLO09Iy8H7jwU2BQEMnZBJSfXfmACVBzACdSC9hgeZNnNn+AEL3gW
         kYtK0g9dsrd+hNGw/2W/HyE7QtR8rh/dG0sHiGsYsefX860cBS6GCARb5QExKWxqHXZX
         Sc1/gA2GH6cPDHbXktkQ90TQ7aZSgu+EiQKdOrXrpHr9xS7SpjDy2rwFkglkXqSLj6n5
         PBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=U8mFFao/dTdehuT9CIZw7gKLbyB2Qe+0qd2+PVIWGKA=;
        b=U42ZHGfZhMEAJYbmKIzF6DDD85hUIxfkR2ciF4tPztAV0tbWx1EoVxkChFTp/hiaY3
         5MI4DDnCul2sCAtfQVoD4rRPnpgy8LoewoL+rV4edrUBUHbZtUry5jdChMqtSqd7lrAG
         aZ5VG3z1GWKSxnNai7a7VAQVFAClQ9AmDnB8zFcff6tIGQxZqWGehyToTVGN/IriDWYj
         mAnkVO0r47UGFFsvuNhMEvZxIRygpoJITBduy5weoNbow8EKrK1UBTcGBW0yKEK7m0tR
         5kdTBe5dJ6s0Ox8dFntSGjVo3mwJXabwCRb2Fk55t1juXIG83okTI/D5JO12QMCA6+Jr
         X7EQ==
X-Gm-Message-State: APjAAAXcengc+wcf8hswgpNeZ5Or+KZZ1wIOmcJTfsIMfiLSXGLJfJ5o
        GJXw4/X343XIBr5I3VypWr9GCw==
X-Google-Smtp-Source: APXvYqw1BIlzx/p1Xrpy9Bp49ZDvW0vNGIBmmsOJhy+3llDPGF2MQPZD+z+VNHd6wzpRtrnK7+w97Q==
X-Received: by 2002:ae9:f709:: with SMTP id s9mr4146860qkg.463.1579892829399;
        Fri, 24 Jan 2020 11:07:09 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id b35sm3948636qtc.9.2020.01.24.11.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2020 11:07:08 -0800 (PST)
Subject: Re: [Patch v8 1/7] sched/pelt: Add support to track thermal pressure
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
 <1579031859-18692-2-git-send-email-thara.gopinath@linaro.org>
 <20200116151724.GR2827@hirez.programming.kicks-ass.net>
 <e5ecad29-11d8-e7ff-27ff-b63ca44fdcd3@arm.com>
Cc:     mingo@redhat.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        amit.kucheria@verdurent.com
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5E2B405A.7040405@linaro.org>
Date:   Fri, 24 Jan 2020 14:07:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <e5ecad29-11d8-e7ff-27ff-b63ca44fdcd3@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/23/2020 02:15 PM, Dietmar Eggemann wrote:
> On 16/01/2020 16:17, Peter Zijlstra wrote:
>> On Tue, Jan 14, 2020 at 02:57:33PM -0500, Thara Gopinath wrote:
>>
>>> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
>>> index afff644..bf1e17b 100644
>>> --- a/kernel/sched/pelt.h
>>> +++ b/kernel/sched/pelt.h
>>> @@ -7,6 +7,16 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
>>>  int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
>>>  int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
>>>  
>>> +#ifdef CONFIG_HAVE_SCHED_THERMAL_PRESSURE
> 
> I assume your plan is to enable this for Arm and Arm64? Otherwise the
> code in 3/7 should also be guarded by this.

Yes. I think it should be enabled for arm and arm64. I can submit a
patch after this series is accepted to enable it.
Nevertheless , I don't understand why is patch 3/7 tied with this.
This portion is the averaging of thermal pressure. Patch 3/7 is to store
and retrieve the instantaneous value.
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e688dfad0b72..9eb414b2c8b9 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -164,6 +164,7 @@ config ARM64
>         select HAVE_FUNCTION_ARG_ACCESS_API
>         select HAVE_RCU_TABLE_FREE
>         select HAVE_RSEQ
> +       select HAVE_SCHED_THERMAL_PRESSURE
>         select HAVE_STACKPROTECTOR
>         select HAVE_SYSCALL_TRACEPOINTS
> 
> Currently it lives in the 'CPU/Task time and stats accounting' of
> .config which doesn't feel right to me.

It is cpu statistics if you think about it. It is also the same .config
where CONFIG_HAVE_SCHED_AVG_IRQ is defined.
> 
> [...]
> 


-- 
Warm Regards
Thara
