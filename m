Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1370C433EC
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF1FE20719
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t13M84+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgGZAeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgGZAen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:34:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE414C08C5C0;
        Sat, 25 Jul 2020 17:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8wofnX+791P80MuJAV6iQxesMHh82XaMA5nH+wlVEnQ=; b=t13M84+K/VdkyCs1w5IwasCD81
        +pOvThEn0EYb/g7Ck+XCiIx4F4ykld5FIS8lqiIP14N4O/tNVHiFIeRcwp/UWeXFrDytYo+uobWaS
        O+v+b5KEJwwlT5/yPrvJlLU+zoRQuNrHMRkkvl6DFe0jd7zP0F9jfHJkqurvc9/7Yv0acK6h6bipY
        wrakHpxbxpoOpQJqQUGNHQiDIt0dMWqvUTrxjgKssB82wT1COgfn9mNkOxIAubWyglgqVBd+Q6ReX
        4QNESueAGRTpw3DO0CcJIHF83ViW/QU1pvevJiDKST8+rS9Mw1Tdxyd17gvnXyd3jsuKUNUFhTeWA
        OFcdsz4A==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUcj-000328-0s; Sun, 26 Jul 2020 00:34:41 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH 5/6] mips: octeon: cvmx-pow.h: fix duplicated words
Date:   Sat, 25 Jul 2020 17:34:28 -0700
Message-Id: <20200726003429.20356-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726003429.20356-1-rdunlap@infradead.org>
References: <20200726003429.20356-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the repeated words "Returns" and convert to kernel-doc
notation by adding a ':'.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
---
 arch/mips/include/asm/octeon/cvmx-pow.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20200720.orig/arch/mips/include/asm/octeon/cvmx-pow.h
+++ linux-next-20200720/arch/mips/include/asm/octeon/cvmx-pow.h
@@ -1345,7 +1345,7 @@ static inline void cvmx_pow_tag_sw_wait(
  * @wait:   When set, call stalls until work becomes avaiable, or times out.
  *		 If not set, returns immediately.
  *
- * Returns Returns the WQE pointer from POW. Returns NULL if no work
+ * Returns: the WQE pointer from POW. Returns NULL if no work
  * was available.
  */
 static inline struct cvmx_wqe *cvmx_pow_work_request_sync_nocheck(cvmx_pow_wait_t
@@ -1379,7 +1379,7 @@ static inline struct cvmx_wqe *cvmx_pow_
  * @wait:   When set, call stalls until work becomes avaiable, or times out.
  *		 If not set, returns immediately.
  *
- * Returns Returns the WQE pointer from POW. Returns NULL if no work
+ * Returns: the WQE pointer from POW. Returns NULL if no work
  * was available.
  */
 static inline struct cvmx_wqe *cvmx_pow_work_request_sync(cvmx_pow_wait_t wait)
@@ -1398,7 +1398,7 @@ static inline struct cvmx_wqe *cvmx_pow_
  * This function waits for any previous tag switch to complete before
  * requesting the null_rd.
  *
- * Returns Returns the POW state of type cvmx_pow_tag_type_t.
+ * Returns: the POW state of type cvmx_pow_tag_type_t.
  */
 static inline enum cvmx_pow_tag_type cvmx_pow_work_request_null_rd(void)
 {
@@ -1482,7 +1482,7 @@ static inline void cvmx_pow_work_request
  * @scr_addr: Scratch memory address to get result from Byte address,
  *	      must be 8 byte aligned.
  *
- * Returns Returns the WQE from the scratch register, or NULL if no
+ * Returns: the WQE from the scratch register, or NULL if no
  * work was available.
  */
 static inline struct cvmx_wqe *cvmx_pow_work_response_async(int scr_addr)
