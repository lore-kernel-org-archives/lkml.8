Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A52C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1423020702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945747;
	bh=oLIKfJGCNx2bGod8RcZC+tmCFiA6XqLaQHeOA42g2oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ioo3tTCv2o0W6A60jM8hS1Z/IJZdhnYYjcb+CW+/3XVXcuA1XIBeKnMCsnSukwp5n
	 hwP90FnnU7CSoGRQ7N4SVRH1jdnGpJM9NzLtV6buMX2ZKl2oCUAjJaJpLi80WLh3Yo
	 D+c2lrpCLrEjolh9xJLBtT/p7KhXSdoN0VJPXNf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392916AbgFWUzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392578AbgFWUoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:44:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0690D218AC;
        Tue, 23 Jun 2020 20:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945072;
        bh=oLIKfJGCNx2bGod8RcZC+tmCFiA6XqLaQHeOA42g2oM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ymEGM3e8G3n2sbT90AcdMJYVwcWVSesHvYNFStSy1F5W6cjRVv9Mwx07Ys4L4RMje
         4yF3Ked0aGWJJ78HxVfOxitXX31YJ1AKgSAHqvLZAxojaei9XY1ueY9MhzDuhpwdVg
         k7b7GMUHhM72nEfWhRvuO+QdTVTFG8cQhF59kRhc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 028/136] nfsd: Fix svc_xprt refcnt leak when setup callback client failed
Date:   Tue, 23 Jun 2020 21:58:04 +0200
Message-Id: <20200623195305.070996150@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
References: <20200623195303.601828702@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

[ Upstream commit a4abc6b12eb1f7a533c2e7484cfa555454ff0977 ]

nfsd4_process_cb_update() invokes svc_xprt_get(), which increases the
refcount of the "c->cn_xprt".

The reference counting issue happens in one exception handling path of
nfsd4_process_cb_update(). When setup callback client failed, the
function forgets to decrease the refcnt increased by svc_xprt_get(),
causing a refcnt leak.

Fix this issue by calling svc_xprt_put() when setup callback client
failed.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4callback.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 80aeb19b176b2..22b784e7ef50b 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1161,6 +1161,8 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 	err = setup_callback_client(clp, &conn, ses);
 	if (err) {
 		nfsd4_mark_cb_down(clp, err);
+		if (c)
+			svc_xprt_put(c->cn_xprt);
 		return;
 	}
 }
-- 
2.25.1



