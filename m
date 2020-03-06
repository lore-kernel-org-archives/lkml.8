Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE098C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76D820717
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fauVLb+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCFAYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 19:24:33 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35175 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgCFAYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:24:33 -0500
Received: by mail-pf1-f193.google.com with SMTP id i19so204837pfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 16:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=xRy9hgdRfr2pI2+j3xM5QiyuXkfsaYppAUVWfvsGN38=;
        b=fauVLb+mmzDkXqeR0x5V4vpTs+F8Fsi7S5j+semYUBkPjjZqFQrMg2Vy2/IPU9Ntvy
         6zz/ISIr18Fba0M1h/D4bqPBJ2aEY1w6Bf9pPuDxlUWRu1MaHnSnI63ocRr8O7QRpgOS
         ULYlBRs04rLMiXN3rfmq91GijGBxNHzll4agw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xRy9hgdRfr2pI2+j3xM5QiyuXkfsaYppAUVWfvsGN38=;
        b=Eyk6T4ZFOZMECvfWvQpJ4T/03R4sz51dZbQcosgpXmS1BZtQ1XOM+pwRbGPBAIHI3Z
         9rpoF5IQ6wY7W23qCDCKBYh5LRhGvGP4rYsVUy6dJIiPZq9+PLZvHKLBx1tHVz+A0zme
         9kcpkuX0Yw/a8b/zLxgPsHDK3IKMxZe1EOv8L+R6ONqyFx0k6alq4njPCAcc3Can36io
         A+gfY9mft/LYtSMy1dwkVXJEPTnigaAXGdVKNAX2NhLQDN6zhOBbh63MCEH6ZVSwHQ9H
         dvJwqezU9dgd9by8mZoZ6yowH3K1CANFuGB13ggSY3JGml0qgP6VJHA9XHMY7ccJmuOU
         E86g==
X-Gm-Message-State: ANhLgQ0brR+7xoQHOtJCT+lculy6KKq77fmHN6OWiNMVWuGt+NE57KU2
        ed9gwyhFoYji+glCrzQ4lMs1EQ==
X-Google-Smtp-Source: ADFU+vvCgOtnmu5BVGxMSLqbNh9JOZ7MZpYoz/vRPGo0pl2lLbg7DmsarwvLoFafJnbWFmTbFUGL5Q==
X-Received: by 2002:aa7:87d4:: with SMTP id i20mr972175pfo.22.1583454270564;
        Thu, 05 Mar 2020 16:24:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w2sm25298002pfb.138.2020.03.05.16.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 16:24:29 -0800 (PST)
Date:   Thu, 5 Mar 2020 16:24:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Silvio Cesare <silvio.cesare@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] slub: Improve bit diffusion for freelist ptr obfuscation
Message-ID: <202003051623.AF4F8CB@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under CONFIG_SLAB_FREELIST_HARDENED=y, the obfuscation was relatively weak
in that the ptr and ptr address were usually so close that the first XOR
would result in an almost entirely 0-byte value[1], leaving most of the
"secret" number ultimately being stored after the third XOR. A single
blind memory content exposure of the freelist was generally sufficient
to learn the secret.

Add a swab() call to mix bits a little more. This is a cheap way
(1 cycle) to make attacks need more than a single exposure to learn
the secret (or to know _where_ the exposure is in memory).

kmalloc-32 freelist walk, before:

ptr              ptr_addr            stored value      secret
ffff90c22e019020@ffff90c22e019000 is 86528eb656b3b5bd (86528eb656b3b59d)
ffff90c22e019040@ffff90c22e019020 is 86528eb656b3b5fd (86528eb656b3b59d)
ffff90c22e019060@ffff90c22e019040 is 86528eb656b3b5bd (86528eb656b3b59d)
ffff90c22e019080@ffff90c22e019060 is 86528eb656b3b57d (86528eb656b3b59d)
ffff90c22e0190a0@ffff90c22e019080 is 86528eb656b3b5bd (86528eb656b3b59d)
...

after:

ptr              ptr_addr            stored value      secret
ffff9eed6e019020@ffff9eed6e019000 is 793d1135d52cda42 (86528eb656b3b59d)
ffff9eed6e019040@ffff9eed6e019020 is 593d1135d52cda22 (86528eb656b3b59d)
ffff9eed6e019060@ffff9eed6e019040 is 393d1135d52cda02 (86528eb656b3b59d)
ffff9eed6e019080@ffff9eed6e019060 is 193d1135d52cdae2 (86528eb656b3b59d)
ffff9eed6e0190a0@ffff9eed6e019080 is f93d1135d52cdac2 (86528eb656b3b59d)

[1] https://blog.infosectcbr.com.au/2020/03/weaknesses-in-linux-kernel-heap.html

Reported-by: Silvio Cesare <silvio.cesare@gmail.com>
Fixes: 2482ddec670f ("mm: add SLUB free list pointer obfuscation")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 17dc00e33115..107d9d89cf96 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -259,7 +259,7 @@ static inline void *freelist_ptr(const struct kmem_cache *s, void *ptr,
 	 * freepointer to be restored incorrectly.
 	 */
 	return (void *)((unsigned long)ptr ^ s->random ^
-			(unsigned long)kasan_reset_tag((void *)ptr_addr));
+			swab((unsigned long)kasan_reset_tag((void *)ptr_addr)));
 #else
 	return ptr;
 #endif
-- 
2.20.1


-- 
Kees Cook
