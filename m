Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60DCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 904FE2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3Aq1EOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405274AbgFXQw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:52:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35974 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404017AbgFXQw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593017546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YgOG3Qn9UrbkC82Csvd2S1YBbX7wsXZhXBrd7kB7GaE=;
        b=C3Aq1EOxuQXfzCxHMRimNJ+GXjogDz2LvE7uonKeZwnQqWLNMMHAX240bo06L360qLJeia
        Jwk+i62GJ9eAnMeMb6grGCoAwCgKEGzplRcDWuIMUUH4W6CSnuSZFLUcOcva+7RkFK/1BO
        NtL/Pd57oecoq0dB17BNYgTunDsYClw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-9XDBz30yN5y-jP_osSf3Ow-1; Wed, 24 Jun 2020 12:52:24 -0400
X-MC-Unique: 9XDBz30yN5y-jP_osSf3Ow-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE81A107ACF4;
        Wed, 24 Jun 2020 16:52:22 +0000 (UTC)
Received: from jsavitz.bos.com (ovpn-112-219.rdu2.redhat.com [10.10.112.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8C552B4AB;
        Wed, 24 Jun 2020 16:52:18 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rafael Aquini <aquini@redhat.com>,
        Fabrizio D'Angelo <fdangelo@redhat.com>, linux-mm@kvack.org
Subject: [PATCH v2] mm/page_alloc: fix documentation error and remove magic numbers
Date:   Wed, 24 Jun 2020 12:49:43 -0400
Message-Id: <20200624164943.32048-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I increased the upper bound of the min_free_kbytes value in
ee8eb9a5fe863, I forgot to tweak the above comment to reflect
the new value. This patch fixes that mistake.

In addition, this patch replaces the magic number bounds with symbolic
constants to clarify the logic.

changes from v1:
- declare constants via enum instead of separate integers

Suggested-by: John Hubbard <jhubbard@nvidia.com>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 mm/page_alloc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 48eb0f1410d4..733c81678b0e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7832,7 +7832,7 @@ void setup_per_zone_wmarks(void)
  * Initialise min_free_kbytes.
  *
  * For small machines we want it small (128k min).  For large machines
- * we want it large (64MB max).  But it is not linear, because network
+ * we want it large (256MB max).  But it is not linear, because network
  * bandwidth does not increase linearly with machine size.  We use
  *
  *	min_free_kbytes = 4 * sqrt(lowmem_kbytes), for better accuracy:
@@ -7852,6 +7852,8 @@ void setup_per_zone_wmarks(void)
  * 8192MB:	11584k
  * 16384MB:	16384k
  */
+static enum { MIN_FREE_KBYTES_LOWER_BOUND = 1 << 7, MIN_FREE_KBYTES_UPPER_BOUND = 1 << 18 };
+
 int __meminit init_per_zone_wmark_min(void)
 {
 	unsigned long lowmem_kbytes;
@@ -7862,10 +7864,10 @@ int __meminit init_per_zone_wmark_min(void)
 
 	if (new_min_free_kbytes > user_min_free_kbytes) {
 		min_free_kbytes = new_min_free_kbytes;
-		if (min_free_kbytes < 128)
-			min_free_kbytes = 128;
-		if (min_free_kbytes > 262144)
-			min_free_kbytes = 262144;
+		if (min_free_kbytes < MIN_FREE_KBYTES_LOWER_BOUND)
+			min_free_kbytes = MIN_FREE_KBYTES_LOWER_BOUND;
+		if (min_free_kbytes > MIN_FREE_KBYTES_UPPER_BOUND)
+			min_free_kbytes = MIN_FREE_KBYTES_UPPER_BOUND;
 	} else {
 		pr_warn("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
 				new_min_free_kbytes, user_min_free_kbytes);
-- 
2.23.0

