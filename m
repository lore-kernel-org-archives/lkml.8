Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2538C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812062051A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338926;
	bh=mOBlwavlbau8vB+rE6PQapruNs+NJ/+2dgZdrnVFrF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D4A/5u3AQCaXOACrQhguyCVQUFeCjQ6Cqu1dcccAu9FSZ04F2Ns0oWd5NDU4+22/U
	 WKgfLj3MNetcUNblPWFbI8SAEa0UmKRrayZL6GpmU/v3CYCpD86qtbEaXkY2wmRHe8
	 1fooRe6yRyRjuY8E0L6pmjFNZ0Thf2UxZzWzd8LU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbgBJMqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:46:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:44552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbgBJMln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:41:43 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1BC12051A;
        Mon, 10 Feb 2020 12:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338502;
        bh=mOBlwavlbau8vB+rE6PQapruNs+NJ/+2dgZdrnVFrF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iGsopIxg5d2rZHBnTkYuw57/WcUxr2Enm+02szQRIWgdMIWbgnh3j2ZE2LEj8D3nG
         ux7rDSbxvRr9im63jDeCcg9OtVdP6m/JrUqTA/sieIkOtzlDtkhv0uYkS9f1oPEMLa
         ZmaMmcQ1/gi61IKHFPpuhv4lSmJLq2qH94tjgfPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 5.5 300/367] nfsd: Return the correct number of bytes written to the file
Date:   Mon, 10 Feb 2020 04:33:33 -0800
Message-Id: <20200210122451.276054807@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trondmy@gmail.com>

commit 09a80f2aef06b7c86143f5c14efd3485e0d2c139 upstream.

We must allow for the fact that iov_iter_write() could have returned
a short write (e.g. if there was an ENOSPC issue).

Fixes: d890be159a71 "nfsd: Add I/O trace points in the NFSv4 write path"
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/vfs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -975,6 +975,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, s
 	host_err = vfs_iter_write(file, &iter, &pos, flags);
 	if (host_err < 0)
 		goto out_nfserr;
+	*cnt = host_err;
 	nfsdstats.io_write += *cnt;
 	fsnotify_modify(file);
 


