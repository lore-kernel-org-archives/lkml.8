Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA20C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 051F22076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BoLnBkwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406545AbgFYTRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390775AbgFYTRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:17:17 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB436C08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:17:16 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a6so7035222wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o1XJQv3xdST2ri9dQSPRqTi+utLoroqVOFsqThWptWg=;
        b=BoLnBkwqv59Kv2JXYWfehBShW2dawYLjjfGT83f2LDKPJ9DgeFbYuYiBm6hc1IninT
         NM9ehe+OWD5qfZiGF1uCZ9zhVMIMIyI5CnwksIQFJZV6Pbw5GBXKCGQVq/sv6WhYD/C0
         bQXZOeTzc7Jzg8nOMOU3Rih1rtIpcJL8Z+xtAw0oodBjpYyJOEB40dl73dwhB8AZa5kY
         lwv5HZCL81ivLPF8dLnO7OgYWsxtDGdFTuN8lvKVuBb0Ts6cv7B2a7sfnpuxG4qqktkD
         0+yBMZMag2MBjMaz6Pscwv1+3auLTu8n05bYIQz6+DgEl9C+19kfCrxi3gTSXcsYHul1
         KQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o1XJQv3xdST2ri9dQSPRqTi+utLoroqVOFsqThWptWg=;
        b=NEn1viVzrcO45+530SVKJ++o6sjPPA1IC54+zz+0Gyl8CqGZ/VQ3YhUR4LmYGkR6Ff
         SdkW3pmIioFbiZ15OUZwzGZZuT3qTyGF18sh4ECoyqKdLcFik2kUGsKgL6YNQoqDiC0A
         m24Pdw4Zzc6Iub2NRKfmEnc6qqtHkGkD4Hkh51k7Vfw9sMiopy5ic0iSmuUPf6xOB0Nj
         /wsbAKo2ZrDRPRs3OgIhimFb11usuy9GZBS2ZrKOsyxx4JfXMZ18x3woSInpsWt7DzMe
         0LPTHUR5epR07T5ZsD4SYYps6sLARIcPPp8p5tMZIJp8Sgz5RTb1YKifucwbpuSQOouz
         6WFw==
X-Gm-Message-State: AOAM5306LJkjBxaTjvAeo6pzL+5fK6ptV3U8VtJ5FKSE/hpQSPddQJXd
        nd+8r8LouzpRT8wp+dTGdmCHMU8jxQjvJA==
X-Google-Smtp-Source: ABdhPJxtSqoSA4WAktcHqgHNSJc/uRopu59O8Pv32mWtJTYz7hbM01rHb3X/SSRuT+mhPP39eykD8A==
X-Received: by 2002:adf:84e2:: with SMTP id 89mr34557885wrg.139.1593112635636;
        Thu, 25 Jun 2020 12:17:15 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p13sm22693983wrn.0.2020.06.25.12.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 12:17:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [RESEND 02/10] regulator: devres: Fix issues with kerneldoc headers
Date:   Thu, 25 Jun 2020 20:17:00 +0100
Message-Id: <20200625191708.4014533-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625191708.4014533-1-lee.jones@linaro.org>
References: <20200625191708.4014533-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide descriptions for some missing function args and
rename others to match the names used.

Fixes the following W=1 warning(s):

 drivers/regulator/devres.c:187: warning: Function parameter or member 'dev' not described in 'devm_regulator_register'
 drivers/regulator/devres.c:226: warning: Function parameter or member 'dev' not described in 'devm_regulator_unregister'
 drivers/regulator/devres.c:226: warning: Function parameter or member 'rdev' not described in 'devm_regulator_unregister'
 drivers/regulator/devres.c:226: warning: Excess function parameter 'regulator' description in 'devm_regulator_unregister'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/devres.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 3ea1c170f8402..3f73ce8590007 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -173,6 +173,7 @@ static void devm_rdev_release(struct device *dev, void *res)
 
 /**
  * devm_regulator_register - Resource managed regulator_register()
+ * @dev:  device to supply
  * @regulator_desc: regulator to register
  * @config: runtime configuration for regulator
  *
@@ -216,7 +217,8 @@ static int devm_rdev_match(struct device *dev, void *res, void *data)
 
 /**
  * devm_regulator_unregister - Resource managed regulator_unregister()
- * @regulator: regulator to free
+ * @dev:  device to supply
+ * @rdev: regulator to free
  *
  * Unregister a regulator registered with devm_regulator_register().
  * Normally this function will not need to be called and the resource
-- 
2.25.1

