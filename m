Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9175AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A31620720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DhI8/oCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgGHMsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729251AbgGHMsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:48:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8FDC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:48:39 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o2so2949653wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4/CDB2l4JpZBpeXJ5F7ZtKgNEooXeOnUoj71PMW6rrU=;
        b=DhI8/oCQvfqih4cQVrA+nD2vHVKiueh86tJLRDQZ9ZqBkQeNL0geAevFCsfNx2+12/
         RVlZnK7bUgzEv44optKyzNUMT0N57KiWQRtLhhzpO0m5WQlcLRYVbFDt/A8VfNupqop+
         nxBdiXS0CEdyZWhSVCZu61hW+nJOjfacy01njfJJ89RFZVAy+kr7V3pKgt8gqcMHvLcY
         0EnQOfIK5EOJb4AMIbzYIGL6KlbhrOyV0OLZXkx+GS4Zu2k6ClHMpys54kQISpEO1o22
         N0mPWzZzNU1y1KkQh6R2m9HIxkRqRh7GdVWCIRvhW4BSTaWn7OEq+Uytbc1BRs1pqCm8
         tE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4/CDB2l4JpZBpeXJ5F7ZtKgNEooXeOnUoj71PMW6rrU=;
        b=ZSJiI+5Cj4VYs50laEmqiBO7dC1QSkz23RdeI4HdQ1dd1hvhMXYiR1kNF/Mq+R9B6B
         E5kDo/AmUn5NJc2A6i2ZzzD7ArOLW+DFVtZuYfywPEqpxnqdMWs61UqZtSpNoh9ca1jA
         UtfFESpWNFzAJHGqA2uP/rjz0GsiqJQlK1m5++YqFCWEpVgZGFLAsOMFgEwprpiUkX4I
         nuI+7kKWRcp2QMw+2xQdpPgfgFfvHidojqcfshXpE+NTXjMQVBwbSgzWfGQg8n48wsD3
         hZwg2VFNDGS0eUy95Mkoo7agR0Ug2cNi9B9zp7ANtcXcIv8FE57sHvrzQHgzHTVh6WCA
         9nnQ==
X-Gm-Message-State: AOAM533s5f5Zc+CMLqub/PQThkgMTHqlUzOSRe/JzqtJP5So0KFk5wHS
        8bkT3oQSJGdjGXFKIuGaZ7yvpdA4yig=
X-Google-Smtp-Source: ABdhPJz2fqO/BRHiY4Ch+nR7hI4H7Y7tDEL1Z6TgNNNjjt0xJwSm8rFaJTbXvBIYqovIbeQzP283OQ==
X-Received: by 2002:a1c:3142:: with SMTP id x63mr8892788wmx.62.1594212517700;
        Wed, 08 Jul 2020 05:48:37 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id x1sm5745408wrp.10.2020.07.08.05.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:48:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/3] regulator: of_regulator: Add missing colon for rdev kerneldoc argument
Date:   Wed,  8 Jul 2020 13:48:31 +0100
Message-Id: <20200708124832.3441649-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708124832.3441649-1-lee.jones@linaro.org>
References: <20200708124832.3441649-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc validation gets confused if syntax isn't "@.*: ".

Adding the missing colons squashes the following W=1 warnings:

Cc: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/of_regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 87637eb6bcbcb..06c0b15fe4c08 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -532,7 +532,7 @@ static bool of_coupling_find_node(struct device_node *src,
 /**
  * of_check_coupling_data - Parse rdev's coupling properties and check data
  *			    consistency
- * @rdev - pointer to regulator_dev whose data is checked
+ * @rdev: pointer to regulator_dev whose data is checked
  *
  * Function checks if all the following conditions are met:
  * - rdev's max_spread is greater than 0
-- 
2.25.1

