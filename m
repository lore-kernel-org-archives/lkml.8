Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FFCC433E5
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C451D21744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MS5hh0TG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGSRmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 13:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSRmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 13:42:51 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA592C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 10:42:50 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id md7so8856873pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 10:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6JE4Y8SOsdCDMPXfyKKBh9zCPbo6gFTjnSOOmLpM6V0=;
        b=MS5hh0TG5Vs08iabbG/a42dRmmRFyOzi4QXmQo+wUXloRIQVnoVuAK3Z2zsY/+ARaS
         oyNuO7dNxVXgIlcvkTtBQkMzuexzLc0vK7bZm6au8ZEfIjgYXgMLWpmGzMcBfA6auhjR
         6sTzneHtyuiEfVPasYlrp8NTcyzuKuSYWOrhEjWovXWaceeHcPvE6bJgGl4wd0iddHN4
         clYNmZaQSBJoxvQCcO3M7J6hgQW5LbO6hZIDvAFTA9fwk9IAI/ziLUl4cdYB7mcGmAW3
         4zXWnPGhH/kcbwhJ8QrbBskUhJKM/02UjD1TGaoearn+ir4oS7yAq3uFkl+A5yu9N2MK
         dIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6JE4Y8SOsdCDMPXfyKKBh9zCPbo6gFTjnSOOmLpM6V0=;
        b=tez8/uLrWrNC5ftBn9r26OkC+8TBAVneh2/B4xV/OqKH4ZuJGNjmMjly5WJL7O45zO
         xsDHE0ZTZwoEsCg+Q3n/G6Y3wM/gt3Fy9bRQH0jJsgkkB2MrYfWTG6rIrB69pkZGG7QV
         h5HDlifzeGaHH9LOTmIHriYmky0l27KTiMkmtfgXnBpir+wZFKen+tTFz3PYDVyQKkE6
         thAhxX6Bdgyqf9ERMi11Lbg7IxEF9cE5ZKhMU1gOAYXWRtWIdZ7cd1ilabZadgD+hzh0
         K8Z0UN9uXNIPDZLJaESKx5TlkRh5/2qUCQxXvBRw6jyJSJFlv4A/LSkwjuYhnx8Y/C6x
         dPMw==
X-Gm-Message-State: AOAM530F0QhkPmwypZ+qgQJK9/ZjIeafvVNuEn6qBEDidSr4vDeJYUSf
        PkDEM7imlnoi4TdYvmKEjvc=
X-Google-Smtp-Source: ABdhPJyK1AKNlRX1cZe556if4ywCezPWEg+1s/KZi2NofptJlUrsHTw3YNOcDnbYiQ4qXkvYU9zkmQ==
X-Received: by 2002:a17:902:64c9:: with SMTP id y9mr15033909pli.289.1595180570389;
        Sun, 19 Jul 2020 10:42:50 -0700 (PDT)
Received: from localhost.localdomain ([182.69.248.222])
        by smtp.gmail.com with ESMTPSA id e191sm13906083pfh.42.2020.07.19.10.42.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jul 2020 10:42:49 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, sboyd@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v7 04/10] clk: actions: Add MMC clock-register reset bits
Date:   Sun, 19 Jul 2020 23:12:01 +0530
Message-Id: <1595180527-11320-5-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
References: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds reset bits needed for MMC clock registers present
on Actions S700 SoC.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v6:
	* No change.
Changes since v5:
        * Added Mani's Reviewed-by: tag.
Changes from v4:
        * Reordered it from 03/10 to 04/10.
Changes from v3:
        * NO change.
Changes from v2:
        * No change.
Changes from v1:
        * No change.
Changes from RFC:
        * No change.
---
 drivers/clk/actions/owl-s700.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/actions/owl-s700.c b/drivers/clk/actions/owl-s700.c
index a2f34d13fb54..cd60eca7727d 100644
--- a/drivers/clk/actions/owl-s700.c
+++ b/drivers/clk/actions/owl-s700.c
@@ -577,6 +577,9 @@ static const struct owl_reset_map s700_resets[] = {
 	[RESET_DSI]	= { CMU_DEVRST0, BIT(2) },
 	[RESET_CSI]	= { CMU_DEVRST0, BIT(13) },
 	[RESET_SI]	= { CMU_DEVRST0, BIT(14) },
+	[RESET_SD0]     = { CMU_DEVRST0, BIT(22) },
+	[RESET_SD1]     = { CMU_DEVRST0, BIT(23) },
+	[RESET_SD2]     = { CMU_DEVRST0, BIT(24) },
 	[RESET_I2C0]	= { CMU_DEVRST1, BIT(0) },
 	[RESET_I2C1]	= { CMU_DEVRST1, BIT(1) },
 	[RESET_I2C2]	= { CMU_DEVRST1, BIT(2) },
-- 
2.7.4

