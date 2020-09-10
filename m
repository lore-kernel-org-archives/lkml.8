Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0534C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 628C620BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599733586;
	bh=qdz3piIzX1wpe0r/0uZBhudtd/hwLAcckI0SXN+J6n8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qn4TlF5vu7qnvj6CTkR48PdYPzHnTWSeKjNRb0PIR7za1Hfjha+mbG6ghMLDR7NDD
	 fKzj7W4JmbhmQOXXckf9Bj+6yCgc4BXiqWSavhQwQh0duz8kmr0m0pdzmtXPZA3ZQn
	 /C657BwD/Sx4Gq1Numax0WrEUXH/UK/FBWdpDSBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbgIJK0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:26:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730717AbgIJKY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:24:29 -0400
Received: from mail.kernel.org (ip5f5ad5ac.dynamic.kabel-deutschland.de [95.90.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95B87221E2;
        Thu, 10 Sep 2020 10:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599733450;
        bh=qdz3piIzX1wpe0r/0uZBhudtd/hwLAcckI0SXN+J6n8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQpLTaxB1z+Z8hDXGlg8cWhS9z7JIQEwW+eYG6nntM8/nl7ldg0I0JNhBYs31bxpR
         SzRJ3LLPi+i6O3YoeRSxv0jmoRkU4vYNPqCpTp/UM5+mXVGb8+A5bTIpyzGt9PzIea
         oTUMalbEK3WyDorvp6Xq4VTz1T9DfMZjNFIlPTPo=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kGJkO-00EINk-D0; Thu, 10 Sep 2020 12:24:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] blk-mq: docs: add kernel-doc description for a new struct member
Date:   Thu, 10 Sep 2020 12:23:57 +0200
Message-Id: <5d4405e08fa3cb5b1fa66e7c7567cb643c7b0b04.1599732764.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599732764.git.mchehab+huawei@kernel.org>
References: <cover.1599732764.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by kernel-doc:
	./include/linux/blk-mq.h:267: warning: Function parameter or member 'active_queues_shared_sbitmap' not described in 'blk_mq_tag_set'

There is now a new member for struct blk_mq_tag_set. Add a
description for it, based on the commit that introduced it.

Fixes: f1b49fdc1c64 ("blk-mq: Record active_queues_shared_sbitmap per tag_set for when using shared sbitmap")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/blk-mq.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b23eeca4d677..794b2a33a2c3 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -235,6 +235,8 @@ enum hctx_type {
  * @flags:	   Zero or more BLK_MQ_F_* flags.
  * @driver_data:   Pointer to data owned by the block driver that created this
  *		   tag set.
+ * @active_queues_shared_sbitmap:
+ * 		   number of active request queues per tag set.
  * @__bitmap_tags: A shared tags sbitmap, used over all hctx's
  * @__breserved_tags:
  *		   A shared reserved tags sbitmap, used over all hctx's
-- 
2.26.2

