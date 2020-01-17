Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D6BC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09C42087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgAQOj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:39:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:57548 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbgAQOjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:39:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C868EAC4A;
        Fri, 17 Jan 2020 14:39:07 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org
Cc:     linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com,
        suzuki.poulose@arm.com, alexander.shishkin@linux.intel.com,
        Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH RFC 12/15] coresight: use IS_ENABLED macro for configuration symbols
Date:   Fri, 17 Jan 2020 15:40:07 +0100
Message-Id: <20200117144010.11149-13-ykaukab@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200117144010.11149-1-ykaukab@suse.de>
References: <20200117144010.11149-1-ykaukab@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare to change configuration symbols type from bool to
tristate in Kconfig.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 drivers/hwtracing/coresight/coresight-priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 9212bc8a20c8..714bee6590ff 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -153,7 +153,7 @@ struct list_head *coresight_build_path(struct coresight_device *csdev,
 				       struct coresight_device *sink);
 void coresight_release_path(struct list_head *path);
 
-#ifdef CONFIG_CORESIGHT_SOURCE_ETM3X
+#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)
 extern int etm_readl_cp14(u32 off, unsigned int *val);
 extern int etm_writel_cp14(u32 off, u32 val);
 #else
-- 
2.16.4

