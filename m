Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E142C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EED12221F7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXvKSBSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgDPVos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725843AbgDPVoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:44:46 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AEFC061A0C;
        Thu, 16 Apr 2020 14:44:46 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g74so250620qke.13;
        Thu, 16 Apr 2020 14:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wr8GZzoV2Cnz7mFH5kt1T9+qrdCylLR2WkcJ8cSy10A=;
        b=bXvKSBSut0tyQ+ae2/DNyQzBAeYLw+GiS1ANlbDjPYDV1tJfM/lY64xNVxlIiP5vxq
         5UGNYcm6Jov0xXnTxW1XamrYE49FWUw/lPHC5oo3jaHki9ml/C+CKgm9xT2kpHylSpX1
         XxCQdcFIRHmT/q/BSyGKT9/ddGtf7izuaG3y19PyeBkTIxRbf4bJ54gECTtECfn9MhHp
         2dTZLnOFkWa5gqVn/VYXIek/5hzkx+Th45JVE0CRYQ2GxEw9aXl3n4++4OCEGlHFm4oK
         c0zKAZvB+ci2m6WlBWSMcjz2k9X81YwJswwqj6LWH/ZpapbZkH4SwIuVAkGd3IPoEa9H
         ftsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wr8GZzoV2Cnz7mFH5kt1T9+qrdCylLR2WkcJ8cSy10A=;
        b=cE7lKCvOsZYbcNH4ztwVH+nWKf+JxqbTsUvdsBqJRDVb4vR5JZGgZ8wCQB2YyN2NzB
         72mUmP7yjSgbQoRGG8cIPepQu4YEJiJN+otD7gIEsrciwcRwrA/i9pPPskTJ5W/a1e+q
         BZVFlp/voUKkBZsDCrzyt3XXnE4T6KV73w0xrkaNlF9PcMBlgLBEdI0U1aEvnF3SuNUF
         iN0vW1ETTZ3byds2X6hBCfqUEzs1df2nsFDijd0ZwpghISv1B9kvryhR/A9SX0N4adxg
         1DHAwnYsLqM+oYF32Q5e75Q94YctXyU4j0crZzi9rzgURGSrXjwsd83HKGga7v5XsY8e
         C95w==
X-Gm-Message-State: AGi0PuYguF6Obn8IQ/UGT1YdXLFbvaSiAbnrqeZeAhg8wKpobzVf3wGh
        rpXi7vW/wFb6fSrjTn6JBGXK7i/1
X-Google-Smtp-Source: APiQypJUSqu2xrd9x8TBoOp+QP2H10ctNK/QK050IRVHwhEuzj4v6F9jOcDtDLJY0X4T+BAIm5K1nA==
X-Received: by 2002:a37:7a46:: with SMTP id v67mr111168qkc.87.1587073485769;
        Thu, 16 Apr 2020 14:44:45 -0700 (PDT)
Received: from localhost.localdomain (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id z34sm3164141qth.43.2020.04.16.14.44.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 14:44:45 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Erhard F." <erhard_f@mailbox.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Subject: [PATCH 2/5] of: unittest: kmemleak in of_unittest_platform_populate()
Date:   Thu, 16 Apr 2020 16:42:47 -0500
Message-Id: <1587073370-25963-3-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1587073370-25963-1-git-send-email-frowand.list@gmail.com>
References: <1587073370-25963-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

kmemleak reports several memory leaks from devicetree unittest.
This is the fix for problem 2 of 5.

of_unittest_platform_populate() left an elevated reference count for
grandchild nodes (which are platform devices).  Fix the platform
device reference counts so that the memory will be freed.

Fixes: fb2caa50fbac ("of/selftest: add testcase for nodes with same name and address")
Reported-by: Erhard F. <erhard_f@mailbox.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 20ff2dfc3143..4c7818276857 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1247,10 +1247,13 @@ static void __init of_unittest_platform_populate(void)
 
 	of_platform_populate(np, match, NULL, &test_bus->dev);
 	for_each_child_of_node(np, child) {
-		for_each_child_of_node(child, grandchild)
-			unittest(of_find_device_by_node(grandchild),
+		for_each_child_of_node(child, grandchild) {
+			pdev = of_find_device_by_node(grandchild);
+			unittest(pdev,
 				 "Could not create device for node '%pOFn'\n",
 				 grandchild);
+			of_dev_put(pdev);
+		}
 	}
 
 	of_platform_depopulate(&test_bus->dev);
-- 
Frank Rowand <frank.rowand@sony.com>

