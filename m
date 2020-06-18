Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECA0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80529206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592479517;
	bh=v+3qkCNUmeD4W+ixW+zyvDBa9CjK4FXA5E6URvp6jkU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ku6W+za93Mld5tLxHS6+2XnnJhr0I9AmpR8LXiT9OK2C/e6FJnOHKzehRkJoplSr1
	 BiMb7+zBszlly16QznZPW088zRwQ7+Aus8onK7tZ3ZAjtjHGEAjUHh5UwVongFHe6c
	 3ZViB7Hxh67GME2vXQzjeaY0SDDvDwgFCJGoBiYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgFRLZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 07:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbgFRLZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 07:25:14 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D34120773;
        Thu, 18 Jun 2020 11:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592479514;
        bh=v+3qkCNUmeD4W+ixW+zyvDBa9CjK4FXA5E6URvp6jkU=;
        h=From:To:Cc:Subject:Date:From;
        b=nJWBlibMXCJuBDg8cPBENgeH68sWeg2oykqvpr5gmlLzwTemkfNAAHrClDMS4gBoF
         6hdJ9xrAuCSUDZpF4LdAjRhO1YmK0BbTqxdozWdUv750++msOwVB7cLtnr2UVo5KUF
         s4+5OLXNghtazdb9pQ5XyjRFiyp6RxCG22wxMgCU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-rc 0/2] Two small fixes to the mlx5_ib
Date:   Thu, 18 Jun 2020 14:25:05 +0300
Message-Id: <20200618112507.3453496-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

The following two fixes are user-visible one. The first patch is needed
to continue to use RAW_PACKET QPs after PR [1] is merged and new FW will
be released. The second patch fixes wrongly reported GID.

Thanks

[1] https://github.com/linux-rdma/rdma-core/pull/745

Leon Romanovsky (1):
  RDMA/mlx5: Remove ECE limitation from the RAW_PACKET QPs

Maor Gottlieb (1):
  RDMA/mlx5: Fix remote gid value in query QP

 drivers/infiniband/hw/mlx5/qp.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

--
2.26.2

