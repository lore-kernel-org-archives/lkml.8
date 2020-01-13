Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FA2C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 02:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F382187F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 02:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733224AbgAMCJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 21:09:23 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8701 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733132AbgAMCJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 21:09:13 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 60436ED5131B7413F9A4;
        Mon, 13 Jan 2020 10:09:12 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 Jan 2020
 10:09:01 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH RESEND 2/4] tty/serial: kgdb_nmi: use true,false for bool variable
Date:   Mon, 13 Jan 2020 10:16:15 +0800
Message-ID: <1578881777-65475-3-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578881777-65475-1-git-send-email-zhengbin13@huawei.com>
References: <1578881777-65475-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/tty/serial/kgdb_nmi.c:121:6-13: WARNING: Assignment of 0/1 to bool variable
drivers/tty/serial/kgdb_nmi.c:133:2-9: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 drivers/tty/serial/kgdb_nmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index 4029272..5022447 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -118,7 +118,7 @@ static int kgdb_nmi_poll_one_knock(void)
 	int c = -1;
 	const char *magic = kgdb_nmi_magic;
 	size_t m = strlen(magic);
-	bool printch = 0;
+	bool printch = false;

 	c = dbg_io_ops->read_char();
 	if (c == NO_POLL_CHAR)
@@ -130,7 +130,7 @@ static int kgdb_nmi_poll_one_knock(void)
 		n = (n + 1) % m;
 		if (!n)
 			return 1;
-		printch = 1;
+		printch = true;
 	} else {
 		n = 0;
 	}
--
2.7.4

