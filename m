Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBA7C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 781F22074F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6tyGJ46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393416AbgDOFnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 01:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393395AbgDOFm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 01:42:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A5DC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:42:58 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a32so6309469pje.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CYNgjV9miUJh8498GJp/E0H6GBvf4hXm8dM5oc2Z5rg=;
        b=Z6tyGJ46RDxT/TEh9zaYlzuWjvowL2tuWTe+Upk1M/TX7J11fGxgxoR0KXY3O9LKw5
         XlrSOpH8Chfgvu1AldMlRXvyNc0tUXjN30v9y3sCalPbdI2Gm/xD/rJtanqDuBzl0wrK
         SQU9nF/5ldVvce4d72M9Cnf0S01oCQx88oO7BxT977DNEbfGeapzJQIgCGhygd/I+SP1
         doJ/IuKY65j5V6fF+nKtl7KXU2s3SjgNRBIno2vb2qNTVGEN9VNtd3LuCvQuWNIy6vf5
         WYrEf/3QpXeytcqmNfs7FhZmNVER1DRByjcwapmiHS/evraq4X6wC0a4oiLE0MOez8GF
         Pjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CYNgjV9miUJh8498GJp/E0H6GBvf4hXm8dM5oc2Z5rg=;
        b=ZwjPh2tnPwyMgIArv4qJTSXUNZyRNzjYOT+msKi/bFSVWioLuSKw8CAVKhB2QBIbr5
         tl2bS3uqYAOeA6EyU0jNg+oT80PQ6uTavPJw4Urseff/RY6P8bCSsvPN5qMbKAr3pq3S
         J/dPQb1Z8JxNOGBuy8Dg66DRJaYNI4+eW2H+MguyaaAvVPYsdJMSNg8hbRRP/3PF7y06
         BKVu/MTqdmGlsfLVEI1TGUwThyO9s0XYRYKurCZ3+Ezkz6lrM5XKTh/uYO6T3koNS5Qu
         CrvccB9vThwCjAlWBVFa4dORGUyfZbC7BOEap86mQslZG/S8IH3HaYCv+LP30hEH4m+l
         gKMQ==
X-Gm-Message-State: AGi0PuaegLDGF+HcHEezCoD5OGC87VQbal0R9MnTNFotroEosV0i4aLm
        waX3eY0XrlfculVKl1rNJ9uEZ4w0
X-Google-Smtp-Source: APiQypKdTaBGZjKti0ZzPJkOWvvDkU+t/nJ6vMx78hCq0ogYRaQDFdcrKjXO8E6OYCXLdLw6NyENCQ==
X-Received: by 2002:a17:90a:32ea:: with SMTP id l97mr4282291pjb.50.1586929378325;
        Tue, 14 Apr 2020 22:42:58 -0700 (PDT)
Received: from bj08259pcu1.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id x25sm10456254pfm.203.2020.04.14.22.42.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 22:42:57 -0700 (PDT)
From:   jing.xia.mail@gmail.com
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        chunyan.zhang@unisoc.com, orson.zhai@unisoc.com,
        Jing Xia <jing.xia@unisoc.com>
Subject: [PATCH] mm: init: report kasan-tag information stored in page->flags
Date:   Wed, 15 Apr 2020 13:42:50 +0800
Message-Id: <1586929370-10838-1-git-send-email-jing.xia.mail@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Xia <jing.xia@unisoc.com>

The pagefalgs_layout_usage shows incorrect message by means of
mminit_loglevel when Kasan runs in the mode of software tag-based
enabled with CONFIG_KASAN_SW_TAGS.
This patch corrects it and reports kasan-tag information.

Signed-off-by: Jing Xia <jing.xia@unisoc.com>
---
 mm/mm_init.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 7da6991..435e5f7 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -67,26 +67,30 @@ void __init mminit_verify_pageflags_layout(void)
 	unsigned long or_mask, add_mask;
 
 	shift = 8 * sizeof(unsigned long);
-	width = shift - SECTIONS_WIDTH - NODES_WIDTH - ZONES_WIDTH - LAST_CPUPID_SHIFT;
+	width = shift - SECTIONS_WIDTH - NODES_WIDTH - ZONES_WIDTH
+		- LAST_CPUPID_SHIFT - KASAN_TAG_WIDTH;
 	mminit_dprintk(MMINIT_TRACE, "pageflags_layout_widths",
-		"Section %d Node %d Zone %d Lastcpupid %d Flags %d\n",
+		"Section %d Node %d Zone %d Lastcpupid %d Kasantag %d Flags %d\n",
 		SECTIONS_WIDTH,
 		NODES_WIDTH,
 		ZONES_WIDTH,
 		LAST_CPUPID_WIDTH,
+		KASAN_TAG_WIDTH,
 		NR_PAGEFLAGS);
 	mminit_dprintk(MMINIT_TRACE, "pageflags_layout_shifts",
-		"Section %d Node %d Zone %d Lastcpupid %d\n",
+		"Section %d Node %d Zone %d Lastcpupid %d Kasantag %d\n",
 		SECTIONS_SHIFT,
 		NODES_SHIFT,
 		ZONES_SHIFT,
-		LAST_CPUPID_SHIFT);
+		LAST_CPUPID_SHIFT,
+		KASAN_TAG_WIDTH);
 	mminit_dprintk(MMINIT_TRACE, "pageflags_layout_pgshifts",
-		"Section %lu Node %lu Zone %lu Lastcpupid %lu\n",
+		"Section %lu Node %lu Zone %lu Lastcpupid %lu Kasantag %lu\n",
 		(unsigned long)SECTIONS_PGSHIFT,
 		(unsigned long)NODES_PGSHIFT,
 		(unsigned long)ZONES_PGSHIFT,
-		(unsigned long)LAST_CPUPID_PGSHIFT);
+		(unsigned long)LAST_CPUPID_PGSHIFT,
+		(unsigned long)KASAN_TAG_PGSHIFT);
 	mminit_dprintk(MMINIT_TRACE, "pageflags_layout_nodezoneid",
 		"Node/Zone ID: %lu -> %lu\n",
 		(unsigned long)(ZONEID_PGOFF + ZONEID_SHIFT),
-- 
1.9.1

