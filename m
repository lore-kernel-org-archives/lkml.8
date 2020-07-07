Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FD2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 03:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1379420734
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 03:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgGGDfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 23:35:51 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:34796 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726869AbgGGDfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 23:35:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U1zux0A_1594092949;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U1zux0A_1594092949)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Jul 2020 11:35:49 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     zohar@linux.ibm.com, vt@altlinux.org, linux-kernel@vger.kernel.org
Cc:     tianjia.zhang@linux.alibaba.com
Subject: [PATCH ima-evm-utils 2/3] ima-evm-utils: beautify the code to make it more readable
Date:   Tue,  7 Jul 2020 11:35:47 +0800
Message-Id: <20200707033548.21640-2-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200707033548.21640-1-tianjia.zhang@linux.alibaba.com>
References: <20200707033548.21640-1-tianjia.zhang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use enum type instead of hard-coded numbers to improve code readability.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 src/libimaevm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index a9419ee..8f2ebcf 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -579,7 +579,7 @@ static int get_hash_algo_from_sig(unsigned char *sig)
 {
 	uint8_t hashalgo;
 
-	if (sig[0] == 1) {
+	if (sig[0] == DIGSIG_VERSION_1) {
 		hashalgo = ((struct signature_hdr *)sig)->hash;
 
 		if (hashalgo >= DIGEST_ALGO_MAX)
@@ -593,7 +593,7 @@ static int get_hash_algo_from_sig(unsigned char *sig)
 		default:
 			return -1;
 		}
-	} else if (sig[0] == 2) {
+	} else if (sig[0] == DIGSIG_VERSION_2) {
 		hashalgo = ((struct signature_v2_hdr *)sig)->hash_algo;
 		if (hashalgo >= PKEY_HASH__LAST)
 			return -1;
@@ -625,7 +625,7 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
 	unsigned char hash[MAX_DIGEST_SIZE];
 	int hashlen, sig_hash_algo;
 
-	if (sig[0] != 0x03) {
+	if (sig[0] != EVM_IMA_XATTR_DIGSIG) {
 		log_err("xattr ima has no signature\n");
 		return -1;
 	}
-- 
2.17.1

