Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F63C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C6020829
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599733512;
	bh=2wMMtTrb36FCEW/xkvvN3FDvc8DUb3YyRvd6j4G+b9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=duH+8mwZ/pXQNNTbI3MgQU9ln9115iTDlBosp969KdUIFfBcXrTkMn9virpCvRs8Y
	 5QO8PFb+/976JBUFORUj4CjFR0vMj3RRyhJcd9TYy+bzwvXf+e+iMiOmiCaBz6O9kY
	 w0ixDhO0aHnxjnxqzqeARXxRo6Z8IRGiHOtID9yQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbgIJKZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgIJKYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:24:11 -0400
Received: from mail.kernel.org (ip5f5ad5ac.dynamic.kabel-deutschland.de [95.90.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B2812078E;
        Thu, 10 Sep 2020 10:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599733450;
        bh=2wMMtTrb36FCEW/xkvvN3FDvc8DUb3YyRvd6j4G+b9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0sfs7pxnF4d9h50MU4fac1EOk0v+JvxlL5zkoYkhAK0tXG6SXA6B4LWErca06azTD
         aRQjHOucDsLEZDy7lSEHSY/Z8mK2spSTRzIqEfJDvKQqEbzodws4kcrZ28zduR/luT
         14Plo61XXluN19dNgR6XnZHNtiPmYccop3LnwZes=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kGJkO-00EINe-8i; Thu, 10 Sep 2020 12:24:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] locking/refcount: document the new "oldp" pointer value
Date:   Thu, 10 Sep 2020 12:23:54 +0200
Message-Id: <fce3aa50004b47aa9b89df7103fa2a6e279cc402.1599732764.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599732764.git.mchehab+huawei@kernel.org>
References: <cover.1599732764.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset a435b9a14356 ("locking/refcount: Provide __refcount API to obtain the old value")
added a new parameter to most refcount functions, but didn't update
the kernel-doc markups.

Add a description for it on all touched functions.

Fixes: a435b9a14356 ("locking/refcount: Provide __refcount API to obtain the old value")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/refcount.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 7fabb1af18e0..e17035ea44ef 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -151,6 +151,7 @@ static inline unsigned int refcount_read(const refcount_t *r)
  * refcount_add_not_zero - add a value to a refcount unless it is 0
  * @i: the value to add to the refcount
  * @r: the refcount
+ * @oldp: if not NULL, stores the previous value of the refcount
  *
  * Will saturate at REFCOUNT_SATURATED and WARN.
  *
@@ -192,6 +193,7 @@ static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
  * refcount_add - add a value to a refcount
  * @i: the value to add to the refcount
  * @r: the refcount
+ * @oldp: if not NULL, stores the previous value of the refcount
  *
  * Similar to atomic_add(), but will saturate at REFCOUNT_SATURATED and WARN.
  *
@@ -225,6 +227,7 @@ static inline void refcount_add(int i, refcount_t *r)
 /**
  * refcount_inc_not_zero - increment a refcount unless it is 0
  * @r: the refcount to increment
+ * @oldp: if not NULL, stores the previous value of the refcount
  *
  * Similar to atomic_inc_not_zero(), but will saturate at REFCOUNT_SATURATED
  * and WARN.
@@ -248,6 +251,7 @@ static inline __must_check bool refcount_inc_not_zero(refcount_t *r)
 /**
  * refcount_inc - increment a refcount
  * @r: the refcount to increment
+ * @oldp: if not NULL, stores the previous value of the refcount
  *
  * Similar to atomic_inc(), but will saturate at REFCOUNT_SATURATED and WARN.
  *
@@ -271,6 +275,7 @@ static inline void refcount_inc(refcount_t *r)
  * refcount_sub_and_test - subtract from a refcount and test if it is 0
  * @i: amount to subtract from the refcount
  * @r: the refcount
+ * @oldp: if not NULL, stores the previous value of the refcount
  *
  * Similar to atomic_dec_and_test(), but it will WARN, return false and
  * ultimately leak on underflow and will fail to decrement when saturated
@@ -313,6 +318,7 @@ static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
 /**
  * refcount_dec_and_test - decrement a refcount and test if it is 0
  * @r: the refcount
+ * @oldp: if not NULL, stores the previous value of the refcount
  *
  * Similar to atomic_dec_and_test(), it will WARN on underflow and fail to
  * decrement when saturated at REFCOUNT_SATURATED.
@@ -336,6 +342,7 @@ static inline __must_check bool refcount_dec_and_test(refcount_t *r)
 /**
  * refcount_dec - decrement a refcount
  * @r: the refcount
+ * @oldp: if not NULL, stores the previous value of the refcount
  *
  * Similar to atomic_dec(), it will WARN on underflow and fail to decrement
  * when saturated at REFCOUNT_SATURATED.
-- 
2.26.2

