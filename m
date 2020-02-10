Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF011C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70E72070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340678;
	bh=V+Z/dCryjszG9zEWn5Vhxv+vMDYsQBbrdjNEh0IcaJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bfoz+/+S+e5iEGTcOU2MrNdW0dDc/8dIRptOsiA1v2/37CiLDdlMYjUd0WgNZ0J4p
	 vRFSldVRoklYSJpS4ZuaZxVPrXoo2Gq5epmmjpDVIGDeYYDFAW71Kgb5Gnb4vQNR03
	 JEm6pQnTEQMMaIg+TiN+vpcDwUh0SDAAJZ7eiEMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgBJNR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:17:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:60762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728978AbgBJMh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:37:59 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F27D2085B;
        Mon, 10 Feb 2020 12:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338278;
        bh=V+Z/dCryjszG9zEWn5Vhxv+vMDYsQBbrdjNEh0IcaJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N6UBumVTRDcvnL/QrLGSbF1B0+p7ATHREikMENC+muSVg9VbEEmxdqQTjgW4rn6I4
         dTEhqjr/Zw4HExV0WUxwqkaaA9RT4/Oy7PsFnHWOzUP2PpDQvjgo32TRpffiZVyyqc
         nZhmL7gq5J0kEj6dvgVQ1nUbqSjdtkWX9cYeauOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 5.4 167/309] nfsd: fix filecache lookup
Date:   Mon, 10 Feb 2020 04:32:03 -0800
Message-Id: <20200210122422.351415309@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
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
@@ -791,6 +791,7 @@ nfsd_file_acquire(struct svc_rqst *rqstp
 	struct nfsd_file *nf, *new;
 	struct inode *inode;
 	unsigned int hashval;
+	bool retry = true;
 
 	/* FIXME: skip this if fh_dentry is already set? */
 	status = fh_verify(rqstp, fhp, S_IFREG,
@@ -826,6 +827,11 @@ wait_for_construction:
 
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


