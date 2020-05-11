Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD48C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9810920801
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dpuCWriu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgEKM0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 08:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727019AbgEKM0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:26:16 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B01C05BD0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:26:14 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q24so7706676pjd.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6UPeYtFxFAx9gPdqtUllM7hIOHzpNJ87ucNQvEyM/W4=;
        b=dpuCWriuMUzF0JT7TfJy/jv3b0jgrrU72bBaJjT1jCmEuJjRUN4ZM+j5GKrrwQI7lp
         v96w4P9TimNRooGph5RFZKg7a8I5I/N4UQ/m35tfgeg556gISKAS7c9X+PcJgNw0lLdX
         ajUDubLvh0FClNcx7j0a1eNK2exQGmMNJ9RLkCBC53NpFUfLrNEJaf/ZnMohP2rHwEwa
         9sGm3MWCrw34sI5hDr1j6uPN4qJ/lWPeXJ14MPUXmU/qZwqKXn5i5NNhrqBEOVOUGDce
         183BM1xLwzgw5o48z1bAJ8+DIie4elOnqPYb0+YcAx602GqqiA6P1g0RB3nNU+jPFV6L
         o2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6UPeYtFxFAx9gPdqtUllM7hIOHzpNJ87ucNQvEyM/W4=;
        b=IpRXudKSYxTbE1c4+JfijPudVw3VZD50Zgg3vcYE/N1Rkz7STdRJoDjlq99jhIocAc
         URFHbnBlf538AX2ZkxBYvvgThx1oqgrDXCf9XCoT2xxHPyWKcilDjZKJ2+ZVVNvpQHcL
         3TaWGBmZoGuNEAHgKxkcHyO4fzhKP2Ep7rTvrLC4qaUuF92M96BQ/pGnvfRju2Nk8J1o
         qm7hWc3io0+zc+/rL/hF5601rCRId1xd+padEWeQc6aOgaPFLEvTK0k9I0vdHiTd+Nio
         +4EPE+pRafA2g0pO2bNu882x33f+ZqlJsuj17Af5Lo3VBxk+WWoMSHzzyEID2F+SoLoc
         H35Q==
X-Gm-Message-State: AGi0PuYFguMKHFSliNr3GXAXidhbbENcz5pe4tgILo7ohfktXtZ8v6QJ
        mRGY/b4sawz394+br7UtCQWsdvT4VMo=
X-Google-Smtp-Source: APiQypKRc5pNcAFtU8nJC4T0/Mj8a73yMDHrfKjYPg2Qve+SWffvBDZg6bGiuSNMLM2cmdKvT+yoTw==
X-Received: by 2002:a17:902:9b8e:: with SMTP id y14mr15048603plp.109.1589199973056;
        Mon, 11 May 2020 05:26:13 -0700 (PDT)
Received: from localhost ([45.127.45.102])
        by smtp.gmail.com with ESMTPSA id f6sm9198173pfn.189.2020.05.11.05.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 05:26:12 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 10/14] thermal/drivers/cpufreq_cooling: Replace module.h with export.h
Date:   Mon, 11 May 2020 17:54:58 +0530
Message-Id: <7a439e41e91d8bc5ff99207f99723fcf04ca36eb.1589199124.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1589199124.git.amit.kucheria@linaro.org>
References: <cover.1589199124.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpufreq_cooling cannot be modular, remove the unnecessary module.h
include and replace with export.h to handle EXPORT_SYMBOL family of
macros.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/cpufreq_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 1b5a63b4763d..9e124020519f 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -10,12 +10,12 @@
  *		Viresh Kumar <viresh.kumar@linaro.org>
  *
  */
-#include <linux/module.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpu_cooling.h>
 #include <linux/energy_model.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/idr.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_qos.h>
-- 
2.20.1

