Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D197C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76AE7206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bmX8oMZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406350AbgFYQgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406322AbgFYQgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:36:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791A0C08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:36:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g18so6548493wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7w/pnlnnQSHCAirkmRSLoxGGcJUAfrsJnqhR6P4aZuM=;
        b=bmX8oMZhEkT5mR32QGDXGU5JDQxWrWOUHAsLmg7Kq1troHvADX/on1a8CxOZMN63bJ
         cPt9Syn8oX4fOe/xAg1BmVMI6U9bn+meIzNYXvLdVWTVa0LWsSpnOBpt9k20vkwn1AOE
         RSkkICZ7JlI16quRqokQEhsLx0U/TnXhM8fRtPm5fNQ/louYdiE5O0q2S0BCs9Uh3Tcr
         p37e7ITisX2e9fOlKKCRuzEfCqh+AVyl0wWSVNtq5b7Jr2rqnsa5krhIVzowcHCTKdyU
         ww7yD2K1XABWmbzeyi2VcYHrZt2gfqbNzFGo55H0fxpNM+nXcLOKCMFY8jxyq67YW7b/
         BBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7w/pnlnnQSHCAirkmRSLoxGGcJUAfrsJnqhR6P4aZuM=;
        b=Q4obXSgX8LX5Qy90w5EWDbYsJVl6dineISqSVq4XayU3isIzBla/dMHZUo92Tm1+at
         JLazWTPWst8u/oWRfWY2Xuw5M+o3VOtBVAuc/KwS6gv/XTxmgnf521LcEocT91w6LDEh
         PZldyCyLyYBtYOhXcfkJLMUDUx8WhrSqeXkwPOn8oP2Tl6bMfeX9uRKWlJ9fnI82s7Ok
         /3CCAoDHfvpdK/syKRDMPEo1QSYQqVw0ekblMiF+sCyhV0M6ZbzRUEwiEZjqWr7tOuA1
         et7SUv2o6vypBdz3BUwg72zFTZzkTop6c8HflCQBYL2KQsu9XhmGB0nHcJzPHH/unpN4
         XUFw==
X-Gm-Message-State: AOAM532HSWX4RqmJaXiKWSfkU/zzxHKz29KmlX4a6cMTpuUjFHuJRwxz
        CQsqKk87EELqijOheWy0pY/WySWEGqo=
X-Google-Smtp-Source: ABdhPJwkefas7Xjc8zxfcgoc5NtjPc9XHGGk7tV1NQOV6YhohojlxLzCRryaWgBWuGxwQ0OnYotAhQ==
X-Received: by 2002:adf:9bc1:: with SMTP id e1mr8307199wrc.253.1593102994153;
        Thu, 25 Jun 2020 09:36:34 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id a15sm36729089wrh.54.2020.06.25.09.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:36:33 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 10/10] regulator: max14577-regulator: Demote kerneldoc header to standard comment
Date:   Thu, 25 Jun 2020 17:36:14 +0100
Message-Id: <20200625163614.4001403-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625163614.4001403-1-lee.jones@linaro.org>
References: <20200625163614.4001403-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing about this comment identifies it as a kerneldoc header.
It's missing all of it's function argument descriptions and the
correct function header.

Fixes the following W=1 warning(s):

 drivers/regulator/max14577-regulator.c:166: warning: Function parameter or member 'max14577' not described in 'max14577_get_regma
 drivers/regulator/max14577-regulator.c:166: warning: Function parameter or member 'reg_id' not described in 'max14577_get_regmap'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/max14577-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max14577-regulator.c b/drivers/regulator/max14577-regulator.c
index 07a150c9bbf22..e34face736f48 100644
--- a/drivers/regulator/max14577-regulator.c
+++ b/drivers/regulator/max14577-regulator.c
@@ -155,7 +155,7 @@ static const struct regulator_desc max77836_supported_regulators[] = {
 	[MAX77836_LDO2] = MAX77836_LDO_REG(2),
 };
 
-/**
+/*
  * Registers for regulators of max77836 use different I2C slave addresses so
  * different regmaps must be used for them.
  *
-- 
2.25.1

