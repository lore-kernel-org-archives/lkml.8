Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F7BC3F2D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF6C2072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgCFHBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:01:47 -0500
Received: from lucky1.263xmail.com ([211.157.147.134]:45516 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgCFHBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:01:47 -0500
Received: from localhost (unknown [192.168.167.209])
        by lucky1.263xmail.com (Postfix) with ESMTP id BF7D96E8A5;
        Fri,  6 Mar 2020 15:01:40 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32633T140274261014272S1583478094758456_;
        Fri, 06 Mar 2020 15:01:37 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <ff3b0c3381f088e0126292714aaa8293>
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
Subject: [PATCH v3 0/1] wait_task_inactive() spend too much time on system startup
Date:   Fri,  6 Mar 2020 15:01:32 +0800
Message-Id: <20200306070133.18335-1-cl@rock-chips.com>
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
v3: Use a new method fix this issue to make the code simple.

Liang Chen (1):
  kthread: do not preempt current task if it is going to call schedule()

 kernel/kthread.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

-- 
2.17.1



