Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203E6C11D32
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A2C2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgBXQCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:02:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50487 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgBXQCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:02:02 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6GB3-00070V-1W; Mon, 24 Feb 2020 17:01:49 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A1F5A10408E; Mon, 24 Feb 2020 17:01:48 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     tony.luck@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH] x86/mce/therm_throt: Handle case where throttle_active_work() is called on behalf of an offline CPU
In-Reply-To: <20200224125525.GA29318@zn.tnic>
References: <20200222162432.497201-1-srinivas.pandruvada@linux.intel.com> <20200222175151.GD11284@zn.tnic> <40989625ca5496a986ca3e595957da83723777f4.camel@linux.intel.com> <20200224125525.GA29318@zn.tnic>
Date:   Mon, 24 Feb 2020 17:01:48 +0100
Message-ID: <87y2ssm0sz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> On Sat, Feb 22, 2020 at 04:25:59PM -0800, Srinivas Pandruvada wrote:
>> If the condition is false, will it prevent offline CPU before executing
>> next statement and reschedule on another CPU? Although It will not
>> cause any error or crash but in rare circumstance may print premature
>> warning/normal message based on the current CPU's state.
>
> Why, offline CPU is offline CPU?
>
> Btw, I'm asking whether you can do the simpler thing *instead* of your
> patch. You basically don't run the workqueue callback on offlined CPUs:
>
> 	get_online_cpus();
>
> 	if (cpu_is_offline(smp_processor_id()))
> 		goto out;
>
> 	...
>
>
> out:
> 	put_online_cpus();

Which is wrong as well. Trying to "fix" it in the work queue callback is
papering over the root cause.

Why is any work scheduled on an outgoing CPU after this CPU executed
thermal_throttle_offline()?

When thermal_throttle_offline() is invoked the cpu bound work queues are
still functional and thermal_throttle_offline() cancels outstanding
work.

So no, please fix the root cause not the symptom.

Thanks,

        tglx



