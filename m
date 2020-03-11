Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68BCC2BB57
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F25215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Lg8Psrxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgCKDpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 23:45:04 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:18680 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbgCKDpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 23:45:00 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200311034456epoutp039f41b7e8ca59bfcc2ad3dc6983b3c1bf~7IxvdMHQ71400414004epoutp03U
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 03:44:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200311034456epoutp039f41b7e8ca59bfcc2ad3dc6983b3c1bf~7IxvdMHQ71400414004epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583898296;
        bh=g9/Soy66OC22nAKgazf5iA56h4uOPCS4a1ETM2dLFpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lg8Psrxp/bm8AG21OtRAU6c2mGgcEE3gYLtCi+QHt9Rlhfrbkj/MHlnDHTMYOaD2O
         UrWh4V4mk0u/l+ei2RzDEL41EIw1UJj9EReaaRapVwHY8nD768yUk9BH+y83KEiF/i
         hRv6/GEOa+MEUSXaROwR2ByLQHIaDilhyfN5AMTE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200311034455epcas1p49a471398213ae95d722d296eba01af54~7Ixu5CM8h1814418144epcas1p4L;
        Wed, 11 Mar 2020 03:44:55 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.165]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48cdBZ6jtSzMqYkb; Wed, 11 Mar
        2020 03:44:54 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.7A.48498.6BE586E5; Wed, 11 Mar 2020 12:44:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200311034454epcas1p46f44b4c1e75fa52b7598749566228a11~7Ixtek13a2104521045epcas1p4X;
        Wed, 11 Mar 2020 03:44:54 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200311034454epsmtrp131c0cb622dc4d191f256ded94186c246~7Ixtdn5343001830018epsmtrp1c;
        Wed, 11 Mar 2020 03:44:54 +0000 (GMT)
X-AuditID: b6c32a36-a55ff7000001bd72-f1-5e685eb69487
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.12.06569.6BE586E5; Wed, 11 Mar 2020 12:44:54 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200311034454epsmtip1b642b362ae1283f0e23af46aeb7c0353~7IxtV5C8A1922919229epsmtip1j;
        Wed, 11 Mar 2020 03:44:54 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [RFC PATCH 3/3] android: ion: include system heap size in
 proc/meminfo
Date:   Wed, 11 Mar 2020 12:44:41 +0900
Message-Id: <20200311034441.23243-4-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200311034441.23243-1-jaewon31.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmru62uIw4gxOHzC2mN3pZzFm/hs2i
        e/NMRove96+YLFbu+cFkcXnXHDaLe2v+s1os+/qe3WJDyyx2i0cTJjFZnLr7md2B22PnrLvs
        HptWdbJ5bPo0id3jzrU9bB4nZvxm8Xi/7yqbR9+WVYweOz9tZvX4vEkugDMqxyYjNTEltUgh
        NS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6FolhbLEnFKgUEBicbGS
        vp1NUX5pSapCRn5xia1SakFKToGhQYFecWJucWleul5yfq6VoYGBkSlQZUJOxutTOgVHRCsu
        LZNvYJwq1MXIySEhYCLx8vt75i5GLg4hgR2MEht3LWOHcD4xSqy7+ZQJwvnGKHHz4V5mmJZN
        uxawQCT2Mkp0zL7BCuF8Z5S4u2U/K0gVm4C2xPsFk8ASIgJrGSX+Ni1hAUkwC5RKvH1zAmyU
        sECgxJlJr9lAbBYBVYmzh58D7ePg4BWwlZj/PgzElBCQl1j4H6yaU8BO4vOdW4wgIyUErrNJ
        HH67lgXiIheJh/sWMkLYwhKvjm9hh7ClJF72t7FDNDQzSryduRmquwXo0k29UB3GEr09F5hB
        tjELaEqs36UPEVaU2Pl7LiPEzXwS7772sEIcxCvR0QYNPDWJlmdfWSFsGYm//55B2R4SzX+W
        QwN1IqPE9I67zBMY5WYhbFjAyLiKUSy1oDg3PbXYsMAIOcY2MYKTo5bZDsZF53wOMQpwMCrx
        8L6oS48TYk0sK67MPcQowcGsJMIbLw8U4k1JrKxKLcqPLyrNSS0+xGgKDMmJzFKiyfnAxJ1X
        Em9oamRsbGxhYmZuZmqsJM77MFIzTkggPbEkNTs1tSC1CKaPiYNTqoGxfioPw+SHhy7ZrbWp
        4/nnJSXp2uEt2sff/c8oLla5V/vNOfHM6UcOGzEftZ071ePEs++/286vtA/fnLC93W/uBZ4u
        R9FvEzn8Y/Szb3/hMBcJ8vVN3c4QMv/DhnLxq8+EFuoyyd65vkduqUnHIpWuYqFtlr+mJkXu
        O3xP5v0Un19n5x061rdNiaU4I9FQi7moOBEAW8WhQ6QDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWy7bCSnO62uIw4g2sHRS2mN3pZzFm/hs2i
        e/NMRove96+YLFbu+cFkcXnXHDaLe2v+s1os+/qe3WJDyyx2i0cTJjFZnLr7md2B22PnrLvs
        HptWdbJ5bPo0id3jzrU9bB4nZvxm8Xi/7yqbR9+WVYweOz9tZvX4vEkugDOKyyYlNSezLLVI
        3y6BK+P1KZ2CI6IVl5bJNzBOFepi5OSQEDCR2LRrAUsXIxeHkMBuRon/2+YzQSRkJN6cfwqU
        4ACyhSUOHy6GqPnKKHFk1iQWkBo2AW2J9wsmsYIkRAS2Mkp8+LMeLMEsUCnx7/YtVhBbWMBf
        YuKlaWBxFgFVibOHnzOBDOUVsJWY/z4MYr68xML/zCAVnAJ2Ep/v3GIECQsBVWx4YDmBkW8B
        I8MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzg0NXS2sF44kT8IUYBDkYlHt4Xdelx
        QqyJZcWVuYcYJTiYlUR44+WBQrwpiZVVqUX58UWlOanFhxilOViUxHnl849FCgmkJ5akZqem
        FqQWwWSZODilGhgt9LY6377H0v2g7ITB/jfLo48dkLAsvtwQHGRlYHWZ9z3TNnX1gofPWVkX
        LntuEvuHW7QiYp6c75kDJnJv+MQPFsWGx7QoiO119We99n7TgZq+V1412S37Lcq/P/BJ9PhS
        ei7zxTe5e2u8mEV2X72g6+c9Y06jn96KWVNe1KzMUgm+6FhULaXEUpyRaKjFXFScCAAuE9e/
        WQIAAA==
X-CMS-MailID: 20200311034454epcas1p46f44b4c1e75fa52b7598749566228a11
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200311034454epcas1p46f44b4c1e75fa52b7598749566228a11
References: <20200311034441.23243-1-jaewon31.kim@samsung.com>
        <CGME20200311034454epcas1p46f44b4c1e75fa52b7598749566228a11@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Android system ion system heap size is huge like hundreds of MB. To
know overal system memory usage, include ion system heap size in
proc/meminfo.

To include heap size, use register_extra_meminfo introduced in previous
patch.

Prior to register we need to add stats to show the ion heap usage. Add
total_allocated into ion heap and count it on allocation and freeing. In
a ion heap using ION_HEAP_FLAG_DEFER_FREE, a buffer can be freed from
user but still live on deferred free list. Keep stats until the buffer
is finally freed so that we can cover situation of deferred free thread
stuck problem.

i.e) cat /proc/meminfo | grep IonSystemHeap
IonSystemHeap:    242620 kB

i.e.) show_mem on oom
<6>[  420.856428]  Mem-Info:
<6>[  420.856433]  IonSystemHeap:32813kB

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 drivers/staging/android/ion/ion.c             | 2 ++
 drivers/staging/android/ion/ion.h             | 1 +
 drivers/staging/android/ion/ion_system_heap.c | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 38b51eace4f9..76db91a9f26a 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -74,6 +74,7 @@ static struct ion_buffer *ion_buffer_create(struct ion_heap *heap,
 
 	INIT_LIST_HEAD(&buffer->attachments);
 	mutex_init(&buffer->lock);
+	atomic_long_add(len, &heap->total_allocated);
 	return buffer;
 
 err1:
@@ -95,6 +96,7 @@ void ion_buffer_destroy(struct ion_buffer *buffer)
 	buffer->heap->num_of_buffers--;
 	buffer->heap->num_of_alloc_bytes -= buffer->size;
 	spin_unlock(&buffer->heap->stat_lock);
+	atomic_long_sub(buffer->size, &buffer->heap->total_allocated);
 
 	kfree(buffer);
 }
diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
index 74914a266e25..10867a2e5728 100644
--- a/drivers/staging/android/ion/ion.h
+++ b/drivers/staging/android/ion/ion.h
@@ -157,6 +157,7 @@ struct ion_heap {
 	u64 num_of_buffers;
 	u64 num_of_alloc_bytes;
 	u64 alloc_bytes_wm;
+	atomic_long_t total_allocated;
 
 	/* protect heap statistics */
 	spinlock_t stat_lock;
diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index b83a1d16bd89..2cc568e2bc9c 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -259,6 +259,8 @@ static struct ion_heap *__ion_system_heap_create(void)
 	if (ion_system_heap_create_pools(heap->pools))
 		goto free_heap;
 
+	register_extra_meminfo(&heap->heap.total_allocated, PAGE_SHIFT,
+			       "IonSystemHeap");
 	return &heap->heap;
 
 free_heap:
-- 
2.13.7

