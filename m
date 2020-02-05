Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D866EC352A1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA63E217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="upPG+0IT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgBEPzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:55:36 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:50317 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgBEPze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:55:34 -0500
Received: by mail-pj1-f65.google.com with SMTP id r67so1155049pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=g1IIx60amrgjfE57qozlHgEQ8/enUuSyOSjIAvt32+w=;
        b=upPG+0ITd2XZHOIr73HlK9LZRj2czAjtnUxJ1HrzBL9cZCq/P/H2b4EmSq6iR2/6YH
         nA1nLitujYZ1IljDqRYJniwUyYAML9tF6fu9S+7vie3MuNCr0FtpactAAHl1vRy+anFi
         f91D/tkK8NBe33ZClBDXNXX/1MyxvB+ZvqNFbrRfmknWiEi84r2H4R7PRpN8uaCL/4Ah
         EpyBDoNLwePdwKq0LHNBE21qDn/GY7iF7PcPkyzGMIal2O8pDR1m8KD2p7oh/pKRowPO
         86/Dl4UhotNZqw3jm/q+e3mAHO7zt3I5nDXVgqexQv8zdE1bDzFy/9o1QenrKNKkjygy
         nxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=g1IIx60amrgjfE57qozlHgEQ8/enUuSyOSjIAvt32+w=;
        b=lftJJAHoL3pKAsMpl94/p1RL/RRp86jnJPjsDGA9LJ5uqFVBE7ANsF5Hgw8jba9x0I
         7SIZX/x1bQ657rcbWlLl9NmfSBMJ/qB48WAmRi6YWC18brAvrJ8hgugqA6d/lyaa5XHr
         XwZQaqEror4qS+yzF9rQ3A9krEomhAfjksIzYgHV9znbndUCaH4wL1YlqAIQ448zIjaQ
         YIT5Wxz7JKAY6a7DERZMordO+1J1ZosXzd14XeVngl8RIwq+NaeSHlKHkXcFzGVA3HBe
         cBuqvii23NKX0Ouc3JD2w8cyW+R0zK2Y2qow2eJ6z/fAwY44JK9Src+v6x8sa6zu82F4
         khgw==
X-Gm-Message-State: APjAAAXPPDSQezYkJfC9oEgYuqztK5fvFt1bNv1HqlXI6v8xf1baC42n
        AxIn0jj86/C6MTYB5MLAL0w=
X-Google-Smtp-Source: APXvYqzYNMNDJuaQ21iEMdiY++REnS7abORLIZMqrNaTbe+qDiaC8RcLrDnyCUo6QBzM28V2/UiETg==
X-Received: by 2002:a17:90a:d804:: with SMTP id a4mr6272089pjv.11.1580918133166;
        Wed, 05 Feb 2020 07:55:33 -0800 (PST)
Received: from emb-wallaby.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id z10sm195678pgz.88.2020.02.05.07.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 07:55:32 -0800 (PST)
From:   Arindam Nath <arindam.nath@amd.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Jiasen Lin <linjiasen@hygon.cn>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 15/15] NTB: add pci shutdown handler for AMD NTB
Date:   Wed,  5 Feb 2020 21:24:32 +0530
Message-Id: <6c943711a14cd79bd6f3b392787f09da2cfb3711.1580914232.git.arindam.nath@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCI shutdown handler is invoked in response
to system reboot or shutdown. A data transfer
might still be in flight when this happens. So
the very first action we take here is to send
a link down notification, so that any pending
data transfer is terminated. Rest of the actions
are same as that of PCI remove handler.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index c6cea0005553..9e310e1ad4d0 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1296,6 +1296,22 @@ static void amd_ntb_pci_remove(struct pci_dev *pdev)
 	kfree(ndev);
 }
 
+static void amd_ntb_pci_shutdown(struct pci_dev *pdev)
+{
+	struct amd_ntb_dev *ndev = pci_get_drvdata(pdev);
+
+	/* Send link down notification */
+	ntb_link_event(&ndev->ntb);
+
+	amd_deinit_side_info(ndev);
+	ntb_peer_db_set(&ndev->ntb, BIT_ULL(ndev->db_last_bit));
+	ntb_unregister_device(&ndev->ntb);
+	ndev_deinit_debugfs(ndev);
+	amd_deinit_dev(ndev);
+	amd_ntb_deinit_pci(ndev);
+	kfree(ndev);
+}
+
 static const struct file_operations amd_ntb_debugfs_info = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
@@ -1326,6 +1342,7 @@ static struct pci_driver amd_ntb_pci_driver = {
 	.id_table	= amd_ntb_pci_tbl,
 	.probe		= amd_ntb_pci_probe,
 	.remove		= amd_ntb_pci_remove,
+	.shutdown	= amd_ntb_pci_shutdown,
 };
 
 static int __init amd_ntb_pci_driver_init(void)
-- 
2.17.1

