Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CFDC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A548C221F9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUYuWzec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgDPVoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727972AbgDPVou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:44:50 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4636C061A0C;
        Thu, 16 Apr 2020 14:44:49 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w29so288665qtv.3;
        Thu, 16 Apr 2020 14:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MYVHgBJ2a4Fh0aMV9sOUIW9OVLp13RPJaMgaav9Q49g=;
        b=UUYuWzectBQsk+Z9yUFV9CHjU7Cg+H0oICqf8+epFYuFp3sOu/xQczQTreYZ83Z9Nq
         OR/yNX84JQkdFLtOvcYzLZNqvGHCYvQZgiCEUBSBMAON97pUXVG6AnWr8c+PUCZXVfuZ
         GxYvGse93U1OiNdPHj2X8+7rINr25eb0tfwTOqcMwZBs6Mj4hbivQv21rqfmz4z69Y4e
         QZNCIEgWcKZL4E2MrQp56NfJyFTT1miPW627fqPLX9XjB14AdWuArDA4tcD4zJx4UWdn
         3GDNK6K6rLB85pYKxnHlB3DWvYZA1k19kORAbyEZbf4PGOeHEU3Ph9l/VUvC0UMy9LvL
         9Z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MYVHgBJ2a4Fh0aMV9sOUIW9OVLp13RPJaMgaav9Q49g=;
        b=bQiZ+JY5oAZkC6Ox/hiRVMAh3MMG6Trh06TUnuFrYQU0/ltRJ3JzkhsclbUHiZ8yzn
         ee6ogaTmCNFo+LY8EpoQ0JtoXEaBQz81YODvy7zfyOfpCMo4WwbMeF6YvrPdzXdx/sUe
         iQa7sm/3BW0vu97coaj4S105TQi8y5O8oOwzIk/YIHxXo+THRph9jMX145eittIMbUq2
         FOKscC9aOACyPXWa0eCE2KIuXVzCWVqfGF/+GpAhqDFJyJkOTKpskvwqnem5vM/9OxCZ
         ZbS3vwENM+pC00e4Y9YL0ScxkB5BEKrgxAKKVCMTnIn7HIdD7LmTKDYu+psfVkG8xgGK
         FAaQ==
X-Gm-Message-State: AGi0PuacAnXdtgyn4uEv2rsuBFGQ7lEG325Xm1ddvTr5hamaf76U15DB
        uvGIDSDjnLyHX/0SuFLY56U=
X-Google-Smtp-Source: APiQypJVOzhFICVzZVa4rS6wAgiym0oNB6opYdISWa+xexCScBmAtfXMU4P83LO7BfjZlW7XpqX8aw==
X-Received: by 2002:ac8:6c23:: with SMTP id k3mr28850568qtu.107.1587073489034;
        Thu, 16 Apr 2020 14:44:49 -0700 (PDT)
Received: from localhost.localdomain (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id z34sm3164141qth.43.2020.04.16.14.44.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 14:44:48 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Erhard F." <erhard_f@mailbox.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Subject: [PATCH 5/5] of: unittest: kmemleak in duplicate property update
Date:   Thu, 16 Apr 2020 16:42:50 -0500
Message-Id: <1587073370-25963-6-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1587073370-25963-1-git-send-email-frowand.list@gmail.com>
References: <1587073370-25963-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

kmemleak reports several memory leaks from devicetree unittest.
This is the fix for problem 5 of 5.

When overlay 'overlay_bad_add_dup_prop' is applied, the apply code
properly detects that a memory leak will occur if the overlay is removed
since the duplicate property is located in a base devicetree node and
reports via printk():

  OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/motor-1/rpm_avail
  OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/motor-1/rpm_avail

The overlay is removed when the apply code detects multiple changesets
modifying the same property.  This is reported via printk():

  OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/rpm_avail

As a result of this error, the overlay is removed resulting in the
expected memory leak.

Add another device node level to the overlay so that the duplicate
property is located in a node added by the overlay, thus no memory
leak will occur when the overlay is removed.

Thus users of kmemleak will not have to debug this leak in the future.

Fixes: 2fe0e8769df9 ("of: overlay: check prevents multiple fragments touching same property")
Reported-by: Erhard F. <erhard_f@mailbox.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 .../of/unittest-data/overlay_bad_add_dup_prop.dts  | 23 ++++++++++++++++++----
 drivers/of/unittest.c                              | 12 +++++------
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/of/unittest-data/overlay_bad_add_dup_prop.dts b/drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
index c190da54f175..6327d1ffb963 100644
--- a/drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
+++ b/drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
@@ -3,22 +3,37 @@
 /plugin/;
 
 /*
- * &electric_1/motor-1 and &spin_ctrl_1 are the same node:
- *   /testcase-data-2/substation@100/motor-1
+ * &electric_1/motor-1/electric and &spin_ctrl_1/electric are the same node:
+ *   /testcase-data-2/substation@100/motor-1/electric
  *
  * Thus the property "rpm_avail" in each fragment will
  * result in an attempt to update the same property twice.
  * This will result in an error and the overlay apply
  * will fail.
+ *
+ * The previous version of this test did not include the extra
+ * level of node 'electric'.  That resulted in the 'rpm_avail'
+ * property being located in the pre-existing node 'motor-1'.
+ * Modifying a property results in a WARNING that a memory leak
+ * will occur if the overlay is removed.  Since the overlay apply
+ * fails, the memory leak does actually occur, and kmemleak will
+ * further report the memory leak if CONFIG_DEBUG_KMEMLEAK is
+ * enabled.  Adding the overlay node 'electric' avoids the
+ * memory leak and thus people who use kmemleak will not
+ * have to debug this non-problem again.
  */
 
 &electric_1 {
 
 	motor-1 {
-		rpm_avail = < 100 >;
+		electric {
+			rpm_avail = < 100 >;
+		};
 	};
 };
 
 &spin_ctrl_1 {
-		rpm_avail = < 100 200 >;
+		electric {
+			rpm_avail = < 100 200 >;
+		};
 };
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index f238b7a3865d..398de04fd19c 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -3181,21 +3181,21 @@ static __init void of_unittest_overlay_high_level(void)
 		   "OF: overlay: ERROR: multiple fragments add and/or delete node /testcase-data-2/substation@100/motor-1/controller");
 
 	EXPECT_BEGIN(KERN_ERR,
-		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/motor-1/rpm_avail");
+		     "OF: overlay: ERROR: multiple fragments add and/or delete node /testcase-data-2/substation@100/motor-1/electric");
 	EXPECT_BEGIN(KERN_ERR,
-		     "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/motor-1/rpm_avail");
+		     "OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/electric/rpm_avail");
 	EXPECT_BEGIN(KERN_ERR,
-		     "OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/rpm_avail");
+		     "OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/electric/name");
 
 	unittest(overlay_data_apply("overlay_bad_add_dup_prop", NULL),
 		 "Adding overlay 'overlay_bad_add_dup_prop' failed\n");
 
 	EXPECT_END(KERN_ERR,
-		   "OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/rpm_avail");
+		     "OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/electric/name");
 	EXPECT_END(KERN_ERR,
-		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/motor-1/rpm_avail");
+		     "OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/electric/rpm_avail");
 	EXPECT_END(KERN_ERR,
-		   "OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/motor-1/rpm_avail");
+		     "OF: overlay: ERROR: multiple fragments add and/or delete node /testcase-data-2/substation@100/motor-1/electric");
 
 	unittest(overlay_data_apply("overlay_bad_phandle", NULL),
 		 "Adding overlay 'overlay_bad_phandle' failed\n");
-- 
Frank Rowand <frank.rowand@sony.com>

