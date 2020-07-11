Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E82C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AC3C2065D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdMH0hkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgGKKpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 06:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgGKKpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 06:45:41 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2357DC08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 03:45:41 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q4so9229882lji.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 03:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=emwwLZ+sCVD9pQmKI5z9zIDSKav8YuxNbGB01XFmDw0=;
        b=gdMH0hkLsBg0LeQOOg3ir0y6Tfe16Uu5JTXMt0cZx6rK441QuK8rcV44Is/IGa5Qma
         PeMixu1wonnYnNZjV7772dnDf/rhXDYpVQxVA+H/mCezZvxOLJMN/5Wew3O/78zdPOVE
         bNXS6zlh2v0FYRMNbwhqj4LMVCZRXPG4ktGtV9jLHab4q+2kybrkHXjqjU9xHJm4FEhB
         3qi6hUOik5HAxXB77C9VCK8Epv05znRjLrERi5AlYmva3T9LksPwiaW9JqI7T0K2Y8GL
         Ms+UlPLKakDDkjeTYEQ0dBuD6SBo1nZ12wp0vS9V2hkZN4afx2OaIS0hBz26OilFFcc0
         RzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=emwwLZ+sCVD9pQmKI5z9zIDSKav8YuxNbGB01XFmDw0=;
        b=P768PnAHDHiCiuAnxShPjn+85zXen5VjoVw8HJkH6JpFXcG+8kS0wUSSRXoRRu35IC
         +yPA18ay3QJi7gLJebzSAp3F/HbVl/J+6lR1HNz0GSpjdhwOpSBjCMDHGIoOp7K0iqqf
         Fp/ZloJQzcqTo/279hO+Gg/jE+n5uc8NlI9+w6J9MmPe7nQiZi0yH5fM2czxns0ppZFh
         4Kdzq93SMRZnPQLTJvQ/hvdAv4szbNzGtnPTenwVTe4TlBeLGb82VQmdSuO5cOUcjwMn
         9O580pmADVoPO/sKfF867/kR3JWpWcIotuGIJseGbBpT4dgy3KBHv9nlsb5S17e955B7
         6Z5w==
X-Gm-Message-State: AOAM531k6TBiEsXm1PYoTBU6the40FMp0sSmfU8xQdWYSneBncjBsMg9
        FSOgbdjYTkfhHcV6XHrKEAE=
X-Google-Smtp-Source: ABdhPJys3VA5gh+UJ5rF9Pab2KKItVlJCxPddT9fMYWk524rqNVig7B+s52+EA2DA8nYPnO08vMTYQ==
X-Received: by 2002:a2e:888d:: with SMTP id k13mr13080218lji.15.1594464339354;
        Sat, 11 Jul 2020 03:45:39 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id m25sm2689233ljj.128.2020.07.11.03.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 03:45:38 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v3 1/1] mm/vmalloc.c: Remove BUG() from the find_va_links()
Date:   Sat, 11 Jul 2020 12:45:31 +0200
Message-Id: <20200711104531.12242-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of BUG() macro, that should be used only when
a critical situation happens and a system is not able
to function anymore.

Replace it with WARN() macro instead, dump some extra
information about start/end addresses of both VAs which
overlap. Such overlap data can help to figure out what
happened making further analysis easier. For example if
both areas are identical it could mean a double free.

A recovery process consists of declining all further
steps regarding inserting of conflicting overlap range.
In that sense find_va_links() now can return NULL, so
its return value has to be checked by callers.

Side effect of such process is it can leak memory, but
it is better than just killing a machine for no good
reason. Apart of that a debugging process can be done
on alive system.

v2 -> v3
    - rename the patch's title;
    - remove information about pointers;
    - convert BUG() to WARN() macros;
    - add "vmalloc bug:" prefix to the message;
    - add recovery process if an overlap occurs;
    - add more comments.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3d7b94eb0ac0..b482d240f9a2 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -512,6 +512,10 @@ static struct vmap_area *__find_vmap_area(unsigned long addr)
 /*
  * This function returns back addresses of parent node
  * and its left or right link for further processing.
+ *
+ * Otherwise NULL is returned. In that case all further
+ * steps regarding inserting of conflicting overlap range
+ * have to be declined and actually considered as a bug.
  */
 static __always_inline struct rb_node **
 find_va_links(struct vmap_area *va,
@@ -550,8 +554,12 @@ find_va_links(struct vmap_area *va,
 		else if (va->va_end > tmp_va->va_start &&
 				va->va_start >= tmp_va->va_end)
 			link = &(*link)->rb_right;
-		else
-			BUG();
+		else {
+			WARN(1, "vmalloc bug: 0x%lx-0x%lx overlaps with 0x%lx-0x%lx\n",
+				va->va_start, va->va_end, tmp_va->va_start, tmp_va->va_end);
+
+			return NULL;
+		}
 	} while (*link);
 
 	*parent = &tmp_va->rb_node;
@@ -697,7 +705,8 @@ insert_vmap_area(struct vmap_area *va,
 	struct rb_node *parent;
 
 	link = find_va_links(va, root, NULL, &parent);
-	link_va(va, root, parent, link, head);
+	if (link)
+		link_va(va, root, parent, link, head);
 }
 
 static void
@@ -713,8 +722,10 @@ insert_vmap_area_augment(struct vmap_area *va,
 	else
 		link = find_va_links(va, root, NULL, &parent);
 
-	link_va(va, root, parent, link, head);
-	augment_tree_propagate_from(va);
+	if (link) {
+		link_va(va, root, parent, link, head);
+		augment_tree_propagate_from(va);
+	}
 }
 
 /*
@@ -722,6 +733,11 @@ insert_vmap_area_augment(struct vmap_area *va,
  * and next free blocks. If coalesce is not done a new
  * free area is inserted. If VA has been merged, it is
  * freed.
+ *
+ * Please note, it can return NULL in case of overlap
+ * ranges, followed by WARN() report. Despite it is a
+ * buggy behaviour, a system can be alive and keep
+ * ongoing.
  */
 static __always_inline struct vmap_area *
 merge_or_add_vmap_area(struct vmap_area *va,
@@ -738,6 +754,8 @@ merge_or_add_vmap_area(struct vmap_area *va,
 	 * inserted, unless it is merged with its sibling/siblings.
 	 */
 	link = find_va_links(va, root, NULL, &parent);
+	if (!link)
+		return NULL;
 
 	/*
 	 * Get next node of VA to check if merging can be done.
@@ -1346,6 +1364,9 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 		va = merge_or_add_vmap_area(va, &free_vmap_area_root,
 					    &free_vmap_area_list);
 
+		if (!va)
+			continue;
+
 		if (is_vmalloc_or_module_addr((void *)orig_start))
 			kasan_release_vmalloc(orig_start, orig_end,
 					      va->va_start, va->va_end);
@@ -3330,8 +3351,9 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 		orig_end = vas[area]->va_end;
 		va = merge_or_add_vmap_area(vas[area], &free_vmap_area_root,
 					    &free_vmap_area_list);
-		kasan_release_vmalloc(orig_start, orig_end,
-				      va->va_start, va->va_end);
+		if (va)
+			kasan_release_vmalloc(orig_start, orig_end,
+				va->va_start, va->va_end);
 		vas[area] = NULL;
 	}
 
@@ -3379,8 +3401,9 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 		orig_end = vas[area]->va_end;
 		va = merge_or_add_vmap_area(vas[area], &free_vmap_area_root,
 					    &free_vmap_area_list);
-		kasan_release_vmalloc(orig_start, orig_end,
-				      va->va_start, va->va_end);
+		if (va)
+			kasan_release_vmalloc(orig_start, orig_end,
+				va->va_start, va->va_end);
 		vas[area] = NULL;
 		kfree(vms[area]);
 	}
-- 
2.20.1

