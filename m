Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10410C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95232146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgCEJ76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 04:59:58 -0500
Received: from lucky1.263xmail.com ([211.157.147.132]:48570 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgCEJ75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 04:59:57 -0500
Received: from localhost (unknown [192.168.167.8])
        by lucky1.263xmail.com (Postfix) with ESMTP id 84B5FA920D;
        Thu,  5 Mar 2020 17:59:53 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P12225T140183483700992S1583402391050204_;
        Thu, 05 Mar 2020 17:59:53 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <5fa7a28b1227fe0fca77ae2005852e54>
X-RL-SENDER: cl@rock-chips.com
X-SENDER: cl@rock-chips.com
X-LOGIN-NAME: cl@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   <cl@rock-chips.com>
To:     heiko@sntech.de
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        akpm@linux-foundation.org, tglx@linutronix.de, mpe@ellerman.id.au,
        surenb@google.com, ben.dooks@codethink.co.uk,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        will@kernel.org, keescook@chromium.org, luto@amacapital.net,
        wad@chromium.org, mark.rutland@arm.com, geert+renesas@glider.be,
        george_davis@mentor.com, sudeep.holla@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org, info@metux.net,
        kstewart@linuxfoundation.org, allison@lohutok.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huangtao@rock-chips.com, Liang Chen <cl@rock-chips.com>
Subject: [PATCH v2 0/1] wait_task_inactive() spend too much time on system startup
Date:   Thu,  5 Mar 2020 17:59:47 +0800
Message-Id: <20200305095948.10873-1-cl@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

Changelog:
v1: wait_task_inactive() frequently call schedule_hrtimeout() and spend a lot of time,
i am trying to optimize it on rockchip platform.
v2: Use atomic_flags(PFA) instead of TIF flag, and add some comments.

Liang Chen (1):
  sched/fair: do not preempt current task if it is going to call
    schedule()

 include/linux/sched.h |  5 +++++
 kernel/kthread.c      |  4 ++++
 kernel/sched/fair.c   | 13 +++++++++++++
 3 files changed, 22 insertions(+)

-- 
2.17.1



