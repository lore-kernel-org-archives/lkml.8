Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1740BC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E604C20776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587732012;
	bh=+vdKnDcBEieV3yadyUoOrGcDswj08iAZns741Z0Kr4U=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=g7IdDuUNfrIKWl5isB9+YDzXhNcCiQtc7CFQHSlxwagfyF7ZB3w1EyivqePg2iYft
	 yjjKuh31AZCeQ25YyzeqcwV1a8iT2dLBnGiba2YvhTk0nldsPRZMfa6cy2pRcjo8xI
	 n8MF/aqw1CqtlUretIj0gfEN6MSaUirUrpJp+fPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgDXMkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbgDXMkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:40:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F27220704;
        Fri, 24 Apr 2020 12:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587732011;
        bh=+vdKnDcBEieV3yadyUoOrGcDswj08iAZns741Z0Kr4U=;
        h=From:To:Cc:Subject:Date:From;
        b=A8chcFzo+owc6vCA5A9/L4mEkgEdgHo0gcjo9UM7exp5VopKB85xHx2M9dYyFAdaw
         ENBO69Sh/qYM7YJH/FYuT5tHYwu4ObZ8INnPG0rclhElvMPX1MDqypleDFZHtZ6TMK
         Nn6JmIxKwiSYgoURDFR3fgjjTeqsknDmniSw1veQ=
From:   Mark Brown <broonie@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] random: Document add_hwgenerator_randomness() with other input functions
Date:   Fri, 24 Apr 2020 13:39:59 +0100
Message-Id: <20200424123959.45559-1-broonie@kernel.org>
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
index 0d10e31fd342..ba2dc45bf718 100644
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

