Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC08AC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 08:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F2920714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 08:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgBKIRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 03:17:39 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:37265 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727687AbgBKIRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 03:17:39 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TpgaLzl_1581409054;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TpgaLzl_1581409054)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 11 Feb 2020 16:17:35 +0800
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Subject: [RFC] why can't dynamic isolation just like the static way
Message-ID: <fed10a26-7423-23b5-316c-c74d354870dd@linux.alibaba.com>
Date:   Tue, 11 Feb 2020 16:17:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, folks

We are dealing with isolcpus these days and try to do the isolation
dynamically.

The kernel doc lead us into the cpuset.sched_load_balance, it's fine
to achieve the dynamic isolation with it, however we got problem with
the systemd stuff.

It's keeping create cgroup with sched_load_balance enabled on default,
while the cpus are overlapped with the isolated ones, which lead into
sched domain rebuild and these cpus become non-isolated.

We're just looking forward an easy way to dynamic isolate some cpus,
just like the isolation parameter, but sched_load_balance forcing us
to dealing with the management of cgroups, we really don't get the
point in here...

Why do we have to mix the isolation with cgroups? Why not just provide
a proc entry to read cpumask and rebuild the domains?

Please let us know if there is any good reason to make the dynamic
isolation in that way, appreciated in advance :-)

Regards,
Michael Wang
