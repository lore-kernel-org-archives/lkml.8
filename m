Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29205C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 03:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08FFD2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 03:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j7CIePE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgGBDPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 23:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGBDPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 23:15:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6C3C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 20:15:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 13so13922903ybx.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 20:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CdvIUOflYKIpzoou6WtUxcq+gVwfhVp2A4cJfb6QLOQ=;
        b=j7CIePE2feBXIQoNkIEb9ht1a2F3NGiMraG57XHLRoNnulgQBq3IFW8CQuBoDdO+GV
         R0Ij5FmaSWYor33Z54uc2bupMuj4TPrjrpMTZ1cg180DmgQI61lzCY1n7mb2Qf/KIN0H
         QhVnQ2/QfP2S/F6gH/Euq+hf0aKuai9RQyAE10NesyHLF+1y9LXo3jt6NoD4Bx54SeAP
         N0/D/ZxNn5+ur4bihNwamMHV60sdlDdHYz1h/Swm+j0Ae6zeDytN5vsvy52dR9tqgWou
         wE8hsx+tiNOjw/ne8XOR/FjOLp21lTeqOCaSJgZ3fPkjYbkwnibTTZ1f/InmQE2IncV4
         K/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CdvIUOflYKIpzoou6WtUxcq+gVwfhVp2A4cJfb6QLOQ=;
        b=ZZFb/+42IC31Z2zX9elgFTkAogxrQSJbsCmC+fHCDBnAGjXt/+ifS+Xz70v9rNp2Iw
         rfeMray5o+wJzRioFPPe2MhBf/059YYwLBQQTjrb9A7jCYbAoqTAhhiytAIzhi73HZCV
         tS74Pj6mPgihlkP/7CoPRnpqqmdngwatQCaQhtbj2jCDMDqysKSMGBXgMjqfyUQZRwC6
         YpR9ghZvYOlZVkQk3anWsI7Xc/u63JmIfyCAyhvnz0W4tOUatlhyqiDd52W1k5/GpPNS
         YxvDLYOZrMRNrorL3+XYGOi4Qk2ZP64cxELLje8o8EKeCIAIfYLofODGp4jtbXVwwxLC
         tB6Q==
X-Gm-Message-State: AOAM531EKe1xqvLqiiR92qLO9JxrHzHGhZPktBUo82XW7l259WBpa0vc
        IpQM4/Ub4u6vb9ZmBSFOlpN0jcw+LGPi
X-Google-Smtp-Source: ABdhPJzXNz99QATFcwOzy0xMvaJnAbV8I/wYK/CJKezLCha1UrJlnlmTSpest394fpFEmmeLEDBYCcsfeCXx
X-Received: by 2002:a25:aa70:: with SMTP id s103mr48095292ybi.492.1593659751405;
 Wed, 01 Jul 2020 20:15:51 -0700 (PDT)
Date:   Thu,  2 Jul 2020 13:15:22 +1000
In-Reply-To: <20200702031525.2662441-1-amistry@google.com>
Message-Id: <20200702131350.1.I96e67ab7b4568287eb939e8a572cbc03e87f1aa0@changeid>
Mime-Version: 1.0
References: <20200702031525.2662441-1-amistry@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 1/4] regulator: da9211: Move buck modes into header file
From:   Anand K Mistry <amistry@google.com>
To:     linux-mediatek@lists.infradead.org
Cc:     hsinyi@chromium.org, drinkcat@chromium.org,
        Anand K Mistry <amistry@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow device trees to make use of these constants.

Signed-off-by: Anand K Mistry <amistry@google.com>
---

 drivers/regulator/da9211-regulator.c             |  5 +----
 .../dt-bindings/regulator/dlg,da9211-regulator.h | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)
 create mode 100644 include/dt-bindings/regulator/dlg,da9211-regulator.h

diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index 2ea4362ffa5c..1f9b75b41346 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -17,6 +17,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/da9211.h>
+#include <dt-bindings/regulator/dlg,da9211-regulator.h>
 #include "da9211-regulator.h"
 
 /* DEVICE IDs */
@@ -24,10 +25,6 @@
 #define DA9213_DEVICE_ID	0x23
 #define DA9215_DEVICE_ID	0x24
 
-#define DA9211_BUCK_MODE_SLEEP	1
-#define DA9211_BUCK_MODE_SYNC	2
-#define DA9211_BUCK_MODE_AUTO	3
-
 /* DA9211 REGULATOR IDs */
 #define DA9211_ID_BUCKA	0
 #define DA9211_ID_BUCKB	1
diff --git a/include/dt-bindings/regulator/dlg,da9211-regulator.h b/include/dt-bindings/regulator/dlg,da9211-regulator.h
new file mode 100644
index 000000000000..cdce2d54c8ba
--- /dev/null
+++ b/include/dt-bindings/regulator/dlg,da9211-regulator.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _DT_BINDINGS_REGULATOR_DLG_DA9211_H
+#define _DT_BINDINGS_REGULATOR_DLG_DA9211_H
+
+/*
+ * These buck mode constants may be used to specify values in device tree
+ * properties (e.g. regulator-initial-mode, regulator-allowed-modes).
+ * A description of the following modes is in the manufacturers datasheet.
+ */
+
+#define DA9211_BUCK_MODE_SLEEP		1
+#define DA9211_BUCK_MODE_SYNC		2
+#define DA9211_BUCK_MODE_AUTO		3
+
+#endif
-- 
2.27.0.212.ge8ba1cc988-goog

