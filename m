Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07987C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A2421D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582056245;
	bh=HH6HlCFLdgp1ceDgg8ltpzWZuWl7JC0QEscAOUdM1RQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v3uaR68n5YlWtU+uAe1qp1+e30yLhkaEVIdjQ8PqERmD0+CSbNExoJJF3R8se9RBx
	 t3r1SuxR6BZeI6u6wujl6Kj6LEEp000vcAFnihpXt47XtPCCGpMY5M6Lohq+xq3xfm
	 TRQQnSsEL1ZvjpyKxq2XCoXT+7eyuw7Z99LgutMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgBRUEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:04:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:45444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729177AbgBRUEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:04:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA3521D56;
        Tue, 18 Feb 2020 20:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582056240;
        bh=HH6HlCFLdgp1ceDgg8ltpzWZuWl7JC0QEscAOUdM1RQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=srCmjDoZkVthdHOcGmZgZNQWyHnB+cBTookbwijWRPKU/XLRsk3NpufC4sQKKP1nc
         iZSn4VmHpRkHuHtmcR/0iSD+yMsIg3N9Ha9pwQbdRhjRUY0lrjD9RokbHIBRAI98wG
         WjyDrOb5PzAzLIetnMF+/F+kE4+ACWKDO26L2OME=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 5.5 72/80] NFSv4.1 make cachethis=no for writes
Date:   Tue, 18 Feb 2020 20:55:33 +0100
Message-Id: <20200218190438.741339929@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190432.043414522@linuxfoundation.org>
References: <20200218190432.043414522@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

commit cd1b659d8ce7697ee9799b64f887528315b9097b upstream.

Turning caching off for writes on the server should improve performance.

Fixes: fba83f34119a ("NFS: Pass "privileged" value to nfs4_init_sequence()")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Reviewed-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/nfs4proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5295,7 +5295,7 @@ static void nfs4_proc_write_setup(struct
 	hdr->timestamp   = jiffies;
 
 	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_WRITE];
-	nfs4_init_sequence(&hdr->args.seq_args, &hdr->res.seq_res, 1, 0);
+	nfs4_init_sequence(&hdr->args.seq_args, &hdr->res.seq_res, 0, 0);
 	nfs4_state_protect_write(server->nfs_client, clnt, msg, hdr);
 }
 


