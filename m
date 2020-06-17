Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A067EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D7412098B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYzbGmtM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgFQWdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgFQWc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:32:59 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25D2C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:32:58 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 9so4864041ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0BofOMCye2tgPB77NxtH0eUGzutDQe2I3xVjUr1cXQY=;
        b=OYzbGmtMd4EDxVc+wkH85RFPTvOYR/IeM/nO4An/m2fcxP/b1FXMIjwAuacvKgDlf9
         SowuIATT0p7MqGgm/dwloyTLdoLCNMdE3t2SxVMqhWP26YjsZxIERi7DxKr1ny3Kvtka
         Wpvq6FxvCOv2t0gNM/x+voBll4oVXPwi9Rs3VVgxeoimnEFuyvnUk8W+s9Xk4AiDatRV
         /nvowGGKl+uXAqjyWL8q3M2VhcKWTTHq44vAxJJfXNg7S30BugqxvDxmSZlvcNrwkwiQ
         o1slt5bLzxff9gxIEG07dzW/MREcROmw0JAGarOdJoJ/vW1kVUX0P0OujR0D4XmS9/yu
         0JRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0BofOMCye2tgPB77NxtH0eUGzutDQe2I3xVjUr1cXQY=;
        b=UPN6jbyywt1c6JgZgjRi3kTpJ7+wfTB+hxxh5sH4WKgedbp+lFroijJ2N63i9Z/qDt
         kJ8bJQ2P1GDkEumuXshhBRfdf7EfqTcFnZyl/bg4mrSgSnqb3RjUb4YK+s0Sk7qpRtHS
         CeGRUDSmLC5k0NOUS52ancjzHLAffhlKx30GsdXeTriNExJCWtZ6XfDiLIhCkiNIu0SO
         6fffFXFgZnUZPK2PM6P8kNHGp1isjAkYMgOXvOwdWM0CAkyw4wdV/dc6c+Jg/hjsTZf0
         1a+D5nzxdOT3cud33wDlu8E8l8a8FQ+bV7mZg9h8TJ22lMK/tB37kTMZ6N7YuJgW9Ll1
         o6Ew==
X-Gm-Message-State: AOAM5337wmV6ONAG70pDfAE67CmkrwhDf+CjErO6INGOzi2GMT6YKdE1
        H2x18xOmctqY/bUME1IuntY=
X-Google-Smtp-Source: ABdhPJzZYSmY7V9ibEXUqfa3Hymvuft7wnYDEiw03zFAB82eCs2y31ayRPizU2y/czxOb9PitE+O4A==
X-Received: by 2002:a2e:8747:: with SMTP id q7mr636594ljj.459.1592433177214;
        Wed, 17 Jun 2020 15:32:57 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-136.NA.cust.bahnhof.se. [82.196.111.136])
        by smtp.gmail.com with ESMTPSA id 203sm226079lfh.19.2020.06.17.15.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:32:56 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 2/5] regulator: cpcap: Constify cpcap_regulator_ops
Date:   Thu, 18 Jun 2020 00:32:44 +0200
Message-Id: <20200617223247.25566-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617223247.25566-1-rikard.falkeborn@gmail.com>
References: <20200617223247.25566-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpcap_regulator_ops is not modified and can be made const to allow the
compiler to put it in read-only memory.

Before:
   text    data     bss     dec     hex filename
  14472     236       0   14708    3974 drivers/regulator/cpcap-regulator.o

After:
   text    data     bss     dec     hex filename
  14604     104       0   14708    3974 drivers/regulator/cpcap-regulator.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/regulator/cpcap-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index f80781d58a28..14642603e755 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -256,7 +256,7 @@ static int cpcap_regulator_set_mode(struct regulator_dev *rdev,
 				  CPCAP_BIT_AUDIO_LOW_PWR, value);
 }
 
-static struct regulator_ops cpcap_regulator_ops = {
+static const struct regulator_ops cpcap_regulator_ops = {
 	.enable = cpcap_regulator_enable,
 	.disable = cpcap_regulator_disable,
 	.is_enabled = regulator_is_enabled_regmap,
-- 
2.27.0

