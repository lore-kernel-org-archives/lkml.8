Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA69C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 06:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4AE9206C3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 06:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590821881;
	bh=knUbagJ9TKl5kkm+2g3P8FOeWVA4h3uYFXswP2rdO/M=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=H4xouQ3ssHj2F8Fi4yqke9G2rCMEyrsAZkW78FsOEiSIbW92yqWy9PRkSjDnsM7V1
	 dmnVPe8jbtPTwV3p6AQs89HaOz+BFUnP0kV+YDgOhsHE8/IVheINBP0AWp82Bf1u7K
	 AJluvqICCA8zWDZRe6hrl2qaTWzKe1uBJGHpgJ/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgE3G6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 02:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728868AbgE3G4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 02:56:07 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75B45221FB;
        Sat, 30 May 2020 06:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590821764;
        bh=knUbagJ9TKl5kkm+2g3P8FOeWVA4h3uYFXswP2rdO/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ruYCdM/q8g8YOGHtv6CuJmiOhYc6Nhgx9pbFBdtqXBZyuf6FFLV8S5YIuGLTWgvP2
         gLDAf2bonT1HN25r7/UZcPx34HbVnEFITm6COOjV3D2rHw2BUnEERjLKS/KyGixEQP
         3d/FQemUUFrJqwUR7rGsA5vZl037uHqjMy0/UqWM=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jevPW-001hrA-Cv; Sat, 30 May 2020 08:56:02 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 39/41] media: atomisp: add some debug messages when binaries are used
Date:   Sat, 30 May 2020 08:55:56 +0200
Message-Id: <f7b456946998d8f67c1cb5eb78fd449ea0620c51.1590821410.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590821410.git.mchehab+huawei@kernel.org>
References: <cover.1590821410.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ISP firmware logic is complex, as several binaries are
contained into a single file.

Print debug messages:
	- with a stack dump if binary not found;
	- when a firmware is selected.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../atomisp/pci/runtime/binary/src/binary.c   | 31 ++++++++++++++++---
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c b/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c
index c10a09ca1c52..cca0c6161350 100644
--- a/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c
+++ b/drivers/staging/media/atomisp/pci/runtime/binary/src/binary.c
@@ -29,6 +29,8 @@
 #include "sh_css_defs.h"
 #include "sh_css_legacy.h"
 
+#include "atomisp_internal.h"
+
 #include "vf/vf_1.0/ia_css_vf.host.h"
 #include "sc/sc_1.0/ia_css_sc.host.h"
 #include "sdis/sdis_1.0/ia_css_sdis.host.h"
@@ -36,7 +38,6 @@
 
 #include "camera/pipe/interface/ia_css_pipe_binarydesc.h"
 
-
 #include "assert_support.h"
 
 #define IMPLIES(a, b)           (!(a) || (b))   /* A => B */
@@ -1375,9 +1376,8 @@ ia_css_binary_fill_info(const struct ia_css_binary_xinfo *xinfo,
 	return 0;
 }
 
-int
-ia_css_binary_find(struct ia_css_binary_descr *descr,
-		   struct ia_css_binary *binary) {
+static int __ia_css_binary_find(struct ia_css_binary_descr *descr,
+				struct ia_css_binary *binary) {
 	int mode;
 	bool online;
 	bool two_ppc;
@@ -1793,9 +1793,32 @@ ia_css_binary_find(struct ia_css_binary_descr *descr,
 	ia_css_debug_dtrace(IA_CSS_DEBUG_TRACE,
 			    "ia_css_binary_find() leave: return_err=%d\n", err);
 
+	if (!err && xcandidate)
+		dev_dbg(atomisp_dev,
+			"Using binary %s (id %d), type %d, mode %d, continuous %s\n",
+			xcandidate->blob->name,
+			xcandidate->sp.id,
+			xcandidate->type,
+			xcandidate->sp.pipeline.mode,
+			xcandidate->sp.enable.continuous ? "true" : "false");
+
+
 	return err;
 }
 
+int ia_css_binary_find(struct ia_css_binary_descr *descr,
+		       struct ia_css_binary *binary)
+{
+	int ret = __ia_css_binary_find(descr, binary);
+
+	if (unlikely(ret)) {
+		dev_dbg(atomisp_dev, "Seeking for binary failed at:");
+		dump_stack();
+	}
+
+	return ret;
+}
+
 unsigned
 ia_css_binary_max_vf_width(void)
 {
-- 
2.26.2

