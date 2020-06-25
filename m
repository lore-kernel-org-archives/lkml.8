Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB85C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B77206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BhDdCYXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406368AbgFYQg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406105AbgFYQga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:36:30 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2BEC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:36:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r12so6466267wrj.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AG5JT6BVc++x++ET4thnNlvU80KPoPW/gm+IcPGlfx4=;
        b=BhDdCYXbf5Bqe3gq5XkEZV0kknc76p0ua5nw3TxvwQkxOhI94SN5qxknw3zwl5wNEW
         3dY47g2rPPn+nFrwNrpOVm9mArj+jAllsr6IQ6L6YNIRNqI0e/4QxmXlxly1hqTF05OU
         0roGmZyUaiHYDJOoxFugRIOQ2NLj4ea2+hRgjreQdrEpeHJJLRuDUWBWt/KvhxCLS+mt
         LuYCoLOJRKiLVmqJ8gAeY5cthidQPeBf86Tv/wn8mfo9GjgoOAAOtTU8TI5IG4BAekLA
         qpxAXf+nHatgdSrGE80pFgsgV8o1PgjegYusaveC+nr8K/h7FbU2qMDsyiSJ7xKhn3ZF
         l6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AG5JT6BVc++x++ET4thnNlvU80KPoPW/gm+IcPGlfx4=;
        b=rt816mEIqNxHkTesFIUSETlrRfc792c2m9UcQT7uOQLHxeVgZMyz+fsMQT18tAoEOM
         6fUmoLb9njCl4bxv5i449m54vrXg4XNnj/eJZ7sscRYl+3tAQsBFSulUOi86WOg4tgFU
         XD4/a58zep6VrDdLlfs3OBsvcpK+nN+H2K++HAuY/ANAsu0BR+H62WbdlwclWTBPzEqG
         NMei4y1hSQ9RnZ+/sa4QJnuzEAJERt5KqtR5qeF0mth7naRa8PB71BShfx+oJQfdz/ij
         0htnLrTRbD/nKdkd/z7v6kT1laXV3k17KMp7v1ZzoZpZHNKXvve5ET14gymU4BEiMklM
         N/qw==
X-Gm-Message-State: AOAM532tQtygSu/c/PTcFCVRMsvUEi/f/HpIw6sOlJ0h68iAyM8UWkOl
        /05bYJlNOskOtIe0scFIYw8X3A==
X-Google-Smtp-Source: ABdhPJwU7z6hTpdi1x9E0HggAu6Vtz2QvUClP5kZIoGM9g28pYobAy85ukWrA02d7gn5e7lGb05t6w==
X-Received: by 2002:adf:f20a:: with SMTP id p10mr29547732wro.41.1593102988733;
        Thu, 25 Jun 2020 09:36:28 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id a15sm36729089wrh.54.2020.06.25.09.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:36:28 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 05/10] regulator: ab8500: Remove unused embedded struct expand_register
Date:   Thu, 25 Jun 2020 17:36:09 +0100
Message-Id: <20200625163614.4001403-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625163614.4001403-1-lee.jones@linaro.org>
References: <20200625163614.4001403-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Used primarily for the AB8540 which lost support in early 2018.
It is now deemed safe to remove this legacy data structure.

Also fixes W=1 issue:

  drivers/regulator/ab8500.c:88: warning: Function parameter or member 'expand_register' not described in 'ab8500_regulator_info'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/ab8500.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index 716ca5bb178e7..47b8b6f7b5715 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -59,6 +59,7 @@ struct ab8500_shared_mode {
  * @voltage_bank: bank to control regulator voltage
  * @voltage_reg: register to control regulator voltage
  * @voltage_mask: mask to control regulator voltage
+ * @expand_register: 
  */
 struct ab8500_regulator_info {
 	struct device		*dev;
@@ -79,12 +80,6 @@ struct ab8500_regulator_info {
 	u8 voltage_bank;
 	u8 voltage_reg;
 	u8 voltage_mask;
-	struct {
-		u8 voltage_limit;
-		u8 voltage_bank;
-		u8 voltage_reg;
-		u8 voltage_mask;
-	} expand_register;
 };
 
 /* voltage tables for the vauxn/vintcore supplies */
-- 
2.25.1

