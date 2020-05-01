Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F52C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C48162051A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588341654;
	bh=nhCt2Lm+GlbVDcPUrxjnDLRk9fDfQp0uSJp10Ax2z50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RgxQqwDEuprgZs9c96xGOwvfpNLQ7eyrgoxmvJPZ3yGeOi7QO7J9lbUNrznYU6I0N
	 LpEpGC416ryC19mMg1uYvHIdrLgMQ7IRbeuoMnDn/a034zH392tlZXMkuLEke/1Tt2
	 sV3z/YSFIQKejfhRJYgZKXydJ9Y+1OBEP2+3d2yg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbgEAN0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:26:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbgEAN0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:26:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B15D20757;
        Fri,  1 May 2020 13:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339600;
        bh=nhCt2Lm+GlbVDcPUrxjnDLRk9fDfQp0uSJp10Ax2z50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xhQIxx9jaRMK4LJhyigIkPd7+NBUyIhvWQrDdWA+wfermqpWt3XRxCy0oXp+9eEAm
         JpK9ZzGRee3PnVGXfZFqcMKuciPK0Q7l8WDiVMMNSYdtGcDzRjjx/CJhRetuRpmF0V
         BGVyZxnWSUH4IUkoNy+UeCNTfXp95zATxTpHqJvo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4.4 42/70] tty: rocket, avoid OOB access
Date:   Fri,  1 May 2020 15:21:30 +0200
Message-Id: <20200501131526.509105545@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131513.302599262@linuxfoundation.org>
References: <20200501131513.302599262@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>

commit 7127d24372bf23675a36edc64d092dc7fd92ebe8 upstream.

init_r_port can access pc104 array out of bounds. pc104 is a 2D array
defined to have 4 members. Each member has 8 submembers.
* we can have more than 4 (PCI) boards, i.e. [board] can be OOB
* line is not modulo-ed by anything, so the first line on the second
  board can be 4, on the 3rd 12 or alike (depending on previously
  registered boards). It's zero only on the first line of the first
  board. So even [line] can be OOB, quite soon (with the 2nd registered
  board already).

This code is broken for ages, so just avoid the OOB accesses and don't
try to fix it as we would need to find out the correct line number. Use
the default: RS232, if we are out.

Generally, if anyone needs to set the interface types, a module parameter
is past the last thing that should be used for this purpose. The
parameters' description says it's for ISA cards anyway.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: stable <stable@vger.kernel.org>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/r/20200417105959.15201-2-jslaby@suse.cz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/rocket.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -645,18 +645,21 @@ static void init_r_port(int board, int a
 	info->port.ops = &rocket_port_ops;
 	init_completion(&info->close_wait);
 	info->flags &= ~ROCKET_MODE_MASK;
-	switch (pc104[board][line]) {
-	case 422:
-		info->flags |= ROCKET_MODE_RS422;
-		break;
-	case 485:
-		info->flags |= ROCKET_MODE_RS485;
-		break;
-	case 232:
-	default:
+	if (board < ARRAY_SIZE(pc104) && line < ARRAY_SIZE(pc104_1))
+		switch (pc104[board][line]) {
+		case 422:
+			info->flags |= ROCKET_MODE_RS422;
+			break;
+		case 485:
+			info->flags |= ROCKET_MODE_RS485;
+			break;
+		case 232:
+		default:
+			info->flags |= ROCKET_MODE_RS232;
+			break;
+		}
+	else
 		info->flags |= ROCKET_MODE_RS232;
-		break;
-	}
 
 	info->intmask = RXF_TRIG | TXFIFO_MT | SRC_INT | DELTA_CD | DELTA_CTS | DELTA_DSR;
 	if (sInitChan(ctlp, &info->channel, aiop, chan) == 0) {


