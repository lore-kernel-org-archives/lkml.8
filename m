Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03FEC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA41206CC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701775;
	bh=e564ST1k+o7W12jAtXCfhSUOBRMI5bbt6lHHNRoycxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0twFssE+iy4s+0UllCNCbPi3CrPsBXZGp7GBP3lXt2yWcFGrbd4oYOsv52xqPpPLD
	 eebw10Moqcuy6eskOaKppNZs9gKkKWiC/HNi0XguYrGQvVmam+V6H1k7Xwz250EYA4
	 epNdP74F81JrYzB50nr9pOtW0L4oOxqViglgknyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390350AbgBNRgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:36:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390206AbgBNQFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:05:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3988D24681;
        Fri, 14 Feb 2020 16:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696339;
        bh=e564ST1k+o7W12jAtXCfhSUOBRMI5bbt6lHHNRoycxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3Xd7lN5z7B24FRapbnSE6hV4xiqouTxovK54vD1I3kVcEEjmt6uHC6w7e59wFqU9
         a+gxiOSUsrwrR15OylcNH1cFbFEte4DFS2kNxUdcc/vocofSuzkLj3hH3xdLfJ64/z
         Y47Gq55Em6IigjB52ixuoGGAwoEFG7rsZAfrTeVM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 175/459] tty: serial: amba-pl011: remove set but unused variable
Date:   Fri, 14 Feb 2020 10:57:05 -0500
Message-Id: <20200214160149.11681-175-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongfeng Wang <wangxiongfeng2@huawei.com>

[ Upstream commit 94345aee285334e9e12fc70572e3d9380791a64e ]

Fix the following warning:
drivers/tty/serial/amba-pl011.c: In function check_apply_cts_event_workaround:
drivers/tty/serial/amba-pl011.c:1461:15: warning: variable dummy_read set but not used [-Wunused-but-set-variable]

The data read is useless and can be dropped.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Link: https://lore.kernel.org/r/1575619526-34482-1-git-send-email-wangxiongfeng2@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/amba-pl011.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index b0b6895463952..8e47ef5093c71 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1456,8 +1456,6 @@ static void pl011_modem_status(struct uart_amba_port *uap)
 
 static void check_apply_cts_event_workaround(struct uart_amba_port *uap)
 {
-	unsigned int dummy_read;
-
 	if (!uap->vendor->cts_event_workaround)
 		return;
 
@@ -1469,8 +1467,8 @@ static void check_apply_cts_event_workaround(struct uart_amba_port *uap)
 	 * single apb access will incur 2 pclk(133.12Mhz) delay,
 	 * so add 2 dummy reads
 	 */
-	dummy_read = pl011_read(uap, REG_ICR);
-	dummy_read = pl011_read(uap, REG_ICR);
+	pl011_read(uap, REG_ICR);
+	pl011_read(uap, REG_ICR);
 }
 
 static irqreturn_t pl011_int(int irq, void *dev_id)
-- 
2.20.1

