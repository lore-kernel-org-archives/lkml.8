Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB22C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568EC208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859230;
	bh=+Nh467WUBrLxIPFA7PqMBLLBaTZSCjMvZb6w5eSQ6r8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XfXAZJVPNCTWubM5kfzfjcg0pidcnNVmmC6FZ83o2N9PGju5jPrk3VYNB0Dio6uPD
	 6fFUFZ4BFm4v9g23Gb4S78MEyqVaJF+0NdWZeO/NFM1iP1waJJ6oFWjdo5y3j3lp7x
	 sfKpRzFzo2HEuz1HDp+4lC8UW2rTcd8CKI6PfpcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387633AbgAXJrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:47:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730667AbgAXJrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:47:07 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03F032087E;
        Fri, 24 Jan 2020 09:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859226;
        bh=+Nh467WUBrLxIPFA7PqMBLLBaTZSCjMvZb6w5eSQ6r8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TF2kxJeqw56RLRin+vL4ui8UclJ3NOjJuc+02irYiZyMzAhEybQDe5BGoYQ3ZFOM0
         pgIXlp/ilDeN5BqEQUp+3p/POhotLYTpRaEnMhNJIyrs4UiQv0j7RoZ2ytCvJgSXZI
         HosZfvv9W0sMW+p+L+aZKakaPuo1Q1TICuVwrwsw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 058/343] RDMA/ocrdma: Fix out of bounds index check in query pkey
Date:   Fri, 24 Jan 2020 10:27:56 +0100
Message-Id: <20200124092927.487316371@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gal Pressman <galpress@amazon.com>

[ Upstream commit b188940796c7be31c1b8c25a9a0e0842c2e7a49e ]

The pkey table size is one element, index should be tested for > 0 instead
of > 1.

Fixes: fe2caefcdf58 ("RDMA/ocrdma: Add driver for Emulex OneConnect IBoE RDMA adapter")
Signed-off-by: Gal Pressman <galpress@amazon.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 27d5e8d9f08d3..7683d13dad3d5 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -55,7 +55,7 @@
 
 int ocrdma_query_pkey(struct ib_device *ibdev, u8 port, u16 index, u16 *pkey)
 {
-	if (index > 1)
+	if (index > 0)
 		return -EINVAL;
 
 	*pkey = 0xffff;
-- 
2.20.1



