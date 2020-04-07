Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71706C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4160920644
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586255177;
	bh=IefxS/Yc5ROgBysnlD7RBJzc6vlR8Ndpi0VarpK9QKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wkD/PqsRHRkq31e9fJK6DnD+WysWSTzsPJn2jLknXI94MlYnkbuowwh+XAOS6TYqD
	 xK7BCcmx57OM2Mald7H5buCpP2TQxhnBI754XQOkR9BNqY2b/xjz4Yc1DrbHkf9J/v
	 9e61xLxJezpoNDWrKUy/n759bU/lsvdRfG0opkJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgDGK0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:26:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728740AbgDGK0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:26:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 222F120644;
        Tue,  7 Apr 2020 10:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586255171;
        bh=IefxS/Yc5ROgBysnlD7RBJzc6vlR8Ndpi0VarpK9QKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uCgIlxEjpPS+GwFVsiLEIdArrNmYsekEcVq34twgQ1U/MouNNKIoUMkSSKR7h+59F
         T/BVC1Ek5WqHOdR/lxUSLQTFM2D9G+2yrpOcQM/6ws9EtWxgbzy442k+hSjGbKPlce
         s67jtjqQbKGCczitrGTnP3OowVBgRYycjUgz8Ijw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 12/29] XArray: Fix xa_find_next for large multi-index entries
Date:   Tue,  7 Apr 2020 12:22:09 +0200
Message-Id: <20200407101453.485392545@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407101452.046058399@linuxfoundation.org>
References: <20200407101452.046058399@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox (Oracle) <willy@infradead.org>

[ Upstream commit bd40b17ca49d7d110adf456e647701ce74de2241 ]

Coverity pointed out that xas_sibling() was shifting xa_offset without
promoting it to an unsigned long first, so the shift could cause an
overflow and we'd get the wrong answer.  The fix is obvious, and the
new test-case provokes UBSAN to report an error:
runtime error: shift exponent 60 is too large for 32-bit type 'int'

Fixes: 19c30f4dd092 ("XArray: Fix xa_find_after with multi-index entries")
Reported-by: Bjorn Helgaas <bhelgaas@google.com>
Reported-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_xarray.c | 18 ++++++++++++++++++
 lib/xarray.c      |  3 ++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 55c14e8c88591..8c7d7a8468b88 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -12,6 +12,9 @@
 static unsigned int tests_run;
 static unsigned int tests_passed;
 
+static const unsigned int order_limit =
+		IS_ENABLED(CONFIG_XARRAY_MULTI) ? BITS_PER_LONG : 1;
+
 #ifndef XA_DEBUG
 # ifdef __KERNEL__
 void xa_dump(const struct xarray *xa) { }
@@ -959,6 +962,20 @@ static noinline void check_multi_find_2(struct xarray *xa)
 	}
 }
 
+static noinline void check_multi_find_3(struct xarray *xa)
+{
+	unsigned int order;
+
+	for (order = 5; order < order_limit; order++) {
+		unsigned long index = 1UL << (order - 5);
+
+		XA_BUG_ON(xa, !xa_empty(xa));
+		xa_store_order(xa, 0, order - 4, xa_mk_index(0), GFP_KERNEL);
+		XA_BUG_ON(xa, xa_find_after(xa, &index, ULONG_MAX, XA_PRESENT));
+		xa_erase_index(xa, 0);
+	}
+}
+
 static noinline void check_find_1(struct xarray *xa)
 {
 	unsigned long i, j, k;
@@ -1081,6 +1098,7 @@ static noinline void check_find(struct xarray *xa)
 	for (i = 2; i < 10; i++)
 		check_multi_find_1(xa, i);
 	check_multi_find_2(xa);
+	check_multi_find_3(xa);
 }
 
 /* See find_swap_entry() in mm/shmem.c */
diff --git a/lib/xarray.c b/lib/xarray.c
index 1d9fab7db8dad..acd1fad2e862a 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1839,7 +1839,8 @@ static bool xas_sibling(struct xa_state *xas)
 	if (!node)
 		return false;
 	mask = (XA_CHUNK_SIZE << node->shift) - 1;
-	return (xas->xa_index & mask) > (xas->xa_offset << node->shift);
+	return (xas->xa_index & mask) >
+		((unsigned long)xas->xa_offset << node->shift);
 }
 
 /**
-- 
2.20.1



