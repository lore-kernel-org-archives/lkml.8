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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3EBC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB93A222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAs7Wj9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388260AbgBNUss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:48:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35339 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387963AbgBNUsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:48:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id w12so12470124wrt.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tPSIqzx9vIZmVccTZdN79SZaoDc7U8iHLI6k79OYee8=;
        b=SAs7Wj9iHmb/zSwkTvomEzdPbXq05Sd9SaBEFloQT7W0rfNjR9tK19jHCfSIwa/dUm
         XR0rMeBEPnCmXd3X1lvxtlyTyJjVqoWcpb4IFPIZ5hICg6Vb3mXfBQ65NOCGrzo1QLhs
         0D02676HGo5ppmbbpbdyg594eE163CNSxpzrM1IU8Vr35ikBgantlnwews8zOklU1sED
         S6MWwQrm/GL36VREjr1N9KgwSyK+N0i44mcb861KvthYaN28zGAR2JLi+u7YThgEBNR3
         D1nMQjzSQKJOgwccLk5YZFEDVOiaqiu291FZosOTzK36BpyVDA1PYQWFeFbgi4P8SccC
         i0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tPSIqzx9vIZmVccTZdN79SZaoDc7U8iHLI6k79OYee8=;
        b=JdWG/l/m4tWQ5FHtSK/DkZW7jlLnH1VkS5mhRkPfZCrbtyXDTyUEz9Hrq/zKiAYBdB
         R0ie6sZeUKvRPQskH/r0KuxRpkYAleNUTJwFFVpVtfNb3H04f1zXk0KcFQlU0hgcTRDE
         yDAAE8uzxk8BYMyrTAKTuaTXuJo/e80M2UP1AtAqTt+Ey6r+nSLy2FyleGV2ncQgPbQZ
         javzy7eYBhEFHYnlxn78dDQG6iTHI1LFamX9hkLY1vK6ucfbDttacEvxEGr3rM2mcgFL
         +zp0xvmZyXIkQT1c5Yozuy4J2PeIW30oGHs9T6edYCzlZ7OcgqBu1ogJTkUS3vazlVUQ
         vfYw==
X-Gm-Message-State: APjAAAV1QDiK8YLEptvB7tvhvBJCcTOukHmTbHvW4PLeBQojgHImqQ1K
        ZWcJFq1iVVifw2BikSP7lyGHnjZegEYa
X-Google-Smtp-Source: APXvYqw7skjqb5hmOvClXAQmeSz8gA1tf4s1sD5scej7zfnCJfQl4Ra+Gq0SvjaSdhJmMY/zSq11GA==
X-Received: by 2002:a5d:6987:: with SMTP id g7mr5612512wru.422.1581713323059;
        Fri, 14 Feb 2020 12:48:43 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:48:42 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org (open list:SLAB ALLOCATOR)
Subject: [PATCH 08/30] mm/slub: Add missing annotation for get_map()
Date:   Fri, 14 Feb 2020 20:47:19 +0000
Message-Id: <20200214204741.94112-9-jbi.octave@gmail.com>
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

Sparse reports a warning at get_map()()

 warning: context imbalance in get_map() - wrong count at exit

The root cause is the missing annotation at get_map()
Add the missing __acquires(&object_map_lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 mm/slub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/slub.c b/mm/slub.c
index 17dc00e33115..3c6d348afcf9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -449,6 +449,7 @@ static DEFINE_SPINLOCK(object_map_lock);
  * not vanish from under us.
  */
 static unsigned long *get_map(struct kmem_cache *s, struct page *page)
+	__acquires(&object_map_lock)
 {
 	void *p;
 	void *addr = page_address(page);
-- 
2.24.1

