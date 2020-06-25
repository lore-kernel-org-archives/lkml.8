Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E80C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05A06206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WpCqNjvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406242AbgFYQb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406203AbgFYQbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:31:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7268DC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:31:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so6503943wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZRm78CKEaQ1OsF7LZfHXu0AnYDnquV1Y/Grx78hG0MU=;
        b=WpCqNjvZboyLwL4LAn6mI62gQryMJLzOSWZ984JZ9DxikGCM6ZwG/VrO/mL2cwkj5q
         sAqNL2+ZthviB5F4ZsFMD37DlbspqcJYPyLqlmWVJmU2DOxg7flC92SMyLY2bkOfaefj
         Vi6bqbTgrkIDd8B4rLiRKkht2kkwTdzoMCIxXAFUYK4wjBbzyZ0Bhli2pME/aLJ2zDly
         EPrGdNGRbIvpgl6SwxbcAtR9VZsd34wuE0obZ+qv57tTKD0olDztMe8GdX9cZFD+uUhI
         zTUZe+rfS3eGSLFaOz4KnYn3kkankdGHblzCQAVTL64GgHqcvYo+qmTDW8xbPdHU8v0H
         O6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZRm78CKEaQ1OsF7LZfHXu0AnYDnquV1Y/Grx78hG0MU=;
        b=ZgNj+1rKJ3q/IXYkNFCnN6a+PnFPtf9B+TYoEf1YP/E9tCyASSbQa8B294gFjQ92Jf
         2DTPUui67n/EE7x84HYMCgiaj8t50NwOb79BzqQxHhvx3Ej2iiYJd/RkYDTyGFd7gLXq
         mXcnyLskwzq59QC/qECOY3uW4acdM07PyYWL7fkWgS+k+1Ue/Q6oAk3/mJtvgcVfQTvA
         YB1SnFtR1axLg3TesIeAisDmcB/fBCNIxt2cI0exz5lNsXiWJraFCw8V9u666BAj1QKd
         +mOA2c1jXuQcs9ErPH0X2NbAT1JArf8a0JQ+MPW41o+cdUKhigrU3Gltp3GmVtvRz4tk
         +LEA==
X-Gm-Message-State: AOAM530FP1iWCVamDgTk4GWnn/laZaGo0lhqJkNpBm6cH0d0jFU79Z7G
        oIDE1EUxW+pxVlyRbD995ka9MQ==
X-Google-Smtp-Source: ABdhPJwOJGuhySHwz3S5co+7hBssBWVGR6ohtDtbKagEqOEZwvh6/BWn16l+PV4RAtyKx+7qYqduSg==
X-Received: by 2002:adf:f388:: with SMTP id m8mr6513876wro.338.1593102703228;
        Thu, 25 Jun 2020 09:31:43 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id l8sm32090847wrq.15.2020.06.25.09.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:31:42 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 09/10] mfd: si476x-i2c: Fix spelling mistake in case() statement's FALLTHROUGH comment
Date:   Thu, 25 Jun 2020 17:31:26 +0100
Message-Id: <20200625163127.4000462-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625163127.4000462-1-lee.jones@linaro.org>
References: <20200625163127.4000462-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

's/FALLTHROUG/FALLTHROUGH'

Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/si476x-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/si476x-i2c.c b/drivers/mfd/si476x-i2c.c
index 517d49bcd667b..c1d7b845244ed 100644
--- a/drivers/mfd/si476x-i2c.c
+++ b/drivers/mfd/si476x-i2c.c
@@ -588,7 +588,7 @@ static int si476x_core_fwver_to_revision(struct si476x_core *core,
 			goto unknown_revision;
 		}
 	case SI476X_FUNC_BOOTLOADER:
-	default:		/* FALLTHROUG */
+	default:		/* FALLTHROUGH */
 		BUG();
 		return -1;
 	}
-- 
2.25.1

