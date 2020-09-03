Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82288C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4216E20829
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599148968;
	bh=scif4zxKzOBVb7m6sWZhxPwdTeMLudkLly3HvHDEAmM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VQKLDShT6Q35pJz2MKYU6LFEJT6LrvT6Ao93FPUGY9PI/lPr83P+vdqiSd2p96Zcy
	 kwKDYU8BrPcwiPvijj4FTq2fIS1zIVceIelABd0Y+126fYE+xO14LNqSqFnTEFv0X+
	 vepS18N8GjhpN2khEYpWeMzdTpvPz+xAUFeFSz6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgICQCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:02:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgICQCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:02:43 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6D8820716;
        Thu,  3 Sep 2020 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599148962;
        bh=scif4zxKzOBVb7m6sWZhxPwdTeMLudkLly3HvHDEAmM=;
        h=From:To:Cc:Subject:Date:From;
        b=qMfVrU12BQB5mLDgDhIr/Ezums9MAAorUu0VegyRAyn77zrgm5z+ITJgV7FZTUWaW
         YZsENQ8BHp24iu1t6+dCIBdr+orRVfAdEjVrwYZdo/Qn5bMnlfMjt5UsKTAE1mtyI/
         6YCA9TbK0GsIOT6ppHeqUeHYtTlZL49opc8a2n3U=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kDrhA-008w6r-Qf; Thu, 03 Sep 2020 17:02:41 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Suman Anna <s-anna@ti.com>, kernel-team@android.com
Subject: [PATCH] mfd: syscon: Don't free allocated name for regmap_config
Date:   Thu,  3 Sep 2020 17:02:37 +0100
Message-Id: <20200903160237.932818-1-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lee.jones@linaro.org, arnd@arndb.de, s-anna@ti.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name allocated for the regmap_config structure is freed
pretty early, right after the registration of the MMIO region.

Unfortunately, that doesn't follow the life cycle that debugfs
expects, as it can access the name field long after the free
has occured.

Move the free on the error path, and keep it forever otherwise.

Fixes: e15d7f2b81d2 ("mfd: syscon: Use a unique name with regmap_config")
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/mfd/syscon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 75859e492984..7a660411c562 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -108,7 +108,6 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	syscon_config.max_register = resource_size(&res) - reg_io_width;
 
 	regmap = regmap_init_mmio(NULL, base, &syscon_config);
-	kfree(syscon_config.name);
 	if (IS_ERR(regmap)) {
 		pr_err("regmap init failed\n");
 		ret = PTR_ERR(regmap);
@@ -145,6 +144,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	regmap_exit(regmap);
 err_regmap:
 	iounmap(base);
+	kfree(syscon_config.name);
 err_map:
 	kfree(syscon);
 	return ERR_PTR(ret);
-- 
2.27.0

