Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19370C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF15121775
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qJfTGxJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgGSAcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 20:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgGSAcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:32:01 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F59DC0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 17:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=qvXy4k9bhHOdfjshhjvQgkxfOWcS9CHZYJ8mc1rdLys=; b=qJfTGxJHl8DyJzFA9fR1SGo7Xs
        ZGmFuc78SoTV4iOqC7CwIsqh33dVEV7L99ASc+V1Mty8GtUVJ5NBPC964saE9LtMk+qeKuNI5yTDz
        +ntSjvSXH8SJpPjZPM5mThwHFkNfu1ieyIE/FuV2ZsuiuczpXLn/sGJ7igYQSzOhgv2dw+5i2yNER
        97QrNE1PUL4LGarUKhTGc08ztKwdITIC2r7+kpLYJ8OwZNKL/qn852xkoATVkTUcqGgKKue2PXArr
        Jj6Ml9JxYVBCuTrkMCiAnAALlIb3kKQlUuu6gBPsqKh4c5rbZALwYpe/jhepq5C1u73nfthCmg9j1
        WfAOB86Q==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxFH-0002yU-7s; Sun, 19 Jul 2020 00:31:59 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH] STM: <linux/stm.h>: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:31:55 -0700
Message-Id: <20200719003155.21150-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 include/linux/stm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/linux/stm.h
+++ linux-next-20200717/include/linux/stm.h
@@ -57,7 +57,7 @@ struct stm_device;
  *
  * Normally, an STM device will have a range of masters available to software
  * and the rest being statically assigned to various hardware trace sources.
- * The former is defined by the the range [@sw_start..@sw_end] of the device
+ * The former is defined by the range [@sw_start..@sw_end] of the device
  * description. That is, the lowest master that can be allocated to software
  * writers is @sw_start and data from this writer will appear is @sw_start
  * master in the STP stream.
