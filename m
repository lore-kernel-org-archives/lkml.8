Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF140C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD3EB2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e7XzSW9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbgFWH21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbgFWH20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:28:26 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D67C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 00:28:25 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id n10so1205826qvp.17
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 00:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nTQWvepZzYSn4rQEU0+1xmqZl1OOXUog19hqREujmU4=;
        b=e7XzSW9BiALiACWkVQb7mFB8mq6jtD10kFJCz/zBWeoYyHB4MjXZv5mb3HDvr1j71/
         cgtALbncqtn6Z0+DsYEIBUPB3KG3dfumqLm0/4nvNRqwmDe//6bQQeEsAb4EuErIDHrC
         F5KDujFk65s4f8WpCKGbF0Dz78AIJECom73qcL78UIZ6rRyPc+XmTX+uoaSgSOK2uipT
         IUnqmSkwigP7MpQJjKOKMGyC3duuOp07Kl8UaBG91ONMvc0oCODHAg7iIrmqdISI7pXg
         ibGwXhA9/6FTWCRR55quMDfGTB+Jv7KLEbaQ0vNx2FX6w5iBzvnoK5Gjq6ZqzQJPXj/q
         WbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nTQWvepZzYSn4rQEU0+1xmqZl1OOXUog19hqREujmU4=;
        b=cuR+8qSTPsJTazTTnsREMLhWvPAXFWFi5qGtzBsKCTSx/ZOf3ElgeswEqHRPYMSKne
         BbpYPM8uAI5swMRzdbeLJLw7smfRphi0GphEU5hgMGBslfaC7vlL6ATNASnVsyy8MNmL
         OHFNp9UPeiXh9FmahK/GGuMpyBlfclkAKx4rf4F2BKnwevR2NEtrFcbL3+vkTPfLdNXU
         jEMnCHb6SmeyDr2AeCPQrR8OvVL3lXstLE6niUDUKPG4e+g6cxWlpAX4RTzXG9W386yk
         ZSMeQWALIk9PBJcpls6JVmY7DsgJVhCBUTkACKV2vRcGaOc7r+11Pn2k2oJ6wLe3g4KS
         m9HQ==
X-Gm-Message-State: AOAM533z7okH80NF77QGlPG0TlCZLVA3dhckG+LR8Cv3faH10DOaEmSq
        hUXYzi5Vx6kby8fHXozkrspABrTK7Q==
X-Google-Smtp-Source: ABdhPJwj2i8o0If+UymYmvMwr9/d224DtNwbNKtKbk/yUkG5UMMHuHoay3TWBfoyY2g3OwYvH8W1ykEufQ==
X-Received: by 2002:a05:6214:8d1:: with SMTP id da17mr5298435qvb.62.1592897304605;
 Tue, 23 Jun 2020 00:28:24 -0700 (PDT)
Date:   Tue, 23 Jun 2020 09:26:54 +0200
Message-Id: <20200623072653.114563-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH v2] mm, kcsan: Instrument SLAB/SLUB free with "ASSERT_EXCLUSIVE_ACCESS"
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the necessary KCSAN checks to assist with debugging racy
use-after-frees. While KASAN is more reliable at generally catching such
use-after-frees (due to its use of a quarantine), it can be difficult to
debug racy use-after-frees. If a reliable reproducer exists, KCSAN can
assist in debugging such issues.

Note: ASSERT_EXCLUSIVE_ACCESS is a convenience wrapper if the size is
simply sizeof(var). Instead, here we just use __kcsan_check_access()
explicitly to pass the correct size.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* SLAB_TYPESAFE_BY_RCU allows racy use after free within RCU grace
  period. If slab is SLAB_TYPESAFE_BY_RCU do not check access.
---
 mm/slab.c | 5 +++++
 mm/slub.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/mm/slab.c b/mm/slab.c
index 9350062ffc1a..cba71d88e89c 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3426,6 +3426,11 @@ static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
 	if (kasan_slab_free(cachep, objp, _RET_IP_))
 		return;
 
+	/* Use KCSAN to help debug racy use-after-free. */
+	if (!(cachep->flags & SLAB_TYPESAFE_BY_RCU))
+		__kcsan_check_access(objp, cachep->object_size,
+				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT);
+
 	___cache_free(cachep, objp, caller);
 }
 
diff --git a/mm/slub.c b/mm/slub.c
index b8f798b50d44..4a9d43fda669 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1470,6 +1470,11 @@ static __always_inline bool slab_free_hook(struct kmem_cache *s, void *x)
 	if (!(s->flags & SLAB_DEBUG_OBJECTS))
 		debug_check_no_obj_freed(x, s->object_size);
 
+	/* Use KCSAN to help debug racy use-after-free. */
+	if (!(s->flags & SLAB_TYPESAFE_BY_RCU))
+		__kcsan_check_access(x, s->object_size,
+				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT);
+
 	/* KASAN might put x into memory quarantine, delaying its reuse */
 	return kasan_slab_free(s, x, _RET_IP_);
 }
-- 
2.27.0.111.gc72c7da667-goog

