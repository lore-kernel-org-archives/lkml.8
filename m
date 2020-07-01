Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A18C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E154020747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 17:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593623768;
	bh=4pQEL9GAKpebhXDIivKoJIWTFshjCyetr1Oi5KUn1kA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XQZeeoBV03LiBT44nogOzZ3C0+DXezrhd5QWI36XEMyzWD8uMeJzX1vREEHG7eKH/
	 7KXnONWYkSt6WMSmb/kYShu/4/UDtlAy4ecONPqU2b3kCcMcXxJcSFW9PlxS16yl1h
	 BapiWO+KNohO59+B55Gyb2mSgKh961VWRuA7A3yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732697AbgGARQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 13:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732632AbgGARQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 13:16:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54D4E20747;
        Wed,  1 Jul 2020 17:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593623766;
        bh=4pQEL9GAKpebhXDIivKoJIWTFshjCyetr1Oi5KUn1kA=;
        h=From:To:Cc:Subject:Date:From;
        b=FVcie8cyf0QNx2kxJYXGM/ya/PMkhz/RXOdx7Ih6WitPSxj7pUdafOtjKOS1DaqHt
         6wz1TK6wuJxRiAToWh/T7TGjR8PVJ0GBB2d/nKZVn1Gy4HgX/IH7JaBW7ybRVqL+Bx
         Yz87QG7CEkyQ2HiP7FsHLP6iohdX75D9UirI6v64=
From:   Mark Brown <broonie@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] random: Document add_hwgenerator_randomness() with other input functions
Date:   Wed,  1 Jul 2020 18:15:58 +0100
Message-Id: <20200701171558.10539-1-broonie@kernel.org>
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
index 2a41b21623ae..fc822842eb0e 100644
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

