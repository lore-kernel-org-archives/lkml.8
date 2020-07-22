Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98645C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77E6220781
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732356AbgGVRVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:21:38 -0400
Received: from foss.arm.com ([217.140.110.172]:60002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731710AbgGVRVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:21:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83C9F1435;
        Wed, 22 Jul 2020 10:21:03 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9F4413F66F;
        Wed, 22 Jul 2020 10:21:02 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RFC PATCH 07/14] coresight: etm4x: Always read the registers on the host CPU
Date:   Wed, 22 Jul 2020 18:20:33 +0100
Message-Id: <20200722172040.1299289-8-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200722172040.1299289-1-suzuki.poulose@arm.com>
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are about to add support for sysreg access to ETM4.4+ components,
make sure that we read the registers only on the host CPU.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-etm4x-sysfs.c         | 23 ++++++++-----------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index b673e738bc9a..90c75ba31a0c 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2341,23 +2341,20 @@ static u32 etmv4_cross_read(const struct device *dev, u32 offset)
 	return reg.data;
 }
 
-#define coresight_etm4x_reg(name, offset)			\
-	coresight_simple_reg32(struct etmv4_drvdata, name, offset)
-
 #define coresight_etm4x_cross_read(name, offset)			\
 	coresight_simple_func(struct etmv4_drvdata, etmv4_cross_read,	\
 			      name, offset)
 
-coresight_etm4x_reg(trcpdcr, TRCPDCR);
-coresight_etm4x_reg(trcpdsr, TRCPDSR);
-coresight_etm4x_reg(trclsr, TRCLSR);
-coresight_etm4x_reg(trcauthstatus, TRCAUTHSTATUS);
-coresight_etm4x_reg(trcdevid, TRCDEVID);
-coresight_etm4x_reg(trcdevtype, TRCDEVTYPE);
-coresight_etm4x_reg(trcpidr0, TRCPIDR0);
-coresight_etm4x_reg(trcpidr1, TRCPIDR1);
-coresight_etm4x_reg(trcpidr2, TRCPIDR2);
-coresight_etm4x_reg(trcpidr3, TRCPIDR3);
+coresight_etm4x_cross_read(trcpdcr, TRCPDCR);
+coresight_etm4x_cross_read(trcpdsr, TRCPDSR);
+coresight_etm4x_cross_read(trclsr, TRCLSR);
+coresight_etm4x_cross_read(trcauthstatus, TRCAUTHSTATUS);
+coresight_etm4x_cross_read(trcdevid, TRCDEVID);
+coresight_etm4x_cross_read(trcdevtype, TRCDEVTYPE);
+coresight_etm4x_cross_read(trcpidr0, TRCPIDR0);
+coresight_etm4x_cross_read(trcpidr1, TRCPIDR1);
+coresight_etm4x_cross_read(trcpidr2, TRCPIDR2);
+coresight_etm4x_cross_read(trcpidr3, TRCPIDR3);
 coresight_etm4x_cross_read(trcoslsr, TRCOSLSR);
 coresight_etm4x_cross_read(trcconfig, TRCCONFIGR);
 coresight_etm4x_cross_read(trctraceid, TRCTRACEIDR);
-- 
2.24.1

