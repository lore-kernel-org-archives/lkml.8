Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B092C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08EDE20784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nDBmuWGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411638AbgDOR7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1416524AbgDORze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:55:34 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454F9C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 10:55:34 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a32so159498pje.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 10:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=WknHuSsMv5PZIolEyRt8fzItA0jcsProAC7yJPzp7k4=;
        b=nDBmuWGLKCO2b/2H3Eg7fuNSI0hhyvNr8N1Q3txVfEtfoojywuD5oY4C9EEbR4Jj+I
         x+RZqc5v9tmdbUboOysxB2lEk81n50KXM2XHhUJq2oH4bpmvVejNxSyD6vy/bPaxMdlo
         iIs8Kka8G3S4OJScn6jfe8YMVVer0A1f4CpdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=WknHuSsMv5PZIolEyRt8fzItA0jcsProAC7yJPzp7k4=;
        b=EIf5FKGs2WCffvx1lW+qeqHXwXo/MZPnNTYygTAQNeQR//lP1r1LGH2miGJ7+2AU/y
         E2QOEum8HTD5DSBNbzacRQU6Phhyac5U2z3E3iLfvRjZoYhVjwmARZG1iDsBz+Z/L6Qe
         Cb/EESPG1wrW0wthi/8PtZH0DyweQWMbx1/BIiV58aAgCR+lVUOV+UFUv7vGNM8w2t6o
         Ef8Kgjmg4AqhVXHEF8wb+eVsMfyrOAcXsjP1QMCKWc6SClUhqvcqInftIOMtb8SMsAxK
         hMxkGy7xqseOTmIkl58akpnysEpBSE3O/IvJSumJNPVleW3tVGQDJpRfPk3r9FFZoQS5
         SLBw==
X-Gm-Message-State: AGi0Pub2Eh/gA/TMj5YPxbhXK+FJLcUbrMi11qnbwN/l4x+N15ugh6zv
        XRFtEWAZeJLvNfd+9kC3ksTvbg==
X-Google-Smtp-Source: APiQypJq7k4/MnAu3XXlcJmYNYMeOnaI3/KkXDgFGyoSc/dzG6EoQ4klxQczruF3S4zVhyJACGAUTg==
X-Received: by 2002:a17:902:b284:: with SMTP id u4mr5638708plr.97.1586973333588;
        Wed, 15 Apr 2020 10:55:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d5sm14476337pfa.59.2020.04.15.10.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 10:55:32 -0700 (PDT)
Date:   Wed, 15 Apr 2020 10:55:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] slub: Avoid redzone when choosing freepointer location
Message-ID: <202004151054.BD695840@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Elver reported system crashes when booting with "slub_debug=Z".
The freepointer location (s->offset) was not taking into account that
the "inuse" size that includes the redzone area should not be used by
the freelist pointer. Change the calculation to save the area of the
object that an inline freepointer may be written into.

Reported-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/linux-mm/20200415164726.GA234932@google.com
Fixes: 3202fa62fb43 ("slub: relocate freelist pointer to middle of object")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 mm/slub.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 332d4b459a90..9bf44955c4f1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3533,6 +3533,7 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
 {
 	slab_flags_t flags = s->flags;
 	unsigned int size = s->object_size;
+	unsigned int freepointer_area;
 	unsigned int order;
 
 	/*
@@ -3541,6 +3542,13 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
 	 * the possible location of the free pointer.
 	 */
 	size = ALIGN(size, sizeof(void *));
+	/*
+	 * This is the area of the object where a freepointer can be
+	 * safely written. If redzoning adds more to the inuse size, we
+	 * can't use that portion for writing the freepointer, so
+	 * s->offset must be limited within this for the general case.
+	 */
+	freepointer_area = size;
 
 #ifdef CONFIG_SLUB_DEBUG
 	/*
@@ -3582,13 +3590,13 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
 		 */
 		s->offset = size;
 		size += sizeof(void *);
-	} else if (size > sizeof(void *)) {
+	} else if (freepointer_area > sizeof(void *)) {
 		/*
 		 * Store freelist pointer near middle of object to keep
 		 * it away from the edges of the object to avoid small
 		 * sized over/underflows from neighboring allocations.
 		 */
-		s->offset = ALIGN(size / 2, sizeof(void *));
+		s->offset = ALIGN(freepointer_area / 2, sizeof(void *));
 	}
 
 #ifdef CONFIG_SLUB_DEBUG
-- 
2.20.1


-- 
Kees Cook
