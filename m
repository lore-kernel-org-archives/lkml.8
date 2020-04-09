Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E6CC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE0E208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tBx8aRUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgDITgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:36:18 -0400
Received: from mail.efficios.com ([167.114.26.124]:47226 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgDITgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:36:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9AB86280F66;
        Thu,  9 Apr 2020 15:36:00 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5bU-wLzZK8f4; Thu,  9 Apr 2020 15:36:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A0F8C280AF0;
        Thu,  9 Apr 2020 15:35:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A0F8C280AF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1586460959;
        bh=dS2j/RfoCvb6S/7DuXu9SUgFlAK346t8v78OVR21ay0=;
        h=From:To:Date:Message-Id;
        b=tBx8aRUw0PewCktQArATxmKEQoI8Hxs24WB5p4gBw8M0c920y4wKP8Xgd+pH6h+Qd
         n8NulPyTFwH8IiiXuA7pqtW3jNtnMxSv7G0K41BZSGRC9gcFS2qyS+XOgdXs2u8vx6
         Frgjs2ZCIPSo21ZjPgmfbI0l8BPFCaU4yXC37Sxt/q6LQVZzvmYALzL3wBKV3Ibpdj
         5sW7Uilj9zSxtAWzhcVvKaWQ4LJBmucAuURlA/J8CUA+4Og426j3NHDFbNXtTlLlkL
         6ej3KGMNcCUfEcFulkGchFBIYrAMrlEmSQh+CjzAXnA00No8G8bKfQVnQZBfChIm9N
         E4QPnlnC03sFA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id W2aLUYIx0DZj; Thu,  9 Apr 2020 15:35:59 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id F290D280F5C;
        Thu,  9 Apr 2020 15:35:58 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, akpm@linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, rostedt@goodmis.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-mm@kvack.org
Subject: [RFC PATCH 6/9] mm: export-GPL get_pageblock_migratetype
Date:   Thu,  9 Apr 2020 15:35:40 -0400
Message-Id: <20200409193543.18115-7-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409193543.18115-1-mathieu.desnoyers@efficios.com>
References: <20200409193543.18115-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro include/linux/mmzone.h:get_pageblock_migratetype() uses
the symbol get_pfnblock_flags_mask, which is not exported. That macro is
used within the kmem and page_ref trace events to trace the migrate type
of the target page.

Exporting this symbol to GPL modules allows GPL kernel tracers to be
implemented as modules.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
---
 mm/page_alloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 114c56c3685d..390febb028a0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -501,6 +501,7 @@ unsigned long get_pfnblock_flags_mask(struct page *page, unsigned long pfn,
 {
 	return __get_pfnblock_flags_mask(page, pfn, end_bitidx, mask);
 }
+EXPORT_SYMBOL_GPL(get_pfnblock_flags_mask);
 
 static __always_inline int get_pfnblock_migratetype(struct page *page, unsigned long pfn)
 {
-- 
2.17.1

