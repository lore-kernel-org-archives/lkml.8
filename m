Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA76C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 22:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A1AA20787
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 22:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="PKTnIp3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgEBWnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 18:43:12 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:48662 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbgEBWnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 18:43:11 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49F3zy4Bwbz9vBqp
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 22:43:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O2EwmzTDkIMd for <linux-kernel@vger.kernel.org>;
        Sat,  2 May 2020 17:43:10 -0500 (CDT)
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49F3zy36JXz9vFJ3
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 17:43:10 -0500 (CDT)
Received: by mail-qt1-f200.google.com with SMTP id q57so15946228qte.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 15:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KR1J6K/N/jgMtmPG7Tj5KjyDT0kXwPVMrBemGwfcPxM=;
        b=PKTnIp3Pp+s6IVQhP198ve09phFiYcts74X67JMi3qpMhxginR5r/ZHjyWetLSWgpn
         GRLkmBXBageZfi/3I4BiDAnqAxm2oKXTfqKpypSPfPhy3oDEXEqIa57TfDvHoSUqZFyF
         TdSEMr68j6SydX9Ct12JCG3rXxClXGMeK4oAKmbIJbAKCRm1nes812WBiLwaDTB98JDg
         fdlvPZsF7Ke1PZC+6JH/oOBkWi56+Bn3nOQqcw/Ko3emhpsKRMFhud9upozve7BbgCGo
         triXpGg7S7Q8WXp072G5ZHOjkiYvh0r5ALUPQwh9zifi8wWXcNKJm4rwLmxPHra6StJx
         nTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KR1J6K/N/jgMtmPG7Tj5KjyDT0kXwPVMrBemGwfcPxM=;
        b=DyR+dBr2kvdfCQgmYd8Z7aqYh2U4t7U1EJyZKdJAjxwtYLED8D68iAssVQLAaOVIcs
         7M95ABN0W4Z+rgFwQdCaeYdMJaUbjveEOGVrZ2TpfFJelyLdrVO4z8sYS9PY5C20NY3i
         hst5kceviX4B+8Kw0slQU/HFwt3CNr1udHG4MtzVXhV7Bm0snLAxSWKDXSzZUjZizomP
         WRIt36/kqATCO2uAsLcz2Q8TQJa9llK6wnnc6lDlsngJechusk+wOAuEyEuMC3FG8IFI
         NxSlvekJiLjAstJKxu9aJ56okwQTLGq0+r43ehYuN79HikqkxvOQl//aJQRRcu70MtFr
         63WQ==
X-Gm-Message-State: AGi0PubYiYQCGHAoZwKLdi5J5zJZqZ0aIXtARXfVYQJ2J5b2YkhfqY/d
        Z7mmN3quhCmCmJmGjSIfG6WjHwkS2g79/D/aDeKFpEF3s+Hk8MXyysOOupjeKV8jL7I58o6wrQF
        ZeKkLqWy01nxLwTeMVvAvlI8jZ7TV
X-Received: by 2002:ac8:39a7:: with SMTP id v36mr10349295qte.387.1588459389749;
        Sat, 02 May 2020 15:43:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypJVoXz32Eihyqk5u9MNYq2tHVXWisKM8exVuCyk24JqmZEeXkVmiFsvZFVPDfijC7XmCArdfw==
X-Received: by 2002:ac8:39a7:: with SMTP id v36mr10349272qte.387.1588459389296;
        Sat, 02 May 2020 15:43:09 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id u24sm5896172qkk.84.2020.05.02.15.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 15:43:08 -0700 (PDT)
From:   wu000273@umn.edu
To:     kuba@kernel.org
Cc:     davem@davemloft.net, oss-drivers@netronome.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kjlu@umn.edu,
        wu000273@umn.edu
Subject: [PATCH] nfp: abm: fix a memory leak bug
Date:   Sat,  2 May 2020 17:42:59 -0500
Message-Id: <20200502224259.1477-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In function nfp_abm_vnic_set_mac, pointer nsp is allocated by nfp_nsp_open.
But when nfp_nsp_has_hwinfo_lookup fail, the pointer is not released,
which can lead to a memory leak bug. Fix this issue by adding
nfp_nsp_close(nsp) in the error path.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/net/ethernet/netronome/nfp/abm/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/netronome/nfp/abm/main.c b/drivers/net/ethernet/netronome/nfp/abm/main.c
index 9183b3e85d21..354efffac0f9 100644
--- a/drivers/net/ethernet/netronome/nfp/abm/main.c
+++ b/drivers/net/ethernet/netronome/nfp/abm/main.c
@@ -283,6 +283,7 @@ nfp_abm_vnic_set_mac(struct nfp_pf *pf, struct nfp_abm *abm, struct nfp_net *nn,
 	if (!nfp_nsp_has_hwinfo_lookup(nsp)) {
 		nfp_warn(pf->cpp, "NSP doesn't support PF MAC generation\n");
 		eth_hw_addr_random(nn->dp.netdev);
+		nfp_nsp_close(nsp);
 		return;
 	}
 
-- 
2.17.1

