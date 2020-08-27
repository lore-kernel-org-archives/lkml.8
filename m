Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC3FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B411207DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgH0TYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:24:13 -0400
Received: from foss.arm.com ([217.140.110.172]:33610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgH0TYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:24:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A70EC31B;
        Thu, 27 Aug 2020 12:24:10 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 558AD3F68F;
        Thu, 27 Aug 2020 12:24:09 -0700 (PDT)
References: <1598542538-46278-1-git-send-email-vincent.donnefort@arm.com> <202008280326.O6kOHfWU%lkp@intel.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        qais.yousef@arm.com, Vincent Donnefort <vincent.donnefort@arm.com>
Subject: Re: [PATCH] sched/debug: Add new tracepoint to track cpu_capacity
Message-ID: <jhjsgc7optp.mognet@arm.com>
In-reply-to: <202008280326.O6kOHfWU%lkp@intel.com>
Date:   Thu, 27 Aug 2020 20:24:03 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/08/20 20:08, kernel test robot wrote:
> All errors (new ones prefixed by >>):
>
>>> kernel/sched/fair.c:11314:18: error: no member named 'cpu_capacity' in 'struct rq'
>            return rq ? rq->cpu_capacity : -1;
>                        ~~  ^
>    1 error generated.
>

The joys of !SMP; you'll want to wrap this in an #ifdef CONFIG_SMP like
some of the other TP's. The !SMP case can probably return
SCHED_CAPACITY_SCALE for the sake of pedantism, AFAICT that TP can't fire
on !SMP (that, or only define it for SMP).
