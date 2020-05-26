Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A730DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 04:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9022D207ED
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 04:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgEZEfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 00:35:21 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:36090 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgEZEfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 00:35:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TzgjMIS_1590467711;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TzgjMIS_1590467711)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 May 2020 12:35:12 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCH 0/2] x86/entry: simplify RESTORE_CR3
Date:   Tue, 26 May 2020 04:35:05 +0000
Message-Id: <20200526043507.51977-1-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I searched percpu data touched by entry code for #DB
protection[1], it seems to me RESTORE_CR3() does too much work,
this patchset simplifies it.

Patch 1 enhances 21e944591102("x86/mm: Optimize RESTORE_CR3") for
kernel CR3.

Patch 2 *reverts* 21e944591102("x86/mm: Optimize RESTORE_CR3") for
User CR3.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: https://lore.kernel.org/lkml/20200525145102.122557-1-laijs@linux.alibaba.com
Lai Jiangshan (2):
  x86/entry: Don't write to CR3 when restoring to kernel CR3
  x86/entry: always flush user CR3 in RESTORE_CR3

 arch/x86/entry/calling.h  | 36 ++++++++----------------------------
 arch/x86/entry/entry_64.S |  6 +++---
 2 files changed, 11 insertions(+), 31 deletions(-)

-- 
2.20.1

