Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAE5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 733DC206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eCsjtb0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406261AbgFYQcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406186AbgFYQbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:31:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4813AC08C5DE
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:31:39 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so6177532wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EoDDRWYqSRFNxuy0oLGiJ2BCcmCTg6+79vgN6npQkDY=;
        b=eCsjtb0CD0LDkL/xpQgVQpUKp46erAgw6x4yrXv2r8sD3j++WjCcmIyOt1/Ru6SBKS
         31Wn7T59R8BrNIi+NbhvYd1Dwd7McIkOUfHsMrPDmjJ7Eevz7+PwJ2mZlbE1thlXu6td
         qpIf95KNd37Ub8rtfwRk8obKD8t7NdwtO3qLfJpkGf56W6hHceqWDZe+g+lR3tycgaNf
         ftPDOpr/JIFpSRm/X6hLfJOuvtaGSqyecEG6Wmnilnk7XeamBZuOZ30XIIiCyLLJ6FyS
         /lod4D62NPUbBm6aLWDd0162ZdkwbS2gLu+NVSsCgaDE7Gsv93oeh4HR1+6xDDHaJ0jt
         8iUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EoDDRWYqSRFNxuy0oLGiJ2BCcmCTg6+79vgN6npQkDY=;
        b=tpDD3phNhpomMoN69pW3n3vf6T9XOEmeGi206hQZMlJ7m5bST1sGghEagKlZm9Qs1P
         b6a0WzDWlK/vvsFeuxZP/tn6ocQGgYXzQuMGJ74FRUktPD3A/zTAB+6BX7I1LfsX/ZHs
         +Hh7xOCYlkFJBTrV095I5RbSZN8EdhdfA3iA8D370Va6nHAgjEJ6WRoHk8iW7GOMNxNq
         JYzUnOWD2TQL/XBD+6ydQU+F6SJnQ9xSWz9vkmXQdvu9761d36X6N4XzwVWNKkJKuAWL
         Sv42D2kFLd+H49aYLkWVuUTPonjUYRDQF8ubnnO2nANEg9ZxKjBB5i/8NcS1S97e+Bqn
         w0uA==
X-Gm-Message-State: AOAM5326AXqDY71OZRVD4XvPa1L1pqLZ8EiegRQrA6AIRZPffBIL9ca2
        QD67TfLht/nO4jZUf+n24GaVog==
X-Google-Smtp-Source: ABdhPJxs0E1ZwZRgy1IPBlo62VKJtW4RR3mcSMYVd6SruY6FQ67fUZ/rYYoLZFZyV6U9/jG7A6WazQ==
X-Received: by 2002:a7b:cbcb:: with SMTP id n11mr4041219wmi.99.1593102698025;
        Thu, 25 Jun 2020 09:31:38 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id l8sm32090847wrq.15.2020.06.25.09.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:31:37 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 04/10] mfd: ab3100-otp: Add missing colon(s) for all documented kerneldoc arguments
Date:   Thu, 25 Jun 2020 17:31:21 +0100
Message-Id: <20200625163127.4000462-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625163127.4000462-1-lee.jones@linaro.org>
References: <20200625163127.4000462-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc validation gets confused if syntax isn't "@.*: ".

Adding the missing colons squashes the following W=1 warnings:

 drivers/mfd/ab3100-otp.c:60: warning: Function parameter or member 'dev' not described in 'ab3100_otp'
 drivers/mfd/ab3100-otp.c:60: warning: Function parameter or member 'locked' not described in 'ab3100_otp'
 drivers/mfd/ab3100-otp.c:60: warning: Function parameter or member 'freq' not described in 'ab3100_otp'
 drivers/mfd/ab3100-otp.c:60: warning: Function parameter or member 'paf' not described in 'ab3100_otp'
 drivers/mfd/ab3100-otp.c:60: warning: Function parameter or member 'imeich' not described in 'ab3100_otp'
 drivers/mfd/ab3100-otp.c:60: warning: Function parameter or member 'cid' not described in 'ab3100_otp'
 drivers/mfd/ab3100-otp.c:60: warning: Function parameter or member 'tac' not described in 'ab3100_otp'
 drivers/mfd/ab3100-otp.c:60: warning: Function parameter or member 'fac' not described in 'ab3100_otp'
 drivers/mfd/ab3100-otp.c:60: warning: Function parameter or member 'svn' not described in 'ab3100_otp'
 drivers/mfd/ab3100-otp.c:60: warning: Function parameter or member 'debugfs' not described in 'ab3100_otp'

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab3100-otp.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/ab3100-otp.c b/drivers/mfd/ab3100-otp.c
index c4751fb9bc224..c393102e3a394 100644
--- a/drivers/mfd/ab3100-otp.c
+++ b/drivers/mfd/ab3100-otp.c
@@ -29,22 +29,22 @@
 
 /**
  * struct ab3100_otp
- * @dev containing device
- * @locked whether the OTP is locked, after locking, no more bits
+ * @dev: containing device
+ * @locked: whether the OTP is locked, after locking, no more bits
  *       can be changed but before locking it is still possible
  *       to change bits from 1->0.
- * @freq clocking frequency for the OTP, this frequency is either
+ * @freq: clocking frequency for the OTP, this frequency is either
  *       32768Hz or 1MHz/30
- * @paf product activation flag, indicates whether this is a real
+ * @paf: product activation flag, indicates whether this is a real
  *       product (paf true) or a lab board etc (paf false)
- * @imeich if this is set it is possible to override the
+ * @imeich: if this is set it is possible to override the
  *       IMEI number found in the tac, fac and svn fields with
  *       (secured) software
- * @cid customer ID
- * @tac type allocation code of the IMEI
- * @fac final assembly code of the IMEI
- * @svn software version number of the IMEI
- * @debugfs a debugfs file used when dumping to file
+ * @cid: customer ID
+ * @tac: type allocation code of the IMEI
+ * @fac: final assembly code of the IMEI
+ * @svn: software version number of the IMEI
+ * @debugfs: a debugfs file used when dumping to file
  */
 struct ab3100_otp {
 	struct device *dev;
-- 
2.25.1

