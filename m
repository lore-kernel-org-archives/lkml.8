Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FECAC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 16:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7C820657
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 16:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgEPQ42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 12:56:28 -0400
Received: from winnie.ispras.ru ([83.149.199.91]:28364 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbgEPQ41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 12:56:27 -0400
Received: from monopod.intra.ispras.ru (monopod.intra.ispras.ru [10.10.3.121])
        by smtp.ispras.ru (Postfix) with ESMTP id F0B5C203BF;
        Sat, 16 May 2020 19:56:22 +0300 (MSK)
Date:   Sat, 16 May 2020 19:56:22 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Stephane Eranian <eranian@google.com>
cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@elte.hu,
        irogers@google.com, kim.phillips@amd.com, jolsa@redhat.com
Subject: Re: [PATCH 0/3] perf/x86/rapl: Enable RAPL for AMD Fam17h
In-Reply-To: <20200515215733.20647-1-eranian@google.com>
Message-ID: <alpine.LNX.2.20.13.2005161908000.16957@monopod.intra.ispras.ru>
References: <20200515215733.20647-1-eranian@google.com>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020, Stephane Eranian wrote:

> The series first moves the rapl.c file to common perf_events x86 and then
> adds the support.
> From the user's point of view, the interface is identical with
> /sys/devices/power. The energy-pkg event is the only one supported.

AMD also has per-core energy metering via MSR 0xc001029a, and I wonder
if you have plans to expose it to perf as well. I see it does not fit
so nicely with the existing code (as it's per-core instead of per-die).

The turbostat tool already exposes these per-core readings:

Core    CPU     Avg_MHz Busy%   Bzy_MHz TSC_MHz CorWatt PkgWatt
-       -       3951    100.00  3951    2373    54.92   30.04
0       0       3945    100.00  3945    2370    8.97    29.98
1       1       3945    100.00  3945    2370    9.11
2       2       3945    100.00  3945    2370    8.96
4       3       3946    100.00  3946    2370    9.32
5       4       3946    100.00  3946    2370    9.11
6       5       3946    100.00  3946    2370    9.39

turbostat sums the per-core energy figures to show the per-socket 54.92W
value. Though as you can see on this example, the figure is not in agreement
with the per-socket MSR you're using in your patch. Maybe the per-core
values are less reliable, but I believe I have a test that shows per-package
figure to be inaccurate as well. It would be nice if AMD clarified how the
counters work.

And, for what (little) it's worth, the series is:

Tested-by: Alexander Monakov <amonakov@ispras.ru>

Thank you.
Alexander
