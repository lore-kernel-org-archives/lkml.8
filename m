Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6997AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 463B02068D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDPwO3ol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgFCHWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgFCHWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:22:53 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6484EC05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 00:22:53 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j1so864775pfe.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 00:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=epHTx4WtH5eVO53u9vYRGtnDvl2Fou6agb9RgeFaY18=;
        b=CDPwO3olv9s5zteGYUfVc+sp3PPPJPLARUW/0rVxq1+Ly8PTZYNTR2mW3V2vZmsLiT
         3oAMpGGkbkfHTmeJlqmXYWVqv+T3LSm8sk0Qx1h+VYo3kBBoWeyhjdKvwlQo/3jUlCrW
         0ttOmubv94mXOn3Yyl/JahnMEW2Sk4SvsuahvpEihKkHm1Ci7nGsbhs2eWHxRWT3ar8H
         lAoF0PK0LLTzSTDLIX0NKc4v3lVMpP9I7hfAR1t57cPwBtKiglm+xeqlwoEkpzgF2Lmi
         QPCkwbuBYt7tpDeHN7sZa2qWc3ua/uLsB+hsIW6e0xDasBj+32acrZyV0pl5oMp0Ba/Z
         u3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=epHTx4WtH5eVO53u9vYRGtnDvl2Fou6agb9RgeFaY18=;
        b=rUHEDLkf/JefDNtUnsOdA5EZOoRS44fP86DFm7M2S4WZdulUAmKBJhtOlZA+K7J0TF
         eUjvun1qzbLd1l/FCZXhTqM9p9lrfH9gwRFDuZkrZsd9sk7+xTWkx8qYUWIbljKwvSbg
         nr5qh9dSqau1hjtmYlnzB9NgPtAr/Qhz6cnq/I4w2+fJGej0Fr0J/6Xl+GRYGa918KMs
         Sxdtlw//k5Sdt5melRPKQD5PZm6ZXS/FpCa8DhMiKUhb1gL3S3x1x/8IfKrhZ/DOH1X2
         iku6M1Pf0dIr7Jjlh5pQ4VCqtiSCD1aKiseNcF7HPgDdhgFegX47PB9Fcz77viKNPqC7
         b72w==
X-Gm-Message-State: AOAM533lIlhv6j/sSbJez0vqP0mqcaeQubCPju2ERrDDr2VY3JS6uM8v
        2Fh2flwTRfKLQRXrVJYBNFOMPg==
X-Google-Smtp-Source: ABdhPJxq6b+TRxfiJi4+MW8+OSaaHBj+RxXJSsUHooYPQOdqGK6CI23+Yc+zOpHUP8us0rlfL65g2g==
X-Received: by 2002:a17:90a:2686:: with SMTP id m6mr4101227pje.11.1591168972877;
        Wed, 03 Jun 2020 00:22:52 -0700 (PDT)
Received: from localhost.localdomain ([117.252.66.248])
        by smtp.gmail.com with ESMTPSA id j17sm1407272pjy.22.2020.06.03.00.22.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2020 00:22:52 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 3/4] kdb: Make kdb_printf() console handling more robust
Date:   Wed,  3 Jun 2020 12:52:14 +0530
Message-Id: <1591168935-6382-4-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591168935-6382-1-git-send-email-sumit.garg@linaro.org>
References: <1591168935-6382-1-git-send-email-sumit.garg@linaro.org>
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
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

