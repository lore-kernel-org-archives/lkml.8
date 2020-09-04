Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE024C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5FB12073B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRnez5fn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbgIDNBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgIDNAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:00:07 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5539BC061244;
        Fri,  4 Sep 2020 06:00:07 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c10so5998765edk.6;
        Fri, 04 Sep 2020 06:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eoJIkDtT5yIdSXOyl7ZSN/ybf/6ZO2PtqfzMV2ShYXs=;
        b=VRnez5fnDdx4YUTxOQcGHIgidGmKBkEm+asD3J7ZNJR0U26yYQNito/FHsTVC9QD2G
         TgWilTQTk6y65Pl3jvfV4kCh0JVkQI31zt1OAWkm8sLSOuarYbuGbHJC6D6oVSmAewgL
         g3OHoNtWlAF1SNGok1YGYsjQ+oMxxkFaGZxrfDImowRjeeE8IFhSxATxJGLaQbCZqfP2
         HhFmFH2qxDy8cE6xtXfRevpSQY0Z+jikSIIyNsZweyH1Onsyijgmp6EnUxl7VJR1Ot7/
         UPitx57LX3xiP8znCQItX5MnrMHaL6oZauMvAH5WWAXcpN49HgYFTThYPCYW+aCiaAi6
         S3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eoJIkDtT5yIdSXOyl7ZSN/ybf/6ZO2PtqfzMV2ShYXs=;
        b=JuhMq3/NgXO3D8Vu6/dva8CFNBcb6YqjDlKSUon/Eumnkgf8RiITAeUlgB0lg6H40z
         SubTksnq9CLhD3UKX72lfc4zeO4b96KMV4Ln/5SBs/cJ+0Ysmpvx+J+H0eiMlxn0ni8n
         2Sf85vhaS39pq3YkAMCGor8Qz+dnVT8petJ3Z8cAeqmG6eecFEvXL3TIY6fbZ6TggV+y
         mKIy6E28/3DrCLA9wMyMf5J/4+J3qjFnM+tgztgxg5cidOJkmesDbiMixbxKRMm+xcjG
         TOXjUZuLbk+diH0N2YyhSTnnUHuSP2qdhyuBRwayxpUd9UIOCEROZBiJJNoeZxA5mcmU
         JWkQ==
X-Gm-Message-State: AOAM530m+ufy3L+JvGlw7unfNo+vsV7KhMSfVJ82t7I7SEORE2C1UobH
        P4D+wABOGy5p6fR5pawk7Bs=
X-Google-Smtp-Source: ABdhPJyd3GfRiKMW3Hv1SXKOXdFm20VEy4aybXXN4EDdDImnvlQLArlBx5ZgWZXwJPMnMy22iZIX8g==
X-Received: by 2002:a50:fe98:: with SMTP id d24mr2605949edt.223.1599224405833;
        Fri, 04 Sep 2020 06:00:05 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id w1sm5839816eds.18.2020.09.04.06.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 06:00:04 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: reserved-memory: Document "active" property
Date:   Fri,  4 Sep 2020 14:59:57 +0200
Message-Id: <20200904130000.691933-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Reserved memory regions can be marked as "active" if hardware is
expected to access the regions during boot and before the operating
system can take control. One example where this is useful is for the
operating system to infer whether the region needs to be identity-
mapped through an IOMMU.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/reserved-memory/reserved-memory.txt           | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
index 4dd20de6977f..163d2927e4fc 100644
--- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
@@ -63,6 +63,13 @@ reusable (optional) - empty property
       able to reclaim it back. Typically that means that the operating
       system can use that region to store volatile or cached data that
       can be otherwise regenerated or migrated elsewhere.
+active (optional) - empty property
+    - If this property is set for a reserved memory region, it indicates
+      that some piece of hardware may be actively accessing this region.
+      Should the operating system want to enable IOMMU protection for a
+      device, all active memory regions must have been identity-mapped
+      in order to ensure that non-quiescent hardware during boot can
+      continue to access the memory.
 
 Linux implementation note:
 - If a "linux,cma-default" property is present, then Linux will use the
-- 
2.28.0

