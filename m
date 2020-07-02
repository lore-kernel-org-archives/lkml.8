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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39478C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16B25208B6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4wddxtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbgGBOx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729942AbgGBOxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:53:55 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00682C08C5C1;
        Thu,  2 Jul 2020 07:53:54 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b16so12622024pfi.13;
        Thu, 02 Jul 2020 07:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KFyeQfdSfeF/OnFMNlNDOOlcmfxLaj5OwuFJXU8uYJo=;
        b=Q4wddxtd7UZEebKb5xPxIoGXYfJOfbE6rOApsa/SLWF4V1snSiQmTb9cz0rL7yrE//
         +2G7Yyxk6p//49Vpr2ZxQri6X9Re2GTXS4URiGhppNp4Ne2NdvMnaXwUKKJD+sIrdJn8
         IamJWPdnjk83DXcBF4iGU/2X2GUqgYlTdGRlByqMborflkpEh+E7Zb5UUtzQ8g70tcHz
         wsKEFL+DLO+W92gGNmI/oLEe1eyunrYm2NroQSFQ2Be70/+PB3CuVzO6zcsNBAPaR1BT
         LNf0JY+VrUY0s/jJgpKXfNeOm6plEZCmuUAK7jNd2qxDkxnCstfadvE+Vzm8EzjIPBRH
         JdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KFyeQfdSfeF/OnFMNlNDOOlcmfxLaj5OwuFJXU8uYJo=;
        b=Q8euB9y0a22E2vXzYKwK2CUZUjIknlJ1fypPb+ElnoM2npG8W2cbAdZlPGbrdfdpup
         n4NDRdcwQNUhSzqD1LlJBr/QJHmWJoWDQCbWaLkMvJxiLzLaMVzp9mRMHUddLo+4Ymde
         TLfmCQuJ96t0YgjCnGga7J/O0xwIkS7plVymKTpmSDhV/s79oog7+cTQnuKazf6CjKGe
         A8WzES6IPnFgsrZGV5ZYMzV6lZZM85bgSwPHUnrOP6D12dmbuw6XOnwnr4H7RRVwg/cL
         iXUYyfAFo5G00qy1zC4MJBa8K0z5PzyPfEkqExKNMW97Z+LKMdBGSGfy0qTsgQCd8unD
         beBQ==
X-Gm-Message-State: AOAM532Yt0dwnJbPNraMavX4BSTFAqelaBwI6szFyWuLhrwAOKp/bFPn
        2ng9542moqGH8fGEKh6HdOM=
X-Google-Smtp-Source: ABdhPJwdC0Exa7dRYIZqQEXrMBCHE4dR99z+nKx4QS/phZ8VY9gtApIyOzT58Mc5ILLh+QgT4vzWBw==
X-Received: by 2002:a63:2c96:: with SMTP id s144mr24253837pgs.359.1593701634505;
        Thu, 02 Jul 2020 07:53:54 -0700 (PDT)
Received: from localhost.localdomain ([223.190.0.253])
        by smtp.gmail.com with ESMTPSA id 204sm9487891pfc.18.2020.07.02.07.53.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 07:53:53 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v5 08/10] dt-bindings: mmc: owl: add compatible string actions,s700-mmc
Date:   Thu,  2 Jul 2020 20:22:54 +0530
Message-Id: <1593701576-28580-9-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit adds a new SoC specific compatible string "actions,s700-mmc"
in combination with more generic string "actions,owl-mmc".

Placement order of these strings should abide by the principle of
"from most specific to most general".

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v4:
	* No change.
Changes since v3:
        * No change.
Changes since v2:
        * Added Rob's Reviewed-by tag
---
 Documentation/devicetree/bindings/mmc/owl-mmc.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
index 1380501fb8f0..5eab25ccf7ae 100644
--- a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
@@ -14,7 +14,11 @@ maintainers:
 
 properties:
   compatible:
-    const: actions,owl-mmc
+    oneOf:
+      - const: actions,owl-mmc
+      - items:
+          - const: actions,s700-mmc
+          - const: actions,owl-mmc
 
   reg:
     maxItems: 1
-- 
2.7.4

