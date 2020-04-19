Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A4DC38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 14:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE70B212CC
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 14:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgDSOky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 10:40:54 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:54691 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbgDSOky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 10:40:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Tw-JlLh_1587307252;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tw-JlLh_1587307252)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 19 Apr 2020 22:40:53 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH 0/3] x86: cleanups
Date:   Sun, 19 Apr 2020 14:40:46 +0000
Message-Id: <20200419144049.1906-1-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple cleanups found while reading the code.

Lai Jiangshan (3):
  x86/entry: remove unneeded kernel cr3 switching
  x86: remove address operator on function machine_check()
  x86/entry: remove an unused label

 arch/x86/entry/entry_64.S | 2 --
 arch/x86/kernel/idt.c     | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.20.1

