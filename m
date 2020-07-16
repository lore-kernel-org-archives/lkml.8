Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B3FC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 400A320775
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pcJlN2SY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgGPBan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 21:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgGPBam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:30:42 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A01C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 18:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=QGJFiMSbfeA+z6ofvehr13Gl7DJfpvXowrjpat4Kb3s=; b=pcJlN2SY1k2Sf5mQxIAXZgAT+u
        aa9kO5Bb0BxrSNhWueN6XcUV6bAOu8Q4/bnExCNcbfZ8Jk9MYsFgxziigYp0UVCTN2ggfdg2bAa3m
        xghouur2y1C0OMNeuuhaqEdbhjgdxzJ6DhvCu01U0P7I/6QzlGTKA2JtHX+QolsY1vpDSEoqWWhr9
        ZCuoQ2VZ+T7Kkw70nRMmsZSUFCyU8fcG+7bDqSIABc8V1SUsmrmGCmB7eWiPc8Gj3kojERE/e2VN1
        VQdrTtWZ5eZjqL7yPIaaX5ujmdYpTluX+Z2onerPNSQIz3vVl+MAjV9lZ6Qs6/fg1LVjZVCN/iSXg
        F9P7uHOg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvsjL-0000XC-O1; Thu, 16 Jul 2020 01:30:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] linux/sched/mm.h: drop duplicated words in comments
To:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>
Message-ID: <927ea8d8-3f6c-9b65-4c2b-63ab4bd59ef1@infradead.org>
Date:   Wed, 15 Jul 2020 18:30:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop doubled words "to" and "that".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 include/linux/sched/mm.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20200714.orig/include/linux/sched/mm.h
+++ linux-next-20200714/include/linux/sched/mm.h
@@ -23,7 +23,7 @@ extern struct mm_struct *mm_alloc(void);
  * will still exist later on and mmget_not_zero() has to be used before
  * accessing it.
  *
- * This is a preferred way to to pin @mm for a longer/unbounded amount
+ * This is a preferred way to pin @mm for a longer/unbounded amount
  * of time.
  *
  * Use mmdrop() to release the reference acquired by mmgrab().
@@ -234,7 +234,7 @@ static inline unsigned int memalloc_noio
  * @flags: Flags to restore.
  *
  * Ends the implicit GFP_NOIO scope started by memalloc_noio_save function.
- * Always make sure that that the given flags is the return value from the
+ * Always make sure that the given flags is the return value from the
  * pairing memalloc_noio_save call.
  */
 static inline void memalloc_noio_restore(unsigned int flags)
@@ -265,7 +265,7 @@ static inline unsigned int memalloc_nofs
  * @flags: Flags to restore.
  *
  * Ends the implicit GFP_NOFS scope started by memalloc_nofs_save function.
- * Always make sure that that the given flags is the return value from the
+ * Always make sure that the given flags is the return value from the
  * pairing memalloc_nofs_save call.
  */
 static inline void memalloc_nofs_restore(unsigned int flags)

