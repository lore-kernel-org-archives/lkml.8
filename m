Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2722C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F53320700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B8LK3u5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgGZAkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgGZAkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:40:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E7DC08C5C0;
        Sat, 25 Jul 2020 17:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=N1E0vLjy0AjMlCoxNGo/CEj36oz02xk+iJm2bFMzjSA=; b=B8LK3u5bxGigCq5pW/LfGWZU5o
        b9d5nilEIJ5iNEKOYsUJ5DnNrYdEnjU7+/W7Zewx8JtdzaVBhA4roftyGYpouKD3Oa1TJiKVPGqxU
        CW1wK2ibcXlM9++twmwUxbaAto71bPT5wNRk/3ukc6KwLdJ0jRzmNMXBSZ569lBSP6Qw2W3OwJK+7
        bnBSd+EHpYu2H/MKAVTSaL3DvY0guDqOWMxxb+I0VMfx5NsHku0JlRnfnTBZ9Vq8wwDu2rIFmPuSh
        uKnLi0jOg4KP+EAcrZ79Ky1MSFlw1Y7TOoKv5h5NKZx+sSnLVczcbAKuL3wibJZILDaRqBx5PL2JT
        jPKkcDXQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUiC-0003NC-De; Sun, 26 Jul 2020 00:40:20 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: [PATCH 2/5] ia64: perfmon.h: delete duplicated word
Date:   Sat, 25 Jul 2020 17:40:10 -0700
Message-Id: <20200726004013.20534-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726004013.20534-1-rdunlap@infradead.org>
References: <20200726004013.20534-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the repeated word "of".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
---
 arch/ia64/include/asm/perfmon.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/ia64/include/asm/perfmon.h
+++ linux-next-20200720/arch/ia64/include/asm/perfmon.h
@@ -53,7 +53,7 @@ typedef struct {
 	unsigned short  active_set;			/* event set active at the time of the overflow */
 	pfm_ovfl_ctrl_t ovfl_ctrl;			/* return: perfmon controls to set by handler */
 
-	unsigned long   pmd_last_reset;			/* last reset value of of the PMD */
+	unsigned long   pmd_last_reset;			/* last reset value of the PMD */
 	unsigned long	smpl_pmds[4];			/* bitmask of other PMD of interest on overflow */
 	unsigned long   smpl_pmds_values[PMU_MAX_PMDS]; /* values for the other PMDs of interest */
 	unsigned long   pmd_value;			/* current 64-bit value of the PMD */
