Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FC1C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9474420656
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583259107;
	bh=Orqhdsj+el0e+3aAklsOAruIoqI8KBC5eVMvDcRwEIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RagxoV3zDnTC8o3cEBMkNfXBYRh4hxaH3UJKBNM2MYABWh7FHMhi52q8t6HThzsgU
	 UmVQ6PB4Y1NTzHCdRM3Hjt1vj6xWfZQKhNRo1ffmaQaM9yyw3TQi3o/G+Q0FG44FNZ
	 0gcBEt8hhAkGP2A6jkDeEYTglwrzS7GeKuRIabQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbgCCRtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:49:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730888AbgCCRt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:49:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2FBE214D8;
        Tue,  3 Mar 2020 17:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257768;
        bh=Orqhdsj+el0e+3aAklsOAruIoqI8KBC5eVMvDcRwEIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MCHIlWjLpz0NUtSzMD34VrDSomvwqNV7HMV5SFo1IC3MK0wPwnhuRTrPJEEuzVZah
         KramnHotoHbueMPNlBeW1gbM2EVaFnHw+G5CFoLY8aeLDtIWYIHPHj0a9ba7e0CGO+
         EJWPcaVDh+4u6mOOC7CtY0R643YfvhvVmgT3TcQM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 121/176] hv_netvsc: Fix unwanted wakeup in netvsc_attach()
Date:   Tue,  3 Mar 2020 18:43:05 +0100
Message-Id: <20200303174318.789628532@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

commit f6f13c125e05603f68f5bf31f045b95e6d493598 upstream.

When netvsc_attach() is called by operations like changing MTU, etc.,
an extra wakeup may happen while netvsc_attach() calling
rndis_filter_device_add() which sends rndis messages when queue is
stopped in netvsc_detach(). The completion message will wake up queue 0.

We can reproduce the issue by changing MTU etc., then the wake_queue
counter from "ethtool -S" will increase beyond stop_queue counter:
     stop_queue: 0
     wake_queue: 1
The issue causes queue wake up, and counter increment, no other ill
effects in current code. So we didn't see any network problem for now.

To fix this, initialize tx_disable to true, and set it to false when
the NIC is ready to be attached or registered.

Fixes: 7b2ee50c0cd5 ("hv_netvsc: common detach logic")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/hyperv/netvsc.c     |    2 +-
 drivers/net/hyperv/netvsc_drv.c |    3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -99,7 +99,7 @@ static struct netvsc_device *alloc_net_d
 
 	init_waitqueue_head(&net_device->wait_drain);
 	net_device->destroy = false;
-	net_device->tx_disable = false;
+	net_device->tx_disable = true;
 
 	net_device->max_pkt = RNDIS_MAX_PKT_DEFAULT;
 	net_device->pkt_align = RNDIS_PKT_ALIGN_DEFAULT;
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -977,6 +977,7 @@ static int netvsc_attach(struct net_devi
 	}
 
 	/* In any case device is now ready */
+	nvdev->tx_disable = false;
 	netif_device_attach(ndev);
 
 	/* Note: enable and attach happen when sub-channels setup */
@@ -2354,6 +2355,8 @@ static int netvsc_probe(struct hv_device
 	else
 		net->max_mtu = ETH_DATA_LEN;
 
+	nvdev->tx_disable = false;
+
 	ret = register_netdevice(net);
 	if (ret != 0) {
 		pr_err("Unable to register netdev.\n");


