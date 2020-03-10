Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7E0C18E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AAE2468D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845478;
	bh=8gxeKVJRTa95MFXJxHtDVepSP8cSP4qItCCKQRtp9S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PMZahbZT5ytQeYzVTc0PKOFgWLqOa90ahPVS+Fiu6WSrUw5ZrulCvhn8eHp7avGgR
	 Tbd17Ab6nCWCEKbmVZSVRpC2DO51LyZHZX9jT23R0+AeDhpV/25748vMwT1CvdoLxs
	 dHy6/oxjqZFT+EQDYFW1z709Kqc5mTXHOwWJVCtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbgCJNEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:04:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730270AbgCJNEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:04:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 845872469E;
        Tue, 10 Mar 2020 13:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845473;
        bh=8gxeKVJRTa95MFXJxHtDVepSP8cSP4qItCCKQRtp9S8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OVtBg7MP+++N4tTl+MS8n21jKDBI9SHhOTHKuqAGy6HOVoJxdIU5ou/bZHe7s4k3s
         DZXIMv9h/i/x2Pc/aIhS+kyQYFzmO8jGxBDyPB/qtv/ZfGi3G9bJ4HFuXD49/rfo7c
         uvPjsp1dwNo4JtlCSSdvB0ulH+evOjaAgoRwXbFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+2e80962bedd9559fe0b3@syzkaller.appspotmail.com,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.5 163/189] RDMA/siw: Fix failure handling during device creation
Date:   Tue, 10 Mar 2020 13:40:00 +0100
Message-Id: <20200310123656.507835659@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bernard Metzler <bmt@zurich.ibm.com>

commit 12e5eef0f4d8087ea7b559f6630be08ffea2d851 upstream.

A failing call to ib_device_set_netdev() during device creation caused
system crash due to xa_destroy of uninitialized xarray hit by device
deallocation. Fixed by moving xarray initialization before potential
device deallocation.

Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
Link: https://lore.kernel.org/r/20200302155814.9896-1-bmt@zurich.ibm.com
Reported-by: syzbot+2e80962bedd9559fe0b3@syzkaller.appspotmail.com
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/sw/siw/siw_main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -388,6 +388,9 @@ static struct siw_device *siw_device_cre
 		{ .max_segment_size = SZ_2G };
 	base_dev->num_comp_vectors = num_possible_cpus();
 
+	xa_init_flags(&sdev->qp_xa, XA_FLAGS_ALLOC1);
+	xa_init_flags(&sdev->mem_xa, XA_FLAGS_ALLOC1);
+
 	ib_set_device_ops(base_dev, &siw_device_ops);
 	rv = ib_device_set_netdev(base_dev, netdev, 1);
 	if (rv)
@@ -415,9 +418,6 @@ static struct siw_device *siw_device_cre
 	sdev->attrs.max_srq_wr = SIW_MAX_SRQ_WR;
 	sdev->attrs.max_srq_sge = SIW_MAX_SGE;
 
-	xa_init_flags(&sdev->qp_xa, XA_FLAGS_ALLOC1);
-	xa_init_flags(&sdev->mem_xa, XA_FLAGS_ALLOC1);
-
 	INIT_LIST_HEAD(&sdev->cep_list);
 	INIT_LIST_HEAD(&sdev->qp_list);
 


