Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0E7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 796B120748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duIu7oJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgGJTkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgGJTky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:40:54 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F70AC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 12:40:54 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u25so3849621lfm.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 12:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8yy5+0XVtV1tT8exC81PHbEZ7mEejnNXr3qie/N1Tjs=;
        b=duIu7oJP7BVSgiZmVAwFlSpOU+5Njc4dEn6QeAcpR5nLoFt2SGRBT8lcNHz96DhV1E
         x4lqEKZiFIyMJ60dmF8Zlq2MQ3dehAMtOk0ObVJnzO7ZzADYbGo2qXHLiovUtBSpWqYY
         vPNi9VJQfMdfa9MbEU9MxDJd3kepGejHtC7byV9Iy+9KuaYWSP+J8Ed/BEOvygQpaH/A
         22f/NvDDzFfyNpbsJDT3YamO331E/AoTixsw9jB4pucBt9TWaPIdDmM0JFA0zKEBl6y3
         bsOmn5838sm+6YBy1k7ITnbquB0U98q5bBfOc6vOrsRvoZ4bsrszAgM6ZZtQf/d8uB00
         SIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8yy5+0XVtV1tT8exC81PHbEZ7mEejnNXr3qie/N1Tjs=;
        b=tp70l8TPhODBgdcsxHdeeb5tOfPOZBXivLD7f7c/8vBwziTVFlWF8r5jJrqhzworYh
         8d62n9GagwZruIN8Zk/lvvxA/jMbMujUi6adyNmu3Dxpiefo0Jwb/ZEu7VFQfGXUvyqQ
         HkyHT6KF3wPWrnEgbXfQrOU12tFictE5YaCLJz4Cr7Vs84SdLQVYwpUe8r89KT2C9ksd
         n1gREIeTiv7IVtF/+g6MU05JJjRY9vZ+YskucaAzmlVRPkKuYKFLDc2QadVb1913gvxF
         6TouDvOQyRx5gOB+mKz2yX+sVXkV6ZYv+2tF2auBZwVtzOU1kcwtWRyF5Unir1kWMtIt
         9e5Q==
X-Gm-Message-State: AOAM530ElWiT5nM0RpJ/iEEP5JNxZ+taAylIVbChiKP0WUIHoyX8l7u6
        Stus0iwK+SycoezsY8uyVzc=
X-Google-Smtp-Source: ABdhPJxDxVgebeLIKDb7zktFvwhLgoVyHh7/MlegYPp69tFBWf9gJfREH2azgmANCbG9OMsN7ekEog==
X-Received: by 2002:ac2:5325:: with SMTP id f5mr44162180lfh.6.1594410052841;
        Fri, 10 Jul 2020 12:40:52 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id x17sm2496279lfe.44.2020.07.10.12.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 12:40:52 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/1] mm/vmalloc.c: Add an error message if two areas overlap
Date:   Fri, 10 Jul 2020 21:40:42 +0200
Message-Id: <20200710194042.2510-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before triggering a BUG() it would be useful to understand
how two areas overlap between each other. Print information
about start/end addresses of both VAs and their addresses.

For example if both are identical it could mean double free.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5a2b55c8dd9a..1679b01febcd 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -549,8 +549,13 @@ find_va_links(struct vmap_area *va,
 		else if (va->va_end > tmp_va->va_start &&
 				va->va_start >= tmp_va->va_end)
 			link = &(*link)->rb_right;
-		else
+		else {
+			pr_err("Overlaps: 0x%px(0x%lx-0x%lx), 0x%px(0x%lx-0x%lx)\n",
+				va, va->va_start, va->va_end, tmp_va,
+				tmp_va->va_start, tmp_va->va_end);
+
 			BUG();
+		}
 	} while (*link);
 
 	*parent = &tmp_va->rb_node;
@@ -1993,6 +1998,9 @@ static void vmap_init_free_space(void)
 			insert_vmap_area_augment(free, NULL,
 				&free_vmap_area_root,
 					&free_vmap_area_list);
+			insert_vmap_area_augment(free, NULL,
+				&free_vmap_area_root,
+					&free_vmap_area_list);
 		}
 	}
 }
-- 
2.20.1

