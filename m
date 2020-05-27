Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78394C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5074120787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G85xHZqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgE0G0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgE0G0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:26:50 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F2CC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:26:50 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nu7so1115157pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tSNP35QYp6xethZiWpN7Amg3X+LW4hgKA/e4KGUMccc=;
        b=G85xHZqLsrWZHmuuol1ub48HKxIZv5mdMUnm3b8yhDQMn6qJH4go9eNLKJHEduMHCw
         5oWiGqTR6R3Lvvs162rEhlcPapcPlp9s1LdpwgUxegA0hZkPCEEbHUlFw2/3jL0Cal8c
         Ald7vkGE8pEFiTwJftEVdcJnU4Bos8caP5Pi18190rIeTGVdbLLnGPZUA3+MpI6z86xe
         Axtl7GI6AkUDP+XLxRcgRSMd5a4tL7OlEiOnSwRh0YujnzdzkRNCN47W+u75SD8ENOcY
         4VahJAFqcN3JceEn3SOat3kt7OqkIjCpofGgPZ+LlmUX2Fp+nhYGTkuIqsGUvUMoeVco
         y81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tSNP35QYp6xethZiWpN7Amg3X+LW4hgKA/e4KGUMccc=;
        b=C/zc4N8+7sC3LDndOV1Tr9CJRQjCWv3B5FvdQIOni30vhPBXPXPp4LWfHEFOtxb+Sm
         egejEyQyI9DV8wOKTNyiDtwvRZHo+1mQMHum+rtkhr7bN4edp0eMK8enCLhSWsQnHAeR
         P5x7QWOCW6MfxhMNDSuOH145oi43YnWeC3C0ES4szla0+DImjmh0T7IYkrOPX9/RLnZj
         PAy1tYXbBTAqXgpKpwG8w3HXC03flHzsrAlBu/xsGDS0UEuiWT2V5Q6aRrK1wKLyY2mW
         3Ro0NQhEzt87piD0xyF2ujzVIeNbS2KhzH09EmtDr3tvELMIivmBI74cKNmcJIx8fYwv
         BJUQ==
X-Gm-Message-State: AOAM532xbtZJxQVOVfBJ/1m3+2kkRqMNyplHwb8bH5O+idA8scGb6/P9
        TgKaosdyayWfOXRkKjuDLB5Xig==
X-Google-Smtp-Source: ABdhPJzEHo4EV0Nw7baAgnSJBBSDsFWrG9xwKApSsxlEfzYi9UM/tqokhAtut1Lf1zGSTCSpFgSJjA==
X-Received: by 2002:a17:902:b904:: with SMTP id bf4mr4500929plb.89.1590560810119;
        Tue, 26 May 2020 23:26:50 -0700 (PDT)
Received: from localhost.localdomain ([117.252.68.136])
        by smtp.gmail.com with ESMTPSA id m12sm1239121pjs.41.2020.05.26.23.26.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 23:26:49 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 3/4] kdb: Make kdb_printf robust to run in NMI context
Date:   Wed, 27 May 2020 11:55:58 +0530
Message-Id: <1590560759-21453-4-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590560759-21453-1-git-send-email-sumit.garg@linaro.org>
References: <1590560759-21453-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While rounding up CPUs via NMIs, its possible that a rounded up CPU
maybe holding a console port lock leading to kgdb master CPU stuck in
a deadlock during invocation of console write operations. So in order
to avoid such a deadlock, enable oops_in_progress prior to invocation
of console handlers.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 349dfcc..f848482 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -566,7 +566,17 @@ static void kdb_msg_write(char *msg, int msg_len)
 	for_each_console(c) {
 		if (!(c->flags & CON_ENABLED))
 			continue;
+		/*
+		 * While rounding up CPUs via NMIs, its possible that
+		 * a rounded up CPU maybe holding a console port lock
+		 * leading to kgdb master CPU stuck in a deadlock during
+		 * invocation of console write operations. So in order
+		 * to avoid such a deadlock, enable oops_in_progress
+		 * prior to invocation of console handlers.
+		 */
+		++oops_in_progress;
 		c->write(c, msg, msg_len);
+		--oops_in_progress;
 		touch_nmi_watchdog();
 	}
 }
-- 
2.7.4

