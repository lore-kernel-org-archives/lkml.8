Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CC4C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613E420708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338986;
	bh=YcbUnEI8ku3L7JAI2gZ656OBZUwtWXRyO7qfoNm5ELI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wtAYgwvF8u3612lzrUy4/Qt3lU8DCIgYpoCMSD8egZnDNnDSyE2jscphI6hXT8CM/
	 25CC0+MZbS/6bH6TAWoaTq0L5YNFakqLdCFSpITiNWRPxWEQ4catyPPpT++nR/A8Zs
	 KBnpZJSs3a38Yfg52IUmU15Bc9rEtfn2XPJXf8SY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbgBJMo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:44:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:41428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729267AbgBJMks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:48 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33DC9208C4;
        Mon, 10 Feb 2020 12:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338448;
        bh=YcbUnEI8ku3L7JAI2gZ656OBZUwtWXRyO7qfoNm5ELI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YX7HXfJulT+hmEuYJV7QUMS/VIOAvg8GhA0vfyF55GARgFeb3/wlm5CzIvm73Ycom
         YY2m+lCraHZw1HfT+EdlfW/yVS4Wo9H8/js93E5LuAFtB95khXK1E+l04vU+w/ymGh
         HzMbMF3QLgBOw0AiHI4Ey0CNWjvCtm3OAGS8cCZw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 5.5 191/367] nfsd: fix filecache lookup
Date:   Mon, 10 Feb 2020 04:31:44 -0800
Message-Id: <20200210122442.230279966@linuxfoundation.org>
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

commit 28c7d86bb6172ffbb1a1237c6388e77f9fe5f181 upstream.

If the lookup keeps finding a nfsd_file with an unhashed open file,
then retry once only.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org
Fixes: 65294c1f2c5e "nfsd: add a new struct file caching facility to nfsd"
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/filecache.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -789,6 +789,7 @@ nfsd_file_acquire(struct svc_rqst *rqstp
 	struct nfsd_file *nf, *new;
 	struct inode *inode;
 	unsigned int hashval;
+	bool retry = true;
 
 	/* FIXME: skip this if fh_dentry is already set? */
 	status = fh_verify(rqstp, fhp, S_IFREG,
@@ -824,6 +825,11 @@ wait_for_construction:
 
 	/* Did construction of this file fail? */
 	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
+		if (!retry) {
+			status = nfserr_jukebox;
+			goto out;
+		}
+		retry = false;
 		nfsd_file_put_noref(nf);
 		goto retry;
 	}


