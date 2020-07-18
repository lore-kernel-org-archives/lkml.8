Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CE1C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 504BC2065E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WK4t+VZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgGRJUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 05:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgGRJUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 05:20:38 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13F5C0619D2;
        Sat, 18 Jul 2020 02:20:38 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cv18so4738854pjb.1;
        Sat, 18 Jul 2020 02:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o09yAv6DGamGaLfCecq9vHf5FNi8bhrG0BGxeRszaDs=;
        b=WK4t+VZYA/s/PJCSDuB64W5TgPkysfZ118jsgNhbs/uLYuaw/jaPR0FPMmEUEV1Cm0
         RkImogV35WsKx3gSejqjLonxKtBxhZYWkM+/twm+W8a3JP2qq6Nc5gT430myXHeSqeHf
         PvrQZFUmxnbbuaRbqsA3pT+3jEYBUmc8siw1ycBjV/KSkz4cbny+/n/57TR+lfZJY7mH
         Wd2yqRkm8PMNcfTBLgRKinKT+hJWHZ5JCxZaRhnMoLQAaPSbBa0OSZnYAqnCEpZxmAxW
         geOMD12f2AfSqFEYgn3+/QByYJcWGZ8jUGprO9p3IdtD/4KHsW9wZF7l9Z/Opd6oyZzK
         6/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o09yAv6DGamGaLfCecq9vHf5FNi8bhrG0BGxeRszaDs=;
        b=jKjzM4QAr00XmmeTamGIMCOwwpHjfESRUWvKiNJiQdozm5+NBq2yaO5c6VZ4aZAeB4
         3J8WNkeEq193yG97yrzOjniEg9N4SM1bqTzMW7T+ZohqyQx7L1WQLrByTrjK2gBAA80t
         kdmKb53Xsy9wld+MWrD9L5fHVU1XWsJX94pQW3qRwiHnzAYEcOW7RqjLZABBWsfb08wI
         JWUAyzb9LFcLRsDLeYADDDkldk3QuF15ZCb5bQYYRfLFSWF6JJHRjrGj9BqtJgaiNn7y
         QJb8/JqmgAlMOPOYVDmPC94FR737pavdKzAWnh81AOOLXH1HlGOLr++tQBsy7SMsi2qp
         QC2A==
X-Gm-Message-State: AOAM530cfCnit+U+Ngw7Yz66mBWIAIu8v1ZZb5c8H1cYDprHsCCcU2Ea
        jkc3w9md38XSaZ+UmE6PC04=
X-Google-Smtp-Source: ABdhPJxHZREFEienqrTnze3kAwYqdAn0t+Ay4f37mE6l3zXJ3uks4pYJXW6rThhYrfX4DdbMCZly1w==
X-Received: by 2002:a17:902:7790:: with SMTP id o16mr9943628pll.299.1595064038360;
        Sat, 18 Jul 2020 02:20:38 -0700 (PDT)
Received: from localhost.localdomain ([182.69.248.222])
        by smtp.gmail.com with ESMTPSA id nl5sm5217800pjb.36.2020.07.18.02.20.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jul 2020 02:20:37 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v6 07/10] dt-bindings: reset: s700: Add binding constants for mmc
Date:   Sat, 18 Jul 2020 14:49:31 +0530
Message-Id: <1595063974-24228-8-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595063974-24228-1-git-send-email-amittomer25@gmail.com>
References: <1595063974-24228-1-git-send-email-amittomer25@gmail.com>
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

