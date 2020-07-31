Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD17C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D8821744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZRpsKcQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbgGaQDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgGaQDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:03:39 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA13C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:03:39 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w19so4684117plq.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7NnDVKa1cF7e0zsWKXYtHJtMsUaxtGL6uhXlzpSA0oM=;
        b=ZRpsKcQVzZqnRkLvjFW8Nd3BTNpxwAP+QnQOFIw0jtLYZX8/4e7LczWdWWLguJrzZL
         rwc77ezaW6jl4YpiRs1s9/HqPV/o4t8AGTcd6GUVe8Mc52Th0casS5JIDQwfPrwdOAqx
         VCgoCKYsdvz+f8H19YVIYY5wLHNSvw+FnRqQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7NnDVKa1cF7e0zsWKXYtHJtMsUaxtGL6uhXlzpSA0oM=;
        b=Nl3Vv5j+QlqmqsqDvOgJyqESs3IiNYTUDeIzivrvxZE9+nx058iNs9MeR/9p09jufE
         Ei6+6Bj1xPb6OwaqY0fUfl9bKPteQBWFk6mEL/y8v9NgjltoJHqGhQFoQFP1r2lsbWDj
         yPSqjpqlSKnXPd4qI05ve3PG/Krq5dZLAiGuj9XyDmuWUGAW1NSxgC8HLh05+/hUnsgS
         VhNHzaaZxamOaun5uQvdyQEJdgHkkMFIYHKvobfvv+miWfxhWihkVXAp8GRBhFUCGF10
         DzFegaB4EoiyrHFnt6lfcofffFoTTWhcs0NsZ4ZFVEbMw8Tw/PRlqFZaimcCsWv6Za7p
         ayQQ==
X-Gm-Message-State: AOAM5300DOO9G+1r4heYSYuRlSrGnRVxB/enahbd6LUkToWNsKLC0prz
        pqF4DkjYvY3fkvQ9jcPJiJ2IyA==
X-Google-Smtp-Source: ABdhPJwgBpL8EF8WbFdh57/y7iuOtfgTx3MOD4nNn4ci1f/RTDgynbqx8R2LiAFPTctBnQeJCPZTzQ==
X-Received: by 2002:a17:90b:1116:: with SMTP id gi22mr223467pjb.209.1596211418932;
        Fri, 31 Jul 2020 09:03:38 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:28b1:5f25:711f:141])
        by smtp.gmail.com with ESMTPSA id 199sm11701826pgc.79.2020.07.31.09.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:03:38 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Markus Reichl <m.reichl@fivetechno.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Suniel Mahesh <sunil@amarulasolutions.com>
Subject: [PATCH v2] arm64: defconfig: Enable REGULATOR_MP8859
Date:   Fri, 31 Jul 2020 21:33:24 +0530
Message-Id: <20200731160324.142097-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3399 boards like ROC-RK3399-PC is using MP8859 DC/DC converter
for 12V supply.

roc-rk3399-pc initially used 12V fixed regulator for this supply,
but the below commit has switched to use MP8859.

commit <1fc61ed04d309b0b8b3562acf701ab988eee12de> "arm64: dts: rockchip:
Enable mp8859 regulator on rk3399-roc-pc"

So, enable bydefault on the defconfig.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Suniel Mahesh <sunil@amarulasolutions.com>
---
Changes for v2:
- none

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 883e8bace3ed..62bcbf987a70 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -556,6 +556,7 @@ CONFIG_REGULATOR_HI6421V530=y
 CONFIG_REGULATOR_HI655X=y
 CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8973=y
+CONFIG_REGULATOR_MP8859=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_QCOM_RPMH=y
-- 
2.25.1

