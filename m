Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA89FC54E49
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF0F221473
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgEIXqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 19:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728808AbgEIXqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:46:02 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78021C05BD0E;
        Sat,  9 May 2020 16:46:02 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXZAN-004iS6-TR; Sat, 09 May 2020 23:45:59 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 13/20] drivers/crypto/ccp/sev-dev.c: get rid of pointless access_ok()
Date:   Sun, 10 May 2020 00:45:50 +0100
Message-Id: <20200509234557.1124086-13-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Contrary to the comments, those do *NOT* verify anything about
writability of memory, etc.

In all cases addresses are passed only to copy_to_user().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/crypto/ccp/sev-dev.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 896f190b9a50..7f97164cbafb 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -371,8 +371,7 @@ static int sev_ioctl_do_pek_csr(struct sev_issue_cmd *argp, bool writable)
 		goto cmd;
 
 	/* allocate a physically contiguous buffer to store the CSR blob */
-	if (!access_ok(input.address, input.length) ||
-	    input.length > SEV_FW_BLOB_MAX_SIZE) {
+	if (input.length > SEV_FW_BLOB_MAX_SIZE) {
 		ret = -EFAULT;
 		goto e_free;
 	}
@@ -609,12 +608,6 @@ static int sev_ioctl_do_get_id2(struct sev_issue_cmd *argp)
 	if (copy_from_user(&input, (void __user *)argp->data, sizeof(input)))
 		return -EFAULT;
 
-	/* Check if we have write access to the userspace buffer */
-	if (input.address &&
-	    input.length &&
-	    !access_ok(input.address, input.length))
-		return -EFAULT;
-
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -730,15 +723,13 @@ static int sev_ioctl_do_pdh_export(struct sev_issue_cmd *argp, bool writable)
 		goto cmd;
 
 	/* Allocate a physically contiguous buffer to store the PDH blob. */
-	if ((input.pdh_cert_len > SEV_FW_BLOB_MAX_SIZE) ||
-	    !access_ok(input.pdh_cert_address, input.pdh_cert_len)) {
+	if (input.pdh_cert_len > SEV_FW_BLOB_MAX_SIZE) {
 		ret = -EFAULT;
 		goto e_free;
 	}
 
 	/* Allocate a physically contiguous buffer to store the cert chain blob. */
-	if ((input.cert_chain_len > SEV_FW_BLOB_MAX_SIZE) ||
-	    !access_ok(input.cert_chain_address, input.cert_chain_len)) {
+	if (input.cert_chain_len > SEV_FW_BLOB_MAX_SIZE) {
 		ret = -EFAULT;
 		goto e_free;
 	}
-- 
2.11.0

