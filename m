Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B83C433E5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2199A206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WExlvRM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgGZAkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgGZAk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:40:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBACC08C5C0;
        Sat, 25 Jul 2020 17:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/Bvv+8RY6P48JwFU2vesZXarPVzAbJ8VaoK9tAhVoHI=; b=WExlvRM5/a5YLeyWGzvAlq9haM
        xnDba1eTY0/20dwq+O/CFD7EAveXRylx6mHdpz+alzawm04vi4EX7XNlvBHArqKn3tImRdmZpYcoT
        kBVqLh/Tzp5rEF22WWWfgENtuQZ5EhAQl/R9wDe+t617iznGSRNrYwRO9v4MWKnFRayXosDtWBkka
        EEvHdmPuwGPlf6BXQX0aggQnza4xC9qrDf727YBPz/isUKbkNA1ZDX/E9a4Za0jFBT2QJEX5UJ1R5
        +4tlg88x7b7GD0d0z2rZ69FayeGCCFl7kaopRByCkm2cu7hlvpOLT+c+na8Px7G1nPl871MHd6L4C
        IxiBz2eA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUiH-0003NC-Q6; Sun, 26 Jul 2020 00:40:26 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: [PATCH 5/5] ia64: kernel: perfmon_m*.h: delete duplicated words
Date:   Sat, 25 Jul 2020 17:40:13 -0700
Message-Id: <20200726004013.20534-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726004013.20534-1-rdunlap@infradead.org>
References: <20200726004013.20534-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the repeated word "the" in two places.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
---
 arch/ia64/kernel/perfmon_mckinley.h  |    2 +-
 arch/ia64/kernel/perfmon_montecito.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200720.orig/arch/ia64/kernel/perfmon_mckinley.h
+++ linux-next-20200720/arch/ia64/kernel/perfmon_mckinley.h
@@ -92,7 +92,7 @@ pfm_mck_pmc_check(struct task_struct *ta
 	/*
 	 * we must clear the debug registers if pmc13 has a value which enable
 	 * memory pipeline event constraints. In this case we need to clear the
-	 * the debug registers if they have not yet been accessed. This is required
+	 * debug registers if they have not yet been accessed. This is required
 	 * to avoid picking stale state.
 	 * PMC13 is "active" if:
 	 * 	one of the pmc13.cfg_dbrpXX field is different from 0x3
--- linux-next-20200720.orig/arch/ia64/kernel/perfmon_montecito.h
+++ linux-next-20200720/arch/ia64/kernel/perfmon_montecito.h
@@ -174,7 +174,7 @@ pfm_mont_pmc_check(struct task_struct *t
 	/*
 	 * we must clear the debug registers if pmc41 has a value which enable
 	 * memory pipeline event constraints. In this case we need to clear the
-	 * the debug registers if they have not yet been accessed. This is required
+	 * debug registers if they have not yet been accessed. This is required
 	 * to avoid picking stale state.
 	 * PMC41 is "active" if:
 	 * 	one of the pmc41.cfg_dtagXX field is different from 0x3
