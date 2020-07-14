Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AC9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7A422229
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgGNMCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:02:14 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:52577 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728083AbgGNMCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:02:13 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@mellanox.com)
        with SMTP; 14 Jul 2020 15:02:08 +0300
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 06EC25df004353;
        Tue, 14 Jul 2020 15:02:08 +0300
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v2 02/11] lib/test-string_helpers.c: Add string_upper() and string_lower() tests
Date:   Tue, 14 Jul 2020 15:01:54 +0300
Message-Id: <20200714120203.10352-3-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200714120203.10352-1-vadimp@mellanox.com>
References: <20200714120203.10352-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add few of simple tests for string_upper() and string_lower() helpers.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 lib/test-string_helpers.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/lib/test-string_helpers.c b/lib/test-string_helpers.c
index 25b5cbfb7615..10360d4ea273 100644
--- a/lib/test-string_helpers.c
+++ b/lib/test-string_helpers.c
@@ -238,6 +238,28 @@ static const struct test_string_2 escape1[] __initconst = {{
 	/* terminator */
 }};
 
+static const struct test_string strings_upper[] __initconst = {
+	{
+		.in = "abcdefgh1234567890test",
+		.out = "ABCDEFGH1234567890TEST",
+	},
+	{
+		.in = "abCdeFgH1234567890TesT",
+		.out = "ABCDEFGH1234567890TEST",
+	},
+};
+
+static const struct test_string strings_lower[] __initconst = {
+	{
+		.in = "ABCDEFGH1234567890TEST",
+		.out = "abcdefgh1234567890test",
+	},
+	{
+		.in = "abCdeFgH1234567890TesT",
+		.out = "abcdefgh1234567890test",
+	},
+};
+
 static __init const char *test_string_find_match(const struct test_string_2 *s2,
 						 unsigned int flags)
 {
@@ -390,6 +412,48 @@ static __init void test_string_get_size(void)
 	test_string_get_size_one(4096, U64_MAX, "75.6 ZB", "64.0 ZiB");
 }
 
+static void __init test_string_upper_lower(void)
+{
+	char *dst;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(strings_upper); i++) {
+		const char *s = strings_upper[i].in;
+		int len = strlen(strings_upper[i].in) + 1;
+
+		dst = kmalloc(len, GFP_KERNEL);
+		if (!dst)
+			return;
+
+		string_upper(dst, s);
+		if (memcmp(dst, strings_upper[i].out, len)) {
+			pr_warn("Test 'string_upper' failed : expected %s, got %s!\n",
+				strings_upper[i].out, dst);
+			kfree(dst);
+			return;
+		}
+		kfree(dst);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(strings_lower); i++) {
+		const char *s = strings_lower[i].in;
+		int len = strlen(strings_lower[i].in) + 1;
+
+		dst = kmalloc(len, GFP_KERNEL);
+		if (!dst)
+			return;
+
+		string_lower(dst, s);
+		if (memcmp(dst, strings_lower[i].out, len)) {
+			pr_warn("Test 'string_lower failed : : expected %s, got %s!\n",
+				strings_lower[i].out, dst);
+			kfree(dst);
+			return;
+		}
+		kfree(dst);
+	}
+}
+
 static int __init test_string_helpers_init(void)
 {
 	unsigned int i;
@@ -411,6 +475,9 @@ static int __init test_string_helpers_init(void)
 	/* Test string_get_size() */
 	test_string_get_size();
 
+	/* Test string upper(), string_lower() */
+	test_string_upper_lower();
+
 	return -EINVAL;
 }
 module_init(test_string_helpers_init);
-- 
2.11.0

