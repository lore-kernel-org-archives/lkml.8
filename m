Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB627C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AEA420717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b0fB/nkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgGQXhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgGQXhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:37:46 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F160C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 16:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=CX+e1T7Qgez0rfBy3xl+GOd4hDhE3xnwRQ0EdSeoV+0=; b=b0fB/nkUZ/juzC6vjYeelGkPUW
        TIqOUy8DweghGGJveLG1iQtUaGYHf3cGwMxBEtRJ3MXYUIT330xcA2+UqzuQ/mnnEh5cere8jnj86
        PxRcbwOqPgiTd6mnpcaPEqKR7WxEpxib3GkDTbp3JgQ6lSp8gGVk3b7/QlEde6dWyOVpadxw5q8pI
        THpd1AXyDs07QkSRfGJlOt9J1n1WuXh1rphOHZG4inI+RV4i61qiSfFL3mos9/KO5HAPDqd1QnZ1A
        Jf/CT8uIXzihTBjpHKnJU/a3h9z1IA3dDWG4gZ+woVul78+Tlq8KC3C3yV7s2/uqfRCgUC/Q72YDK
        Pq8MLZsQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwZvC-0006bq-9v; Fri, 17 Jul 2020 23:37:42 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] xz: drop duplicated word in <linux/xz.h>
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lasse Collin <lasse.collin@tukaani.org>
Message-ID: <05ebba7a-c1e4-01ae-fc7b-15c081b33f3e@infradead.org>
Date:   Fri, 17 Jul 2020 16:37:38 -0700
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

Drop the doubled word "than" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/xz.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/linux/xz.h
+++ linux-next-20200714/include/linux/xz.h
@@ -28,7 +28,7 @@
  * enum xz_mode - Operation mode
  *
  * @XZ_SINGLE:              Single-call mode. This uses less RAM than
- *                          than multi-call modes, because the LZMA2
+ *                          multi-call modes, because the LZMA2
  *                          dictionary doesn't need to be allocated as
  *                          part of the decoder state. All required data
  *                          structures are allocated at initialization,

