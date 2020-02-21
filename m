Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A96C35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F272073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgBUXQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 18:16:11 -0500
Received: from mga11.intel.com ([192.55.52.93]:45531 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgBUXQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:16:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 15:16:10 -0800
X-IronPort-AV: E=Sophos;i="5.70,470,1574150400"; 
   d="scan'208";a="236718090"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 15:16:09 -0800
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roman Gushchin <guro@fb.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [RESEND PATCH] percpu_ref: Fix comment regarding percpu_ref_init flags
Date:   Fri, 21 Feb 2020 15:16:07 -0800
Message-Id: <20200221231607.12782-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The comment for percpu_ref_init() implies that using
PERCPU_REF_ALLOW_REINIT will cause the refcount to start at 0.  But
this is not true.  PERCPU_REF_ALLOW_REINIT starts the count at 1 as
if the flags were zero.  Add this fact to the kernel doc comment.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
RESEND:
	Add more people on the CC list to see if I'm wrong here.
	https://lore.kernel.org/lkml/20200206042810.GA29917@iweiny-DESK2.sc.intel.com/
---

 lib/percpu-refcount.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index 4f6c6ebbbbde..48d7fcff70b6 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -50,9 +50,9 @@ static unsigned long __percpu *percpu_count_ptr(struct percpu_ref *ref)
  * @flags: PERCPU_REF_INIT_* flags
  * @gfp: allocation mask to use
  *
- * Initializes @ref.  If @flags is zero, @ref starts in percpu mode with a
- * refcount of 1; analagous to atomic_long_set(ref, 1).  See the
- * definitions of PERCPU_REF_INIT_* flags for flag behaviors.
+ * Initializes @ref.  If @flags is zero or PERCPU_REF_ALLOW_REINIT, @ref starts
+ * in percpu mode with a refcount of 1; analagous to atomic_long_set(ref, 1).
+ * See the definitions of PERCPU_REF_INIT_* flags for flag behaviors.
  *
  * Note that @release must not sleep - it may potentially be called from RCU
  * callback context by percpu_ref_kill().
-- 
2.21.0

