Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2CCC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E161218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607578;
	bh=LDwsagcPvncREaWRkphZJJ11vcxiGs5VBaB88r8yZBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1qHNxJzdmxoa3Z78pJZsv654EyQwMyn7twWRyWEwGnJyAOcS2OhwCuStQXDJ6QVzf
	 +LmEMAw/uVyHqMhpO/6h8RXW9q29iNzDPAUImplVM2WQoYKyhuBIOjUv12098i5wYH
	 Ajy5ZXa9O03kbYCDkvGNIiI9XJdrMd1HhYGkmKjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387521AbgBMP0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:26:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgBMPY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:27 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8390820848;
        Thu, 13 Feb 2020 15:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607466;
        bh=LDwsagcPvncREaWRkphZJJ11vcxiGs5VBaB88r8yZBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iNqGoTnroNlka0HwiDU2MhteuulY6VKI7vG4CYBomnoN+h4YQ1pchM+yFN0wXVrGc
         WtyIfadIHhNZtJm/REe6DP1Vu8qEWuF41sg7GwdLSQFDcJfVSpHmVIe+Dmg+9b84vZ
         X0odJQSfmuVozJMJAElNbwLYm1Qzk5Po6zjWvouk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Milkowski <rmilkowski@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 4.9 102/116] NFSv4: try lease recovery on NFS4ERR_EXPIRED
Date:   Thu, 13 Feb 2020 07:20:46 -0800
Message-Id: <20200213151922.089222431@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
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
@@ -2916,6 +2916,11 @@ static struct nfs4_state *nfs4_do_open(s
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


