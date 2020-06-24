Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455C6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2888820707
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405368AbgFXRKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:10:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43993 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405229AbgFXRKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:10:15 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1jo8ub-0000XK-8I
        for linux-kernel@vger.kernel.org; Wed, 24 Jun 2020 17:10:13 +0000
Received: by mail-il1-f200.google.com with SMTP id l20so2009098ilk.22
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kgKpiNpGwHDOQMosQGkPXdFtHsQOqDrWGR8l3ZM7PP0=;
        b=oHKhK12h3T67Ak3CC58GZ7FYI1mPu+G8pt7ihscCaluaGSIk9NoUNpoSDKVjGYTY/1
         1FOnyegT/lkdteQT1tuhzLUWnC+RbxTz9JPdV9q1I3AvBjkLzj+SRKRuVcMSM8XtmKvv
         JMviUvp15hEh+2hI4xrxIN0pbco5UoJK3wkWHernhNvi8IRcSUHITgGFnrC5g6jdDRwE
         zuBr6KoSplUu1RC698cnT+Nh3iriFpyKcaEJMnHTCOJ080IU1TQfG89khlq/ZJXbPF9l
         2Z7mUjAy7EO94SU4Nqk/g+PMZAFVElFjaDeV8ZNZgbeYOVUGdei6Mu7cWyJzfY5LWwHt
         /a+g==
X-Gm-Message-State: AOAM5317zPzB0a2WIQrLAG9sHEBEmLkuqtqfJqhkIuyi6RnJT9wkddvE
        53765WtKZ2l7lIfi8TcQvIPj/oeGxQIVQgyCiCt7EpKQ/w+En5lgEewLsfGtVjQhz/qioiewM8f
        hgnqRNPZkhwpa5ZpD1u5WtQslNVfs+7WS5Cpfj9K7Ew==
X-Received: by 2002:a05:6602:1647:: with SMTP id y7mr32079842iow.75.1593018612199;
        Wed, 24 Jun 2020 10:10:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxqMBP8roE762qfwjNqRPrTKS40lTKfWlkCH86fkBnaZJ2nVaRDqTa0p+NTUGIlZS6OXM2GQ==
X-Received: by 2002:a05:6602:1647:: with SMTP id y7mr32079809iow.75.1593018611787;
        Wed, 24 Jun 2020 10:10:11 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:f090:1573:c2fc:6389])
        by smtp.gmail.com with ESMTPSA id w15sm11370028ilq.4.2020.06.24.10.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 10:10:11 -0700 (PDT)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: rename da903x to da903x-regulator
Date:   Wed, 24 Jun 2020 12:10:10 -0500
Message-Id: <20200624171010.845271-1-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This module shares the same name as its parent PMIC driver, which
confuses tools like kmod. Rename the regulator driver to avoid
such problems.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 drivers/regulator/Makefile                         | 2 +-
 drivers/regulator/{da903x.c => da903x-regulator.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/regulator/{da903x.c => da903x-regulator.c} (100%)

diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index e8f163371071..0796e4a47afa 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -31,7 +31,7 @@ obj-$(CONFIG_REGULATOR_BD70528) += bd70528-regulator.o
 obj-$(CONFIG_REGULATOR_BD71828) += bd71828-regulator.o
 obj-$(CONFIG_REGULATOR_BD718XX) += bd718x7-regulator.o
 obj-$(CONFIG_REGULATOR_BD9571MWV) += bd9571mwv-regulator.o
-obj-$(CONFIG_REGULATOR_DA903X)	+= da903x.o
+obj-$(CONFIG_REGULATOR_DA903X)	+= da903x-regulator.o
 obj-$(CONFIG_REGULATOR_DA9052)	+= da9052-regulator.o
 obj-$(CONFIG_REGULATOR_DA9055)	+= da9055-regulator.o
 obj-$(CONFIG_REGULATOR_DA9062)	+= da9062-regulator.o
diff --git a/drivers/regulator/da903x.c b/drivers/regulator/da903x-regulator.c
similarity index 100%
rename from drivers/regulator/da903x.c
rename to drivers/regulator/da903x-regulator.c
-- 
2.27.0

