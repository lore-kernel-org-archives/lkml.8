Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74BEC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC41320675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608828;
	bh=Om4DCQ6MWrdTNqEtW7PJVl/OK48/2nRUNwjKoGUwVKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HyaANGyGqPXxpnserjWwinspfkc1OWbExTwA1nbVFsZHC0lc8NG3x3npwC05byxNN
	 FshWprGJPWI/MwzpbY1GUYCmZYGaIqrExGk4Yy6GoPBD6P7E6jHXXia2f/qphGzS6W
	 TuVGSfd3bC6KabGWO4IWQBmZ8MIMMYEtTwpI3tRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbgBMPrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:49252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728444AbgBMP1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:11 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3E5E206DB;
        Thu, 13 Feb 2020 15:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607631;
        bh=Om4DCQ6MWrdTNqEtW7PJVl/OK48/2nRUNwjKoGUwVKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ya4YytysVT9p1buR0L5VnFvluERK0PbhMKWfNfM4u/lnKGhRsmntEc3+siu7xL6uW
         JbA8DUQBiuXwLhpuzDAhRgz427KCIXcVriE39NqRgoCJMcUG7FKepJ4pzI/SiUrmqx
         2jgyy+IWhJ1IbPo91u/8l7PeqfaYBQMf7TqHBrTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 5.4 31/96] NFSv4: pnfs_roc() must use cred_fscmp() to compare creds
Date:   Thu, 13 Feb 2020 07:20:38 -0800
Message-Id: <20200213151850.993479505@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151839.156309910@linuxfoundation.org>
References: <20200213151839.156309910@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trondmy@gmail.com>

commit 387122478775be5d9816c34aa29de53d0b926835 upstream.

When comparing two 'struct cred' for equality w.r.t. behaviour under
filesystem access, we need to use cred_fscmp().

Fixes: a52458b48af1 ("NFS/NFSD/SUNRPC: replace generic creds with 'struct cred'.")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/pnfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1425,7 +1425,7 @@ retry:
 	/* lo ref dropped in pnfs_roc_release() */
 	layoutreturn = pnfs_prepare_layoutreturn(lo, &stateid, &iomode);
 	/* If the creds don't match, we can't compound the layoutreturn */
-	if (!layoutreturn || cred != lo->plh_lc_cred)
+	if (!layoutreturn || cred_fscmp(cred, lo->plh_lc_cred) != 0)
 		goto out_noroc;
 
 	roc = layoutreturn;


