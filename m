Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD8FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39A8E206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgE2P0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:26:13 -0400
Received: from foss.arm.com ([217.140.110.172]:37978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgE2P0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:26:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 159011045;
        Fri, 29 May 2020 08:26:12 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE0AD3F718;
        Fri, 29 May 2020 08:26:10 -0700 (PDT)
References: <20200526161057.531933155@infradead.org> <20200526161907.778543557@infradead.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, frederic@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net
Subject: Re: [RFC][PATCH 1/7] sched: Fix smp_call_function_single_async() usage for ILB
In-reply-to: <20200526161907.778543557@infradead.org>
Date:   Fri, 29 May 2020 16:26:04 +0100
Message-ID: <jhjr1v2iwz7.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/05/20 17:10, Peter Zijlstra wrote:
> The recent commit: 90b5363acd47 ("sched: Clean up scheduler_ipi()")
> got smp_call_function_single_async() subtly wrong. Even though it will
> return -EBUSY when trying to re-use a csd, that condition is not
> atomic and still requires external serialization.
>
> The change in kick_ilb() got this wrong.
>
> While on first reading kick_ilb() has an atomic test-and-set that
> appears to serialize the use, the matching 'release' is not in the
> right place to actually guarantee this serialization.
>

I got confused the first time I read through that, and had the same
thoughts as Vincent; reading Frederic's reply and the thread
helped. Could we mention the tick softirq vs ilb kick race
thing in the changelog?

Otherwise the change looks okay, I couldn't convince myself there were
more gaps left to fill.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> Rework the nohz_idle_balance() trigger so that the release is in the
> IPI callback and thus guarantees the required serialization for the
> CSD.
>
> Fixes: 90b5363acd47 ("sched: Clean up scheduler_ipi()")
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
