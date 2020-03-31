Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD07C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C156520786
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgCaSeJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:34:09 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:59525 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726170AbgCaSeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:34:09 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20756283-1500050 
        for multiple; Tue, 31 Mar 2020 19:33:51 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1585678285.30493.27.camel@suse.cz>
References: <20200122151617.531-2-ggherdovich@suse.cz> <158029757853.396.10568128383380430250.tip-bot2@tip-bot2> <158556634294.3228.4889951961483021094@build.alporthouse.com> <1585678285.30493.27.camel@suse.cz>
Subject: Re: [tip: sched/core] x86, sched: Add support for frequency invariance
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        x86 <x86@kernel.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        tip-bot2 for Giovanni Gherdovich <tip-bot2@linutronix.de>
Message-ID: <158567963079.5852.13300525696474233020@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Tue, 31 Mar 2020 19:33:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Giovanni Gherdovich (2020-03-31 19:11:25)
> Hello Chris,
> 
> thank you for catching this problem and sorry for the mess.
> 
> Until your message I wasn't aware that CPU0 can be hotplugged, but now that I
> check the feature is been there since v3.8 :/
> 
> The code assumes cpu0 is always there and I need to fix that.
> 
> It seems your report comes from executing an automated test suite, can you
> give me a link to the test sources and a hint on how to run it? I'd like to
> reproduce locally so that I make sure I correctly address this problem.

https://gitlab.freedesktop.org/drm/igt-gpu-tools/

It's an i915 test (so expects i915 running and root access to your
machine, with the intent of breaking your machine), but the cpu
hotplugging could be extracted

https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/perf_pmu.c#L1153

since it's basically doing:
	i = 0
	while :; do
		test -e /sys/devices/system/cpu/cpu$i/online || break

		echo 0 > /sys/devices/system/cpu/cpu$i/online
		sleep .1
		echo 1 > /sys/devices/system/cpu/cpu$i/online

		i = $[[ $i + 1 ]]
	done
	dmesg

Possibly running that under perf stat to keep perf_event_open, or
something else that hooks up the perf cpu hotplug callbacks.

Hope that helps,
-Chris
