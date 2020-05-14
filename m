Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6AAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 311AC205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PpVJWvwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgENGld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 02:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbgENGlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 02:41:31 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8369DC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 23:41:31 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so799189pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 23:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gk+N3LutZMyHgr08P1PZQX76ikfahgQaVgvg9g2G9nU=;
        b=PpVJWvwQPxce5dVGvG5hizL3Rc9U9oMwao2rh5kLORY4zJSBDQk/MePiBaSnFQn5ep
         y6ns9BoPf/cQVMfY77+G2KvuclN9Nna+3rnEFCHCmq63FmXRDnWrG2zbIvwhlRTVnsPo
         Kjy/pDEHsn4mP4rZwO5GJMijW8T/B4Kd8odVxWxmlt9Gj5Y8/PaYMW7xhYCGT5CGexdJ
         W27POU8ForZUXeRpfKjqzgpYn5JRBjRIi+i4C65JjrC9b5oXwqcryl+eK+6TaXVzsmi6
         1CD0o5Y28004meh+9hTnCJGRLQ9DGwtwF7EhTCOhzsvZnmaKqAf47yNFmE0WfichDisv
         WvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gk+N3LutZMyHgr08P1PZQX76ikfahgQaVgvg9g2G9nU=;
        b=PCz8B9ZFnIw7ycDGxygZzO8dNUh7m+U5YhQzuWhiWb7UsoTuUwE3cqnw9Cj3tV7anI
         PjjlJl+3aEA0umiRvk4pRlLUYFPbLqY5SR93AaEGudSf9XP/GBEAaDzyisRtx7GRDPVm
         TUKCfwgiTDZH99usrzKyBGp/ElWW4BNIYRD1k+t955VOg0QkXSFQmqAP+xT3FwVa95ax
         iRAnBqiJnI016xdvn3S6jnTPSnjAe4B0C+lTHrpRDT5srtZMu3LGfI/VJ/SsbnavlTUL
         F3J/x47FL0cgljl2016aEgkUm7xooSXXLyBY/0VkZa0NQa2VH2AKw+wr1OjvMBr6J//E
         m1LA==
X-Gm-Message-State: AOAM532noWGpcxWK+EDkkkQjc0WPUb0avaUWWbjX/6vw2U3sRD5ZObbi
        IOqTafaSJz0rGoKtm/vtCgJRfVh7bGs=
X-Google-Smtp-Source: ABdhPJw3+P36PXleQ9B4OdKjfE9KdvFKTv1RVRurbpqRfCTR6zS+inu1p52jnemBxmbdnWUTcz/kqg==
X-Received: by 2002:a17:902:b78c:: with SMTP id e12mr2849628pls.88.1589438490429;
        Wed, 13 May 2020 23:41:30 -0700 (PDT)
Received: from localhost ([45.127.44.21])
        by smtp.gmail.com with ESMTPSA id d8sm1335956pgb.42.2020.05.13.23.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 23:41:29 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, Andy Gross <agross@kernel.org>,
        Elliot Berman <eberman@codeaurora.org>
Subject: [PATCH] firmware: qcom_scm: Prefer initialisation during the descriptor declaration
Date:   Thu, 14 May 2020 12:10:57 +0530
Message-Id: <9dac309d985931a02b198714a5ae64fdce8c47ff.1589438283.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcom_scm_iommu_secure_ptbl_init() initialises the args twice, once while
declaring the struct, and then again by assignment. Remove the duplicate
assignment.

Similarly, move arginfo initialisation to the declaration in
__qcom_scm_is_call_available for consistency with other .arginfo
initialisation in the file.

Fixes: 9a434cee773a ("firmware: qcom_scm: Dynamically support SMCCC and legacy conventions")
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/firmware/qcom_scm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 6ba132be1b6e..eae9c28679cc 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -228,10 +228,10 @@ static int __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
 		.svc = QCOM_SCM_SVC_INFO,
 		.cmd = QCOM_SCM_INFO_IS_CALL_AVAIL,
 		.owner = ARM_SMCCC_OWNER_SIP,
+		.arginfo = QCOM_SCM_ARGS(1),
 	};
 	struct qcom_scm_res res;
 
-	desc.arginfo = QCOM_SCM_ARGS(1);
 	switch (__get_convention()) {
 	case SMC_CONVENTION_ARM_32:
 	case SMC_CONVENTION_ARM_64:
@@ -742,12 +742,6 @@ int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare)
 	};
 	int ret;
 
-	desc.args[0] = addr;
-	desc.args[1] = size;
-	desc.args[2] = spare;
-	desc.arginfo = QCOM_SCM_ARGS(3, QCOM_SCM_RW, QCOM_SCM_VAL,
-				     QCOM_SCM_VAL);
-
 	ret = qcom_scm_call(__scm->dev, &desc, NULL);
 
 	/* the pg table has been initialized already, ignore the error */
-- 
2.20.1

