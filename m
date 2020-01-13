Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F91C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 02:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761EB2187F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 02:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733124AbgAMCJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 21:09:10 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:44330 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732676AbgAMCJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 21:09:10 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 20E472C5DB99BA276497;
        Mon, 13 Jan 2020 10:09:07 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 Jan 2020
 10:09:00 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH RESEND 0/4] tty: use true,false for bool variable
Date:   Mon, 13 Jan 2020 10:16:13 +0800
Message-ID: <1578881777-65475-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use real name 'Zheng Bin', instead of zhengbin

Zheng Bin (4):
  tty: synclink_gt: use true,false for bool variable
  tty/serial: kgdb_nmi: use true,false for bool variable
  tty/serial: atmel: use true,false for bool variable
  tty/serial: 8250_exar: use true,false for bool variable

 drivers/tty/serial/8250/8250_exar.c | 6 +++---
 drivers/tty/serial/atmel_serial.c   | 6 +++---
 drivers/tty/serial/kgdb_nmi.c       | 4 ++--
 drivers/tty/synclink_gt.c           | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

--
2.7.4

