Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB01CC433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2FB2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753517;
	bh=sj7Mgy53uvCuBJN5AxCbcIf+Ao8fcs55/4IY3bzKD68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qbMjA4vDN9iE1SjkoWWRq4/sXcpdLVTbm32QIl+1wGkiFqxjryf5x7mPXI3ZKRCBd
	 vbltJlkoGot3GIU4FinWx96z6SdLwR9yPXYPFarhMWoRAmFj0R7DtYZb9P3VhaUId8
	 vtNd5v/3FVwh846kdX+qD+ru2IV/DyP+KSSVytu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbgGNTFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729554AbgGNSzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:55:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87BE322BF3;
        Tue, 14 Jul 2020 18:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752901;
        bh=sj7Mgy53uvCuBJN5AxCbcIf+Ao8fcs55/4IY3bzKD68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KABGEfNkMwcFlZZAjPTzoqFKhxezYb914OoGcmVe7mYkpCueCFe8RmEFa5M4JHJ2O
         Cfu7ym5gpd/cLQOS5WWqv6GSjhUOBhJSBYaEMHgR8Pfojl98NheaKqJ2ICAxACtZUx
         XT0P5UXA7+OH9Zzjge/0LnCD3w5/9Dc5PdcRqfTs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 043/166] nfs: Fix memory leak of export_path
Date:   Tue, 14 Jul 2020 20:43:28 +0200
Message-Id: <20200714184117.942167644@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

[ Upstream commit 4659ed7cc8514369043053463514408ca16ad6f3 ]

The try_location function is called within a loop by nfs_follow_referral.
try_location calls nfs4_pathname_string to created the export_path.
nfs4_pathname_string allocates the memory. export_path is stored in the
nfs_fs_context/fs_context structure similarly as hostname and source.
But whereas the ctx hostname and source are freed before assignment,
export_path is not.  So if there are multiple loops, the new export_path
will overwrite the old without the old being freed.

So call kfree for export_path.

Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4namespace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4namespace.c b/fs/nfs/nfs4namespace.c
index a3ab6e219061b..873342308dc0d 100644
--- a/fs/nfs/nfs4namespace.c
+++ b/fs/nfs/nfs4namespace.c
@@ -308,6 +308,7 @@ static int try_location(struct fs_context *fc,
 	if (IS_ERR(export_path))
 		return PTR_ERR(export_path);
 
+	kfree(ctx->nfs_server.export_path);
 	ctx->nfs_server.export_path = export_path;
 
 	source = kmalloc(len + 1 + ctx->nfs_server.export_path_len + 1,
-- 
2.25.1



