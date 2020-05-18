Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B88BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 04:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A8B20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 04:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgEREAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 00:00:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58192 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbgEREAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 00:00:11 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9C8696BCAAAF13898985;
        Mon, 18 May 2020 12:00:09 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 18 May 2020 11:59:59 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <adobriyan@gmail.com>, <patrick.bellasi@arm.com>,
        <mingo@kernel.org>, <peterz@infradead.org>, <tglx@linutronix.de>,
        <gregkh@linuxfoundation.org>, <Jisheng.Zhang@synaptics.com>,
        <bigeasy@linutronix.de>, <pmladek@suse.com>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <nixiaoming@huawei.com>, <wangle6@huawei.com>,
        <alex.huangjianhui@huawei.com>
Subject: [PATCH v3 0/4] cleaning up the sysctls table (hung_task watchdog)
Date:   Mon, 18 May 2020 11:59:53 +0800
Message-ID: <1589774397-42485-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel/sysctl.c contains more than 190 interface files, and there are a 
large number of config macro controls. When modifying the sysctl 
interface directly in kernel/sysctl.c, conflicts are very easy to occur.
E.g: https://lkml.org/lkml/2020/5/10/413.

Use register_sysctl() to register the sysctl interface to avoid
merge conflicts when different features modify sysctl.c at the same time.

So consider cleaning up the sysctls table, details are in:
	https://kernelnewbies.org/KernelProjects/proc
	https://lkml.org/lkml/2020/5/13/990

The current patch set extracts register_sysctl_init and some sysctl_vals
variables, and clears the interface of hung_task and watchdog in sysctl.c.

The current patch set is based on commit b9bbe6ed63b2b9 ("Linux 5.7-rc6"),
which conflicts with the latest branch of linux-next:
	9b4caf6941fc41d ("kernel / hung_task.c: introduce sysctl to print
all traces when a hung task is detected")

Should I modify to make patch based on the "linux-next" branch to avoid
conflicts, or other branches?

changes in v3:
  1. make hung_task_timeout_max to be const
  2. fix build warning:
     kernel/watchdog.c:779:14: warning: initialization discards 'const'
         qualifier from pointer target type [-Wdiscarded-qualifiers]
         .extra2  = &sixty,
                    ^

V2: https://lkml.org/lkml/2020/5/16/81
changes in v2:
  1. Adjusted the order of patches, first do public function
     extraction, then do feature code movement
  2. Move hung_task sysctl to hung_task.c instead of adding new file
  3. Extract multiple common variables instead of only neg_one, and keep
     the order of member values in sysctl_vals
  4. Add const modification to the variable sixty in watchdog sysctl

V1: https://lkml.org/lkml/2020/5/15/17

Xiaoming Ni (4):
  sysctl: Add register_sysctl_init() interface
  sysctl: Move some boundary constants form sysctl.c to sysctl_vals
  hung_task: Move hung_task sysctl interface to hung_task.c
  watchdog: move watchdog sysctl interface to watchdog.c

 fs/proc/proc_sysctl.c        |   2 +-
 include/linux/sched/sysctl.h |   8 +-
 include/linux/sysctl.h       |  13 ++-
 kernel/hung_task.c           |  63 +++++++++++++-
 kernel/sysctl.c              | 202 ++++++++-----------------------------------
 kernel/watchdog.c            | 101 ++++++++++++++++++++++
 6 files changed, 210 insertions(+), 179 deletions(-)

-- 
1.8.5.6
