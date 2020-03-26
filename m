Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3537BC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 01:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE03220714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 01:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nM+vPiUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgCZBrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 21:47:16 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37175 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgCZBrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 21:47:15 -0400
Received: by mail-qk1-f196.google.com with SMTP id x3so4938641qki.4;
        Wed, 25 Mar 2020 18:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5wd/zw98nuWqyLvhS++Ejmu/Z/A9wzpD5MWi9/URyhg=;
        b=nM+vPiUZo+ZJ+zg9ad54B1xME/CHKQOdSKXxe+WTl9fH4QMqfoob+QrnnD3wucPibP
         Ggx4x0QhlyKKKbpcMKhdU3ndrzZ2kli4ocNSSwpbIh0kS3cyeCH3FhR+xAPjY4OlNlIa
         EkVmUE684w9HOs9oty2GP9YHbsuWeQOdqeIFC6W+JJp2BCV/9YQpZcadewZWV/B2SVZ+
         6dMCW/oaMoGNcr+lIGbGVFDYBOXnmNH8cb7DG8uvzYw9ONUPXAOrmHMzg2xBWOE6jp9Z
         rQLQVUwvIRfhd1mqzjTfN2o/QVVvCFuGgUC4i7VC89HvN4ktwVeKGfvW424mbRSIlTSh
         PACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5wd/zw98nuWqyLvhS++Ejmu/Z/A9wzpD5MWi9/URyhg=;
        b=JD9aJcsQWDLbUX+MGGm8ljmBqAC1yzHYxUj0sgNCJLLzJRFEYZLGuKBDljB6Zt1Min
         zW8NBHhpqRsW28WZ9uJVrjzltQbMnCUxAKs1nzUdeJobRY4JQz1F3HT09Zr3+545p5mG
         XTJvlxUgvkV8ycqvC9fcrkwAAS8AWLj3uK6tpvKBHt/6zt6GSS2bEK5p0rqsvxEsfdoM
         SzgeVR4y8M7h3tb1snBgr2QbbC/dBMD6+eXWxZ+7XCF/abIE4gwzf1F6gugg4Rbq45uv
         r250xksE8Ws//o0D2RZeVMy6pcLeDdEmOhuMKNltc6clwHeJBNz+8zcqzr5MZxBZKcte
         2mmw==
X-Gm-Message-State: ANhLgQ363caNDjEULqwQtyAhDGGrQfL21DugCW3txhCc3esiOpysM+BX
        b+f3BXC5wWY1gOWOLEfLxkM=
X-Google-Smtp-Source: ADFU+vs7JO1GzICkH0QesQ7atv64SQuGCyLZDOzXAUUEsEVpAMu19Xa6XMT3NFOuOX7f8n1lawo6QA==
X-Received: by 2002:a37:4644:: with SMTP id t65mr4550054qka.239.1585187233634;
        Wed, 25 Mar 2020 18:47:13 -0700 (PDT)
Received: from localhost.localdomain (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id h129sm463552qkf.54.2020.03.25.18.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Mar 2020 18:47:13 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Subject: [PATCH 2/2] of: some unittest overlays not untracked
Date:   Wed, 25 Mar 2020 20:45:31 -0500
Message-Id: <1585187131-21642-3-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1585187131-21642-1-git-send-email-frowand.list@gmail.com>
References: <1585187131-21642-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

kernel test robot reported "WARNING: held lock freed!" triggered by
unittest_gpio_remove(), which should not have been called because
the related gpio overlay was not tracked.  Another overlay that
was tracked had previously used the same id as the gpio overlay
but had not been untracked when the overlay was removed.  Thus the
clean up function of_unittest_destroy_tracked_overlays() incorrectly
attempted to remove the reused overlay id.

Patch contents:

  - Create tracking related helper functions
  - Change BUG() to WARN_ON() for overlay id related issues
  - Add some additional error checking for valid overlay id values
  - Add the missing overlay untrack
  - update comment on expectation that overlay ids are assigned in
    sequence

Fixes: 492a22aceb75 ("of: unittest: overlay: Keep track of created overlays")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 25911ad1ce99..27f538f859a6 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1689,19 +1689,27 @@ static const char *overlay_name_from_nr(int nr)
 
 static const char *bus_path = "/testcase-data/overlay-node/test-bus";
 
-/* it is guaranteed that overlay ids are assigned in sequence */
+/* FIXME: it is NOT guaranteed that overlay ids are assigned in sequence */
+
 #define MAX_UNITTEST_OVERLAYS	256
 static unsigned long overlay_id_bits[BITS_TO_LONGS(MAX_UNITTEST_OVERLAYS)];
 static int overlay_first_id = -1;
 
+static long of_unittest_overlay_tracked(int id)
+{
+	if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS))
+		return 0;
+	return overlay_id_bits[BIT_WORD(id)] & BIT_MASK(id);
+}
+
 static void of_unittest_track_overlay(int id)
 {
 	if (overlay_first_id < 0)
 		overlay_first_id = id;
 	id -= overlay_first_id;
 
-	/* we shouldn't need that many */
-	BUG_ON(id >= MAX_UNITTEST_OVERLAYS);
+	if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS))
+		return;
 	overlay_id_bits[BIT_WORD(id)] |= BIT_MASK(id);
 }
 
@@ -1710,7 +1718,8 @@ static void of_unittest_untrack_overlay(int id)
 	if (overlay_first_id < 0)
 		return;
 	id -= overlay_first_id;
-	BUG_ON(id >= MAX_UNITTEST_OVERLAYS);
+	if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS))
+		return;
 	overlay_id_bits[BIT_WORD(id)] &= ~BIT_MASK(id);
 }
 
@@ -1726,7 +1735,7 @@ static void of_unittest_destroy_tracked_overlays(void)
 		defers = 0;
 		/* remove in reverse order */
 		for (id = MAX_UNITTEST_OVERLAYS - 1; id >= 0; id--) {
-			if (!(overlay_id_bits[BIT_WORD(id)] & BIT_MASK(id)))
+			if (!of_unittest_overlay_tracked(id))
 				continue;
 
 			ovcs_id = id + overlay_first_id;
@@ -1743,7 +1752,7 @@ static void of_unittest_destroy_tracked_overlays(void)
 				continue;
 			}
 
-			overlay_id_bits[BIT_WORD(id)] &= ~BIT_MASK(id);
+			of_unittest_untrack_overlay(id);
 		}
 	} while (defers > 0);
 }
@@ -1804,7 +1813,7 @@ static int __init of_unittest_apply_revert_overlay_check(int overlay_nr,
 		int unittest_nr, int before, int after,
 		enum overlay_type ovtype)
 {
-	int ret, ovcs_id;
+	int ret, ovcs_id, save_id;
 
 	/* unittest device must be in before state */
 	if (of_unittest_device_exists(unittest_nr, ovtype) != before) {
@@ -1832,6 +1841,7 @@ static int __init of_unittest_apply_revert_overlay_check(int overlay_nr,
 		return -EINVAL;
 	}
 
+	save_id = ovcs_id;
 	ret = of_overlay_remove(&ovcs_id);
 	if (ret != 0) {
 		unittest(0, "%s failed to be destroyed @\"%s\"\n",
@@ -1839,6 +1849,7 @@ static int __init of_unittest_apply_revert_overlay_check(int overlay_nr,
 				unittest_path(unittest_nr, ovtype));
 		return ret;
 	}
+	of_unittest_untrack_overlay(save_id);
 
 	/* unittest device must be again in before state */
 	if (of_unittest_device_exists(unittest_nr, PDEV_OVERLAY) != before) {
@@ -2528,6 +2539,11 @@ static void __init of_unittest_overlay_gpio(void)
 	 * Similar to installing a driver as a module, the
 	 * driver is registered after applying the overlays.
 	 *
+	 * The overlays are applied by overlay_data_apply()
+	 * instead of of_unittest_apply_overlay() so that they
+	 * will not be tracked.  Thus they will not be removed
+	 * by of_unittest_destroy_tracked_overlays().
+	 *
 	 * - apply overlay_gpio_01
 	 * - apply overlay_gpio_02a
 	 * - apply overlay_gpio_02b
-- 
Frank Rowand <frank.rowand@sony.com>

