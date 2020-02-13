Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B366C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5405F20675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608196;
	bh=5kwNS4XKm3AZXsdFsl8F+9R4Dv3SzGpFpihSZp9kgfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JrmjrCYtV4Ci4aMTwSpQqfrEP2pV7yGMyODDxfTGubwmMlNycmfdDMc4z1I4TTVAl
	 MJtoNHNpZnbVQnmsv4m8c5DVjl7tqzphXuu9Kt0mONsB8xI0pV7x9sXEPLs+d4jAF1
	 N4+ifBbiYtCVWM8asgYYuish9UW2mIQbjzIEaWVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387922AbgBMPaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:30:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:49298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbgBMP1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:12 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B5EF2465D;
        Thu, 13 Feb 2020 15:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607631;
        bh=5kwNS4XKm3AZXsdFsl8F+9R4Dv3SzGpFpihSZp9kgfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1PdQKhQKYTtJQG++pb8OYIIxxSB98dLD3yJR0vS9/oWHO4cUfHW6Nfh1GqauAG4xH
         O28K0BDaBZ2BeWNNrwFpc3hjzaRFqj7Z1NdfK05zfBJnKKDgt2PQgWMGg+o6GHaUsJ
         DrZvtGJPf/ZRoB1pN0h1d8pvXc+DiAgWUfce8QWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Milkowski <rmilkowski@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 5.4 32/96] NFSv4: try lease recovery on NFS4ERR_EXPIRED
Date:   Thu, 13 Feb 2020 07:20:39 -0800
Message-Id: <20200213151851.414866295@linuxfoundation.org>
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

From: Robert Milkowski <rmilkowski@gmail.com>

commit 924491f2e476f7234d722b24171a4daff61bbe13 upstream.

Currently, if an nfs server returns NFS4ERR_EXPIRED to open(),
we return EIO to applications without even trying to recover.

Fixes: 272289a3df72 ("NFSv4: nfs4_do_handle_exception() handle revoke/expiry of a single stateid")
Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
Reviewed-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/nfs4proc.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3187,6 +3187,11 @@ static struct nfs4_state *nfs4_do_open(s
 			exception.retry = 1;
 			continue;
 		}
+		if (status == -NFS4ERR_EXPIRED) {
+			nfs4_schedule_lease_recovery(server->nfs_client);
+			exception.retry = 1;
+			continue;
+		}
 		if (status == -EAGAIN) {
 			/* We must have found a delegation */
 			exception.retry = 1;


