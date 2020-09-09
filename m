Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3736DC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F24B62087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599670775;
	bh=/bHl1yHvnGqPKNbvJvHMSS5pZd7oY1zhfyqb1y94N8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mMKMfIG/YFFWhjOEjPDtJ7gtEqtIcKgUq+0SzizHHBaKR+WdgoQTU6lxHovqOwIsp
	 59THChZ9+Gg5kAegI4hnALyRk8VBxVFK9PILHA7UVbksMmaW23SuklfWcqhq81Q9ST
	 +SG2e49Vd38aBwp2AAVRfGjkP8KanNPg0Pyr3l/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbgIIQ7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730644AbgIIPvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:12 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B44F22224;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=/bHl1yHvnGqPKNbvJvHMSS5pZd7oY1zhfyqb1y94N8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FCK6umZ/T1bgfxy0JCt+Ww14qBxq5foV4KXk4yy+EPtB5Y0u/S1ZBpjPv+g9xPtXv
         SqsRk79xfI2OzOoxhGFp9OosrB6Vy+aR6p49iktgbnvULxELbw4TcBswrWwHqbTrXX
         xcui4rdXkUcSmR/EWTcqLMYRKpnUPnG5DLlKi2/I=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUXX-LW; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 22/30] kunit: test.h: solve kernel-doc warnings
Date:   Wed,  9 Sep 2020 16:10:53 +0200
Message-Id: <8fc5501c341836d8591f8dd11721585cc8694d73.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some warnings there:
	./include/kunit/test.h:90: warning: Function parameter or member 'name' not described in 'kunit_resource'
	./include/kunit/test.h:353: warning: Function parameter or member 'res' not described in 'kunit_add_resource'
	./include/kunit/test.h:367: warning: Function parameter or member 'res' not described in 'kunit_add_named_resource'
	./include/kunit/test.h:367: warning: Function parameter or member 'name' not described in 'kunit_add_named_resource'
	./include/kunit/test.h:367: warning: Function parameter or member 'data' not described in 'kunit_add_named_resource'
	./include/kunit/test.h:367: warning: Excess function parameter 'name_data' description in 'kunit_add_named_resource'

Address them, ensuring that all non-private arguments will
be properly described. With that regards, at struct kunit_resource,
the free argument is described as user-provided. So, this
doesn't seem to belong to the "private" part of the struct.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/kunit/test.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 59f3144f009a..41b3a266bf8c 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -25,6 +25,7 @@ typedef void (*kunit_resource_free_t)(struct kunit_resource *);
 /**
  * struct kunit_resource - represents a *test managed resource*
  * @data: for the user to store arbitrary data.
+ * @name: optional name
  * @free: a user supplied function to free the resource. Populated by
  * kunit_resource_alloc().
  *
@@ -80,10 +81,10 @@ typedef void (*kunit_resource_free_t)(struct kunit_resource *);
  */
 struct kunit_resource {
 	void *data;
-	const char *name;		/* optional name */
-
-	/* private: internal use only. */
+	const char *name;
 	kunit_resource_free_t free;
+
+	/* private: internal use only. */
 	struct kref refcount;
 	struct list_head node;
 };
@@ -343,6 +344,7 @@ static inline void kunit_put_resource(struct kunit_resource *res)
  *        none is supplied, the resource data value is simply set to @data.
  *	  If an init function is supplied, @data is passed to it instead.
  * @free: a user-supplied function to free the resource (if needed).
+ * @res: The resource.
  * @data: value to pass to init function or set in resource data field.
  */
 int kunit_add_resource(struct kunit *test,
@@ -356,7 +358,9 @@ int kunit_add_resource(struct kunit *test,
  * @test: The test context object.
  * @init: a user-supplied function to initialize the resource data, if needed.
  * @free: a user-supplied function to free the resource data, if needed.
- * @name_data: name and data to be set for resource.
+ * @res: The resource.
+ * @name: name to be set for resource.
+ * @data: value to pass to init function or set in resource data field.
  */
 int kunit_add_named_resource(struct kunit *test,
 			     kunit_resource_init_t init,
-- 
2.26.2

