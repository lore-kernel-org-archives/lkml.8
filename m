Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDF7C2BB85
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC74221655
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607704;
	bh=iG//IDtDGiIwfUG6Zw9oLRfItHxPDSHWN+r3Gw+cZkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dXuHT2pzPmvx1Qe4TesJzTlRWS3GNwMfB7WUBmaka4hy+zehL3DbI755MUHqbuL5W
	 ygJcimenOpby2vMQkVq2vkfZpmyP+RGhUVWc/W3lyLGGgQWasKTClpQ8A9DFwOC2dT
	 o/VNiVJEgyKnD3fHI+BeK6ruGjdhXQUEi2CWqM60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgDKMVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:21:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729154AbgDKMVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:21:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA7512084D;
        Sat, 11 Apr 2020 12:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607695;
        bh=iG//IDtDGiIwfUG6Zw9oLRfItHxPDSHWN+r3Gw+cZkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W5AW1kR44vWVMDg33jJLgW6RqtYExiUmtRGVVPBhLeYy0kmmCUauNcYi8v/HSWlPJ
         ES0FAhEWvv3yXWyl45GZmdj/Lg63qYQ8DbItodZrCPiIFxNo3TxduGCwtEG5X/ZXfO
         kn68INjpvwtclZ3FhNEhDa9LpvDwePGDtUs1hck0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.6 31/38] RDMA/cma: Teach lockdep about the order of rtnl and lock
Date:   Sat, 11 Apr 2020 14:10:08 +0200
Message-Id: <20200411115503.064066625@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115459.324496182@linuxfoundation.org>
References: <20200411115459.324496182@linuxfoundation.org>
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
@@ -4790,6 +4790,19 @@ static int __init cma_init(void)
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


