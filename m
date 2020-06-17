Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142E4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D984021548
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fjNF7THt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgFQTyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 15:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgFQTx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 15:53:56 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF905C061755
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 12:53:55 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s23so1649427pfh.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 12:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dVavS5ePbCYrK2z1L2wDQV1nTQ1HDrNhoLc61sG4Q5M=;
        b=fjNF7THtjmalkLduwfjs6WAcXUJ8XrLQgh8AJX/PbmUoNRwB7NJXiEnIF4/WGEgshv
         0Sc3PHTV8qK08Y1adWyY7RpUt61/9K8iqxsOWwrnN8OiquPeq+5Drr0hasoLXBo3LkL9
         Qyi/sIH5I2ZUP4aCOZ0r4QvPuhCN7u5xakY94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVavS5ePbCYrK2z1L2wDQV1nTQ1HDrNhoLc61sG4Q5M=;
        b=pFvr3A9rzsMy3D28M/OihdaJZuNfrvBc76fm8Try2O1lH4E3xlRWGRaMnMqTxN68WO
         /XRykLA/x46+0+yMOPZiu8D5HiMLqiyBgB+uFKrqpUlA27Ft+bDl5PSVAUJg1wRncBpt
         4jz41KlC0QaasXVzIzVvjb7I2SDc9FrXcoBUcn5Xyv2zYzxbg+de1ePz3TRa7cxZGMFV
         KzjjqhFpwiY/qhIGct1jcqNqh3pBopvVFc1C0MGf9UUtSLIC7wBGQCD4PhZ7qGcgJ2n7
         pHUVrch03XSeLIZNasU2mF+Uoli8f8HlzJE7GbGXWlGdLBoFoF4eCZ4fwtR+mQAqvtoP
         mJ3g==
X-Gm-Message-State: AOAM532DNXVkrwCZi3wuqyMIIa+lQ5zLQJMRIMi1xVkeqFORAHBr0fBY
        2Fa7UHMH5eBfS/rsnrcJYTeEbQ==
X-Google-Smtp-Source: ABdhPJwOg59bPWyGSiT3mjPppY6RygkG6jLQonyfdZ8GMgBRzj7URVeINwVlCe50tSbxuqAvoLP34w==
X-Received: by 2002:a63:4562:: with SMTP id u34mr358332pgk.309.1592423635262;
        Wed, 17 Jun 2020 12:53:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r4sm566043pgp.60.2020.06.17.12.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 12:53:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
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
Subject: [PATCH 2/2] slab: Add naive detection of double free
Date:   Wed, 17 Jun 2020 12:53:49 -0700
Message-Id: <20200617195349.3471794-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617195349.3471794-1-keescook@chromium.org>
References: <20200617195349.3471794-1-keescook@chromium.org>
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
index 9350062ffc1a..c4e3a194b271 100644
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
@@ -3466,7 +3476,7 @@ void ___cache_free(struct kmem_cache *cachep, void *objp,
 		}
 	}
 
-	ac->entry[ac->avail++] = objp;
+	__free_one(ac, objp);
 }
 
 /**
-- 
2.25.1

