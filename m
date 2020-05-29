Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA5BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 766DF21534
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cTntY+QP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgE2L1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 07:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2L1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:27:36 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD230C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 04:27:36 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id g5so1236382pfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 04:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=swXPGMrzCEsQLDtOomMfEMI5zRSTvjf8q0XZ57NNdwQ=;
        b=cTntY+QP7be+KCZ3TmD3G+ZmCEJTyACPPKqh2zbGHf6TTf1vlDeMuZgJO3O+/yLT/b
         VrWg+hXVkn98YCY8v/zOyzKGb9uN5TU0eVylsq9kNnKyREVfvU1B0zeNuxnC835XV2aL
         8jFexlrTTmbsOccFNv6Me65nM5nD/oh6a0T6rK4v5PJW0nc3ZZ51yUe0cT5YB14f0pw5
         nocjZCF2mLqp9UVZMNqHIT8aeScGfMaD+OOi3KltXiQBPya9SX2387AetuSs0d9FjhoO
         ugRvO7m/rWHwQ14gklIx1bqhblOgnwhMHTIZLyZNZOed1HNYmgCoHaZOHyg4j8v1GMO2
         dDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=swXPGMrzCEsQLDtOomMfEMI5zRSTvjf8q0XZ57NNdwQ=;
        b=mRNenQ++obzn+PIRqP9bCMdQ1aRvZJT/4oMRZUpeVIPdPeqtaXX848zuR01y1tZzMR
         yWAp7OtKI8kxj4PQmOdunwaOgDWc1OD9xGWlisOM7q3kIqzVU0S5FJApUz5XOsmyB3uP
         p3AALKS59fLxlpzDkeMTj9WoKfuI2V9mzUTNS57ifRbb9C/WPdZ4x2WLfMzX5ecoLW56
         Lt3nfBUC4d1sLNcclkPzuCmk0EZA0+yGPtVqQOqt+vG4upaA3i/GIrfgPeR4Bg+0qMQE
         BgPse7P1q005nOpeAO7v63JHDZX/SrjUYQigBzVn0oFKgfW0kFvd/TCH53TUkn/4lNec
         aFvQ==
X-Gm-Message-State: AOAM531kc3JrCS2tF2kgU970qaQ2DOg2nbE2Tc365syUan6L/y90MWjH
        cU8Whv/mP1OlkFeoOa08Jlr9uw==
X-Google-Smtp-Source: ABdhPJzRFOc862JgIEx+A0mSz9srzgGZ4R0z9zW75evtV1vuGUT/6zFHIAoUTXkiLE+CpLE2Grmhig==
X-Received: by 2002:aa7:9a0e:: with SMTP id w14mr8332032pfj.288.1590751656230;
        Fri, 29 May 2020 04:27:36 -0700 (PDT)
Received: from localhost.localdomain ([117.252.66.248])
        by smtp.gmail.com with ESMTPSA id w190sm7016741pfw.35.2020.05.29.04.27.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 04:27:35 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 3/4] kdb: Make kdb_printf() console handling more robust
Date:   Fri, 29 May 2020 16:56:46 +0530
Message-Id: <1590751607-29676-4-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590751607-29676-1-git-send-email-sumit.garg@linaro.org>
References: <1590751607-29676-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While rounding up CPUs via NMIs, its possible that a rounded up CPU
maybe holding a console port lock leading to kgdb master CPU stuck in
a deadlock during invocation of console write operations. A similar
deadlock could also be possible while using synchronous breakpoints.

So in order to avoid such a deadlock, set oops_in_progress to encourage
the console drivers to disregard their internal spin locks: in the
current calling context the risk of deadlock is a bigger problem than
risks due to re-entering the console driver. We operate directly on
oops_in_progress rather than using bust_spinlocks() because the calls
bust_spinlocks() makes on exit are not appropriate for this calling
context.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index fad38eb..9e5a40d 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -566,7 +566,18 @@ static void kdb_msg_write(char *msg, int msg_len)
 	for_each_console(c) {
 		if (!(c->flags & CON_ENABLED))
 			continue;
+		/*
+		 * Set oops_in_progress to encourage the console drivers to
+		 * disregard their internal spin locks: in the current calling
+		 * context the risk of deadlock is a bigger problem than risks
+		 * due to re-entering the console driver. We operate directly on
+		 * oops_in_progress rather than using bust_spinlocks() because
+		 * the calls bust_spinlocks() makes on exit are not appropriate
+		 * for this calling context.
+		 */
+		++oops_in_progress;
 		c->write(c, msg, msg_len);
+		--oops_in_progress;
 		touch_nmi_watchdog();
 	}
 }
-- 
2.7.4

