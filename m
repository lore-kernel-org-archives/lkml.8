Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EC4C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91F5B20857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ncimkw70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgDTNsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:48:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22063 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726105AbgDTNsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587390483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ZjlyqsZfuiODwhCKfbfQEkXEQlTAeCutroJ0YpFBPE=;
        b=Ncimkw70uGBj5ZU9MlAgA/KKPJJeHq+2tetvmI7+9x+iIdevnCVYFRzCfx5A9p6EfF/8yQ
        4BbcjO403SYQB+KZMTWWmRu15jz2FXxjkbfNYnlJaPtHmg0aLHcNArbxK0/5dX3ilXxefj
        DEoOm1oZq9YRYNlAV3tWdTFmQadvmo0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-oZMkdelZPm-vbC4GzrCy-A-1; Mon, 20 Apr 2020 09:48:01 -0400
X-MC-Unique: oZMkdelZPm-vbC4GzrCy-A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 566E11005510;
        Mon, 20 Apr 2020 13:48:00 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5804F5DA76;
        Mon, 20 Apr 2020 13:47:57 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 03KDlusI007528;
        Mon, 20 Apr 2020 09:47:56 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 03KDlsUL007524;
        Mon, 20 Apr 2020 09:47:55 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 20 Apr 2020 09:47:54 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: [PATCH v2] x86: introduce memcpy_flushcache_single
In-Reply-To: <87a739zvrg.fsf@nanos.tec.linutronix.de>
Message-ID: <alpine.LRH.2.02.2004200943160.4909@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2004071029270.8662@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4goJ2jbXNVZbMUKtRUominhuMhuTKrMh=fnhrfvC4jyjw@mail.gmail.com> <alpine.LRH.2.02.2004081439080.13932@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4grNHvyYEc4W6PkymhEJvLb17tXbC3JZdqvtFxmMZ8DCQ@mail.gmail.com> <alpine.LRH.2.02.2004090612320.27517@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2004160411460.7833@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gpe8u=zNrRhvd9ioVNGbOJfRUXzFZuV--be6Hbj0xXtQ@mail.gmail.com> <alpine.LRH.2.02.2004170831530.16047@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4jjJ_SZuAjdhdQKGWh6qiP1O4kFyzP9BcBgbb2oanc=yQ@mail.gmail.com>
 <87a739zvrg.fsf@nanos.tec.linutronix.de>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Apr 2020, Thomas Gleixner wrote:

> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > The goal of naming it _inatomic() was specifically for the observation
> > that your driver coordinates atomic access and does not benefit from
> > the cache friendliness that non-temporal stores afford. That said
> > _inatomic() is arguably not a good choice either because that refers
> > to whether the copy is prepared to take a fault or not. What about
> > _exclusive() or _single()? Anything but _clflushopt() that conveys no
> > contextual information.

OK. I renamed it to memcpy_flushcache_single

> > Other than quibbling with the name, and one more comment below, this
> > looks ok to me.
> >
> >> Index: linux-2.6/drivers/md/dm-writecache.c
> >> ===================================================================
> >> --- linux-2.6.orig/drivers/md/dm-writecache.c   2020-04-17 14:06:35.139999000 +0200
> >> +++ linux-2.6/drivers/md/dm-writecache.c        2020-04-17 14:06:35.129999000 +0200
> >> @@ -1166,7 +1166,10 @@ static void bio_copy_block(struct dm_wri
> >>                         }
> >>                 } else {
> >>                         flush_dcache_page(bio_page(bio));
> >> -                       memcpy_flushcache(data, buf, size);
> >> +                       if (likely(size > 512))
> >
> > This needs some reference to how this magic number is chosen and how a
> > future developer might determine whether the value needs to be
> > adjusted.
> 
> I don't think it's a good idea to make this decision in generic code as
> architectures or even CPU models might have different constraints on the
> size.
> 
> So I'd rather let the architecture implementation decide and make this
> 
>                          flush_dcache_page(bio_page(bio));
>  -                       memcpy_flushcache(data, buf, size);
>  +                       memcpy_flushcache_bikesheddedname(data, buf, size);
> 
> and have the default fallback memcpy_flushcache() and let the
> architecture sort the size limit and the underlying technology out.
> 
> So x86 can use clflushopt or implement it with movdir64b and any other
> architecture can provide their own magic soup without changing the
> callsite.
> 
> Thanks,
> 
>         tglx

OK - so I moved the decision to memcpy_flushcache_single and I added a 
comment that explains the magic number.

Mikulas




From: Mikulas Patocka <mpatocka@redhat.com>

Implement the function memcpy_flushcache_single which flushes cache just
like memcpy_flushcache - except that it uses cached writes and explicit
cache flushing instead of non-temporal stores.

Explicit cache flushing performs better in singlethreaded cases (i.e. the
dm-writecache target with block size greater than 512), non-temporal
stores perform better in other cases (mostly multithreaded workloads) - so
we provide these two functions and the user should select which one is
faster for his particular workload.

dm-writecache througput (on real Optane-based persistent memory):
block size	512		1024		2048		4096
movnti		496 MB/s	642 MB/s	725 MB/s	744 MB/s
clflushopt	373 MB/s	688 MB/s	1.1 GB/s	1.2 GB/s

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 arch/x86/include/asm/string_64.h |   10 ++++++++
 arch/x86/lib/usercopy_64.c       |   46 +++++++++++++++++++++++++++++++++++++++
 drivers/md/dm-writecache.c       |    2 -
 include/linux/string.h           |    6 +++++
 4 files changed, 63 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/x86/include/asm/string_64.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/string_64.h	2020-04-20 15:31:46.939999000 +0200
+++ linux-2.6/arch/x86/include/asm/string_64.h	2020-04-20 15:31:46.929999000 +0200
@@ -114,6 +114,14 @@ memcpy_mcsafe(void *dst, const void *src
 	return 0;
 }
 
+/*
+ * In some cases (mostly single-threaded workload), clflushopt is faster
+ * than non-temporal stores. In other situations, non-temporal stores are
+ * faster. So, we provide two functions:
+ *	memcpy_flushcache using non-temporal stores
+ *	memcpy_flushcache_single using clflushopt
+ * The caller should test which one is faster for the particular workload.
+ */
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 #define __HAVE_ARCH_MEMCPY_FLUSHCACHE 1
 void __memcpy_flushcache(void *dst, const void *src, size_t cnt);
@@ -135,6 +143,8 @@ static __always_inline void memcpy_flush
 	}
 	__memcpy_flushcache(dst, src, cnt);
 }
+#define __HAVE_ARCH_MEMCPY_FLUSHCACHE_CLFLUSHOPT 1
+void memcpy_flushcache_single(void *dst, const void *src, size_t cnt);
 #endif
 
 #endif /* __KERNEL__ */
Index: linux-2.6/include/linux/string.h
===================================================================
--- linux-2.6.orig/include/linux/string.h	2020-04-20 15:31:46.939999000 +0200
+++ linux-2.6/include/linux/string.h	2020-04-20 15:31:46.929999000 +0200
@@ -175,6 +175,12 @@ static inline void memcpy_flushcache(voi
 	memcpy(dst, src, cnt);
 }
 #endif
+#ifndef __HAVE_ARCH_MEMCPY_FLUSHCACHE_CLFLUSHOPT
+static inline void memcpy_flushcache_single(void *dst, const void *src, size_t cnt)
+{
+	memcpy_flushcache(dst, src, cnt);
+}
+#endif
 void *memchr_inv(const void *s, int c, size_t n);
 char *strreplace(char *s, char old, char new);
 
Index: linux-2.6/arch/x86/lib/usercopy_64.c
===================================================================
--- linux-2.6.orig/arch/x86/lib/usercopy_64.c	2020-04-20 15:31:46.939999000 +0200
+++ linux-2.6/arch/x86/lib/usercopy_64.c	2020-04-20 15:38:13.159999000 +0200
@@ -199,6 +199,52 @@ void __memcpy_flushcache(void *_dst, con
 }
 EXPORT_SYMBOL_GPL(__memcpy_flushcache);
 
+void memcpy_flushcache_single(void *_dst, const void *_src, size_t size)
+{
+	unsigned long dest = (unsigned long) _dst;
+	unsigned long source = (unsigned long) _src;
+
+	/*
+	 * dm-writecache througput (on real Optane-based persistent memory):
+	 * measured with dd:
+	 *
+	 * block size	512		1024		2048		4096
+	 * movnti	496 MB/s	642 MB/s	725 MB/s	744 MB/s
+	 * clflushopt	373 MB/s	688 MB/s	1.1 GB/s	1.2 GB/s
+	 *
+	 * We see that movnti performs better for 512-byte blocks, and
+	 * clflushopt performs better for 1024-byte and larger blocks. So, we
+	 * prefer clflushopt for sizes >= 768.
+	 */
+
+	if (static_cpu_has(X86_FEATURE_CLFLUSHOPT) && likely(boot_cpu_data.x86_clflush_size == 64) &&
+	    likely(size >= 768)) {
+		if (unlikely(!IS_ALIGNED(dest, 64))) {
+			size_t len = min_t(size_t, size, ALIGN(dest, 64) - dest);
+
+			memcpy((void *) dest, (void *) source, len);
+			clflushopt((void *)dest);
+			dest += len;
+			source += len;
+			size -= len;
+		}
+		do {
+			memcpy((void *)dest, (void *)source, 64);
+			clflushopt((void *)dest);
+			dest += 64;
+			source += 64;
+			size -= 64;
+		} while (size >= 64) 
+		if (unlikely(size != 0)) {
+			memcpy((void *)dest, (void *)source, size);
+			clflushopt((void *)dest);
+		}
+		return;
+	}
+	memcpy_flushcache((void *)dest, (void *)source, size);
+}
+EXPORT_SYMBOL_GPL(memcpy_flushcache_single);
+
 void memcpy_page_flushcache(char *to, struct page *page, size_t offset,
 		size_t len)
 {
Index: linux-2.6/drivers/md/dm-writecache.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-writecache.c	2020-04-20 15:31:46.939999000 +0200
+++ linux-2.6/drivers/md/dm-writecache.c	2020-04-20 15:32:35.549999000 +0200
@@ -1166,7 +1166,7 @@ static void bio_copy_block(struct dm_wri
 			}
 		} else {
 			flush_dcache_page(bio_page(bio));
-			memcpy_flushcache(data, buf, size);
+			memcpy_flushcache_single(data, buf, size);
 		}
 
 		bvec_kunmap_irq(buf, &flags);

