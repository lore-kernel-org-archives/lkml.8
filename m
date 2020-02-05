Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F1BC352A1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8D221741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoRJst93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgBERRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:17:50 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40196 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgBERRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 12:17:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id z7so1268699pgk.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 09:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=5Epmkols/Jcpk4BOtB6xrYTMWDhv57jhe/5P27cPTsM=;
        b=JoRJst93U9bCZZNxTFkotrbqwe9DANT/aWnQ3KQKK48a4/aTEAOk2JtA2PmYsMkjB+
         iRMfR/50HPQjQA5q/jBlq9+xFgLDJtWXWxbfTNo6cTK/arVA+rhTwMVC7y4n2Ga44rfz
         R3pbxUZNXouDw3CeOZGQTL8UjVLUWMtmm4i4F+a2thsaACE+RVjbT9VSFv6PajGgfIi0
         Z6zIZ4mqYmk50XZr3vNUYUPRQXXZ7areM3Lr32YudlJx0mOwiLIX1AjSu6fZRQrNPQq0
         lxaE0lNku48jmfLyck2tI2N9LC/phWqf/D2XxPndkVWcnCfPp9PfkfRybvKQGeY/UxWK
         k23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=5Epmkols/Jcpk4BOtB6xrYTMWDhv57jhe/5P27cPTsM=;
        b=Yjp/HIlzJU876GE4gatOysnup3BN7pH/4N53JdRKAfmFEdrssoSrTEEiWWN6sh95NQ
         WH/kxvBLfLkIBP5Z8RWHQnHlCiQYeCc/F7GMRtT0gsh23pfcUZyP2zYjnTSurEuUwcxc
         wnql7kDkVd0AoIRpA5gj72E5UVQfH7AaF2aM3D5hZUTZAorxswY97fJqKP0YQgzp6rfE
         WWX6+54i1JGabvjrxmY9dCPZVBbEGBe9PBIq3pJoCD5RNxHhtQegpwvcMSv5QsrpMuNM
         f/SRTYQBIoC2St7qzlYYD8D9ZKJ9YI0evqSaoBOYEUm0y5lpeOG9sNUXObYzxl4SWEwq
         gRlA==
X-Gm-Message-State: APjAAAWUh18I9cU7b5d4ddCOIuOEp/3FWf2Jw3hm2os37gB5ZrNhkofI
        Eu6OND9hxFWPu1So6XbPRSw=
X-Google-Smtp-Source: APXvYqzXVTVChYHqPGJAAnvf91budGML5xKedygkZ/afLbay4FAJDdeS+mI0C3P15GHFFZf171UepQ==
X-Received: by 2002:a63:60a:: with SMTP id 10mr1707960pgg.302.1580923066845;
        Wed, 05 Feb 2020 09:17:46 -0800 (PST)
Received: from emb-wallaby.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id l8sm357945pjy.24.2020.02.05.09.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 09:17:46 -0800 (PST)
From:   Arindam Nath <arindam.nath@amd.com>
To:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 3/4] ntb_perf: pass correct struct device to dma_alloc_coherent
Date:   Wed,  5 Feb 2020 22:46:57 +0530
Message-Id: <aa4e69feffab2fd3cd846569e0546c5cf8f8f6b4.1580921119.git.arindam.nath@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580921119.git.arindam.nath@amd.com>
References: <cover.1580921119.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580921119.git.arindam.nath@amd.com>
References: <cover.1580921119.git.arindam.nath@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

Currently, ntb->dev is passed to dma_alloc_coherent
and dma_free_coherent calls. The returned dma_addr_t
is the CPU physical address. This works fine as long
as IOMMU is disabled. But when IOMMU is enabled, we
need to make sure that IOVA is returned for dma_addr_t.
So the correct way to achieve this is by changing the
first parameter of dma_alloc_coherent() as ntb->pdev->dev
instead.

Fixes: 5648e56 ("NTB: ntb_perf: Add full multi-port NTB API support")
Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 5116655f0211..65501f24b742 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -558,7 +558,7 @@ static void perf_free_inbuf(struct perf_peer *peer)
 		return;
 
 	(void)ntb_mw_clear_trans(peer->perf->ntb, peer->pidx, peer->gidx);
-	dma_free_coherent(&peer->perf->ntb->dev, peer->inbuf_size,
+	dma_free_coherent(&peer->perf->ntb->pdev->dev, peer->inbuf_size,
 			  peer->inbuf, peer->inbuf_xlat);
 	peer->inbuf = NULL;
 }
@@ -587,8 +587,9 @@ static int perf_setup_inbuf(struct perf_peer *peer)
 
 	perf_free_inbuf(peer);
 
-	peer->inbuf = dma_alloc_coherent(&perf->ntb->dev, peer->inbuf_size,
-					 &peer->inbuf_xlat, GFP_KERNEL);
+	peer->inbuf = dma_alloc_coherent(&perf->ntb->pdev->dev,
+					 peer->inbuf_size, &peer->inbuf_xlat,
+					 GFP_KERNEL);
 	if (!peer->inbuf) {
 		dev_err(&perf->ntb->dev, "Failed to alloc inbuf of %pa\n",
 			&peer->inbuf_size);
-- 
2.17.1

