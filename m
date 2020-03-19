Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879C2C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571C221927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623831;
	bh=DhQdjjQn2eZ24B9bz74nkgn/f/f2bBwkrO5iDNd754A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sj8/LZ1c6QMbXC7JSACZQe7eVR1aveKc/LHYj0Ej3qqQqB0ANYAYHOU8Yp+MwDuyA
	 Y/ECTYaMKH9K9MPwkKmb0iX5GZZhpvu4ejCh7wZwTTjuV+TuyfR/ivDWYajbJumJxs
	 2+8LtN3wN2pNKkO3g8NmwpgmmZQzGDdZq/r76zZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgCSNRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:17:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbgCSNRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:17:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 084DC2098B;
        Thu, 19 Mar 2020 13:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623825;
        bh=DhQdjjQn2eZ24B9bz74nkgn/f/f2bBwkrO5iDNd754A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q7I0wozGiyaM6KEUDqG5RQEaF7UI7lEGyiyeGNfjSHpIJPbV5cUUC3bqRINF3XkIB
         S+faLAwgByi1WhP+HqrHg4ua9HhRKjQZAM0FlRBGDtoedZqfQikJk31ku93eFNVzLC
         5gglC43OAT7tQI66tGT2dEJcziGW+xPkdZDm6w/M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+84484ccebdd4e5451d91@syzkaller.appspotmail.com,
        Karsten Graul <kgraul@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 65/99] net/smc: check for valid ib_client_data
Date:   Thu, 19 Mar 2020 14:03:43 +0100
Message-Id: <20200319124001.180108595@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123941.630731708@linuxfoundation.org>
References: <20200319123941.630731708@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Karsten Graul <kgraul@linux.ibm.com>

commit a2f2ef4a54c0d97aa6a8386f4ff23f36ebb488cf upstream.

In smc_ib_remove_dev() check if the provided ib device was actually
initialized for SMC before.

Reported-by: syzbot+84484ccebdd4e5451d91@syzkaller.appspotmail.com
Fixes: a4cf0443c414 ("smc: introduce SMC as an IB-client")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/smc/smc_ib.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -513,6 +513,8 @@ static void smc_ib_remove_dev(struct ib_
 	struct smc_ib_device *smcibdev;
 
 	smcibdev = ib_get_client_data(ibdev, &smc_ib_client);
+	if (!smcibdev || smcibdev->ibdev != ibdev)
+		return;
 	ib_set_client_data(ibdev, &smc_ib_client, NULL);
 	spin_lock(&smc_ib_devices.lock);
 	list_del_init(&smcibdev->list); /* remove from smc_ib_devices */


