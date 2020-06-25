Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31975C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C27D20768
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EAX1DJUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407399AbgFYV4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391278AbgFYVz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:55:58 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8562AC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:55:58 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b5so3668280pfp.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7A3ut0s/fDrYdZLuerEwUW8oCMYtKMgoS+BmFPV6E48=;
        b=EAX1DJUjyWzo+h0AIzexC7N/8D1YSmVHsQR+1EMo5hJkdoOjsTZH71VlIZJq9Ln5v2
         4ucz7qrAwno2uZFZm6xgJyccTswpWYnpRoX1HlRBF1jPneET7PwSm/M5sz4YD0b/wptd
         rw0ky4FI5PBORLUuxCJmyieQ5XMmlBJx+YIt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7A3ut0s/fDrYdZLuerEwUW8oCMYtKMgoS+BmFPV6E48=;
        b=sqH86ZtahR/9JS0rY5Cw/TN9U04WHToBd2opamLFon/D7neAwQ3iX2iFBW3gSUxe+O
         V0xdZglFGfcG5X5nDTCevzr/gE2ZJjhSEL6GwRDkXOyvrSioJAVPB8QPfhxioU9uvPpr
         W2fUkZdG1b+JWh9N32He4GIqwgb6ztZ0zRIs2dmnGAdB9bkm5ntwbAanVr+BMuthUk5a
         RO5l7+IJVUAd6uZrYzraUE3u+/16u+XdoDIoJ51JraUt6xA1+Xqa7O/MGvqYFkstbH9u
         U+hvD7uY02cVsFk3vWvmpJi2G7NTzLl3kbgJF4QRFraAeou9uyWnvEJsn7mxu8RpgZ+9
         Pw3Q==
X-Gm-Message-State: AOAM533qrLw4ZkQghcfgRM2w6jgsO8DSQeB+Taa/VMAtd7JLQLBJoYZu
        XuLUZZy3R6jq7JOzo4DyN1T5EA==
X-Google-Smtp-Source: ABdhPJyhcT2sDKANwEpDmUbojDTCXPEXRrzBTDNJGDiwSiqDtIycN9E7qeWFgne+DnoVmxgF5v59Lw==
X-Received: by 2002:a63:5a66:: with SMTP id k38mr27602446pgm.240.1593122158040;
        Thu, 25 Jun 2020 14:55:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q6sm23425892pff.79.2020.06.25.14.55.56
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
Subject: [PATCH v2 1/2] mm: Expand CONFIG_SLAB_FREELIST_HARDENED to include SLAB
Date:   Thu, 25 Jun 2020 14:55:47 -0700
Message-Id: <20200625215548.389774-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625215548.389774-1-keescook@chromium.org>
References: <20200625215548.389774-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include SLAB caches when performing kmem_cache pointer verification. A
defense against such corruption[1] should be applied to all the
allocators. With this added, the "SLAB_FREE_CROSS" and "SLAB_FREE_PAGE"
LKDTM tests now pass on SLAB:

  lkdtm: Performing direct entry SLAB_FREE_CROSS
  lkdtm: Attempting cross-cache slab free ...
  ------------[ cut here ]------------
  cache_from_obj: Wrong slab cache. lkdtm-heap-b but object is from lkdtm-heap-a
  WARNING: CPU: 2 PID: 2195 at mm/slab.h:530 kmem_cache_free+0x8d/0x1d0
  ...
  lkdtm: Performing direct entry SLAB_FREE_PAGE
  lkdtm: Attempting non-Slab slab free ...
  ------------[ cut here ]------------
  virt_to_cache: Object is not a Slab page!
  WARNING: CPU: 1 PID: 2202 at mm/slab.h:489 kmem_cache_free+0x196/0x1d0

Additionally clean up neighboring Kconfig entries for clarity,
readability, and redundant option removal.

[1] https://github.com/ThomasKing2014/slides/raw/master/Building%20universal%20Android%20rooting%20with%20a%20type%20confusion%20vulnerability.pdf

Fixes: 598a0717a816 ("mm/slab: validate cache membership under freelist hardening")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 init/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index a46aa8f3174d..7542d28c6f61 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1885,9 +1885,8 @@ config SLAB_MERGE_DEFAULT
 	  command line.
 
 config SLAB_FREELIST_RANDOM
-	default n
+	bool "Randomize slab freelist"
 	depends on SLAB || SLUB
-	bool "SLAB freelist randomization"
 	help
 	  Randomizes the freelist order used on creating new pages. This
 	  security feature reduces the predictability of the kernel slab
@@ -1895,12 +1894,14 @@ config SLAB_FREELIST_RANDOM
 
 config SLAB_FREELIST_HARDENED
 	bool "Harden slab freelist metadata"
-	depends on SLUB
+	depends on SLAB || SLUB
 	help
 	  Many kernel heap attacks try to target slab cache metadata and
 	  other infrastructure. This options makes minor performance
 	  sacrifices to harden the kernel slab allocator against common
-	  freelist exploit methods.
+	  freelist exploit methods. Some slab implementations have more
+	  sanity-checking than others. This option is most effective with
+	  CONFIG_SLUB.
 
 config SHUFFLE_PAGE_ALLOCATOR
 	bool "Page allocator randomization"
-- 
2.25.1

