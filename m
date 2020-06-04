Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F9DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0505C206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgFDV3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 17:29:25 -0400
Received: from winnie.ispras.ru ([83.149.199.91]:32068 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726326AbgFDV3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 17:29:25 -0400
Received: from monopod.intra.ispras.ru (monopod.intra.ispras.ru [10.10.3.121])
        by smtp.ispras.ru (Postfix) with ESMTP id 4A88A203BF;
        Fri,  5 Jun 2020 00:29:23 +0300 (MSK)
Date:   Fri, 5 Jun 2020 00:29:23 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     linux-kernel@vger.kernel.org
cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: schedutil issue with serial workloads
Message-ID: <alpine.LNX.2.20.13.2006042341160.3984@monopod.intra.ispras.ru>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is a question/bugreport about behavior of schedutil on serial workloads
such as rsync, or './configure', or 'make install'. These workloads are
such that there's no single task that takes a substantial portion of CPU
time, but at any moment there's at least one runnable task, and overall
the workload is compute-bound. To run the workload efficiently, cpufreq
governor should select a high frequency.

Assume the system is idle except for the workload in question.

Sadly, schedutil will select the lowest frequency, unless the workload is
confined to one core with taskset (in which case it will select the
highest frequency, correctly though somewhat paradoxically).

This sounds like it should be a known problem, but I couldn't find any
mention of it in the documentation.

I was able to replicate the effect with a pair of 'ping-pong' programs
that get a token, burn some cycles to simulate work, and pass the token.
Thus, each program has 50% CPU utilization. To repeat my test:

gcc -O2 pingpong.c -o pingpong
mkfifo ping
mkfifo pong
taskset -c 0 ./pingpong 1000000 < ping > pong &
taskset -c 1 ./pingpong 1000000 < pong > ping &
echo > ping

#include <stdio.h>
#include <unistd.h>
int main(int argc, char *argv[])
{
	unsigned i, n;
	sscanf(argv[1], "%u", &n);
	for (;;) {
		char c;
		read(0, &c, 1);
		for (i = n; i; i--)
			asm("" :: "r"(i));
		write(1, &c, 1);
	}
}

Alexander
