Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ED1C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F7D20578
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgGJNjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:39:51 -0400
Received: from foss.arm.com ([217.140.110.172]:47102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbgGJNjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:39:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0B211FB;
        Fri, 10 Jul 2020 06:39:50 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D38F03F8C6;
        Fri, 10 Jul 2020 06:39:49 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, arnd@arndb.de
Subject: [PATCH 1/3] firmware: arm_scmi: Remove zero-length array in SCMI Notifications
Date:   Fri, 10 Jul 2020 14:39:17 +0100
Message-Id: <20200710133919.39792-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Substitute zero-length array defined in scmi_base_error_report with
a flexible length array definition.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 include/linux/scmi_protocol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 46d98be92466..7d4348fb7330 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -421,7 +421,7 @@ struct scmi_base_error_report {
 	u32 agent_id;
 	bool fatal;
 	u16 cmd_count;
-	u64 reports[0];
+	u64 reports[];
 };
 
 #endif /* _LINUX_SCMI_PROTOCOL_H */
-- 
2.17.1

