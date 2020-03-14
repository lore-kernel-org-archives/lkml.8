Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03219C4CECE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC51E2074E
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584147330;
	bh=foM5P14pb5C9zO28lRafxju3k6trcDAwDnYDz9wY3ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g6qQ/t9BPqCZwEQxDnJBC9fbjKjPaPmJ8GCllVLA9m5/6rhheS3kAOdyB7WGXu0qr
	 fwDHPkpFSVlXBuEHfSdG5Tcg6YDYe5YI3bTi3qiNKoG5ww4ZOnltAZYSyjC6IKbnTR
	 lzU/iMO3EBdsv6K9JEHFUPYpNsbp4exfnZOYqwk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgCNAzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 20:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbgCNAzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 20:55:09 -0400
Received: from kicinski-fedora-PC1C0HJN.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6FBA20752;
        Sat, 14 Mar 2020 00:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584147308;
        bh=foM5P14pb5C9zO28lRafxju3k6trcDAwDnYDz9wY3ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vwXNdKTu9eEwIbdYjMhQcwMyCHftM+LN+NPamDzDiJ1RNVIcQf6CUhRHORwTeirM8
         iH/m8g/7a20/sqB8LzztdeZvBscEAwT0l1gaRHH1aNXWPMr16XprQpipOXZH1FmKpX
         ypSwsYNLnSLP12rcO7TkjNxHNbYhdSqLi4TlxSWA=
From:   Jakub Kicinski <kuba@kernel.org>
To:     shuah@kernel.org, keescook@chromium.org
Cc:     luto@amacapital.net, wad@chromium.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v2 4/4] selftests: tls: run all tests for TLS 1.2 and TLS 1.3
Date:   Fri, 13 Mar 2020 17:55:01 -0700
Message-Id: <20200314005501.2446494-5-kuba@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200314005501.2446494-1-kuba@kernel.org>
References: <20200314005501.2446494-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TLS 1.2 and TLS 1.3 differ in the implementation.
Use fixture parameters to run all tests for both
versions, and remove the one-off TLS 1.2 test.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/net/tls.c | 93 ++++++-------------------------
 1 file changed, 17 insertions(+), 76 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 0ea44d975b6c..82d48ce0787e 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -101,6 +101,21 @@ FIXTURE(tls)
 	bool notls;
 };
 
+FIXTURE_PARAMS(tls)
+{
+	unsigned int tls_version;
+};
+
+FIXTURE_PARAMS_ADD(tls, 12)
+{
+	.tls_version = TLS_1_2_VERSION,
+};
+
+FIXTURE_PARAMS_ADD(tls, 13)
+{
+	.tls_version = TLS_1_3_VERSION,
+};
+
 FIXTURE_SETUP(tls)
 {
 	struct tls12_crypto_info_aes_gcm_128 tls12;
@@ -112,7 +127,7 @@ FIXTURE_SETUP(tls)
 	len = sizeof(addr);
 
 	memset(&tls12, 0, sizeof(tls12));
-	tls12.info.version = TLS_1_3_VERSION;
+	tls12.info.version = CURRENT_PARAMS(tls)->tls_version;
 	tls12.info.cipher_type = TLS_CIPHER_AES_GCM_128;
 
 	addr.sin_family = AF_INET;
@@ -733,7 +748,7 @@ TEST_F(tls, bidir)
 		struct tls12_crypto_info_aes_gcm_128 tls12;
 
 		memset(&tls12, 0, sizeof(tls12));
-		tls12.info.version = TLS_1_3_VERSION;
+		tls12.info.version = CURRENT_PARAMS(tls)->tls_version;
 		tls12.info.cipher_type = TLS_CIPHER_AES_GCM_128;
 
 		ret = setsockopt(self->fd, SOL_TLS, TLS_RX, &tls12,
@@ -1258,78 +1273,4 @@ TEST(keysizes) {
 	close(cfd);
 }
 
-TEST(tls12) {
-	int fd, cfd;
-	bool notls;
-
-	struct tls12_crypto_info_aes_gcm_128 tls12;
-	struct sockaddr_in addr;
-	socklen_t len;
-	int sfd, ret;
-
-	notls = false;
-	len = sizeof(addr);
-
-	memset(&tls12, 0, sizeof(tls12));
-	tls12.info.version = TLS_1_2_VERSION;
-	tls12.info.cipher_type = TLS_CIPHER_AES_GCM_128;
-
-	addr.sin_family = AF_INET;
-	addr.sin_addr.s_addr = htonl(INADDR_ANY);
-	addr.sin_port = 0;
-
-	fd = socket(AF_INET, SOCK_STREAM, 0);
-	sfd = socket(AF_INET, SOCK_STREAM, 0);
-
-	ret = bind(sfd, &addr, sizeof(addr));
-	ASSERT_EQ(ret, 0);
-	ret = listen(sfd, 10);
-	ASSERT_EQ(ret, 0);
-
-	ret = getsockname(sfd, &addr, &len);
-	ASSERT_EQ(ret, 0);
-
-	ret = connect(fd, &addr, sizeof(addr));
-	ASSERT_EQ(ret, 0);
-
-	ret = setsockopt(fd, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls"));
-	if (ret != 0) {
-		notls = true;
-		printf("Failure setting TCP_ULP, testing without tls\n");
-	}
-
-	if (!notls) {
-		ret = setsockopt(fd, SOL_TLS, TLS_TX, &tls12,
-				 sizeof(tls12));
-		ASSERT_EQ(ret, 0);
-	}
-
-	cfd = accept(sfd, &addr, &len);
-	ASSERT_GE(cfd, 0);
-
-	if (!notls) {
-		ret = setsockopt(cfd, IPPROTO_TCP, TCP_ULP, "tls",
-				 sizeof("tls"));
-		ASSERT_EQ(ret, 0);
-
-		ret = setsockopt(cfd, SOL_TLS, TLS_RX, &tls12,
-				 sizeof(tls12));
-		ASSERT_EQ(ret, 0);
-	}
-
-	close(sfd);
-
-	char const *test_str = "test_read";
-	int send_len = 10;
-	char buf[10];
-
-	send_len = strlen(test_str) + 1;
-	EXPECT_EQ(send(fd, test_str, send_len, 0), send_len);
-	EXPECT_NE(recv(cfd, buf, send_len, 0), -1);
-	EXPECT_EQ(memcmp(buf, test_str, send_len), 0);
-
-	close(fd);
-	close(cfd);
-}
-
 TEST_HARNESS_MAIN
-- 
2.24.1

