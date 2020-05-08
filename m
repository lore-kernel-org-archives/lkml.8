Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8262CC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 566DE20870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943751;
	bh=j86P8k+g1afCoj1GO37lmRvusAWBC1GoGPfUwLbH1M4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ggIo6AJSvNdoz7+jW4lxiphC5Z/IHl9Npwq53MtV6NRWT1YLvtoATqeQ7s5g8TgrS
	 hoFZgg356hS1SsLpSbGrBbgy9iNuEW8smeC5CPkTKCw2Y4WMNOXYN6PhCkh+0FYpjd
	 wXHlH/r5nhVWh38JIyXrG6pFWuebq3ghW40X9oQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgEHNPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:15:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728963AbgEHMpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:45:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 636332495A;
        Fri,  8 May 2020 12:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941945;
        bh=j86P8k+g1afCoj1GO37lmRvusAWBC1GoGPfUwLbH1M4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qLmrNanVvmxSzELAE3N0frzVUSiMQREqM/wic3OvMo4CmoaFMXadgrn8yDFVpyFRI
         Q71EcQfUc72YkbsLyMJktBj/OjYo0p0sMS1ma2Kcmi2yKCY5cACcj3gBrI+iH9yEbz
         vF1sBlK2AFCleLcuPz7MUyp4MQ/K+MVkA8j/KWus=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 186/312] be2net: Dont leak iomapped memory on removal.
Date:   Fri,  8 May 2020 14:32:57 +0200
Message-Id: <20200508123137.559477603@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Miller <dougmill@linux.vnet.ibm.com>

commit a69bf3c5b49ef488970c74e26ba0ec12f08491c2 upstream.

The adapter->pcicfg resource is either mapped via pci_iomap() or
derived from adapter->db. During be_remove() this resource was ignored
and so could remain mapped after remove.

Add a flag to track whether adapter->pcicfg was mapped or not, then
use that flag in be_unmap_pci_bars() to unmap if required.

Fixes: 25848c901 ("use PCI MMIO read instead of config read for errors")

Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/emulex/benet/be.h      |    1 +
 drivers/net/ethernet/emulex/benet/be_main.c |    4 ++++
 2 files changed, 5 insertions(+)

--- a/drivers/net/ethernet/emulex/benet/be.h
+++ b/drivers/net/ethernet/emulex/benet/be.h
@@ -531,6 +531,7 @@ struct be_adapter {
 
 	struct delayed_work be_err_detection_work;
 	u8 err_flags;
+	bool pcicfg_mapped;	/* pcicfg obtained via pci_iomap() */
 	u32 flags;
 	u32 cmd_privileges;
 	/* Ethtool knobs and info */
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -5526,6 +5526,8 @@ static void be_unmap_pci_bars(struct be_
 		pci_iounmap(adapter->pdev, adapter->csr);
 	if (adapter->db)
 		pci_iounmap(adapter->pdev, adapter->db);
+	if (adapter->pcicfg && adapter->pcicfg_mapped)
+		pci_iounmap(adapter->pdev, adapter->pcicfg);
 }
 
 static int db_bar(struct be_adapter *adapter)
@@ -5577,8 +5579,10 @@ static int be_map_pci_bars(struct be_ada
 			if (!addr)
 				goto pci_map_err;
 			adapter->pcicfg = addr;
+			adapter->pcicfg_mapped = true;
 		} else {
 			adapter->pcicfg = adapter->db + SRIOV_VF_PCICFG_OFFSET;
+			adapter->pcicfg_mapped = false;
 		}
 	}
 


