Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D882CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAAD520771
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uHSLzt1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgGBOxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbgGBOxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:53:50 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD039C08C5C1;
        Thu,  2 Jul 2020 07:53:50 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p1so2141473pls.4;
        Thu, 02 Jul 2020 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bmzt/AsSOhq3HKUhRuMThjgeLot59mOrnHpndVV8f7g=;
        b=uHSLzt1Hjszo/5CVYAIJYoXAcudAbL2P9I8+1xbtIdj2MCAZvzkN+ihiXgn/2p0DwN
         fCygS/05OAx/ZXIxXNuuR9G42kyjJPjG54Un/KApxhInty7YL46I7jaRM/FoSwFY2VtI
         jVXode+f4ZkUBDbpiERX8Ygj/0v6PtxUiKpYXghdiz3brZ6BcBhNkFOB+IReA+Cluud3
         kh8fQk+ilV4X64ipm9ArNSQefd8x1EZlkxG/h3dApdJn9zCj6cgNyinc5A2z3genVNx/
         o2HxBiMAtLHXcGfRDnns2ZrghhZdFGXu0Hr94kefuOPkhrT4OnK761Uarw4JAYGXNJMm
         yhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bmzt/AsSOhq3HKUhRuMThjgeLot59mOrnHpndVV8f7g=;
        b=PZuEP5MmjgE26DBTqRRVBS4cxW4ScJi3pK5s0arMBXWJewghei66uRjZLqqAdfU8em
         KcqNDzp3gZ5wo4AjAXHyviGrZLElw1Yx5SGJxBf8BYL4FN6LgLGyN1rpuySfaTemvJoA
         eDfLGF2+fytF9M88n0RhCz9x79lxjQUOV7tfpFpnuS0czPfOuYAXSFa/x8Efar9fwKsj
         BKPtY+5leB6go0PWFucMT7dF4YdXXvhnFKY2pBtHbMRZzRTRjUWlk72stT5tCv20vS6x
         tA4MAJhPbpMvS9tNNh3LmLQPcyOCfiUl8bzYMC1SySQWn48ZiKtyHd0gROtdrc5WdXov
         +IZw==
X-Gm-Message-State: AOAM530/HcYkbtURPShxiHv0MyA0OdVvOZefJFuMk0/kCVxpJKyimEfM
        F4RU4HJxfUR/baRFYFgo4K+HSLqElFVKrg==
X-Google-Smtp-Source: ABdhPJxckODXNqFIFNAuwlM5ZXzYzJvKVfejAASEHXqtCqC2ZJNV/Asfyn44HZVR80jLiL1Q/kbUEA==
X-Received: by 2002:a17:90a:1a83:: with SMTP id p3mr17159776pjp.113.1593701630276;
        Thu, 02 Jul 2020 07:53:50 -0700 (PDT)
Received: from localhost.localdomain ([223.190.0.253])
        by smtp.gmail.com with ESMTPSA id 204sm9487891pfc.18.2020.07.02.07.53.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 07:53:49 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v5 07/10] dt-bindings: reset: s700: Add binding constants for mmc
Date:   Thu,  2 Jul 2020 20:22:53 +0530
Message-Id: <1593701576-28580-8-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds device tree binding reset constants for mmc controller
present on Actions S700 Soc.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v4:
	* No change.
Changes since v3:
        * No change.
Changes since v2:
        * No change.
Changes since v1:
        * No change.
Changes since RFC:
        * added Rob's acked-by tag
---
 include/dt-bindings/reset/actions,s700-reset.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/reset/actions,s700-reset.h b/include/dt-bindings/reset/actions,s700-reset.h
index 5e3b16b8ef53..a3118de6d7aa 100644
--- a/include/dt-bindings/reset/actions,s700-reset.h
+++ b/include/dt-bindings/reset/actions,s700-reset.h
@@ -30,5 +30,8 @@
 #define RESET_UART4				20
 #define RESET_UART5				21
 #define RESET_UART6				22
+#define RESET_SD0				23
+#define RESET_SD1				24
+#define RESET_SD2				25
 
 #endif /* __DT_BINDINGS_ACTIONS_S700_RESET_H */
-- 
2.7.4

