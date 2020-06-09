Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEA9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E82612081A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzkKWAcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgFIKSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbgFIKSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:18:07 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51001C05BD1E;
        Tue,  9 Jun 2020 03:18:07 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id m2so1210746pjv.2;
        Tue, 09 Jun 2020 03:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rwQBB3SQ45lNIAYQMElQim+hOPVHVp+Rp81J6MgbD0I=;
        b=BzkKWAcSP/q6sOnyq4AwirGqrIlB35JDTGq1wsCd3o9BKNuhKxNNsXIaceQA/AfuOR
         pbcgLOFMaxWDhWYHbP+etR4jTp419US6hhblVzcrns758do6cFzq8O17z3nydFfky2yt
         wZsL/RPm0A6ylUaCPLsp1U2flzilN5ROrpGu3HUFBRk+EHWN1fOMeTfwBxjpXVbuyd/R
         3EEzZZ5nK6A0xAdTL2q0/vfEluRc0MtUJCauodAxA/y+dVL2T3NxapKyJULhyLAZ6BDE
         6U+SGjKjKkWeP9dObhKGsg9wbaZICGrUYmACmp+XE+kbUFdSOjl7W6fCKW4gH4VBahNy
         IGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rwQBB3SQ45lNIAYQMElQim+hOPVHVp+Rp81J6MgbD0I=;
        b=NKZgiYXMz6jmZis5SshThVaMjIW0dVihwHe193uU2yQBeDp1vQQlDDvhGUdp0QJowQ
         LGENd9FyPDxDjPeePGcnzSla0+PhA50q/bNwZMTb5Z0PBGZCQW2W/LklY9pyOIa1WCTU
         JH9QorglSK5qVezGN1vkIQ4FMa82jRnkPb/0qj1SHGZIXbDNarYW2fZUbQsQLE9PNb/d
         erq0916Th64nGWzSgaRiSM906kScN1RGi+zf+OABHkJ2TI3X3/uHPJ4OijrkP9aQeWj9
         ms04ldHbmGvR7jLbq9Iw9s0B3teblNu8GwUBiSnXuduZcGqSVy8fLttBupRBYE7ufHUU
         B+8g==
X-Gm-Message-State: AOAM53265r2n8EeHrSGHU+THBp+WfATbX2z0qoJpgH55DDvAySx9LA49
        urQLD6pE0z3nP5OL1K9Bb1o=
X-Google-Smtp-Source: ABdhPJyp+Ff7aKSbdfsIg9q+VMKOm3dyndijjSBn2liztrRerMuSn+XqLSxlfR+E2UiBJqxwg+TYDA==
X-Received: by 2002:a17:902:bf48:: with SMTP id u8mr2540416pls.15.1591697886808;
        Tue, 09 Jun 2020 03:18:06 -0700 (PDT)
Received: from localhost.localdomain ([223.190.87.90])
        by smtp.gmail.com with ESMTPSA id d189sm9637253pfc.51.2020.06.09.03.18.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 03:18:06 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 07/10] dt-bindings: reset: s700: Add binding constants for mmc
Date:   Tue,  9 Jun 2020 15:47:07 +0530
Message-Id: <1591697830-16311-8-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
References: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds device tree binding reset constants for mmc controller
present on Actions S700 Soc.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
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

