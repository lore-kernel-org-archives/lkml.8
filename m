Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5F1C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7741B206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TzPt0pmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbgIJK2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730851AbgIJK1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:27:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21094C061756
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:27:51 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b124so4340130pfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LZQZwXwRu53YKSXrfkUA0WjeNn/V21ZhpJY2/Y12QvI=;
        b=TzPt0pmdNspzQOTFKvx730AMrhJJADm6SbOatLVVciImg0+7g406SmECpp/TEcMqRk
         286/u47cu3OOeQjZ7+aCD7K2ITZwnS4UZBphCBBO8VqHPC+2sdgt2jbpL5G3Gub1kWuI
         9+oDszZ9EoGdzvisVMzMJPCPtuDYCqH3/GCiM62RQeEJ10KS1+Y+xCjkFR6M/WadeY9K
         C/QDyORxqjQN5FX5TLy4T7XMzAZTj9AGV6avnS+GY+ksFyO9AY3OmtdXb2BTGGQrCjkG
         ll3Cykr20wvPpmBg50/kGoK1zTizaFIWM2Q1FTnjyqpDm98rncC6qZIkvMW9w+D8hRPJ
         f+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LZQZwXwRu53YKSXrfkUA0WjeNn/V21ZhpJY2/Y12QvI=;
        b=ZbdKRdv9lNQJKYVu9wFs+FYihwQet9jXKQdHWYiajTdx6aY3MlU8Ze/uQNTERFczNE
         9JBG3AwEAAovfMb20nBVjUlXftE5fhy4wX6mftyMZuJUN5tsLDY3EtfyZBqmoFfQDSmy
         vqXs3UlreVXIHV/2S3y+EgQtxcOqKQdR7YpZrcPk0dY15VPUEcU1RsFL8N2xiYbQ6h5C
         v+VDQ3P9wgq3oNZChU+BzftQQ03akDtBvF1bUbacNvLh670oRGT1TgLVM2KGG2HQKLQD
         qPFd2KpwgFI926UTSoJflv+043a4GBvAHhVBbSRVkvWVz1J8iUgoJf6MFTMkYErebQn7
         RAGQ==
X-Gm-Message-State: AOAM530hTnS86g48pSRbwzYXdrPzHU+wk69zfaqszZaotZN4Bki/4vRx
        Er9+EuTCNkafu8rkG6pLaPEocHW777fqyw==
X-Google-Smtp-Source: ABdhPJwo5Opm062PHIrhNSfRQH8EwatTMoUC2rcPFPzEY+vMvxlwb0kB1iL/Zh9vB25/UPh/cJpcBQ==
X-Received: by 2002:a62:52c8:0:b029:13e:d13d:a10b with SMTP id g191-20020a6252c80000b029013ed13da10bmr4696466pfb.39.1599733669949;
        Thu, 10 Sep 2020 03:27:49 -0700 (PDT)
Received: from localhost ([103.208.69.30])
        by smtp.gmail.com with ESMTPSA id m14sm5392656pfo.202.2020.09.10.03.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 03:27:48 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
X-Google-Original-From: Amit Kucheria <amitk@kernel.org>
To:     linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] powercap: make documentation reflect code
Date:   Thu, 10 Sep 2020 15:57:46 +0530
Message-Id: <e40a76dbc4d17d0bc80daf95e259fcd6cc6d48e2.1599733531.git.amitk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up documentation of the struct members to reflect reality. Also
fixup a stray whitespace.

Signed-off-by: Amit Kucheria <amitk@kernel.org>
---
 include/linux/powercap.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/powercap.h b/include/linux/powercap.h
index 4537f57f9e42f..3d557bbcd2c71 100644
--- a/include/linux/powercap.h
+++ b/include/linux/powercap.h
@@ -44,19 +44,18 @@ struct powercap_control_type_ops {
 };
 
 /**
- * struct powercap_control_type- Defines a powercap control_type
- * @name:		name of control_type
+ * struct powercap_control_type - Defines a powercap control_type
  * @dev:		device for this control_type
  * @idr:		idr to have unique id for its child
- * @root_node:		Root holding power zones for this control_type
+ * @nr_zones:		counter for number of zones of this type
  * @ops:		Pointer to callback struct
- * @node_lock:		mutex for control type
+ * @lock:		mutex for control type
  * @allocated:		This is possible that client owns the memory
  *			used by this structure. In this case
  *			this flag is set to false by framework to
  *			prevent deallocation during release process.
  *			Otherwise this flag is set to true.
- * @ctrl_inst:		link to the control_type list
+ * @node:		linked-list node
  *
  * Defines powercap control_type. This acts as a container for power
  * zones, which use same method to control power. E.g. RAPL, RAPL-PCI etc.
@@ -129,7 +128,7 @@ struct powercap_zone_ops {
  *			this flag is set to false by framework to
  *			prevent deallocation during release process.
  *			Otherwise this flag is set to true.
- * @constraint_ptr:	List of constraints for this zone.
+ * @constraints:	List of constraints for this zone.
  *
  * This defines a power zone instance. The fields of this structure are
  * private, and should not be used by client drivers.
-- 
2.25.1

