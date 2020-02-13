Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D0BC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94412217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m8NYusRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgBMQmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:42:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42409 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbgBMQmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:42:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id k11so7497058wrd.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 08:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bhsGWp5ne3QnPpqxRlkmT7D4Kf4En5d9ZglTG1EbOnk=;
        b=m8NYusRz6pGqHOIbtp/UK78XKjqljtr184HPe9b+etmJlQW5bOC0mqRml3sp3A2Nex
         N9KUVzKA/H6LA57hd/WtL2VYTogSF+e5X26N9Asa0oqItBCe9w+TUW3A2kGEytUCAOD4
         6rFqWl2yOLpJLp1uNWXRV1ynAwxNB/iZFrbk6gFXpgUzJYYaetcphvbT2Xdlvm3AHYo4
         Y8xCiIKAkjS6D9Uh9wSpED1US3WCBkrs4amLxNRKzPpVQnDzUUUMIw67I85IBjoV0yp8
         JLsaF3tMPDbO6nD1dEbIxfITuTMegxy42BdnsKnyTucmzuDRSFW7cuD8Dr4LGBexGAX0
         JLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bhsGWp5ne3QnPpqxRlkmT7D4Kf4En5d9ZglTG1EbOnk=;
        b=qA0EnWGMFy17h8GLZSbR0vC1QlZddgtVOG2TapcDNvKz58qRKXdqTxGCsop20ihk4T
         tRMJYNBNhOIiDBojTXsTNh2/FmUJ+DJnjcW+9Pg0Z79HCvWccScs6lEHlm5BuPBI0CpG
         w6vjbf8sbcTVOFZ+yj9nR+pBdK/3WztcT3J1dkMI40/BIrma5oQAOMb7JwzF7un6NWmy
         tgrf6DwNdV/Ej9j6AMHq9dGYYgMd46YAfmOvYqFWsj+a49B19th0pvjJqljZy9cQCmps
         bkmevcti83ew8gVSSjZ+zuk18ViqZHfW2y66AApyWTxCiCu82F35n7M9QivD63GyCEDR
         K5Pg==
X-Gm-Message-State: APjAAAUgcTnROdpDHsxEa+yJeDA/KDEpzrqpEzllz6jj33VtPuJ1YS/K
        gZ455OC5nJxpmPi8/WBiZY8Bww==
X-Google-Smtp-Source: APXvYqyDkeGF7a8mW0wXHklVzjs0VtRvaPbtmdGxhIbIJZmYTZw8vqRf/7h0b/F1wPHDGl17lZYMFw==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr21947668wrq.51.1581612124532;
        Thu, 13 Feb 2020 08:42:04 -0800 (PST)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id o4sm3461402wrx.25.2020.02.13.08.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 08:42:04 -0800 (PST)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org, Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Subject: [PATCH] kdb: Censor attempts to set PROMPT without ENABLE_MEM_READ
Date:   Thu, 13 Feb 2020 16:41:46 +0000
Message-Id: <20200213164146.366251-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the PROMPT variable could be abused to provoke the printf()
machinery to read outside the current stack frame. Normally this
doesn't matter becaues md is already a much better tool for reading
from memory.

However the md command can be disabled by not setting KDB_ENABLE_MEM_READ.
Let's also prevent PROMPT from being modified in these circumstances.

Whilst adding a comment to help future code reviewers we also remove
the #ifdef where PROMPT in consumed. There is no problem passing an
unused (0) to snprintf when !CONFIG_SMP.
argument

Reported-by: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index ba12e9f4661e..8dae08792641 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -398,6 +398,13 @@ int kdb_set(int argc, const char **argv)
 	if (argc != 2)
 		return KDB_ARGCOUNT;

+	/*
+	 * Censor sensitive variables
+	 */
+	if (strcmp(argv[1], "PROMPT") == 0 &&
+	    !kdb_check_flags(KDB_ENABLE_MEM_READ, kdb_cmd_enabled, false))
+		return KDB_NOPERM;
+
 	/*
 	 * Check for internal variables
 	 */
@@ -1298,12 +1305,9 @@ static int kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs,
 		*(cmd_hist[cmd_head]) = '\0';

 do_full_getstr:
-#if defined(CONFIG_SMP)
+		/* PROMPT can only be set if we have MEM_READ permission. */
 		snprintf(kdb_prompt_str, CMD_BUFLEN, kdbgetenv("PROMPT"),
 			 raw_smp_processor_id());
-#else
-		snprintf(kdb_prompt_str, CMD_BUFLEN, kdbgetenv("PROMPT"));
-#endif
 		if (defcmd_in_progress)
 			strncat(kdb_prompt_str, "[defcmd]", CMD_BUFLEN);


base-commit: bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9
--
2.23.0

