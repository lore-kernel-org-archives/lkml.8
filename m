Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11979C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD26D214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nMndJjSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgA0PcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:32:23 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:54287 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgA0PcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 10:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580139143; x=1611675143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=w5hA1PF90OTjQxM6N8ucGOURntMZjlaqhctLj5i7xTA=;
  b=nMndJjSSLCFFj860XwLv0g62Qu9YJ6BNi3Sr2zDbV2X15W4jzHduzCVX
   X3T/+KNO4z1GaoQaxOX64TF9cprPKP9XXqYrbKNk5iu64xpG77sTrrZPV
   zZbSmEkCsTVRu1DHH2VlxtxFyoqOtAm5pVyU+nkwWPIFXzWI/KbzsnWxA
   A=;
IronPort-SDR: Ds4euVgMziH+yDZ6yIO2TDL1xDyfD3I+sNhQgqD6cB5icmpdB2It3PFfH2yjWFp+m1z4mpPzmT
 +abll6g5a2Ow==
X-IronPort-AV: E=Sophos;i="5.70,370,1574121600"; 
   d="scan'208";a="14323896"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 27 Jan 2020 15:32:21 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS id 198F8A1F4B;
        Mon, 27 Jan 2020 15:32:20 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 27 Jan 2020 15:32:19 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.48) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 27 Jan 2020 15:32:16 +0000
From:   <sjpark@amazon.com>
To:     <brendanhiggins@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH] docs/kunit/start: Use '_KUNIT_TEST' config name suffix
Date:   Mon, 27 Jan 2020 16:32:01 +0100
Message-ID: <20200127153201.3908-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200126015924.4198-1-sj38.park@gmail.com>
References: <20200126015924.4198-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.48]
X-ClientProxiedBy: EX13D30UWB004.ant.amazon.com (10.43.161.51) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

It is recommended to use '_KUNIT_TEST' config name suffix for kunit
tests but the example is using only '_TEST' suffix.  This commit fixes
it to also use '_KUNIT_TEST' suffix.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/dev-tools/kunit/start.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 4e1d24db6b13..2f8b4eda97eb 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -138,7 +138,7 @@ Now add the following to ``drivers/misc/Kconfig``:
 
 .. code-block:: kconfig
 
-	config MISC_EXAMPLE_TEST
+	config MISC_EXAMPLE_KUNIT_TEST
 		bool "Test for my example"
 		depends on MISC_EXAMPLE && KUNIT
 
@@ -146,14 +146,14 @@ and the following to ``drivers/misc/Makefile``:
 
 .. code-block:: make
 
-	obj-$(CONFIG_MISC_EXAMPLE_TEST) += example-test.o
+	obj-$(CONFIG_MISC_EXAMPLE_KUNIT_TEST) += example-test.o
 
 Now add it to your ``.kunitconfig``:
 
 .. code-block:: none
 
 	CONFIG_MISC_EXAMPLE=y
-	CONFIG_MISC_EXAMPLE_TEST=y
+	CONFIG_MISC_EXAMPLE_KUNIT_TEST=y
 
 Now you can run the test:
 
-- 
2.17.1

