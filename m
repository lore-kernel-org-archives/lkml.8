Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A28C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A2B206F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403989AbgDCRKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:10:30 -0400
Received: from foss.arm.com ([217.140.110.172]:55502 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbgDCRKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:10:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDAC61FB;
        Fri,  3 Apr 2020 10:10:29 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3B8D83F71E;
        Fri,  3 Apr 2020 10:10:29 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] firmware: arm_scmi: Add include guard to linux/scmi_protocol.h
Date:   Fri,  3 Apr 2020 18:10:17 +0100
Message-Id: <20200403171018.1230-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If this header is include twice, it will generate loads of compile
time error with the following below error pattern. It was reported by
0day kbuild robot on a branch pushed with double inclusion by accident.

 	error: conflicting types for ‘...’
 	note: previous declaration of ‘...’ was here
	error: redefinition of ‘...’

Add a header include guard just in case.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 include/linux/scmi_protocol.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 5c873a59b387..ce2f5c28b2df 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -4,6 +4,10 @@
  *
  * Copyright (C) 2018 ARM Ltd.
  */
+
+#ifndef _LINUX_SCMI_PROTOCOL_H
+#define _LINUX_SCMI_PROTOCOL_H
+
 #include <linux/device.h>
 #include <linux/types.h>
 
@@ -319,3 +323,5 @@ static inline void scmi_driver_unregister(struct scmi_driver *driver) {}
 typedef int (*scmi_prot_init_fn_t)(struct scmi_handle *);
 int scmi_protocol_register(int protocol_id, scmi_prot_init_fn_t fn);
 void scmi_protocol_unregister(int protocol_id);
+
+#endif /* _LINUX_SCMI_PROTOCOL_H */
-- 
2.17.1

