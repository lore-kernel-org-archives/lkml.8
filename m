Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398DBC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 18:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA1F20674
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 18:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCHSez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 14:34:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:55952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgCHSey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 14:34:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D6740B11E;
        Sun,  8 Mar 2020 18:34:52 +0000 (UTC)
Date:   Sun, 8 Mar 2020 18:34:48 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     qiwuchen55@gmail.com
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] sched/fair: fix build warning about undefined
 test_idle_cores()
Message-ID: <20200308183448.GI3772@suse.de>
References: <1583682792-30844-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1583682792-30844-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 11:53:12PM +0800, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> The build with arm64's defconfig:
> CONFIG_SCHED_MC=y
> # CONFIG_SCHED_SMT is not set
> 
> Trigger the following warning due to test_idle_cores()'s definition
> missing:
> kernel/sched/fair.c:1524:20: warning: ???test_idle_cores??? declared ???static???
> 	but never defined [-Wunused-function]
> 
> Move the CONFIG_SCHED_SMT ifdeffery around test_idle_cores()'s declaration
> to fix it.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>

Thanks. A fix has been merged to tip/sched/core as

commit 76c389ab2b5e300698eab87f9d4b7916f14117ba
Author: Valentin Schneider <valentin.schneider@arm.com>
Date:   Tue Mar 3 11:02:57 2020 +0000

    sched/fair: Fix kernel build warning in test_idle_cores() for !SMT NUMA


-- 
Mel Gorman
SUSE Labs
