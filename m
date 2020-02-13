Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3937C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9002D20661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608494;
	bh=5kwNS4XKm3AZXsdFsl8F+9R4Dv3SzGpFpihSZp9kgfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ENsGeJoJs5DHol1/dYXrU0LKtPRmrhKe2NSo+jh9BsqSAHpeAxp0Vk5HIoiyoyGMs
	 1rU4l8TgX6VN+VENee4Dto6+fTm/GTUXCuCh2c6VVl74W4f3hM8NzxFwmBSNJOmthN
	 Xq0L4+QU739POi0OtYV5PQkPp3G2nieypvz7ISNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgBMPld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:41:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387719AbgBMP2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:33 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B40F222C2;
        Thu, 13 Feb 2020 15:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607712;
        bh=5kwNS4XKm3AZXsdFsl8F+9R4Dv3SzGpFpihSZp9kgfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rlxl2RnjE9msQsnL3Yhohul7G+Tc1/o2IqGBsRqR5wK2kRxPetpg6GGwQWT/K2wUF
         jyD1E4NUNQPW15hUN3Sg/qHFkEJAwdzJk+WouE3QUVCbrv8R2habI2y0+cFuQzq5HZ
         6nJkAzCSqBvOvkbW4pz8uoY6vvu8RvNdecbM4cpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Milkowski <rmilkowski@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 5.5 033/120] NFSv4: try lease recovery on NFS4ERR_EXPIRED
Date:   Thu, 13 Feb 2020 07:20:29 -0800
Message-Id: <20200213151913.099664754@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
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


