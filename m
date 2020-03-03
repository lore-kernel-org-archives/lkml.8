Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1873DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE8820728
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgCCKjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:39:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:54280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728341AbgCCKjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:39:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B9C22AD9A;
        Tue,  3 Mar 2020 10:39:44 +0000 (UTC)
Date:   Tue, 3 Mar 2020 10:39:41 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        rostedt@goodmis.org, bsegall@google.com,
        lkft-triage@lists.linaro.org, anshuman.khandual@arm.com
Subject: Re: kernel/sched/fair.c:1524:20: warning: ???test_idle_cores???
 declared ???static??? but never defined
Message-ID: <20200303103941.GD3772@suse.de>
References: <CA+G9fYtE-=odd9OLrGim-D1hqgrMaoxqpGSvXCNLfAicdxS8jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CA+G9fYtE-=odd9OLrGim-D1hqgrMaoxqpGSvXCNLfAicdxS8jA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 02:42:38PM +0530, Naresh Kamboju wrote:
> Linux next-20200303 arm64 build warnings
> Please refer below links for more information.
> 
> make -sk KBUILD_BUILD_USER=TuxBuild -C/linux -j16 ARCH=arm64
> CROSS_COMPILE=aarch64-linux-gnu- HOSTCC=gcc CC="sccache
> aarch64-linux-gnu-gcc" O=build Image
> 
> ../kernel/sched/fair.c:1524:20: warning: ???test_idle_cores??? declared
> ???static??? but never defined [-Wunused-function]
>  1524 | static inline bool test_idle_cores(int cpu, bool def);
>       |                    ^~~~~~~~~~~~~~~
> 

There is a fix posted that addresses this but it has not reached
tip/sched/core. I'll resend the accumulated fixes today and cc you.

-- 
Mel Gorman
SUSE Labs
