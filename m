Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203CFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F09EA207CD
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDZcQosI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgHXSmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgHXSmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:42:32 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC70C061573;
        Mon, 24 Aug 2020 11:42:32 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v15so4987855pgh.6;
        Mon, 24 Aug 2020 11:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8jrJbdIXQQAFjo/ry7i+txJOnZIwex0ahQyZ/9frdio=;
        b=vDZcQosIOwttT+7YVD0YcJH63i/4ANBtWVWvB3iylHAaQulSk6Zt7LO0aYaQGeR8La
         Nf8A20AmUnyBL5dyL5YvhbxVitCshAaCyxzgTjfew1FhVN8rwvRSHF+nw1IRTCT+HJEy
         LgfiPuvEKOs/thV8w202+qBEZDCU+r1Zl8SLot+h3dwwLhotl/DUgl81PJRW1yM79dcZ
         9QGffNgb65T+Rovp82CSbUGQINp+vpJ8/XXTWUFo6wLY6s7ajEGZZXyDUVmzzrVB1BeB
         DA6m6erABwDeEATCGThEYV5o1xN7WllNV2le6drxEfsYY72ehk5qdU1vkRSxeuJJeZFW
         XY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8jrJbdIXQQAFjo/ry7i+txJOnZIwex0ahQyZ/9frdio=;
        b=NzdVbx+GF2RlSAWZxmMuUHsyJGX0cbTMrk2tkfHw4ZylOU/IfAVknDyMlNpeePvz8q
         K3it9VMYYaHd18kYcTTahCmmCtx8iWrnH0ShLQkFI4bvTX8kLAnSOKxtuw4GiXv19Asc
         187h3XY9SJKhQ+gS/CZSnuYcJpDyx0pgvqBSPm2O8ooVrM0tuZb5dlcCbyuoI9HEiRkl
         lwSLzFwG+a+VzdnWZpIWt7iSSpGvc+tq8f5IxsW0uaykil5aYe3UqGx/nK7nXAUjqDm8
         pwE2MdHVOS0mbJJxojhL3SpglCA88Ek6smJ5+t0A7h9O2h8tqo7QsBXy88uQwi80mRZm
         kAGQ==
X-Gm-Message-State: AOAM530La9GwL8zf323mcH623tcB1o450HIlNXKm808QJVQXBJDY//QH
        iHBeh8t6SNUytkmIlIqllxA=
X-Google-Smtp-Source: ABdhPJz3GfCDsrY2e8D8NgnMkrpU5oev72R67ENvd+ltLeKwaHWMDwrcr34kf5ZWRUkLqlnrTXmo9w==
X-Received: by 2002:a63:ca4e:: with SMTP id o14mr4352543pgi.213.1598294551624;
        Mon, 24 Aug 2020 11:42:31 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id il13sm251907pjb.0.2020.08.24.11.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 11:42:30 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Will Deacon <will@kernel.org>, freedreno@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Brian Masney <masneyb@onstation.org>,
        Eric Anholt <eric@anholt.net>, Joerg Roedel <jroedel@suse.de>,
        John Stultz <john.stultz@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 10/20] dt-bindings: arm-smmu: Add compatible string for Adreno GPU SMMU
Date:   Mon, 24 Aug 2020 11:37:44 -0700
Message-Id: <20200824183825.1778810-11-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824183825.1778810-1-robdclark@gmail.com>
References: <20200824183825.1778810-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jordan Crouse <jcrouse@codeaurora.org>

Every Qcom Adreno GPU has an embedded SMMU for its own use. These
devices depend on unique features such as split pagetables,
different stall/halt requirements and other settings. Identify them
with a compatible string so that they can be identified in the
arm-smmu implementation specific code.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 503160a7b9a0..3b63f2ae24db 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -28,8 +28,6 @@ properties:
           - enum:
               - qcom,msm8996-smmu-v2
               - qcom,msm8998-smmu-v2
-              - qcom,sc7180-smmu-v2
-              - qcom,sdm845-smmu-v2
           - const: qcom,smmu-v2
 
       - description: Qcom SoCs implementing "arm,mmu-500"
@@ -40,6 +38,13 @@ properties:
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
           - const: arm,mmu-500
+      - description: Qcom Adreno GPUs implementing "arm,smmu-v2"
+        items:
+          - enum:
+              - qcom,sc7180-smmu-v2
+              - qcom,sdm845-smmu-v2
+          - const: qcom,adreno-smmu
+          - const: qcom,smmu-v2
       - description: Marvell SoCs implementing "arm,mmu-500"
         items:
           - const: marvell,ap806-smmu-500
-- 
2.26.2

