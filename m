Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CFCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69CFF207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VMk0Zw6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407007AbgFYVz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391276AbgFYVz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:55:58 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142E1C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:55:58 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p3so3972547pgh.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=71I6z5szBhKim0wgDhUvujL5ZR5Eh3Fxzt3bloEgVL0=;
        b=VMk0Zw6JIilxDB2FbkGpjPfL/X2M4XMT9HR1Xa4byqvRS92XoM32NszNcobm+xX3SO
         koLQok/7rd9CYszwpisV556fJmVvxWPDT7Aj5U4uDp3x9Bzwz6sfpU46hntjIt5/m/Gd
         4JQ3yP9GjK68VZAAZF6NwKY8jd9a1tbWJ2KGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=71I6z5szBhKim0wgDhUvujL5ZR5Eh3Fxzt3bloEgVL0=;
        b=fFuMOrTqZYe+HF1YzeaO8xvg9Fl6ZUdXg5ef9VoxKM2WDgjMMQ+iBijNlCOw3tYyiy
         oRPhj/YHsZP3vp/YgNIwnM7HL3/8oZs9OX5TyvVs2t3Rba/7+TOR+OlZ7Wayd+UWyoh9
         cRdM+pDUZ25PDqIrUOgRaZidTGB8o8/yQw3VQGhwdKNnQNuYCYxpOTDSaaltlTe4NWFj
         aFPpHYAQ2aLDPEMOvBsvDuWnjnesE2190O9G/S/2sFsy9lkK+QXqOOv00lsHtf6vMeet
         Ctk979G5V8Ewxsy2JsOO2ptkylYtJkkdHvasfNssP1+pL/XXVNm8dqpdGpVC3hWci82b
         Iykw==
X-Gm-Message-State: AOAM531OU3qHFAqIKPnUMy0WbBz23DsvtWOdOq7lRnDSQj/X8C87RA+B
        TlAWGWUMgh4g5xFnz5w8MY6jBg==
X-Google-Smtp-Source: ABdhPJw2R/tP8rME+1EtDAT2i3js5LC+uVczTVn3tgK6kguv96cWBfloLw7fIXNJwNDeNNnwbyBpRg==
X-Received: by 2002:aa7:91cc:: with SMTP id z12mr22931068pfa.239.1593122157514;
        Thu, 25 Jun 2020 14:55:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 64sm16026524pgb.63.2020.06.25.14.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 14:55:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     akpm@linux-foundation.org
Cc:     Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Christoph Lameter <cl@linux.com>,
        Alexander Popov <alex.popov@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, vinmenon@codeaurora.org,
        Matthew Garrett <mjg59@google.com>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] slab: Add naive detection of double free
Date:   Thu, 25 Jun 2020 14:55:48 -0700
Message-Id: <20200625215548.389774-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625215548.389774-1-keescook@chromium.org>
References: <20200625215548.389774-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit ce6fa91b9363 ("mm/slub.c: add a naive detection
of double free or corruption"), add a very cheap double-free check
for SLAB under CONFIG_SLAB_FREELIST_HARDENED. With this added, the
"SLAB_FREE_DOUBLE" LKDTM test passes under SLAB:

  lkdtm: Performing direct entry SLAB_FREE_DOUBLE
  lkdtm: Attempting double slab free ...
  ------------[ cut here ]------------
  WARNING: CPU: 2 PID: 2193 at mm/slab.c:757 ___cache _free+0x325/0x390

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 mm/slab.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index ebac5e400ad0..bbff6705ab2b 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -749,6 +749,16 @@ static void drain_alien_cache(struct kmem_cache *cachep,
 	}
 }
 
+/* &alien->lock must be held by alien callers. */
+static __always_inline void __free_one(struct array_cache *ac, void *objp)
+{
+	/* Avoid trivial double-free. */
+	if (IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
+	    WARN_ON_ONCE(ac->avail > 0 && ac->entry[ac->avail - 1] == objp))
+		return;
+	ac->entry[ac->avail++] = objp;
+}
+
 static int __cache_free_alien(struct kmem_cache *cachep, void *objp,
 				int node, int page_node)
 {
@@ -767,7 +777,7 @@ static int __cache_free_alien(struct kmem_cache *cachep, void *objp,
 			STATS_INC_ACOVERFLOW(cachep);
 			__drain_alien_cache(cachep, ac, page_node, &list);
 		}
-		ac->entry[ac->avail++] = objp;
+		__free_one(ac, objp);
 		spin_unlock(&alien->lock);
 		slabs_destroy(cachep, &list);
 	} else {
@@ -3457,7 +3467,7 @@ void ___cache_free(struct kmem_cache *cachep, void *objp,
 		}
 	}
 
-	ac->entry[ac->avail++] = objp;
+	__free_one(ac, objp);
 }
 
 /**
-- 
2.25.1

