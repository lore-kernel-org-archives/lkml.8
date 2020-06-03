Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90B9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8582720679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I0S3XYU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgFCHWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgFCHWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:22:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB24C05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 00:22:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e9so1134880pgo.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 00:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KH9mdDVcPHEY0mojValvd3JCyi55UJUFJ61D84czA9Q=;
        b=I0S3XYU+nNeK9ISWU1458r0kuMd3K6rN3SacyxgQr4DuSLAFPR9t4UhOauqbuhZ20a
         yPdlKC9njptkxgd0ZbIPtSUEepv9SglcMj5d0r2RY+ztemInMrrqQMKxZy3fxHIc1dpx
         N0G4bvRaNTwS68qdSTC/GjutgZjwd4gPu5FvrAn6s8S2iYs9zOpr3G7CCJ/n42dPfe8z
         x158WQg1stswQjoqv9wfJBP1i7XSDB33JFHoVujRwZvQyvf3sCN+rO/94JYQUWrF7h6p
         laiQKIEttSSC0ugoS9IaUiwu5Ob3mP8NiEE3NCuC88Yb5XpYdDCngMAGq6NVoPUMlPjK
         wEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KH9mdDVcPHEY0mojValvd3JCyi55UJUFJ61D84czA9Q=;
        b=QY/y1T6oJQiP+U74qTE9G/0OXZ5YwyOb0nkTGI5euXMhXlA407iFEOWHLTdMqg83qJ
         FwEmceFuqn8xw17ZETGsI3Yum0g23PeYKNyi2DSKU4Op9Zj1y5vrbISUbsFRoULRJ5zM
         WtswH+jPGHgPnfPgdApbEV1gbw8D2cCFPhNtmI6/erHNqLYq1it8sdDou5zhHcfF9QuU
         dL0duFE03xPCHGrRgXcDJ2CZC/cy+Gerverl2AsjvcdC7cQ1W4BDEvLW4M6fhHa2BCIM
         NKKW82VZm5S0/hECUO56CzuEyQN8mg1ic1OzT7g6nduX6c0l+ijVexdekitQcCiAYVI+
         VfHA==
X-Gm-Message-State: AOAM533GFfiM7KB62W2TpHLKRujhpkhNyjZ3IIJV++6lNpY/Z2f8lnBV
        qV2DgPAKoqcgNL15+kLOktehBw==
X-Google-Smtp-Source: ABdhPJzbIj0dPQSD91jSKU+b3V+XS3Q+jbXkgTqE7TWO3f+KavuzGx+MLzMkc43ztjLhIFtbPkoPgQ==
X-Received: by 2002:a17:90a:f198:: with SMTP id bv24mr4099950pjb.206.1591168966618;
        Wed, 03 Jun 2020 00:22:46 -0700 (PDT)
Received: from localhost.localdomain ([117.252.66.248])
        by smtp.gmail.com with ESMTPSA id j17sm1407272pjy.22.2020.06.03.00.22.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2020 00:22:45 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 2/4] kdb: Check status of console prior to invoking handlers
Date:   Wed,  3 Jun 2020 12:52:13 +0530
Message-Id: <1591168935-6382-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591168935-6382-1-git-send-email-sumit.garg@linaro.org>
References: <1591168935-6382-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if a console is enabled prior to invoking corresponding write
handler.

Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 kernel/debug/kdb/kdb_io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 2d42a02..58b7d25 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -560,6 +560,8 @@ static void kdb_msg_write(const char *msg, int msg_len)
 	}
 
 	for_each_console(c) {
+		if (!(c->flags & CON_ENABLED))
+			continue;
 		c->write(c, msg, msg_len);
 		touch_nmi_watchdog();
 	}
-- 
2.7.4

