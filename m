Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53022C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BFEA206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbgGOImZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:42:25 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:5411 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729475AbgGOImX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:42:23 -0400
From:   Peter Enderborg <peter.enderborg@sony.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Peter Enderborg <peter.enderborg@sony.com>
Subject: [PATCH 1/2] tracefs: Remove unnecessary debug_fs checks.
Date:   Wed, 15 Jul 2020 10:42:06 +0200
Message-ID: <20200715084207.7639-2-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715084207.7639-1-peter.enderborg@sony.com>
References: <20200617133738.6631-1-peter.enderborg@sony.com>
 <20200715084207.7639-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
X-SEG-SpamProfiler-Analysis: v=2.3 cv=CszBjUwD c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=_RQrkK6FrEwA:10 a=QyXUC8HyAAAA:8 a=z6gsHLkEAAAA:8 a=ag1SF4gXAAAA:8 a=meVymXHHAAAA:8 a=g-dhFznQ5d8k2vTQpKYA:9 a=d-OLMTCWyvARjPbQ-enb:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=2JgSa4NbpEOStq-L5dxp:22
X-SEG-SpamProfiler-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation for debugfs restricted mode.
We don't need debugfs to trace, the removed check stop tracefs to work
if debugfs is not initialised. We instead tries to automount within
debugfs and relay on it's handling. The code path is to create a
backward compatibility from when tracefs was part of debugfs, it is now
standalone and does not need debugfs. When debugfs is in restricted
it is compiled in but not active and return EPERM to clients and
tracefs wont work if it assumes it is active it is compiled in
kernel.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bb62269724d5..848f67a5f16d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8945,9 +8945,7 @@ struct dentry *tracing_init_dentry(void)
 	if (tr->dir)
 		return NULL;
 
-	if (WARN_ON(!tracefs_initialized()) ||
-		(IS_ENABLED(CONFIG_DEBUG_FS) &&
-		 WARN_ON(!debugfs_initialized())))
+	if (WARN_ON(!tracefs_initialized()))
 		return ERR_PTR(-ENODEV);
 
 	/*
-- 
2.17.1

