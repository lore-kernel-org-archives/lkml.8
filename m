Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68171C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43B6C20809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581588;
	bh=wnNS99cHA6dlfP6h9le3Lc48er4P4aLxFt0UGZFEX7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cbPNYhHa8mNm1luV1RzZoNeVmM/XM/RuFrKsAkZq0qAVq9YYdMlcCKY5d6nk7J5WK
	 KaAMagB2Q9dVVd3PgfLVzgkkdeBLBOf2lDI77Quwd1rKSI0VWnGBtR78Q1D6XYCETQ
	 EPrTG1XfR2jBVNyj4uYqWOdtKi6vuY3q09pLf7Ho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391025AbgFSP0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:26:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393261AbgFSPY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:24:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECFCD217A0;
        Fri, 19 Jun 2020 15:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580266;
        bh=wnNS99cHA6dlfP6h9le3Lc48er4P4aLxFt0UGZFEX7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZiI/AstDvRnS76hi1H/CKkv4CmHKsyCRMjl4bjn7SSqjzbsia1EbZALOEyzpiAouQ
         x4QdcwH+S2op6zsa3R6edTqwLJL2ss5eyW3o4khGrtOeERUsmQgzBpq2mYFzTuXifT
         cQ64yn2aAGHwE5HxtTQMmt7YWDG74/rxEobbv9g4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 144/376] selinux: fix error return code in policydb_read()
Date:   Fri, 19 Jun 2020 16:31:02 +0200
Message-Id: <20200619141717.149515339@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 4c09f8b6913a779ca0c70ea8058bf21537eebb3b ]

Fix to return negative error code -ENOMEM from the kvcalloc() error
handling case instead of 0, as done elsewhere in this function.

Fixes: acdf52d97f82 ("selinux: convert to kvmalloc")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/ss/policydb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index c21b922e5ebe..1a4f74e7a267 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2504,6 +2504,7 @@ int policydb_read(struct policydb *p, void *fp)
 	if (rc)
 		goto bad;
 
+	rc = -ENOMEM;
 	p->type_attr_map_array = kvcalloc(p->p_types.nprim,
 					  sizeof(*p->type_attr_map_array),
 					  GFP_KERNEL);
-- 
2.25.1



