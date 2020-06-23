Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61378C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3067B2070E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947206;
	bh=x52YH5A12U1s0BZMnkC2ea7ZFIj87Gj1lcrGA1eHNlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=knr2sRosRDiNN/BWua1z7QfSWOsHfNK+9La0Kg5sI4FIET7BJCJOVVpfBmzH0moO+
	 C/GhsG/wXv8O5oLZDTK8x+Bdbaj7e7FkyGNxKJtDI+CjMC0UBdcxQyZn4L+VxBtEhc
	 4Stb1hNCKy4+Be0TaBW+0vqpJAS2TD64L5HInlCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391770AbgFWVUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:20:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390348AbgFWUXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:23:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AD702064B;
        Tue, 23 Jun 2020 20:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943834;
        bh=x52YH5A12U1s0BZMnkC2ea7ZFIj87Gj1lcrGA1eHNlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZBJIAfLTHDYVbYzjVh22Jd9mSFZNTurfv/Ii+rscWNuMYpO/RCeLHSG/4u9fmSR65
         GAkKHPvSrthGcyTCfGWlSEWylWFWWVeqWO+2Z7BO1NbNunTgN0Hs1faRXdydzLO7aM
         Gigoek1r+KU6xEVs67p7BEhW3lQDTHUIHZsRJ/G8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 062/314] nfsd: Fix svc_xprt refcnt leak when setup callback client failed
Date:   Tue, 23 Jun 2020 21:54:17 +0200
Message-Id: <20200623195341.783878353@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
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
index afca3287184b9..efe55d101b0ed 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1230,6 +1230,8 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
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



