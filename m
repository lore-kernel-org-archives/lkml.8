Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A143C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F5220752
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589229769;
	bh=lWxUFO7+ilIRrLEBP9LvhbxGDPBqUhNNYn0A1J7W2VE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q5zJmjL/vKRFzq0vd2h/Lo3GmYPRZRs8Xso7uKinm+qH1aYFoVJGVRnBFgyuhe9QS
	 vEql7+RJes0F6ic6qqH8pUZyM//L5Bd4oGXoRGX8gOJ18dnWIRlCU4DyjfsTtCs5ty
	 EoyVlt1VDE68W9e42UxlOYMKA+E3Fp0H7sCrpIZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbgEKUms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:42:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731840AbgEKUmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:42:46 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8146420836;
        Mon, 11 May 2020 20:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589229765;
        bh=lWxUFO7+ilIRrLEBP9LvhbxGDPBqUhNNYn0A1J7W2VE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qjb7EWAhwsAK8r8X5IjdzaHM9FobA0j7igLn49bXpyLiLUxI1dUs85V3/UXVo3vKf
         WgBHifBBfmia/O6jxQNJlTNdsPyfOSUVnVOqzg4UqsZvUlKBVFwwI9gXLhZAqOGgff
         k26aC9FA/ZJayc6oEp+KJ08Va11/2ss8HQsmdYas=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     elver@google.com, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, peterz@infradead.org, will@kernel.org
Subject: [PATCH v5 08/18] fault_inject: Don't rely on "return value" from WRITE_ONCE()
Date:   Mon, 11 May 2020 21:41:40 +0100
Message-Id: <20200511204150.27858-9-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511204150.27858-1-will@kernel.org>
References: <20200511204150.27858-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a bit weird that WRITE_ONCE() evaluates to the value it stores and
it's also different to smp_store_release(), which can't be used this
way.

In preparation for preventing this in WRITE_ONCE(), change the fault
injection code to use a local variable instead.

Cc: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 lib/fault-inject.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index 8186ca84910b..ce12621b4275 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -106,7 +106,9 @@ bool should_fail(struct fault_attr *attr, ssize_t size)
 		unsigned int fail_nth = READ_ONCE(current->fail_nth);
 
 		if (fail_nth) {
-			if (!WRITE_ONCE(current->fail_nth, fail_nth - 1))
+			fail_nth--;
+			WRITE_ONCE(current->fail_nth, fail_nth);
+			if (!fail_nth)
 				goto fail;
 
 			return false;
-- 
2.26.2.645.ge9eca65c58-goog

