Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61856C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CBE214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="VE07v7+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAWQBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:01:00 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:58655 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726885AbgAWQBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 11:01:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579795259; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=eFeZtL7giiOcNKhy0ZgWz6ZZVkZcK/c5/KyFaL3YYBo=; b=VE07v7+C6ofajeZZdj5OiMmM5RX1Ccx2CsKiKujkHkAiNCTJqny0p/z8pcflVww8lo/tOrMl
 6TJTp0bxNvLZDRrXhSKioPulNZlLDoeVsH2JAJuxAuhDhYjmUVRtUlX1LHZacdlb3DkomEBN
 RIVfJV0EZATsXFh7q/PyWKcbE1Q=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e29c32b.7f86da1909d0-smtp-out-n03;
 Thu, 23 Jan 2020 16:00:43 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CE2FDC4479C; Thu, 23 Jan 2020 16:00:42 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 63103C43383;
        Thu, 23 Jan 2020 16:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63103C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH] pstore: Fix printing of duplicate boot messages to console
Date:   Thu, 23 Jan 2020 21:30:31 +0530
Message-Id: <20200123160031.9853-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit f92b070f2dc8 ("printk: Do not miss new messages
when replaying the log"), CON_PRINTBUFFER flag causes the
duplicate boot messages to be printed on the console when
PSTORE_CONSOLE and earlycon (boot console) is enabled.
Pstore console registers to boot console when earlycon is
enabled during pstore_register_console as a part of ramoops
initialization in postcore_initcall and the printk core
checks for CON_PRINTBUFFER flag and replays the log buffer
to registered console (in this case pstore console which
just registered to boot console) causing duplicate messages
to be printed. Remove the CON_PRINTBUFFER flag from pstore
console since pstore is not concerned with the printing of
buffer to console but with writing of the buffer to the
backend.

Console log with earlycon and pstore console enabled:

[    0.008342] Console: colour dummy device 80x25
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x51df805e]
...
[    1.244049] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x51df805e]

Fixes: f92b070f2dc8 ("printk: Do not miss new messages when replaying the log")
Reported-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 fs/pstore/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index d896457e7c11..271b00db0973 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -505,7 +505,7 @@ static void pstore_console_write(struct console *con, const char *s, unsigned c)
 static struct console pstore_console = {
 	.name	= "pstore",
 	.write	= pstore_console_write,
-	.flags	= CON_PRINTBUFFER | CON_ENABLED | CON_ANYTIME,
+	.flags	= CON_ENABLED | CON_ANYTIME,
 	.index	= -1,
 };
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
