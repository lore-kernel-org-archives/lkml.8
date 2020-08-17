Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1250C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF452072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597687717;
	bh=Yc7j79dnbAWX6tEFGGgvS0Ycw7eGmKt4dcAot2CU+GE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FTDzFpi4Acv/h2KPnB0AzlRgzcqeOt0vX5drGQj1IFqbulPwrf6tQA1hbHsgwKZ99
	 NHleSTumMrlUkzb/yGqE4JTDll5SBm31e4wPGCTXX4gdU8dUv6qHovdKcR9CzxCAjN
	 8HT9RagNcVBGIQcr2nf5EIYXuadOoWfVUrnQstj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390341AbgHQSIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:08:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388444AbgHQQIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:08:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E28CE20866;
        Mon, 17 Aug 2020 16:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680495;
        bh=Yc7j79dnbAWX6tEFGGgvS0Ycw7eGmKt4dcAot2CU+GE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pZDE0ISFK88Ig6GBE7/LRq1v/x3vjUVlMqsWxR+o6P/qKeoMlibMPS/bnXccnDsa4
         2kWGGP7RIIBOv3KWqLmCBuXChEHWuXIEVmvL7/fK8UTwVdYYQD7ezC524Sdq5pRJe7
         qVqBPbg+V6ok/dndkClX51SFodiqrgCzyNsS9GM0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wang Hai <wanghai38@huawei.com>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 210/270] dlm: Fix kobject memleak
Date:   Mon, 17 Aug 2020 17:16:51 +0200
Message-Id: <20200817143806.246083079@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Hai <wanghai38@huawei.com>

[ Upstream commit 0ffddafc3a3970ef7013696e7f36b3d378bc4c16 ]

Currently the error return path from kobject_init_and_add() is not
followed by a call to kobject_put() - which means we are leaking
the kobject.

Set do_unreg = 1 before kobject_init_and_add() to ensure that
kobject_put() can be called in its error patch.

Fixes: 901195ed7f4b ("Kobject: change GFS2 to use kobject_init_and_add")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/lockspace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index afb8340918b86..c689359ca532b 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -632,6 +632,9 @@ static int new_lockspace(const char *name, const char *cluster,
 	wait_event(ls->ls_recover_lock_wait,
 		   test_bit(LSFL_RECOVER_LOCK, &ls->ls_flags));
 
+	/* let kobject handle freeing of ls if there's an error */
+	do_unreg = 1;
+
 	ls->ls_kobj.kset = dlm_kset;
 	error = kobject_init_and_add(&ls->ls_kobj, &dlm_ktype, NULL,
 				     "%s", ls->ls_name);
@@ -639,9 +642,6 @@ static int new_lockspace(const char *name, const char *cluster,
 		goto out_recoverd;
 	kobject_uevent(&ls->ls_kobj, KOBJ_ADD);
 
-	/* let kobject handle freeing of ls if there's an error */
-	do_unreg = 1;
-
 	/* This uevent triggers dlm_controld in userspace to add us to the
 	   group of nodes that are members of this lockspace (managed by the
 	   cluster infrastructure.)  Once it's done that, it tells us who the
-- 
2.25.1



