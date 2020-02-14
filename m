Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACB7C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBC3222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n/3pcw0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgBNOwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:52:49 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:39017 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgBNOwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 09:52:49 -0500
Received: by mail-qt1-f171.google.com with SMTP id c5so7098653qtj.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 06:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=tnlmESUS7e/lt3iu4vQwY6s70Wopj6FQsQf7vvV54+c=;
        b=n/3pcw0bqVyvCWa1kqvFzqQ9YXmEGFKN0YRR2neUWdPPC8IvXRfn9NSRbfe06eEV1X
         0bnKEk7wXfJPqsWe0gmvjoP7VRz9YighOU9Ql4ywCQJjd0ml6yaScSEopSJT3ze+gSLs
         yDfwsv3gqtKjGMLAoL9kIvR2mxg6zZnwhHLHJoMJFr+qPjR54dLMNNKA7IkVKMRE4cWR
         lxGRhhpBlYTSrO3SOzzb2yX736inibrzy/zDcnFQ4DGD5FDeq3cLv55TvzpDwLadVh5u
         IExqgmSzl/PWn1LXtRl1HE4tvmn2zrgkEIAn8G1rMTsqtaiJeabtt2qntICiDSQTN6qr
         A1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=tnlmESUS7e/lt3iu4vQwY6s70Wopj6FQsQf7vvV54+c=;
        b=fI0RW9ecWiOjz/PW4sXNni5ULJtNfM/e0Z1wayi2itnxedws6ICYY2iT15ycIF8Xvk
         LmxNsBZvJi3edeiIW92OSYMeQFUXP6OupwysHDesX+1DMmC/J7vAD8ZFTfb45J/r8ZfI
         FZFu5oum0DJGfNPWjWt1N9zfz7bfE8xMEYLlqDq655nZOwvCN8RFYVJOCQvN3QMFDyhD
         GF1Br0yR19zgQTzkyZj0Rxl8g0hr3+PA6cn1YGk7BwcKe/PQzCN/iW97L94xl8QFnRlo
         RDDXAeD0AKK/AiP1+kwZk1zEmw+zPVHqkytby5/QH9mAYQ4nRNgk+5FQJQ6DjUPV1onT
         e5Ww==
X-Gm-Message-State: APjAAAX1ibrukTB+0n6J5a5wsPg22vz01tlfb7mdA/DjOltRHoe8LFz7
        3ouwNtpwR1A7CC1eT3mhv9X5eg==
X-Google-Smtp-Source: APXvYqyX3lvXGcbNAkCUWSCrSDFdTwhcMS3Pye9DYKdycBuRbIPpStZPL88KOwbV4CodjoU/0Fa8WQ==
X-Received: by 2002:ac8:2a55:: with SMTP id l21mr2859273qtl.111.1581691968190;
        Fri, 14 Feb 2020 06:52:48 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id k58sm3516212qtb.60.2020.02.14.06.52.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 06:52:47 -0800 (PST)
Subject: Re: [Patch v9 5/8] sched/fair: update cpu_capacity to reflect thermal
 pressure
To:     Amit Kucheria <amit.kucheria@linaro.org>
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
 <1580250967-4386-6-git-send-email-thara.gopinath@linaro.org>
 <CAHLCerNH+8TLoez1K=JHhd63z_kGv6cupPiyvugiE4YbQuuxpQ@mail.gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, ionela.voinescu@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Zhang Rui <rui.zhang@intel.com>, qperret@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, corbet@lwn.net,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5E46B43E.1000304@linaro.org>
Date:   Fri, 14 Feb 2020 09:52:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAHLCerNH+8TLoez1K=JHhd63z_kGv6cupPiyvugiE4YbQuuxpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/2020 08:39 AM, Amit Kucheria wrote:
> On Wed, Jan 29, 2020 at 4:06 AM Thara Gopinath
> <thara.gopinath@linaro.org> wrote:
>>
>> cpu_capacity initially reflects the maximum possible capacity of a cpu.
>> Thermal pressure on a cpu means this maximum possible capacity is
>> unavailable due to thermal events. This patch subtracts the average thermal
>> pressure for a cpu from its maximum possible capacity so that cpu_capacity
>> reflects the actual maximum currently available capacity.
> 
> "actual maximum currently available capacity" is quite a mouthful. :-)
> 
> "Remaining capacity" or "Effective capacity" anyone?

"Remaining maximum capacity"?

> 
> IIUC, this remaining capacity is NOT the same as the capped/decreased
> capacity referred to in patches 1 and 3. The delta capacity (aka
> thermal pressure) there refers to the difference between HW max
> capacity and thermally throttled capacity.
> Here, we also subtract RT/DL utilisation. Is that accurate?

Yes, here we do subtract RT/DL utilization as well. But from the thermal
pressure point of view, it is immaterial. I am not touching the code
that subtracts RT/DL utilization , I am just adding thermal pressure to
the variables that has to be deducted from the stated max capacity to
reflect the actual capacity. So as far as this patch series is
concerned, capped/decreased capacity is the same across all
patches.(Though there is the instantaneous capped capacity and the
time-averaged capped capacity)


-- 
Warm Regards
Thara
