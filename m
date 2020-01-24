Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B42C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 13:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEF92072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 13:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579873277;
	bh=I623IPMBZkN/NHAhJa9WzwohcO2Gmhn/AsZZAnTZPeE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=g2nxM3WGRFBQb/3FaBUfSVoh/2tXoVNtoZ7ATD4BfLOLQlRaOhNjKA91pewTpjJLc
	 F8oherMOjoZOONTVDycePQnmDNtPdoycQn80IrckU9DiW4Lv1qcXh92E+yk8kV2IIi
	 uGG0EW9Yai1ajpW+0sQi8XnO/Tcu/rRjSEnUbOUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389908AbgAXNlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 08:41:16 -0500
Received: from foss.arm.com ([217.140.110.172]:51768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387743AbgAXNlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 08:41:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B5591FB;
        Fri, 24 Jan 2020 05:41:15 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F2263F68E;
        Fri, 24 Jan 2020 05:41:14 -0800 (PST)
From:   Mark Brown <broonie@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] random: Document add_hwgenerator_randomness() with other input functions
Date:   Fri, 24 Jan 2020 13:41:06 +0000
Message-Id: <20200124134106.8472-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The section at the top of random.c which documents the input functions
available does not document add_hwgenerator_randomness() which might lead
a reader to overlook it. Add a brief note about it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/char/random.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index c7f9584de2c8..16070c36add3 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -228,6 +228,14 @@
  * particular randomness source.  They do this by keeping track of the
  * first and second order deltas of the event timings.
  *
+ * There is also an interface for true hardware RNGs:
+ *
+ *	void add_hwgenerator_randomness(const char *buffer, size_t count,
+ *				size_t entropy);
+ *
+ * This will credit entropy as specified by the caller, if the entropy
+ * pool is full it will block until more entropy is needed.
+ *
  * Ensuring unpredictability at system startup
  * ============================================
  *
-- 
2.20.1

