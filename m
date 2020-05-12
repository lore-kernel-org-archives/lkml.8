Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D02C54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615F1208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589265460;
	bh=XaJzdYSi4MgUFXsfxFcBr/AwcDZLznlRsdGp3exbcNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IrJr+wpdUp9shKQzWGcRMc2Cm5++1aJmh6nKlQJprxc+/3czmlm2ssk6K++RjqaSN
	 O/bLXKiB5OKwxD57mBdoLEYgfolGuzV5roUR5U3cWsMDYRSICJb/XY9TAUhQl0Yg3v
	 N/+UEd/PaGw4UM5gsL89Av0Ec+ac8eZ1HQnAE8PU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgELGhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 02:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgELGhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:37:39 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C24E20752;
        Tue, 12 May 2020 06:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589265458;
        bh=XaJzdYSi4MgUFXsfxFcBr/AwcDZLznlRsdGp3exbcNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XLI8Ef5wYzdiOUNT5ZDhMCz6RpIyQ/FIhTvFlehqtejKfgzBujoAANi1ywV5vIk8N
         nV+tpEiDxm2wksUhZxNFg1Q6JcXBX9OlnNFfF5nbbU+PH8Il9oyDtgf7RUAo1LrUIq
         DgK5hy83Lxi/GN0Uj2TYYbucRYwzlFuNSezb7Usk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <adech.fo@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Michal Marek <mmarek@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/2] kasan: fix compilation warnings due to missing function prototypes
Date:   Tue, 12 May 2020 09:37:27 +0300
Message-Id: <20200512063728.17785-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512063728.17785-1-leon@kernel.org>
References: <20200512063728.17785-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

__asan_report_* function generates the following warnings while compiling
kernel, add them to the internal header to be aligned with other __asan_*
function prototypes.

mm/kasan/generic_report.c:130:6: warning: no previous prototype for '__asan_report_load1_noabort' [-Wmissing-prototypes]
  130 | void __asan_report_load##size##_noabort(unsigned long addr) \
      |      ^~~~~~~~~~~~~~~~~~
mm/kasan/generic_report.c:143:1: note: in expansion of macro 'DEFINE_ASAN_REPORT_LOAD'
  143 | DEFINE_ASAN_REPORT_LOAD(1);
      | ^~~~~~~~~~~~~~~~~~~~~~~

<...>

mm/kasan/generic_report.c:137:6: warning: no previous prototype for '__asan_report_store1_noabort' [-Wmissing-prototypes]
  137 | void __asan_report_store##size##_noabort(unsigned long addr) \
      |      ^~~~~~~~~~~~~~~~~~~
mm/kasan/generic_report.c:148:1: note: in expansion of macro 'DEFINE_ASAN_REPORT_STORE'
  148 | DEFINE_ASAN_REPORT_STORE(1);
      | ^~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 0b24becc810d ("kasan: add kernel address sanitizer infrastructure")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 mm/kasan/kasan.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index e8f37199d885..d428e588c700 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -230,15 +230,27 @@ void __asan_load16(unsigned long addr);
 void __asan_store16(unsigned long addr);

 void __asan_load1_noabort(unsigned long addr);
+void __asan_report_load1_noabort(unsigned long addr);
 void __asan_store1_noabort(unsigned long addr);
+void __asan_report_store1_noabort(unsigned long addr);
 void __asan_load2_noabort(unsigned long addr);
+void __asan_report_load2_noabort(unsigned long addr);
 void __asan_store2_noabort(unsigned long addr);
+void __asan_report_store2_noabort(unsigned long addr);
 void __asan_load4_noabort(unsigned long addr);
+void __asan_report_load4_noabort(unsigned long addr);
 void __asan_store4_noabort(unsigned long addr);
+void __asan_report_store4_noabort(unsigned long addr);
 void __asan_load8_noabort(unsigned long addr);
+void __asan_report_load8_noabort(unsigned long addr);
 void __asan_store8_noabort(unsigned long addr);
+void __asan_report_store8_noabort(unsigned long addr);
 void __asan_load16_noabort(unsigned long addr);
+void __asan_report_load16_noabort(unsigned long addr);
 void __asan_store16_noabort(unsigned long addr);
+void __asan_report_store16_noabort(unsigned long addr);
+void __asan_report_load_n_noabort(unsigned long addr, size_t size);
+void __asan_report_store_n_noabort(unsigned long addr, size_t size);

 void __asan_set_shadow_00(const void *addr, size_t size);
 void __asan_set_shadow_f1(const void *addr, size_t size);
--
2.26.2

