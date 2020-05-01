Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE7FC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 01:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 672A82074A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 01:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1dhhecU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgEABHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 21:07:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51617 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727114AbgEABHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 21:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588295261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EU5hMHIDBwanKqUThLEMKgdcgJ0c7t+O7ajiXIHk0no=;
        b=S1dhhecUMNPTraHhJcdWLHxp5Bar7lLcJzpwis3QdV/P87lCe7qtgsmHsczV90dQd8xLjx
        Q/7D0j4xE3/sa6nU56P8NzPYwAsDFEXSqZVSHhk09N4o5z53YNRdwnp1SvV4ttkvmTX2HY
        AnHZ9xhkaoiNscL15fm3PV2hPlqYMCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-fcevY-GHNeeCfOfwUTTktQ-1; Thu, 30 Apr 2020 21:07:38 -0400
X-MC-Unique: fcevY-GHNeeCfOfwUTTktQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CBA2107ACCA;
        Fri,  1 May 2020 01:07:37 +0000 (UTC)
Received: from treble (ovpn-113-19.rdu2.redhat.com [10.10.113.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F083239E;
        Fri,  1 May 2020 01:07:35 +0000 (UTC)
Date:   Thu, 30 Apr 2020 20:07:33 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200501010733.ptvgzl3nbxybo4rd@treble>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <CAK8P3a2Gzj9SVZSGo+PxWR0cMJb1sFwv+ii9J6jEGE-Z41Fr+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a2Gzj9SVZSGo+PxWR0cMJb1sFwv+ii9J6jEGE-Z41Fr+A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 04:05:07PM +0200, Arnd Bergmann wrote:
> lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x133: call to do_strncpy_from_user() with UACCESS enabled
> lib/strnlen_user.o: warning: objtool: strnlen_user()+0x122: call to do_strnlen_user() with UACCESS enabled

Does this fix it?

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 706020b06617..cb3ae7a093c3 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -30,6 +30,9 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src,
 	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
 	unsigned long res = 0;
 
+	if (!user_access_begin(src, max))
+		return -EFAULT;
+
 	if (IS_UNALIGNED(src, dst))
 		goto byte_at_a_time;
 
@@ -43,7 +46,8 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src,
 		if (has_zero(c, &data, &constants)) {
 			data = prep_zero_mask(c, data, &constants);
 			data = create_zero_mask(data);
-			return res + find_zero(data);
+			res += find_zero(data);
+			goto done;
 		}
 		res += sizeof(unsigned long);
 		max -= sizeof(unsigned long);
@@ -56,7 +60,7 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src,
 		unsafe_get_user(c,src+res, efault);
 		dst[res] = c;
 		if (!c)
-			return res;
+			goto done;
 		res++;
 		max--;
 	}
@@ -65,14 +69,20 @@ static inline long do_strncpy_from_user(char *dst, const char __user *src,
 	 * Uhhuh. We hit 'max'. But was that the user-specified maximum
 	 * too? If so, that's ok - we got as much as the user asked for.
 	 */
-	if (res >= count)
-		return res;
+	if (res < count) {
+		/*
+		 * Nope: we hit the address space limit, and we still had more
+		 * characters the caller would have wanted. That's an EFAULT.
+		 */
+		goto efault;
+	}
+
+done:
+	user_access_end();
+	return res;
 
-	/*
-	 * Nope: we hit the address space limit, and we still had more
-	 * characters the caller would have wanted. That's an EFAULT.
-	 */
 efault:
+	user_access_end();
 	return -EFAULT;
 }
 
@@ -105,7 +115,6 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 	src_addr = (unsigned long)untagged_addr(src);
 	if (likely(src_addr < max_addr)) {
 		unsigned long max = max_addr - src_addr;
-		long retval;
 
 		/*
 		 * Truncate 'max' to the user-specified limit, so that
@@ -116,11 +125,7 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 
 		kasan_check_write(dst, count);
 		check_object_size(dst, count, false);
-		if (user_access_begin(src, max)) {
-			retval = do_strncpy_from_user(dst, src, count, max);
-			user_access_end();
-			return retval;
-		}
+		return do_strncpy_from_user(dst, src, count, max);
 	}
 	return -EFAULT;
 }
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 41670d4a5816..f1e9e447bef1 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -26,6 +26,9 @@ static inline long do_strnlen_user(const char __user *src, unsigned long count,
 	unsigned long align, res = 0;
 	unsigned long c;
 
+	if (!user_access_begin(src, max))
+		return 0;
+
 	/*
 	 * Do everything aligned. But that means that we
 	 * need to also expand the maximum..
@@ -39,10 +42,12 @@ static inline long do_strnlen_user(const char __user *src, unsigned long count,
 
 	for (;;) {
 		unsigned long data;
+
 		if (has_zero(c, &data, &constants)) {
 			data = prep_zero_mask(c, data, &constants);
 			data = create_zero_mask(data);
-			return res + find_zero(data) + 1 - align;
+			res += find_zero(data) + 1 - align;
+			goto done;
 		}
 		res += sizeof(unsigned long);
 		/* We already handled 'unsigned long' bytes. Did we do it all ? */
@@ -58,13 +63,21 @@ static inline long do_strnlen_user(const char __user *src, unsigned long count,
 	 * too? If so, return the marker for "too long".
 	 */
 	if (res >= count)
-		return count+1;
+		res = count + 1;
+	else {
+		/*
+		 * Nope: we hit the address space limit, and we still had more
+		 * characters the caller would have wanted. That's 0.
+		 */
+		goto efault;
+	}
+
+done:
+	user_access_end();
+	return res;
 
-	/*
-	 * Nope: we hit the address space limit, and we still had more
-	 * characters the caller would have wanted. That's 0.
-	 */
 efault:
+	user_access_end();
 	return 0;
 }
 
@@ -100,7 +113,6 @@ long strnlen_user(const char __user *str, long count)
 	src_addr = (unsigned long)untagged_addr(str);
 	if (likely(src_addr < max_addr)) {
 		unsigned long max = max_addr - src_addr;
-		long retval;
 
 		/*
 		 * Truncate 'max' to the user-specified limit, so that
@@ -109,11 +121,7 @@ long strnlen_user(const char __user *str, long count)
 		if (max > count)
 			max = count;
 
-		if (user_access_begin(str, max)) {
-			retval = do_strnlen_user(str, count, max);
-			user_access_end();
-			return retval;
-		}
+		return do_strnlen_user(str, count, max);
 	}
 	return 0;
 }

