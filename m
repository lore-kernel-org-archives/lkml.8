Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F83C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BDF521655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgDVL4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:56:19 -0400
Received: from foss.arm.com ([217.140.110.172]:48256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgDVL4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:56:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B3F931B;
        Wed, 22 Apr 2020 04:56:18 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE7D33F6CF;
        Wed, 22 Apr 2020 04:56:16 -0700 (PDT)
References: <20200422112719.826676174@infradead.org> <20200422112831.574539982@infradead.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, qais.yousef@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, daniel.lezcano@linaro.org,
        sudeep.holla@arm.com
Subject: Re: [PATCH 06/23] sched,psci: Convert to sched_set_fifo*()
In-reply-to: <20200422112831.574539982@infradead.org>
Date:   Wed, 22 Apr 2020 12:55:53 +0100
Message-ID: <jhjtv1bloom.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/04/20 12:27, Peter Zijlstra wrote:
> Because SCHED_FIFO is a broken scheduler model (see previous patches)
> take away the priority field, the kernel can't possibly make an
> informed decision.
>
> Effectively changes prio from 99 to 50.
>
> XXX this thing is horrific, it basically open-codes a stop-machine and
> idle.
>

I went and tried to clean up the thing. I didn't find a clean way to use
stop_machine() + play_idle() (stoppers can't sleep), but I did manage to
get something usable with the existing FIFO threads, play_idle_precise()
and the cpuidle state usage stats, so the whole homebrewed idle thing can
go.

I also just tested it with 50 prio and big surprise it didn't change
anything (it ends up being sibling of idle injection). So FWIW:

Acked-by: Valentin Schneider <valentin.schneider@arm.com>

> Cc: daniel.lezcano@linaro.org
> Cc: sudeep.holla@arm.com
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
