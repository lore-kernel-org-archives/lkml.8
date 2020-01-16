Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50C7C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5312064C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218276;
	bh=zxMwx2OtgXRt1znZy60Yrg+tBGsBd59R2bQKe67uDE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I5fvoOWu10u28H6W7ka9lVo/eFX2gGUWlMGvLAfVVVW1P+lcl/cj5XQxAy+G7IX84
	 5m7BwoNyriPQdhbS7qVpnIcXG7fU96ykZ3paKU1tZ6inWMHG7G6K/9Pg/pyawUZzyu
	 YAIFDk/LXZXHcCEwRt/3RPRPsIq7ZM0n5BHADTbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733063AbgAPXYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:24:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:52668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729794AbgAPXX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:23:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC201206D9;
        Thu, 16 Jan 2020 23:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217035;
        bh=zxMwx2OtgXRt1znZy60Yrg+tBGsBd59R2bQKe67uDE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CPxCudQ8sbjoRp1c9qRHf9ORESqhCcA70eyZJrYJhms6EvLSb0Y5X3Ueh7IWr08ry
         xbch6Xx0vNddMqi37h746pDJvab/+62KoRYdMt2AtJtMkQkClBgBTJranqOEl9iUb2
         CTTH7pKkJRDFpMIrBNVRuOdkynuYWCln5rbsllvw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jamie Heilman <jamie@audible.transient.net>,
        Scott Mayhew <smayhew@redhat.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 5.4 105/203] nfsd: Fix cld_net->cn_tfm initialization
Date:   Fri, 17 Jan 2020 00:17:02 +0100
Message-Id: <20200116231754.736665919@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Mayhew <smayhew@redhat.com>

commit 18b9a895e652979b70f9c20565394a69354dfebc upstream.

Don't assign an error pointer to cld_net->cn_tfm, otherwise an oops will
occur in nfsd4_remove_cld_pipe().

Also, move the initialization of cld_net->cn_tfm so that it occurs after
the check to see if nfsdcld is running.  This is necessary because
nfsd4_client_tracking_init() looks for -ETIMEDOUT to determine whether
to use the "old" nfsdcld tracking ops.

Fixes: 6ee95d1c8991 ("nfsd: add support for upcall version 2")
Reported-by: Jamie Heilman <jamie@audible.transient.net>
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/nfs4recover.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -1578,6 +1578,7 @@ nfsd4_cld_tracking_init(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	bool running;
 	int retries = 10;
+	struct crypto_shash *tfm;
 
 	status = nfs4_cld_state_init(net);
 	if (status)
@@ -1586,11 +1587,6 @@ nfsd4_cld_tracking_init(struct net *net)
 	status = __nfsd4_init_cld_pipe(net);
 	if (status)
 		goto err_shutdown;
-	nn->cld_net->cn_tfm = crypto_alloc_shash("sha256", 0, 0);
-	if (IS_ERR(nn->cld_net->cn_tfm)) {
-		status = PTR_ERR(nn->cld_net->cn_tfm);
-		goto err_remove;
-	}
 
 	/*
 	 * rpc pipe upcalls take 30 seconds to time out, so we don't want to
@@ -1607,6 +1603,12 @@ nfsd4_cld_tracking_init(struct net *net)
 		status = -ETIMEDOUT;
 		goto err_remove;
 	}
+	tfm = crypto_alloc_shash("sha256", 0, 0);
+	if (IS_ERR(tfm)) {
+		status = PTR_ERR(tfm);
+		goto err_remove;
+	}
+	nn->cld_net->cn_tfm = tfm;
 
 	status = nfsd4_cld_get_version(nn);
 	if (status == -EOPNOTSUPP)


