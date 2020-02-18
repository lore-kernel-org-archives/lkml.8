Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9D9C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494EE24677
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582055855;
	bh=u9QadL+YesFMEdUQcQEqUQB7XQTVq7Y/7R5E6mojdVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W7MQSc8rThKWAhd7LZtzyBLAAORNcZqbIPlz8hSZ30cpPTKKlBz53P0dLSWuhJS2t
	 y2XnYjkid3pUg4AAUU2cRYP133/mekEbkyukFi7c8bPDy45gpasRjVXduG9QrAhQiK
	 WHmrb3zAMnZ3NhJGsEFczvk2IKm0ASJJxQEsnfqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgBRT5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:57:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgBRT50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:57:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57C0C20659;
        Tue, 18 Feb 2020 19:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582055845;
        bh=u9QadL+YesFMEdUQcQEqUQB7XQTVq7Y/7R5E6mojdVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cf53A2HV90r4BQNaIZhWm1Q5b+NGBF/PZF7RaPSVI234U02wIY07o34u8lOoDXazs
         0+TCY74SIY7Dkvy6qy3FcP21njkBlplmLeu0CO8z5tGE41vb+ugrRkN6LXu6+nJRUu
         42HJLBNx/xwHqd7Ml/7juLxDdYnrKGzqxyHuiS5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.19 35/38] NFSv4.1 make cachethis=no for writes
Date:   Tue, 18 Feb 2020 20:55:21 +0100
Message-Id: <20200218190422.605660378@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190418.536430858@linuxfoundation.org>
References: <20200218190418.536430858@linuxfoundation.org>
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
@@ -5117,7 +5117,7 @@ static void nfs4_proc_write_setup(struct
 	hdr->timestamp   = jiffies;
 
 	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_WRITE];
-	nfs4_init_sequence(&hdr->args.seq_args, &hdr->res.seq_res, 1, 0);
+	nfs4_init_sequence(&hdr->args.seq_args, &hdr->res.seq_res, 0, 0);
 	nfs4_state_protect_write(server->nfs_client, clnt, msg, hdr);
 }
 


