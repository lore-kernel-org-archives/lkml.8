Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20011C33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E586921744
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="lxFLu5Y0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387606AbgAMGaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 01:30:24 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46939 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732311AbgAMGaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 01:30:24 -0500
Received: by mail-qk1-f195.google.com with SMTP id r14so7515474qke.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 22:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Crc/Gho+4uCi7wS6J8p28l1PRbnoeVXJW703VJimiYA=;
        b=lxFLu5Y0sFNfuaPax9SoEB+cVNZYrPFBCCxTtSL/v3SVTJrSrHdnW8XLPIdMgVL1YO
         HLeAxZmo+ukZsu3YjK1F7M4lA2H9GG9A1Iw6HlqEm5sWwR8ORB5Dw19F9mB9vjZRvUhQ
         yIPK7dcDtcYhcw7Ux3HB0kCxug11cHt6bno32gI1MbpTqfs43u80KC7Ljfzn+12d3tK/
         w46JTqAUYG5S6yubsVHmRQxengUAMjljhAsdpKh7/Jl+c+hGvI27546RshP4qaW3xVvN
         zM27AmqjMaX14fDjrD3SEbKMvYC55xTemj5U4Aj5/67mJp6gJMfOLHB+gCVZ0qnUCVSM
         7/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Crc/Gho+4uCi7wS6J8p28l1PRbnoeVXJW703VJimiYA=;
        b=i2hXSDnk1Svq4r4sUIU650LEChv1n8ht2e75Vh819U05ln6BZKcfqu1p9z9xN6VwUy
         I77HdM8x44QFNaViI9HeU37j/YSnEBVIuBwTfSU4mAqd1+y04n2nzX9aKSZiC+97WTp8
         8x72HStrodQTcGM1lFrK0JWhn5baNlGEr/GYyo/DlQCDOUD5ttndZL/bYx4JO3d8WWXj
         uCPxBhBmjBTpFwpcZLrAcsYNlmr7YCqxS9XDywc83680v0bBSCdahtSTGjmVyvEOGq+I
         ttEcrOGVmt2Dh6eb+YlDKvVnKstqFs19SaXUVw3H7sLHC9ioHz0NHj7q32kAbHQh7VR5
         Bh0A==
X-Gm-Message-State: APjAAAVljUjHJLBVmwChEnfpeYS3MYZuhz801mEYR/r9oekq/3qGfHAI
        utX/iuhOjBXwAONlvpN1Z9ViTA==
X-Google-Smtp-Source: APXvYqyOHf6wcEymYgGcAuQWL4pDaR4hhmOCgJyrxLpBH1bkdCEIF0a44U/ikpGRPLNFItwMpiFE8g==
X-Received: by 2002:a37:bc04:: with SMTP id m4mr10338771qkf.224.1578897023382;
        Sun, 12 Jan 2020 22:30:23 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 11sm4561748qko.76.2020.01.12.22.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jan 2020 22:30:22 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] sched/core: fix illegal RCU from offline CPUs
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <3ffaaf32-88b6-fdf1-c7c7-ab56292c047f@I-love.SAKURA.ne.jp>
Date:   Mon, 13 Jan 2020 01:30:21 -0500
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        bsegall@google.com, mgorman@suse.de, paulmck@kernel.org,
        tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7168A4A4-E735-4809-B80A-389990603EB8@lca.pw>
References: <20200112161752.10492-1-cai@lca.pw>
 <3ffaaf32-88b6-fdf1-c7c7-ab56292c047f@I-love.SAKURA.ne.jp>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 12, 2020, at 7:33 PM, Tetsuo Handa =
<penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>=20
> On 2020/01/13 1:17, Qian Cai wrote:
>> In the CPU-offline process, it calls mmdrop() after idle entry and =
the
>> subsequent call to cpuhp_report_idle_dead(). Once execution passes =
the
>> call to rcu_report_dead(), RCU is ignoring the CPU, which results in
>> lockdep complaints when mmdrop() uses RCU from either memcg or
>> debugobjects. Fix it by scheduling mmdrop() on another online CPU.
>>=20
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 90e4b00ace89..41fb49f3dfce 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -6194,7 +6194,8 @@ void idle_task_exit(void)
>> 		current->active_mm =3D &init_mm;
>> 		finish_arch_post_lock_switch();
>> 	}
>> -	mmdrop(mm);
>> +	smp_call_function_single(cpumask_first(cpu_online_mask),
>> +				(void (*)(void *))mmdrop, mm, 0);
>=20
> mmdrop() might sleep, but

If that is the case, and then the commit e78a7614f387 (=E2=80=9Cidle: =
Prevent
late-arriving interrupts from disrupting offline=E2=80=9D) is incorrect =
because it
will disable local irq before calling mmdrop() which will trigger
the might_sleep() warning. Can you prove it?

>=20
> /*
> * smp_call_function_single - Run a function on a specific CPU
> * @func: The function to run. This must be fast and non-blocking.
> * @info: An arbitrary pointer to pass to the function.
> * @wait: If true, wait until function has completed on other CPUs.
> *
> * Returns 0 on success, else a negative status code.
> */
>=20
> . Maybe mmdrop_async() instead?

