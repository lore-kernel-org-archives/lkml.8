Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF4FC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829E822314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IH965hYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388382AbgBNUsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:48:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42406 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388171AbgBNUsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:48:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id k11so12451777wrd.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fYMUoir6P369DFUPvjd9IwSNVlH2uDcEsa0cDBpYLmc=;
        b=IH965hYmyOF45cvMjEbRiDZZHOfl7fOe2Zt2qY2QXjTrD5vr4E5o4ASz8NwEfLdoyf
         8QJ2ggGHOVmUtDfg+vWAdH5Q2dGsRU1nSYUITlgpiO7Rh2xI/Qa6qPAriZdxx4Ed8lhP
         M62ffg9W1oDsfpS6MIGSI576dgmdWMpUEGvDIWrmdHObOhZiFkh0PNnuBdtD5l17XqZu
         Ut+cb9B8iSuqnnhoEYEkasVH9Vh4zT/JL3p9zadH9BwHaUTKi6F+SlpuvmmweEK8szLn
         ipvYMQPdKaczrekBAqMiz+3LYbwNKeIeRsrSTjbQvwT0dltW8NTNL6ZkifJDrLLE1gro
         J9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fYMUoir6P369DFUPvjd9IwSNVlH2uDcEsa0cDBpYLmc=;
        b=BUPh0qTKMlKsurvuUEaj/cezJZyoaWkNqfGLQKu4FfkSCMA3gcwoKicXfEexDLvr3h
         Dtwwx6l+YhuIkYQ1IsVpXyoHHJL1qM4hEyO6U7zwRYWeJC3mJsGTmKvTfoZk5l3oxigx
         ippwduvSPO/2YJ1op3PaMZwABX9x0E4DcoUx+WVplehXYjRGO/t34iV91nr0gruh0HQ5
         jumuI0YEanMp8juYtEc4b9KxbxQIYPAgR2hCce9ZPdscWCA2IzX+/91q+pxHLMg5vZQg
         TxABaXE2YuptdOMf7DzgvD393PvBsOaVHwvcPzZWZxHg/io3dyMhnoxiPOh8WKyHLISW
         QKGQ==
X-Gm-Message-State: APjAAAUWPURKJ8E5Pt25WshF0urubGKvqYkmW+tCp+ooUcQi/vTibEZU
        +yDwHbngc937IOzxol9SVkKBo4f8HdRA
X-Google-Smtp-Source: APXvYqw/O96To8bCrgkPpvj8JepZ3NSkL1ul2b+UKRpE5VHbikhxIVb/2uqKJmL9Jlv+6W9sjjD/Bw==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr5687888wrp.321.1581713324201;
        Fri, 14 Feb 2020 12:48:44 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:48:43 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org (open list:SLAB ALLOCATOR)
Subject: [PATCH 09/30] mm/slub: Add missing annotation for put_map()
Date:   Fri, 14 Feb 2020 20:47:20 +0000
Message-Id: <20200214204741.94112-10-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214204741.94112-1-jbi.octave@gmail.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at put_map()()

 warning: context imbalance in put_map() - unexpected unlock

The root cause is the missing annotation at put_map()
Add the missing __releases(&object_map_lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3c6d348afcf9..c273d0f32b8f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -466,7 +466,7 @@ static unsigned long *get_map(struct kmem_cache *s, struct page *page)
 	return object_map;
 }
 
-static void put_map(unsigned long *map)
+static void put_map(unsigned long *map) __releases(&object_map_lock)
 {
 	VM_BUG_ON(map != object_map);
 	lockdep_assert_held(&object_map_lock);
-- 
2.24.1

