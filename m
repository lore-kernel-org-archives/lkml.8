Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4736C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7705024673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWM7kJP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgBTSlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:41:53 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36547 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbgBTSlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:41:47 -0500
Received: by mail-yb1-f195.google.com with SMTP id u26so2636450ybd.3;
        Thu, 20 Feb 2020 10:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1kq/R8X2qTgwwCpwv49hLLrosUG8n/csG7QFzD9+hpk=;
        b=kWM7kJP2d/GnOC27uPBrb/5LUsiv/k/30/pdNjdTqGXaQwbBbzZgBZuO6/WY4zHPLc
         Ax0tbliy2OIvCtBhttHZJwa/1AunhZuSETWgwztD9ordBolb6WFEAqe4qEVxOc5whX9w
         uiLb8xRk6m/xT4WcXWJqm+iK/+rFtBt+3TbSyZaXIHaTR5giLCyUBEHxcMR3QZJ2JM1h
         2H60zDijWTkiaqM3HT9QcOn5MixXKcM9WzUk7Cp3kpOGhPohiULbcXmvU9uVVzj8Jhbi
         8QuGHPrszUXcWLHVqu8olFOLmRQW7fp5xGW0m+Ue1vijJl2Oi79dWo/u3ANGaWlJIO0Z
         8PjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1kq/R8X2qTgwwCpwv49hLLrosUG8n/csG7QFzD9+hpk=;
        b=B+h/naRwhsW2pz7PVZ8B4LPKGY28w9sUv1kgoBFAYtfH1BTICSwaZqe9ZtTkH3shyU
         BPmiieMetFT5b21+YZ+aRKYc/1fLyoc1htbLGzkmOwCEnUWW+1hKwjQ2ziYglkvTbm9P
         MKySZ2qBGwnXbcEZmbQ0CVoc4Hvai/eFBSv/PLwoMPmrZuy0dAvbap0dwr85EkI1EJB1
         KG54/SSqwrYuOxCX6+HqzTobF0L/TgOxaHhbpZjGKqHlAZtlTHERou50wcjiXSqWfhYA
         3MfTTRqXkg8K2FRjQ5C0boPbsg2+wYYF5ehQkpao5WdNhXSdIoyJGkwjZ2yZxsGaqc1+
         naww==
X-Gm-Message-State: APjAAAXZS++i9OEtYwbj8mxCu3BfMUZY1smljr4LXZUPv+wILWnRzSad
        mhWDrPhGNcBE1ZTIDHz9pDs=
X-Google-Smtp-Source: APXvYqzX6VI5uQsI/P4velmUnt4/4Q4L2bX7y150UbTmyFD3QpEaCMUkobshxZotGgRlcvJyqUhrRw==
X-Received: by 2002:a25:41d3:: with SMTP id o202mr12968782yba.161.1582224105953;
        Thu, 20 Feb 2020 10:41:45 -0800 (PST)
Received: from localhost.localdomain (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id a74sm206875ywe.42.2020.02.20.10.41.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Feb 2020 10:41:45 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        pantelis.antoniou@konsulko.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Tull <atull@kernel.org>
Subject: [PATCH v2 2/2] of: unittest: annotate warnings triggered by unittest
Date:   Thu, 20 Feb 2020 12:40:21 -0600
Message-Id: <1582224021-12827-3-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1582224021-12827-1-git-send-email-frowand.list@gmail.com>
References: <1582224021-12827-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Some tests in the devicetree unittests result in printk messages
from the code being tested.  It can be difficult to determine
whether the messages are the result of unittest or are potentially
reporting bugs that should be fixed.  The most recent example of
a person asking whether to be concerned about these messages is [1].

Add annotations for all messages triggered by unittests, except
KERN_DEBUG messages.  (KERN_DEBUG is a special case due to the
possible interaction of CONFIG_DYNAMIC_DEBUG.)

The format of the annotations is expected to change when unittests
are converted to use the kunit infrastructure when the broader
testing community has an opportunity to discuss the implementation
of annotations of test triggered messages.

[1] https://lore.kernel.org/r/6021ac63-b5e0-ed3d-f964-7c6ef579cd68@huawei.com

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
changes since v1:
  - none

 drivers/of/unittest.c | 375 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 345 insertions(+), 30 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 6059bb363097..96ae8a762a9e 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -51,6 +51,9 @@
  * Expected message may have a message level other than KERN_INFO.
  * Print the expected message only if the current loglevel will allow
  * the actual message to print.
+ *
+ * Do not use EXPECT_BEGIN() or EXPECT_END() for messages generated by
+ * pr_debug().
  */
 #define EXPECT_BEGIN(level, fmt, ...) \
 	printk(level pr_fmt("EXPECT \\ : ") fmt, ##__VA_ARGS__)
@@ -536,29 +539,77 @@ static void __init of_unittest_parse_phandle_with_args(void)
 
 	/* Check for missing cells property */
 	memset(&args, 0, sizeof(args));
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1");
+
 	rc = of_parse_phandle_with_args(np, "phandle-list",
 					"#phandle-cells-missing", 0, &args);
+
+	EXPECT_END(KERN_INFO,
+		   "OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1");
+
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1");
+
 	rc = of_count_phandle_with_args(np, "phandle-list",
 					"#phandle-cells-missing");
+
+	EXPECT_END(KERN_INFO,
+		   "OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1");
+
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 
 	/* Check for bad phandle in list */
 	memset(&args, 0, sizeof(args));
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "OF: /testcase-data/phandle-tests/consumer-a: could not find phandle");
+
 	rc = of_parse_phandle_with_args(np, "phandle-list-bad-phandle",
 					"#phandle-cells", 0, &args);
+
+	EXPECT_END(KERN_INFO,
+		   "OF: /testcase-data/phandle-tests/consumer-a: could not find phandle");
+
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "OF: /testcase-data/phandle-tests/consumer-a: could not find phandle");
+
 	rc = of_count_phandle_with_args(np, "phandle-list-bad-phandle",
 					"#phandle-cells");
+
+	EXPECT_END(KERN_INFO,
+		   "OF: /testcase-data/phandle-tests/consumer-a: could not find phandle");
+
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 
 	/* Check for incorrectly formed argument list */
 	memset(&args, 0, sizeof(args));
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1");
+
 	rc = of_parse_phandle_with_args(np, "phandle-list-bad-args",
 					"#phandle-cells", 1, &args);
+
+	EXPECT_END(KERN_INFO,
+		   "OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1");
+
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1");
+
 	rc = of_count_phandle_with_args(np, "phandle-list-bad-args",
 					"#phandle-cells");
+
+	EXPECT_END(KERN_INFO,
+		   "OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1");
+
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 }
 
@@ -669,20 +720,41 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 
 	/* Check for missing cells,map,mask property */
 	memset(&args, 0, sizeof(args));
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "OF: /testcase-data/phandle-tests/consumer-b: could not get #phandle-missing-cells for /testcase-data/phandle-tests/provider1");
+
 	rc = of_parse_phandle_with_args_map(np, "phandle-list",
 					    "phandle-missing", 0, &args);
+	EXPECT_END(KERN_INFO,
+		   "OF: /testcase-data/phandle-tests/consumer-b: could not get #phandle-missing-cells for /testcase-data/phandle-tests/provider1");
+
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 
 	/* Check for bad phandle in list */
 	memset(&args, 0, sizeof(args));
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "OF: /testcase-data/phandle-tests/consumer-b: could not find phandle");
+
 	rc = of_parse_phandle_with_args_map(np, "phandle-list-bad-phandle",
 					    "phandle", 0, &args);
+	EXPECT_END(KERN_INFO,
+		   "OF: /testcase-data/phandle-tests/consumer-b: could not find phandle");
+
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 
 	/* Check for incorrectly formed argument list */
 	memset(&args, 0, sizeof(args));
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found -1");
+
 	rc = of_parse_phandle_with_args_map(np, "phandle-list-bad-args",
 					    "phandle", 1, &args);
+	EXPECT_END(KERN_INFO,
+		   "OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found -1");
+
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 }
 
@@ -1213,7 +1285,15 @@ static void __init of_unittest_platform_populate(void)
 		np = of_find_node_by_path("/testcase-data/testcase-device2");
 		pdev = of_find_device_by_node(np);
 		unittest(pdev, "device 2 creation failed\n");
+
+		EXPECT_BEGIN(KERN_INFO,
+			     "platform testcase-data:testcase-device2: IRQ index 0 not found");
+
 		irq = platform_get_irq(pdev, 0);
+
+		EXPECT_END(KERN_INFO,
+			   "platform testcase-data:testcase-device2: IRQ index 0 not found");
+
 		unittest(irq < 0 && irq != -EPROBE_DEFER,
 			 "device parsing error failed - %d\n", irq);
 	}
@@ -1417,6 +1497,9 @@ static int __init unittest_data_add(void)
 		return 0;
 	}
 
+	EXPECT_BEGIN(KERN_INFO,
+		     "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
+
 	/* attach the sub-tree to live tree */
 	np = unittest_data_node->child;
 	while (np) {
@@ -1427,6 +1510,9 @@ static int __init unittest_data_add(void)
 		np = next;
 	}
 
+	EXPECT_END(KERN_INFO,
+		   "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
+
 	of_overlay_mutex_unlock();
 
 	return 0;
@@ -1769,8 +1855,18 @@ static int __init of_unittest_apply_revert_overlay_check(int overlay_nr,
 /* test activation of device */
 static void __init of_unittest_overlay_0(void)
 {
+	int ret;
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest0/status");
+
 	/* device should enable */
-	if (of_unittest_apply_overlay_check(0, 0, 0, 1, PDEV_OVERLAY))
+	ret = of_unittest_apply_overlay_check(0, 0, 0, 1, PDEV_OVERLAY);
+
+	EXPECT_END(KERN_INFO,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest0/status");
+
+	if (ret)
 		return;
 
 	unittest(1, "overlay test %d passed\n", 0);
@@ -1779,28 +1875,58 @@ static void __init of_unittest_overlay_0(void)
 /* test deactivation of device */
 static void __init of_unittest_overlay_1(void)
 {
+	int ret;
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest1/status");
+
 	/* device should disable */
-	if (of_unittest_apply_overlay_check(1, 1, 1, 0, PDEV_OVERLAY))
+	ret = of_unittest_apply_overlay_check(1, 1, 1, 0, PDEV_OVERLAY);
+
+	EXPECT_END(KERN_INFO,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest1/status");
+
+	if (ret)
 		return;
 
 	unittest(1, "overlay test %d passed\n", 1);
+
 }
 
 /* test activation of device */
 static void __init of_unittest_overlay_2(void)
 {
+	int ret;
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest2/status");
+
 	/* device should enable */
-	if (of_unittest_apply_overlay_check(2, 2, 0, 1, PDEV_OVERLAY))
-		return;
+	ret = of_unittest_apply_overlay_check(2, 2, 0, 1, PDEV_OVERLAY);
+
+	EXPECT_END(KERN_INFO,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest2/status");
 
+	if (ret)
+		return;
 	unittest(1, "overlay test %d passed\n", 2);
 }
 
 /* test deactivation of device */
 static void __init of_unittest_overlay_3(void)
 {
+	int ret;
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest3/status");
+
 	/* device should disable */
-	if (of_unittest_apply_overlay_check(3, 3, 1, 0, PDEV_OVERLAY))
+	ret = of_unittest_apply_overlay_check(3, 3, 1, 0, PDEV_OVERLAY);
+
+	EXPECT_END(KERN_INFO,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest3/status");
+
+	if (ret)
 		return;
 
 	unittest(1, "overlay test %d passed\n", 3);
@@ -1819,8 +1945,18 @@ static void __init of_unittest_overlay_4(void)
 /* test overlay apply/revert sequence */
 static void __init of_unittest_overlay_5(void)
 {
+	int ret;
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest5/status");
+
 	/* device should disable */
-	if (of_unittest_apply_revert_overlay_check(5, 5, 0, 1, PDEV_OVERLAY))
+	ret = of_unittest_apply_revert_overlay_check(5, 5, 0, 1, PDEV_OVERLAY);
+
+	EXPECT_END(KERN_INFO,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest5/status");
+
+	if (ret)
 		return;
 
 	unittest(1, "overlay test %d passed\n", 5);
@@ -1834,6 +1970,8 @@ static void __init of_unittest_overlay_6(void)
 	int before = 0, after = 1;
 	const char *overlay_name;
 
+	int ret;
+
 	/* unittest device must be in before state */
 	for (i = 0; i < 2; i++) {
 		if (of_unittest_device_exists(unittest_nr + i, PDEV_OVERLAY)
@@ -1848,18 +1986,41 @@ static void __init of_unittest_overlay_6(void)
 	}
 
 	/* apply the overlays */
-	for (i = 0; i < 2; i++) {
 
-		overlay_name = overlay_name_from_nr(overlay_nr + i);
+	EXPECT_BEGIN(KERN_INFO,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest6/status");
+
+	overlay_name = overlay_name_from_nr(overlay_nr + 0);
 
-		if (!overlay_data_apply(overlay_name, &ovcs_id)) {
-			unittest(0, "could not apply overlay \"%s\"\n",
-					overlay_name);
+	ret = overlay_data_apply(overlay_name, &ovcs_id);
+
+	if (!ret) {
+		unittest(0, "could not apply overlay \"%s\"\n", overlay_name);
+			return;
+	}
+	ov_id[0] = ovcs_id;
+	of_unittest_track_overlay(ov_id[0]);
+
+	EXPECT_END(KERN_INFO,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest6/status");
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest7/status");
+
+	overlay_name = overlay_name_from_nr(overlay_nr + 1);
+
+	ret = overlay_data_apply(overlay_name, &ovcs_id);
+
+	if (!ret) {
+		unittest(0, "could not apply overlay \"%s\"\n", overlay_name);
 			return;
-		}
-		ov_id[i] = ovcs_id;
-		of_unittest_track_overlay(ov_id[i]);
 	}
+	ov_id[1] = ovcs_id;
+	of_unittest_track_overlay(ov_id[1]);
+
+	EXPECT_END(KERN_INFO,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest7/status");
+
 
 	for (i = 0; i < 2; i++) {
 		/* unittest device must be in after state */
@@ -1900,6 +2061,7 @@ static void __init of_unittest_overlay_6(void)
 	}
 
 	unittest(1, "overlay test %d passed\n", 6);
+
 }
 
 /* test overlay application in sequence */
@@ -1908,26 +2070,65 @@ static void __init of_unittest_overlay_8(void)
 	int i, ov_id[2], ovcs_id;
 	int overlay_nr = 8, unittest_nr = 8;
 	const char *overlay_name;
+	int ret;
 
 	/* we don't care about device state in this test */
 
+	EXPECT_BEGIN(KERN_INFO,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest8/status");
+
+	overlay_name = overlay_name_from_nr(overlay_nr + 0);
+
+	ret = overlay_data_apply(overlay_name, &ovcs_id);
+	if (!ret)
+		unittest(0, "could not apply overlay \"%s\"\n", overlay_name);
+
+	EXPECT_END(KERN_INFO,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest8/status");
+
+	if (!ret)
+		return;
+
+	ov_id[0] = ovcs_id;
+	of_unittest_track_overlay(ov_id[0]);
+
+	overlay_name = overlay_name_from_nr(overlay_nr + 1);
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest8/property-foo");
+
 	/* apply the overlays */
-	for (i = 0; i < 2; i++) {
+	ret = overlay_data_apply(overlay_name, &ovcs_id);
 
-		overlay_name = overlay_name_from_nr(overlay_nr + i);
+	EXPECT_END(KERN_INFO,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest8/property-foo");
 
-		if (!overlay_data_apply(overlay_name, &ovcs_id)) {
-			unittest(0, "could not apply overlay \"%s\"\n",
-					overlay_name);
-			return;
-		}
-		ov_id[i] = ovcs_id;
-		of_unittest_track_overlay(ov_id[i]);
+	if (!ret) {
+		unittest(0, "could not apply overlay \"%s\"\n", overlay_name);
+		return;
 	}
 
+	ov_id[1] = ovcs_id;
+	of_unittest_track_overlay(ov_id[1]);
+
 	/* now try to remove first overlay (it should fail) */
 	ovcs_id = ov_id[0];
-	if (!of_overlay_remove(&ovcs_id)) {
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "OF: overlay: node_overlaps_later_cs: #6 overlaps with #7 @/testcase-data/overlay-node/test-bus/test-unittest8");
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "OF: overlay: overlay #6 is not topmost");
+
+	ret = of_overlay_remove(&ovcs_id);
+
+	EXPECT_END(KERN_INFO,
+		   "OF: overlay: overlay #6 is not topmost");
+
+	EXPECT_END(KERN_INFO,
+		   "OF: overlay: node_overlaps_later_cs: #6 overlaps with #7 @/testcase-data/overlay-node/test-bus/test-unittest8");
+
+	if (!ret) {
 		unittest(0, "%s was destroyed @\"%s\"\n",
 				overlay_name_from_nr(overlay_nr + 0),
 				unittest_path(unittest_nr,
@@ -1959,6 +2160,7 @@ static void __init of_unittest_overlay_10(void)
 
 	/* device should disable */
 	ret = of_unittest_apply_overlay_check(10, 10, 0, 1, PDEV_OVERLAY);
+
 	if (unittest(ret == 0,
 			"overlay test %d failed; overlay application\n", 10))
 		return;
@@ -1982,6 +2184,7 @@ static void __init of_unittest_overlay_11(void)
 	/* device should disable */
 	ret = of_unittest_apply_revert_overlay_check(11, 11, 0, 1,
 			PDEV_OVERLAY);
+
 	unittest(ret == 0, "overlay test %d failed; overlay apply\n", 11);
 }
 
@@ -2212,12 +2415,21 @@ static int of_unittest_overlay_i2c_init(void)
 		return ret;
 
 	ret = platform_driver_register(&unittest_i2c_bus_driver);
+
 	if (unittest(ret == 0,
 			"could not register unittest i2c bus driver\n"))
 		return ret;
 
 #if IS_BUILTIN(CONFIG_I2C_MUX)
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "i2c i2c-1: Added multiplexed i2c bus 2");
+
 	ret = i2c_add_driver(&unittest_i2c_mux_driver);
+
+	EXPECT_END(KERN_INFO,
+		   "i2c i2c-1: Added multiplexed i2c bus 2");
+
 	if (unittest(ret == 0,
 			"could not register unittest i2c mux driver\n"))
 		return ret;
@@ -2237,8 +2449,18 @@ static void of_unittest_overlay_i2c_cleanup(void)
 
 static void __init of_unittest_overlay_i2c_12(void)
 {
+	int ret;
+
 	/* device should enable */
-	if (of_unittest_apply_overlay_check(12, 12, 0, 1, I2C_OVERLAY))
+	EXPECT_BEGIN(KERN_INFO,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest12/status");
+
+	ret = of_unittest_apply_overlay_check(12, 12, 0, 1, I2C_OVERLAY);
+
+	EXPECT_END(KERN_INFO,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest12/status");
+
+	if (ret)
 		return;
 
 	unittest(1, "overlay test %d passed\n", 12);
@@ -2247,8 +2469,18 @@ static void __init of_unittest_overlay_i2c_12(void)
 /* test deactivation of device */
 static void __init of_unittest_overlay_i2c_13(void)
 {
+	int ret;
+
+	EXPECT_BEGIN(KERN_INFO,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest13/status");
+
 	/* device should disable */
-	if (of_unittest_apply_overlay_check(13, 13, 1, 0, I2C_OVERLAY))
+	ret = of_unittest_apply_overlay_check(13, 13, 1, 0, I2C_OVERLAY);
+
+	EXPECT_END(KERN_INFO,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest13/status");
+
+	if (ret)
 		return;
 
 	unittest(1, "overlay test %d passed\n", 13);
@@ -2261,8 +2493,18 @@ static void of_unittest_overlay_i2c_14(void)
 
 static void __init of_unittest_overlay_i2c_15(void)
 {
+	int ret;
+
 	/* device should enable */
-	if (of_unittest_apply_overlay_check(15, 15, 0, 1, I2C_OVERLAY))
+	EXPECT_BEGIN(KERN_INFO,
+		     "i2c i2c-1: Added multiplexed i2c bus 3");
+
+	ret = of_unittest_apply_overlay_check(15, 15, 0, 1, I2C_OVERLAY);
+
+	EXPECT_END(KERN_INFO,
+		   "i2c i2c-1: Added multiplexed i2c bus 3");
+
+	if (ret)
 		return;
 
 	unittest(1, "overlay test %d passed\n", 15);
@@ -2723,6 +2965,7 @@ static __init void of_unittest_overlay_high_level(void)
 	struct device_node *overlay_base_symbols;
 	struct device_node **pprev;
 	struct property *prop;
+	int ret;
 
 	if (!overlay_base_root) {
 		unittest(0, "overlay_base_root not initialized\n");
@@ -2837,15 +3080,86 @@ static __init void of_unittest_overlay_high_level(void)
 
 	/* now do the normal overlay usage test */
 
-	unittest(overlay_data_apply("overlay", NULL),
-		 "Adding overlay 'overlay' failed\n");
+	EXPECT_BEGIN(KERN_ERR,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/status");
+	EXPECT_BEGIN(KERN_ERR,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/status");
+	EXPECT_BEGIN(KERN_ERR,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/ride@100/track@30/incline-up");
+	EXPECT_BEGIN(KERN_ERR,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/ride@100/track@40/incline-up");
+	EXPECT_BEGIN(KERN_ERR,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/status");
+	EXPECT_BEGIN(KERN_ERR,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/color");
+	EXPECT_BEGIN(KERN_ERR,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/rate");
+	EXPECT_BEGIN(KERN_ERR,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/hvac_2");
+	EXPECT_BEGIN(KERN_ERR,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200");
+	EXPECT_BEGIN(KERN_ERR,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200_left");
+	EXPECT_BEGIN(KERN_ERR,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200_right");
+
+	ret = overlay_data_apply("overlay", NULL);
+
+	EXPECT_END(KERN_ERR,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200_right");
+	EXPECT_END(KERN_ERR,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200_left");
+	EXPECT_END(KERN_ERR,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200");
+	EXPECT_END(KERN_ERR,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/hvac_2");
+	EXPECT_END(KERN_ERR,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/rate");
+	EXPECT_END(KERN_ERR,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/color");
+	EXPECT_END(KERN_ERR,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/status");
+	EXPECT_END(KERN_ERR,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/ride@100/track@40/incline-up");
+	EXPECT_END(KERN_ERR,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/ride@100/track@30/incline-up");
+	EXPECT_END(KERN_ERR,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/status");
+	EXPECT_END(KERN_ERR,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/status");
+
+	unittest(ret, "Adding overlay 'overlay' failed\n");
+
+	EXPECT_BEGIN(KERN_ERR,
+		     "OF: overlay: ERROR: multiple fragments add and/or delete node /testcase-data-2/substation@100/motor-1/controller");
+	EXPECT_BEGIN(KERN_ERR,
+		     "OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/controller/name");
 
 	unittest(overlay_data_apply("overlay_bad_add_dup_node", NULL),
 		 "Adding overlay 'overlay_bad_add_dup_node' failed\n");
 
+	EXPECT_END(KERN_ERR,
+		   "OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/controller/name");
+	EXPECT_END(KERN_ERR,
+		   "OF: overlay: ERROR: multiple fragments add and/or delete node /testcase-data-2/substation@100/motor-1/controller");
+
+	EXPECT_BEGIN(KERN_ERR,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/motor-1/rpm_avail");
+	EXPECT_BEGIN(KERN_ERR,
+		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/motor-1/rpm_avail");
+	EXPECT_BEGIN(KERN_ERR,
+		     "OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/rpm_avail");
+
 	unittest(overlay_data_apply("overlay_bad_add_dup_prop", NULL),
 		 "Adding overlay 'overlay_bad_add_dup_prop' failed\n");
 
+	EXPECT_END(KERN_ERR,
+		   "OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/rpm_avail");
+	EXPECT_END(KERN_ERR,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/motor-1/rpm_avail");
+	EXPECT_END(KERN_ERR,
+		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/motor-1/rpm_avail");
+
 	unittest(overlay_data_apply("overlay_bad_phandle", NULL),
 		 "Adding overlay 'overlay_bad_phandle' failed\n");
 
@@ -2869,6 +3183,8 @@ static int __init of_unittest(void)
 	struct device_node *np;
 	int res;
 
+	pr_info("start of unittest - you will see error messages\n");
+
 	/* adding data for unittest */
 
 	if (IS_ENABLED(CONFIG_UML))
@@ -2887,7 +3203,6 @@ static int __init of_unittest(void)
 	}
 	of_node_put(np);
 
-	pr_info("start of unittest - you will see error messages\n");
 	of_unittest_check_tree_linkage();
 	of_unittest_check_phandles();
 	of_unittest_find_node_by_name();
-- 
Frank Rowand <frank.rowand@sony.com>

