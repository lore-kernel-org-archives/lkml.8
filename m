Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB656C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8CB206F8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404040AbgDCRKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:10:32 -0400
Received: from foss.arm.com ([217.140.110.172]:55506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbgDCRKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:10:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A21A11045;
        Fri,  3 Apr 2020 10:10:30 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0C6DD3F71E;
        Fri,  3 Apr 2020 10:10:29 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] firmware: arm_scpi: Add include guard to linux/scpi_protocol.h
Date:   Fri,  3 Apr 2020 18:10:18 +0100
Message-Id: <20200403171018.1230-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200403171018.1230-1-sudeep.holla@arm.com>
References: <20200403171018.1230-1-sudeep.holla@arm.com>
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
This is based on the similar change in linux/scmi_protocol.h

        error: conflicting types for ‘...’
        note: previous declaration of ‘...’ was here
        error: redefinition of ‘...’

Add a header include guard just in case.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 include/linux/scpi_protocol.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/scpi_protocol.h b/include/linux/scpi_protocol.h
index ecb004711acf..afbf8037d8db 100644
--- a/include/linux/scpi_protocol.h
+++ b/include/linux/scpi_protocol.h
@@ -4,6 +4,10 @@
  *
  * Copyright (C) 2014 ARM Ltd.
  */
+
+#ifndef _LINUX_SCPI_PROTOCOL_H
+#define _LINUX_SCPI_PROTOCOL_H
+
 #include <linux/types.h>
 
 struct scpi_opp {
@@ -71,3 +75,5 @@ struct scpi_ops *get_scpi_ops(void);
 #else
 static inline struct scpi_ops *get_scpi_ops(void) { return NULL; }
 #endif
+
+#endif /* _LINUX_SCPI_PROTOCOL_H */
-- 
2.17.1

