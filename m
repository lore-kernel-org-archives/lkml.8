Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F128DC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D066620678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgDIRNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:13:31 -0400
Received: from vkten.in ([104.244.73.96]:45266 "EHLO vkten.in"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgDIRNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:13:30 -0400
Received: (qmail 1341 invoked from network); 9 Apr 2020 17:13:26 -0000
Received: from unknown (HELO localhost) (vkor@vkten.in@117.209.168.92)
  de/crypted with TLSv1.3: TLS_AES_256_GCM_SHA384 [256/256] DN=none
  by vkten with ESMTPSA; 9 Apr 2020 17:13:26 -0000
From:   R Veera Kumar <vkor@vkten.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     R Veera Kumar <vkor@vkten.in>, Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: android: ion: use macro DEFINE_DEBUGFS_ATTRIBUTE to define debugfs fops
Date:   Thu,  9 Apr 2020 22:43:18 +0530
Message-Id: <20200409171318.1730-1-vkor@vkten.in>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is more clear to use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs file
operation rather than DEFINE_SIMPLE_ATTRIBUTE.

Found using coccinelle.

Signed-off-by: R Veera Kumar <vkor@vkten.in>
---
Changes in v2:
 - Give correct explanation for patch
 - Adjust git commit tag and msg accordingly
---
 drivers/staging/android/ion/ion.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 38b51eace4f9..dbe4018a6f83 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -554,8 +554,8 @@ static int debug_shrink_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(debug_shrink_fops, debug_shrink_get,
-			debug_shrink_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(debug_shrink_fops, debug_shrink_get,
+			 debug_shrink_set, "%llu\n");
 
 void ion_device_add_heap(struct ion_heap *heap)
 {
-- 
2.20.1

