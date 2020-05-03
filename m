Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72709C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 20:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F72D206A4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 20:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="S4jyhd/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgECUto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 16:49:44 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:50062 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729034AbgECUtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 16:49:43 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49FdQZ45yfz9vKTB
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 20:49:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q6Lq0ykXCmLy for <linux-kernel@vger.kernel.org>;
        Sun,  3 May 2020 15:49:42 -0500 (CDT)
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49FdQZ2scPz9vKT9
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 15:49:42 -0500 (CDT)
Received: by mail-qk1-f198.google.com with SMTP id k138so16697091qke.15
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 13:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zSYYMjCer/k9tmJ7ZZe4YO3vkQ6QJMlcwBfIN/y6pU4=;
        b=S4jyhd/m97dQjajh3P06TxKvTaD5NanIRG9+JD9GuZVN+HHjK92aLTnnMkH914pr3J
         E6MJi1qP/gWWjsfaKqEkDrLTePribNxLCtgLQE87Iwgg5aCFd0VkEZhjYW+INF0HEYJ5
         FvQf6AccCvuhnHLXSvretDJxSYjoGoREO+iyqbGFL51LcoCySRjgTteR8+fy08cPuncp
         fYNp8G+yqikiMNpn8/KK2gWKysFCslyJf24GhdE1IpxNMTnqcJTnTYUypsQPfVm+5qbI
         y8rGLXqF4+FIJslak9Qq8gxi/Pyv8iqMoLtNcvJP4313bI1YaDGPppuLjK2NhLlvmRB4
         2xDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zSYYMjCer/k9tmJ7ZZe4YO3vkQ6QJMlcwBfIN/y6pU4=;
        b=mJD1W2bLdy/kI7hRyksfv05zZOlWcHT+N5Ptez1G1kvSqIfcWakI6BxwgFBTqL28Hb
         nSwCvC88/jh/QUutYMdHGCRIJvJiel5n9NPUGgwKU3X1lJQBJCEZSIhoGemXsN/OIRM6
         A4BiqL7zIs1p4i5VH2U4uUqiX8inYRaOsAPXqTKEZx5z7mzAdcUCbmBFSkW4um0TbNRF
         zWzz0dlrrBOQByD2B6e7XsCe3luPnDbJJzrJJCb94zxm+LAf+3YdigPK4LfxT48caPnW
         UU7piJh9WAloK5Dd34h0ANZLD9uf97Gny13h727jFI9IAtJMtTBXovaF4tGrUoZM+8gX
         WzTg==
X-Gm-Message-State: AGi0PuYDXksR6oi8b1wWy/WwQGptj3YFhNjs/gZk494XUp3JsU8BOMfb
        UngvlcZX9lCfUBMqpbxKcznbhXRxEFrgn52NcW5FC41MIurmsqSg2hoD2qzr+yzU8QSNBg92ZVv
        W2F+DuTbPbic8spGDW3ilutP83p/g
X-Received: by 2002:a37:4955:: with SMTP id w82mr12151027qka.240.1588538981655;
        Sun, 03 May 2020 13:49:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypL/yRI3pvKwp5EcSRyFRyzRWgGDsy73tBk0Bjk1YTubstQEXIh8JCXYenyVhJAmb49/eivC6w==
X-Received: by 2002:a37:4955:: with SMTP id w82mr12151006qka.240.1588538981093;
        Sun, 03 May 2020 13:49:41 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id a124sm8366919qkf.93.2020.05.03.13.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 13:49:40 -0700 (PDT)
From:   wu000273@umn.edu
To:     kuba@kernel.org
Cc:     davem@davemloft.net, Markus.Elfring@web.de,
        oss-drivers@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH v3] nfp: abm: Fix incomplete release of system resources in nfp_abm_vnic_set_mac()
Date:   Sun,  3 May 2020 15:49:32 -0500
Message-Id: <20200503204932.11167-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In function nfp_abm_vnic_set_mac, pointer nsp is allocated by nfp_nsp_open.
But when nfp_nsp_has_hwinfo_lookup fail, the pointer is not released,
which can lead to a memory leak bug. Thus add a call of the function
“nfp_nsp_close” for the completion of the exception handling.

Fixes: f6e71efdf9fb1 ("nfp: abm: look up MAC addresses via management FW")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/net/ethernet/netronome/nfp/abm/main.c | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/abm/main.c b/drivers/net/ethernet/netronome/nfp/abm/main.c
index 9183b3e85d21..f196789f62fe 100644
--- a/drivers/net/ethernet/netronome/nfp/abm/main.c
+++ b/drivers/net/ethernet/netronome/nfp/abm/main.c
@@ -265,8 +265,7 @@ nfp_abm_vnic_set_mac(struct nfp_pf *pf, struct nfp_abm *abm, struct nfp_net *nn,
 
 	if (id > pf->eth_tbl->count) {
 		nfp_warn(pf->cpp, "No entry for persistent MAC address\n");
-		eth_hw_addr_random(nn->dp.netdev);
-		return;
+		goto generate_random_address;
 	}
 
 	snprintf(hwinfo, sizeof(hwinfo), "eth%u.mac.pf%u",
@@ -276,14 +275,13 @@ nfp_abm_vnic_set_mac(struct nfp_pf *pf, struct nfp_abm *abm, struct nfp_net *nn,
 	if (IS_ERR(nsp)) {
 		nfp_warn(pf->cpp, "Failed to access the NSP for persistent MAC address: %ld\n",
 			 PTR_ERR(nsp));
-		eth_hw_addr_random(nn->dp.netdev);
-		return;
+		goto generate_random_address;
 	}
 
 	if (!nfp_nsp_has_hwinfo_lookup(nsp)) {
 		nfp_warn(pf->cpp, "NSP doesn't support PF MAC generation\n");
-		eth_hw_addr_random(nn->dp.netdev);
-		return;
+		nfp_nsp_close(nsp);
+		goto generate_random_address;
 	}
 
 	err = nfp_nsp_hwinfo_lookup(nsp, hwinfo, sizeof(hwinfo));
@@ -291,8 +289,7 @@ nfp_abm_vnic_set_mac(struct nfp_pf *pf, struct nfp_abm *abm, struct nfp_net *nn,
 	if (err) {
 		nfp_warn(pf->cpp, "Reading persistent MAC address failed: %d\n",
 			 err);
-		eth_hw_addr_random(nn->dp.netdev);
-		return;
+		goto generate_random_address;
 	}
 
 	if (sscanf(hwinfo, "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",
@@ -300,12 +297,16 @@ nfp_abm_vnic_set_mac(struct nfp_pf *pf, struct nfp_abm *abm, struct nfp_net *nn,
 		   &mac_addr[3], &mac_addr[4], &mac_addr[5]) != 6) {
 		nfp_warn(pf->cpp, "Can't parse persistent MAC address (%s)\n",
 			 hwinfo);
-		eth_hw_addr_random(nn->dp.netdev);
-		return;
+		goto generate_random_address;
 	}
 
 	ether_addr_copy(nn->dp.netdev->dev_addr, mac_addr);
 	ether_addr_copy(nn->dp.netdev->perm_addr, mac_addr);
+	return;
+
+generate_random_address:
+	eth_hw_addr_random(nn->dp.netdev);
+	return;
 }
 
 static int
-- 
2.17.1

