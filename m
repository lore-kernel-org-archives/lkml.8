Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C93AC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 174DB206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgD2Gqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 02:46:43 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:58852 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726355AbgD2Gqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:46:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Tx.8cMk_1588142795;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0Tx.8cMk_1588142795)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Apr 2020 14:46:39 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     bp@alien8.de, hpa@zytor.com, jpoimboe@redhat.com,
        luto@amacapital.net, michal.lkml@markovi.net, mingo@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, x86@kernel.org,
        yamada.masahiro@socionext.com
Subject: [PATCH 0/2] Build ORC fast lookup table in scripts/sorttable tool
Date:   Wed, 29 Apr 2020 14:46:24 +0800
Message-Id: <20200429064626.16389-1-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move building of fast lookup table from boot to sorttable tool. This saves us
6380us boot time on Intel(R) Xeon(R) CPU E5-2682 v4 @ 2.50GHz with cores.

Huaixin Chang (2):
  scripts/sorttable: Build orc fast lookup table via sorttable tool
  x86/unwind/orc: Remove unwind_init() from x86 boot

 arch/x86/include/asm/unwind.h |  2 -
 arch/x86/kernel/setup.c       |  2 -
 arch/x86/kernel/unwind_orc.c  | 51 ----------------------
 scripts/sorttable.h           | 99 ++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 92 insertions(+), 62 deletions(-)

-- 
2.14.4.44.g2045bb6

