Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA4BC2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A2120719
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrVvmAvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgDFS6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:58:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28268 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725928AbgDFS6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586199527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=QLx4/sdG9v1nmxm7Nxx7v62MFnknzk0r6dRJ8swzlNk=;
        b=JrVvmAvHuX78u3DOxJIElTGGhSMHg2o93j38NLsrYeONi2J86v8Z+On54sR4pk4oICAqC1
        mNF+dRI0fsv6b3VxhijGyM3H5oUWXufw6z6QtPwJjxEh4CE7rt+iqPAE08pxQ1IxbI4Z9B
        xuZAtpRC9p5jhwbsae5ZBBEXes47RcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-T2oxZoLWMue6HCaiqW986Q-1; Mon, 06 Apr 2020 14:58:42 -0400
X-MC-Unique: T2oxZoLWMue6HCaiqW986Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 095A4DBA5;
        Mon,  6 Apr 2020 18:58:41 +0000 (UTC)
Received: from llong.com (ovpn-115-20.rdu2.redhat.com [10.10.115.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58A9F19C4F;
        Mon,  6 Apr 2020 18:58:36 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-mm@kvack.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2] mm: Add kvfree_sensitive() for freeing sensitive data objects
Date:   Mon,  6 Apr 2020 14:58:27 -0400
Message-Id: <20200406185827.22249-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For kvmalloc'ed data object that contains sensitive information like
cryptographic key, we need to make sure that the buffer is always
cleared before freeing it. Using memset() alone for buffer clearing may
not provide certainty as the compiler may compile it away. To be sure,
the special memzero_explicit() has to be used.

This patch introduces a new kvfree_sensitive() for freeing those
sensitive data objects allocated by kvmalloc(). The relevnat places
where kvfree_sensitive() can be used are modified to use it.

Fixes: 4f0882491a14 ("KEYS: Avoid false positive ENOMEM error on key read")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/mm.h       |  1 +
 mm/util.c                | 18 ++++++++++++++++++
 security/keys/internal.h | 11 -----------
 security/keys/keyctl.c   | 16 +++++-----------
 4 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7dd5c4ccbf85..9b3130b20f42 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -757,6 +757,7 @@ static inline void *kvcalloc(size_t n, size_t size, gfp_t flags)
 }
 
 extern void kvfree(const void *addr);
+extern void kvfree_sensitive(const void *addr, size_t len);
 
 static inline int compound_mapcount(struct page *page)
 {
diff --git a/mm/util.c b/mm/util.c
index 988d11e6c17c..01e210766f3d 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -604,6 +604,24 @@ void kvfree(const void *addr)
 }
 EXPORT_SYMBOL(kvfree);
 
+/**
+ * kvfree_sensitive - free a data object containing sensitive information
+ * @addr - address of the data object to be freed
+ * @len  - length of the data object
+ *
+ * Use the special memzero_explicit() function to clear the content of a
+ * kvmalloc'ed object containing sensitive data to make sure that the
+ * compiler won't optimize out the data clearing.
+ */
+void kvfree_sensitive(const void *addr, size_t len)
+{
+	if (likely(!ZERO_OR_NULL_PTR(addr))) {
+		memzero_explicit((void *)addr, len);
+		kvfree(addr);
+	}
+}
+EXPORT_SYMBOL(kvfree_sensitive);
+
 static inline void *__page_rmapping(struct page *page)
 {
 	unsigned long mapping;
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 6d0ca48ae9a5..153d35c20d3d 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -350,15 +350,4 @@ static inline void key_check(const struct key *key)
 #define key_check(key) do {} while(0)
 
 #endif
-
-/*
- * Helper function to clear and free a kvmalloc'ed memory object.
- */
-static inline void __kvzfree(const void *addr, size_t len)
-{
-	if (addr) {
-		memset((void *)addr, 0, len);
-		kvfree(addr);
-	}
-}
 #endif /* _INTERNAL_H */
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 5e01192e222a..edde63a63007 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -142,10 +142,7 @@ SYSCALL_DEFINE5(add_key, const char __user *, _type,
 
 	key_ref_put(keyring_ref);
  error3:
-	if (payload) {
-		memzero_explicit(payload, plen);
-		kvfree(payload);
-	}
+	kvfree_sensitive(payload, plen);
  error2:
 	kfree(description);
  error:
@@ -360,7 +357,7 @@ long keyctl_update_key(key_serial_t id,
 
 	key_ref_put(key_ref);
 error2:
-	__kvzfree(payload, plen);
+	kvfree_sensitive(payload, plen);
 error:
 	return ret;
 }
@@ -914,7 +911,7 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 		 */
 		if (ret > key_data_len) {
 			if (unlikely(key_data))
-				__kvzfree(key_data, key_data_len);
+				kvfree_sensitive(key_data, key_data_len);
 			key_data_len = ret;
 			continue;	/* Allocate buffer */
 		}
@@ -923,7 +920,7 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 			ret = -EFAULT;
 		break;
 	}
-	__kvzfree(key_data, key_data_len);
+	kvfree_sensitive(key_data, key_data_len);
 
 key_put_out:
 	key_put(key);
@@ -1225,10 +1222,7 @@ long keyctl_instantiate_key_common(key_serial_t id,
 		keyctl_change_reqkey_auth(NULL);
 
 error2:
-	if (payload) {
-		memzero_explicit(payload, plen);
-		kvfree(payload);
-	}
+	kvfree_sensitive(payload, plen);
 error:
 	return ret;
 }
-- 
2.18.1

