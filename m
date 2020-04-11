Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7A2C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9E020787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607375;
	bh=67LXw2T1Q5Xxds2H0TR+DgKNBIZV5hKGpkb0wzIGYdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yU6AEUQ/TwthzAvw2X7rCRRZ+hdfJU7s8hP3VHrLEqItEWVBwGyex42bK3ewR3k5X
	 nHiRaEqW4z7VCUyRc9rqS+f+lLt/Bnz4NPH27/Aoz8UxtEtUlpRZBeEgDM9FWe5W8M
	 Cf0Wlx64eKojH5+Np4kpP7rielkwCxFfjVNvwZN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgDKMQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727974AbgDKMQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:16:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D2D221744;
        Sat, 11 Apr 2020 12:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607368;
        bh=67LXw2T1Q5Xxds2H0TR+DgKNBIZV5hKGpkb0wzIGYdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JBSvZBrCIXzDMorzfeumYRBHmlFZESkLAj/kf5r25ouRrwgm+AWALTEmzXBP5BFt/
         1spgwxP6vNHGQUySuWGf2DIlWaBep+l37kzDDoKodXRPrhNljt36YeRIaldIKUeN0L
         4u4XfDiSgHftiz8lOx5voUKYkG6XYfQn/OqOlUUU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.19 45/54] RDMA/cma: Teach lockdep about the order of rtnl and lock
Date:   Sat, 11 Apr 2020 14:09:27 +0200
Message-Id: <20200411115513.221115209@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115508.284500414@linuxfoundation.org>
References: <20200411115508.284500414@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

commit 32ac9e4399b12d3e54d312a0e0e30ed5cd19bd4e upstream.

This lock ordering only happens when bonding is enabled and a certain
bonding related event fires. However, since it can happen this is a global
restriction on lock ordering.

Teach lockdep about the order directly and unconditionally so bugs here
are found quickly.

See https://syzkaller.appspot.com/bug?extid=55de90ab5f44172b0c90

Link: https://lore.kernel.org/r/20200227203651.GA27185@ziepe.ca
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/cma.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4635,6 +4635,19 @@ static int __init cma_init(void)
 {
 	int ret;
 
+	/*
+	 * There is a rare lock ordering dependency in cma_netdev_callback()
+	 * that only happens when bonding is enabled. Teach lockdep that rtnl
+	 * must never be nested under lock so it can find these without having
+	 * to test with bonding.
+	 */
+	if (IS_ENABLED(CONFIG_LOCKDEP)) {
+		rtnl_lock();
+		mutex_lock(&lock);
+		mutex_unlock(&lock);
+		rtnl_unlock();
+	}
+
 	cma_wq = alloc_ordered_workqueue("rdma_cm", WQ_MEM_RECLAIM);
 	if (!cma_wq)
 		return -ENOMEM;


