Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A2BC433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B2322224
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgGNMCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:02:46 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:52617 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728121AbgGNMCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:02:18 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@mellanox.com)
        with SMTP; 14 Jul 2020 15:02:14 +0300
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 06EC25dj004353;
        Tue, 14 Jul 2020 15:02:14 +0300
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v2 06/11] platform_data/mlxreg: Add support for complex attributes
Date:   Tue, 14 Jul 2020 15:01:58 +0300
Message-Id: <20200714120203.10352-7-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200714120203.10352-1-vadimp@mellanox.com>
References: <20200714120203.10352-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new field 'regnum' to the structure 'mlxreg_core_data' to specify
the number of registers occupied by multi-register attribute.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 include/linux/platform_data/mlxreg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/platform_data/mlxreg.h b/include/linux/platform_data/mlxreg.h
index b8da8aef2446..a2adc3ad45f2 100644
--- a/include/linux/platform_data/mlxreg.h
+++ b/include/linux/platform_data/mlxreg.h
@@ -80,6 +80,7 @@ struct mlxreg_hotplug_device {
  * @hpdev - hotplug device data;
  * @health_cntr: dynamic device health indication counter;
  * @attached: true if device has been attached after good health indication;
+ * @regnum: number of registers occupied by multi-register attribute;
  */
 struct mlxreg_core_data {
 	char label[MLXREG_CORE_LABEL_MAX_SIZE];
@@ -92,6 +93,7 @@ struct mlxreg_core_data {
 	struct mlxreg_hotplug_device hpdev;
 	u8 health_cntr;
 	bool attached;
+	u8 regnum;
 };
 
 /**
-- 
2.11.0

