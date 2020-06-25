Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C08C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5D54206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Clvr0gA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406360AbgFYQgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406316AbgFYQge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:36:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A1CC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:36:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h15so6504936wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p8b+PVloZKecBIPRr/OI23SwGO/e4hTRF+SmOkygulE=;
        b=Clvr0gA4nLJBZGW6W/+HM9VWedZywRI9gj5x8nbcChWuKDVxsOPcRqm7opsvillYev
         VnVcVawCHAs8atU6mQP1AWBBYIqUyZ4pcdT06OcEnaS3BK+Yd043lFERn83GnlFAq+RJ
         Hwp75B6pHUL1Jm7ON5CEN+o+kne7pIVGhQ7rZlXaRVc0Wmwlfe71YmqKo9tV3gdB+mq4
         get8f7O5pMdch0xN3a8XCzwfJcHqdNnuyMGX24kEXxzEb33aLnQFyOlBI/RJBCKMjCPN
         m/yWapgMU5DHtKSQwOYafBEfjASBncKU/oB1ppJqV37Zf+eSN24EdsC22njJm+696N0y
         7BHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p8b+PVloZKecBIPRr/OI23SwGO/e4hTRF+SmOkygulE=;
        b=MAaPk4YW+EHjrCoTbjpdQJ3M+xpGBEU6bjOtE4hnYmlLqZW2HVecu+An0UQh9uBKu8
         wFUJ3Eyu4lpxTgDz1c0KfMnxFfq4zPawYhS9o9Vlj8fzi99Z6PuFLvARFkdbUwkvDDoL
         u5G+4KTmI237sfdL90bSRF07R6Jp+4XwMpHCmX9jaa1hWBd4pEzHVD/8Vzwb4Kn963SC
         +MZ87VxiDxu+Pw/83pleQqAHACTYeBzR/IrQgAtN9lpxuuU6JiyZ0gII/V7NHNbTUsF3
         n8c+TD9N/w64tRjYxGhsktBVfeHo7DLz3jIXaj0X0Jy6yubsVwgP2nsMb2jVII4Itsem
         ZHKw==
X-Gm-Message-State: AOAM5311v1mm+1FnvKICHE8uLg9fCW7gveEqqDabYM3nk6AhAeKjNzzk
        h/bIcwc7zjoMOIN/gLU2EiuNA+TWxj8=
X-Google-Smtp-Source: ABdhPJyr1ofOi7hZPmKskeIrOB05REDu3cC6GxuHEK6qzVDcUnQbMElvkDMUwm1aSNxpOCPQ6f7Jig==
X-Received: by 2002:adf:8067:: with SMTP id 94mr35980537wrk.427.1593102993280;
        Thu, 25 Jun 2020 09:36:33 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id a15sm36729089wrh.54.2020.06.25.09.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:36:32 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 09/10] regulator: da9063-regulator: Fix .suspend 'initialized field overwritten' warnings
Date:   Thu, 25 Jun 2020 17:36:13 +0100
Message-Id: <20200625163614.4001403-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625163614.4001403-1-lee.jones@linaro.org>
References: <20200625163614.4001403-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks as though 9f75ce666199 ("regulator: da9063: fix suspend") failed
to clean-up all of the existing .suspend variable initialisations.
This has led to some 'initilized field overwritten' issues now present
in W=1 builds.

This patch squashes the following build warnings:

 In file included from drivers/regulator/da9063-regulator.c:17:
 include/linux/regmap.h:1124:37: warning: initialized field overwritten [-Woverride-init]
 1124 | #define REG_FIELD(_reg, _lsb, _msb) { | ^
 drivers/regulator/da9063-regulator.c:27:2: note: in expansion of macro ‘REG_FIELD’
 27 | REG_FIELD(_reg, __builtin_ffs((int)_mask) - 1, | ^~~~~~~~~
 drivers/regulator/da9063-regulator.c:515:14: note: in expansion of macro ‘BFIELD’
 515 | .suspend = BFIELD(DA9063_REG_LDO9_CONT, DA9063_VLDO9_SEL),
 | ^~~~~~
 include/linux/regmap.h:1124:37: note: (near initialization for ‘da9063_regulator_info[11].suspend’)
 1124 | #define REG_FIELD(_reg, _lsb, _msb) { | ^
 drivers/regulator/da9063-regulator.c:27:2: note: in expansion of macro ‘REG_FIELD’
 27 | REG_FIELD(_reg, __builtin_ffs((int)_mask) - 1, | ^~~~~~~~~
 drivers/regulator/da9063-regulator.c:515:14: note: in expansion of macro ‘BFIELD’
 515 | .suspend = BFIELD(DA9063_REG_LDO9_CONT, DA9063_VLDO9_SEL),
 | ^~~~~~

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/da9063-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index e1d6c8f6d40bb..fe65b5acaf280 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -512,7 +512,6 @@ static const struct da9063_regulator_info da9063_regulator_info[] = {
 	},
 	{
 		DA9063_LDO(DA9063, LDO9, 950, 50, 3600),
-		.suspend = BFIELD(DA9063_REG_LDO9_CONT, DA9063_VLDO9_SEL),
 	},
 	{
 		DA9063_LDO(DA9063, LDO11, 900, 50, 3600),
-- 
2.25.1

