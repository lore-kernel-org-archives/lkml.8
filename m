Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB85C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AAE120719
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t+MKrRZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgGZAen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgGZAel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:34:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFB3C08C5C0;
        Sat, 25 Jul 2020 17:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nBk4Q7orQIK0jkBUUDU0U2iWDTc0Pyf+uhCmouq6Ync=; b=t+MKrRZZSDsom1JbZ3a3QgFdY+
        BLgIrrwYyCYyLE/QDDh0AqbrwZCCaPHxLI34brPowCrMpOkGFKm1K0UWokYCwEPSD3GxdxXZ6Uw5y
        8mU7XtahRRPW6WFyTM+utqnkSlkPpK7DMv4fnof08OzEJochB3O9QPnMu9vURw/13GFrhhD8S3MkH
        sqOWT1/qyspkEBnG2uVqXK1A+S8c+gxNsRj6qDtwZeRVKM+neCePTYskNWMwMBVH0yGNQ7SXPneps
        5PEheFBYiMzGG1d6AVjbqJfU4R7mo545bnkxwKHiqmELyM0S25v/gO4KJO9Ix98Nf8TwkXIrAkCnl
        ep245+sQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUch-000328-Ad; Sun, 26 Jul 2020 00:34:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH 4/6] mips: octeon: cvmx-pkoh: fix duplicated words
Date:   Sat, 25 Jul 2020 17:34:27 -0700
Message-Id: <20200726003429.20356-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726003429.20356-1-rdunlap@infradead.org>
References: <20200726003429.20356-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the repeated word "command".
Delete the repeated words "returns" and convert to kernel-doc notation
by adding a ':'.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
---
 arch/mips/include/asm/octeon/cvmx-pko.h |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- linux-next-20200720.orig/arch/mips/include/asm/octeon/cvmx-pko.h
+++ linux-next-20200720/arch/mips/include/asm/octeon/cvmx-pko.h
@@ -40,8 +40,7 @@
  * generic code while CVMX_PKO_LOCK_CMD_QUEUE should be used
  * with hand tuned fast path code.
  *
- * Some of other SDK differences visible to the command command
- * queuing:
+ * Some of other SDK differences visible to the command queuing:
  * - PKO indexes are no longer stored in the FAU. A large
  *   percentage of the FAU register block used to be tied up
  *   maintaining PKO queue pointers. These are now stored in a
@@ -413,7 +412,7 @@ static inline void cvmx_pko_send_packet_
  * @use_locking: CVMX_PKO_LOCK_NONE, CVMX_PKO_LOCK_ATOMIC_TAG, or
  *		 CVMX_PKO_LOCK_CMD_QUEUE
  *
- * Returns returns CVMX_PKO_SUCCESS on success, or error code on
+ * Returns: CVMX_PKO_SUCCESS on success, or error code on
  * failure of output
  */
 static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(
@@ -456,7 +455,7 @@ static inline cvmx_pko_status_t cvmx_pko
  * @use_locking: CVMX_PKO_LOCK_NONE, CVMX_PKO_LOCK_ATOMIC_TAG, or
  *		 CVMX_PKO_LOCK_CMD_QUEUE
  *
- * Returns returns CVMX_PKO_SUCCESS on success, or error code on
+ * Returns: CVMX_PKO_SUCCESS on success, or error code on
  * failure of output
  */
 static inline cvmx_pko_status_t cvmx_pko_send_packet_finish3(
