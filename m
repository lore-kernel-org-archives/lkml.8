Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32FBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE230206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SYdCbuGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgFDKB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 06:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgFDKB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 06:01:58 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10031C03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 03:01:58 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so2001780plv.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 03:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SWaxGGeqdBIuWfi0Pr0m5m/UNqCqE+K7xfquz67qpwE=;
        b=SYdCbuGB3J+72xEODNYeEFFubJezd+u5T6ELue2n2bkROzHd2EyydUBLmsE7tEE5IK
         mDLRPEOakhiDKP/h8VqX7TsibzreU/6CF7HFgmH+zXZYwaPCR54DUJeiy3fMy1YG63UI
         rK28OvFotjU0s+B/3q9D7X//OQHu9ZAdFKMWgqVQfJqOoLU9LaFNApnfxsG4YaaWD24c
         rhJ2VbxifJv8HJF7kgkmixaChgR5AlHXdX4A0vElchU932cv+DatjB3YJlfb4cr3+sGY
         1rlm7px04nPTYsYXd37BHB7bKDgqF+DSNLynDT1Mmv70C6Tx+Y+jsUTwO4DmNQ9e7RY4
         bMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SWaxGGeqdBIuWfi0Pr0m5m/UNqCqE+K7xfquz67qpwE=;
        b=hIB6DkqMuJK16np7N9/T/02TMIzgrQssQvP62oSUwIT3qIZpTg8SCCbi0Izikk1dnG
         6o7Ig8lX9bbfD1KzDoNpv+b8kH5t0vYbMxmXN5B0/PyUg+BeOa39RS2JHIhn5Ay4URwi
         PfiHSJxSfSBiXIotGt3hLrDps+flFgq8NhcNV6BP1tbB3E0I1I3uLNUHV+yscYPYD6xU
         k4/CsWW/4t+uucDUJDnR1aLEDX2gnRjN60GOhuf5f+LWvJFeaG+tw+VR4F1WyWbZaF2S
         nT37WM5mhtQO3mZwI8Aob2KE5mOlX0p01DYx4T8ajITT1Ze3SRONFsQEqL05vIzsvMP5
         ucTA==
X-Gm-Message-State: AOAM530mpbcHxTvcYJx4WQyWnJYwKBkLf5crmIHLElgwQRdR5PXCixfT
        c3vu5wcesT6DXEPYT3xVlNb4hA==
X-Google-Smtp-Source: ABdhPJw0mqKUcRmUd840WqEdRfBHzQiTtI08e9dRTAOEKoLenr0WoeMdzZUbKKaoxlDGWF8PFm/7LQ==
X-Received: by 2002:a17:90a:aa8f:: with SMTP id l15mr5379447pjq.211.1591264917610;
        Thu, 04 Jun 2020 03:01:57 -0700 (PDT)
Received: from localhost.localdomain ([117.252.66.248])
        by smtp.gmail.com with ESMTPSA id np5sm5786992pjb.43.2020.06.04.03.01.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jun 2020 03:01:56 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 3/4] kdb: Make kdb_printf() console handling more robust
Date:   Thu,  4 Jun 2020 15:31:18 +0530
Message-Id: <1591264879-25920-4-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591264879-25920-1-git-send-email-sumit.garg@linaro.org>
References: <1591264879-25920-1-git-send-email-sumit.garg@linaro.org>
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

Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Revieved-by: Petr Mladek <pmladek@suse.com>
---
 kernel/debug/kdb/kdb_io.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 58b7d25..0e4f2ed 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -562,7 +562,18 @@ static void kdb_msg_write(const char *msg, int msg_len)
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

