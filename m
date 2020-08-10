Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F349C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B9A920782
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597072982;
	bh=HcBNhSb0GmByQS2frDJPr/p9ayMXKaZQ4dRvzizDfvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IhUVesTfkxbFGj/hx4EtouI7NKozcYwQGVpeOCFplnZsKXsDMggCwHRPBjiXPLdvT
	 J/dZJW4eL4dpPrbPmrrDgy2a+cgJXuYlVlu6Nv9aBUhLAYKeqOeObFsmsxva3bcqYe
	 JmSF7sganKzn/Gv+b0GF0gCMOnzLr5afvIhtYLqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgHJPW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:22:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728255AbgHJPWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:22:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27B6B20768;
        Mon, 10 Aug 2020 15:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597072973;
        bh=HcBNhSb0GmByQS2frDJPr/p9ayMXKaZQ4dRvzizDfvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xbyLIvL5vwAZNmEOzFkAgpG+AcSJQwCvfQnfif9CvR+Pj0EaQU3uh4tE9Vq4E8JqS
         m5RJwB0fb5KWjdiY/grMvMc4ELbF9sbwSMhS9Aipx1WkYzqtJyWVs8xbJx/xZVrw00
         9HcfaI7oYCYVRdj0nQiwOWg97eP/FUEbNEdu+O7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.7 22/79] lkdtm/heap: Avoid edge and middle of slabs
Date:   Mon, 10 Aug 2020 17:20:41 +0200
Message-Id: <20200810151813.282571528@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151812.114485777@linuxfoundation.org>
References: <20200810151812.114485777@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

commit e12145cf1c3a8077e6d9f575711e38dd7d8a3ebc upstream.

Har har, after I moved the slab freelist pointer into the middle of the
slab, now it looks like the contents are getting poisoned. Adjust the
test to avoid the freelist pointer again.

Fixes: 3202fa62fb43 ("slub: relocate freelist pointer to middle of object")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20200625203704.317097-3-keescook@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/lkdtm/heap.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -58,11 +58,12 @@ void lkdtm_READ_AFTER_FREE(void)
 	int *base, *val, saw;
 	size_t len = 1024;
 	/*
-	 * The slub allocator uses the first word to store the free
-	 * pointer in some configurations. Use the middle of the
-	 * allocation to avoid running into the freelist
+	 * The slub allocator will use the either the first word or
+	 * the middle of the allocation to store the free pointer,
+	 * depending on configurations. Store in the second word to
+	 * avoid running into the freelist.
 	 */
-	size_t offset = (len / sizeof(*base)) / 2;
+	size_t offset = sizeof(*base);
 
 	base = kmalloc(len, GFP_KERNEL);
 	if (!base) {


