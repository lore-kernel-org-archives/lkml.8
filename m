Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B4AC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 05:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4BF82087C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 05:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKc+xw85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgIKF3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 01:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgIKF3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 01:29:22 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDA1C061573;
        Thu, 10 Sep 2020 22:29:21 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b124so6362882pfg.13;
        Thu, 10 Sep 2020 22:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nEbCHjkuXDoaKqNoX/pXlsfKXaRlHFlOyuXXdN/SzCI=;
        b=lKc+xw85RcLBvm2/ZaKuYeC65po2Xt0YQbb4ZB36YBjFLJjHspmkZZajFsJCGRcPZN
         3dvApPREI1wB+qQg1teHxobughKwzKyTDlJQSkWhhdxxpkoQ+S3+nciFMOGfaeVQfB2S
         ruau7PPJqGHi1EUMbQAKCodHFROfTVQOca377ff8YEWI8j6R2RZt3w2xtMzzazJUusSp
         v+x173CQy65Jx05hzHH5YPLrXzHbx7P6ftGEqRW7SY3mSJrNr9vyvfeakc1PlFpGEEmS
         bc27vNhD31+OulClzuloIBRFgYuO8zKG7jz3FuGInhEX+xAWeiBS9Kr6E++bx1LJHls4
         3Vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nEbCHjkuXDoaKqNoX/pXlsfKXaRlHFlOyuXXdN/SzCI=;
        b=X9rfsbZuWK8Idlq7HY2KFbidOftBm/0vIS/2N4p5rjja32ErHXix56/1TxmiINxpJy
         /Fd4hhIkWn5EvBhLjgs3MSJsuONTDp8UcmllGdwiih4yNw2qirkBasW6RN2Wz5YdzVYR
         MGQOeieV3fpt/NjAfpmZUuiJ2VB8D4BiCkzCxyCWjRwVT9tk/BfKeaDzehhPx1K2MmDg
         dk+AnP+JW6cQMqRH9qrYIh8XpETo08ZSsGc0RBmYGkpcV7ovS8gXWNg36wkGiQHP+7Nn
         8py/5qH/wenfKufsWUYpdHc3NuSBAb9j8izxg/JS61OkZr01a3fgpy55NdVz/xFgTqoP
         n2Hg==
X-Gm-Message-State: AOAM530y8ikYLjTnqHF1a4PyrjJ19HwoQ65iUzi/7gTm3TlHAmL1huim
        DK02TkSoSWFou2muMvN8x7s=
X-Google-Smtp-Source: ABdhPJw0Wg3eGqLQBMxPGJzytWU5P+ToitVN5KcJapUH7pluNPG/KbdHWGygBNRKbHuR+c53fI2S7w==
X-Received: by 2002:a17:902:6bc1:b029:d0:cbe1:e73d with SMTP id m1-20020a1709026bc1b02900d0cbe1e73dmr708425plt.24.1599802160511;
        Thu, 10 Sep 2020 22:29:20 -0700 (PDT)
Received: from amit-ThinkPad-X230.domain.name ([106.215.94.244])
        by smtp.gmail.com with ESMTPSA id q4sm863298pfs.193.2020.09.10.22.29.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2020 22:29:19 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     sboyd@kernel.org, cristian.ciocaltea@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v7 07/10] dt-bindings: reset: s700: Add binding constants for mmc
Date:   Fri, 11 Sep 2020 10:59:03 +0530
Message-Id: <1599802143-6218-1-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595180527-11320-8-git-send-email-amittomer25@gmail.com>
References: <1595180527-11320-8-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds device tree binding reset constants for mmc controller
present on Actions S700 Soc.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v6:
	* No change.
Changes since v5:
        * Added Mani's Reviewed-by: tag.
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

