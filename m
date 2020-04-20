Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D42C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D323B20722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUkNkLAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgDTNUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726049AbgDTNUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:20:07 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3CBC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:20:07 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x25so11003751wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kskdakcrRDDo91fKKn7OmT1ABdfxtHTqlHARV8i00xs=;
        b=aUkNkLAKtinYXOavLQJR4mxUih+wv7V9IIV5NCBglcrY2wRxfDYBx0oBY6UoEzaY1Z
         hWMx7UkJYRTqvGRUf9lsw5g/ubgsCVxTBkf1hCbl34ojscJs9LpOkazrxXwHwU7ik/HY
         GWfF8DuKreVT8/viaIGGkvEvoKu5s2yDarFWFW/vjCXNCzQ6gmBxOreUKkKeGK+8k5fx
         vgMyY2V9mje8RTJtMxQq/qbZrstI+AQA/hhG3xxfhnyO8dyzCxIGoR70O7FIMSYhRQYX
         WTPioZNGzmlfpgGRwJX2uMe13cobITxAoNpc34eFSxArzhWpp4YrmcdhnmY/VymONzVa
         Lu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kskdakcrRDDo91fKKn7OmT1ABdfxtHTqlHARV8i00xs=;
        b=s+pPfiNt4q6/ShXLKF9QM4/wt/I+Z/ZuaBC418qVH1hVsN1hFYQnAudRMyl3cjKjv/
         jmq1JyorVMYc5+4AEXKSVgScAHlvHKOhv5NrCHYCw8UqZKzm85K4KmB3c8hEIQ1JcULg
         KdzPqTzqLP2C8HytdPo2P1tZwlD7ioiszP4n2moqJRRRZWqMb9irgW1k2HoLGQ/LlSty
         0Y6BwV3GhSKyvB2S0SvTYnhW8YaUE2LqxIpqYuFDs9i/VPleJO0c5SP0me/HQb1OMn3q
         1A1zazDPekqXl/tVQLAIoR4bM6rD/p+5gjntnYXJYOCHwB/c0OeFgIZfJKgDPu8IAsz1
         uqPQ==
X-Gm-Message-State: AGi0Puaoj3+RrNsJPXDEq0C0xdOCAuxtUrnWqxC6/VVjcjX/sDv9QTaU
        WcIuI6b9eBNNOzZKzFj+Fdli8DGB
X-Google-Smtp-Source: APiQypK3K2b4fWenwyn8NZmGOaFzl5N6U9bT3lDViuWJnAwH7TScEy7QYI5qYpT7x6FJe48OXAjEXw==
X-Received: by 2002:a1c:2457:: with SMTP id k84mr15813838wmk.96.1587388805686;
        Mon, 20 Apr 2020 06:20:05 -0700 (PDT)
Received: from PC192-168-2-103.speedport.ip (p5B05E57B.dip0.t-ipconnect.de. [91.5.229.123])
        by smtp.gmail.com with ESMTPSA id z76sm1545815wmc.9.2020.04.20.06.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 06:20:05 -0700 (PDT)
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, david@redhat.com, mst@redhat.com,
        jmoyer@redhat.com, pankaj.gupta@cloud.ionos.com,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [RFC 1/2] pmem: make nvdimm_flush asynchronous
Date:   Mon, 20 Apr 2020 15:19:46 +0200
Message-Id: <20200420131947.41991-2-pankaj.gupta.linux@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200420131947.41991-1-pankaj.gupta.linux@gmail.com>
References: <20200420131947.41991-1-pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 This patch converts nvdimm_flush to return when 
 asynchronous flush is in process.

Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
---
 drivers/nvdimm/pmem.c        | 15 ++++++++-------
 drivers/nvdimm/region_devs.c |  3 +--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 4ffc6f7ca131..747ffaee513b 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -192,8 +192,10 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
 	struct pmem_device *pmem = q->queuedata;
 	struct nd_region *nd_region = to_region(pmem);
 
-	if (bio->bi_opf & REQ_PREFLUSH)
-		ret = nvdimm_flush(nd_region, bio);
+	if ((bio->bi_opf & REQ_PREFLUSH) &&
+		nvdimm_flush(nd_region, bio)) {
+		return BLK_QC_T_NONE;
+	}
 
 	do_acct = nd_iostat_start(bio, &start);
 	bio_for_each_segment(bvec, bio, iter) {
@@ -207,11 +209,10 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
 	if (do_acct)
 		nd_iostat_end(bio, start);
 
-	if (bio->bi_opf & REQ_FUA)
-		ret = nvdimm_flush(nd_region, bio);
-
-	if (ret)
-		bio->bi_status = errno_to_blk_status(ret);
+	if (bio->bi_opf & REQ_FUA) {
+		nvdimm_flush(nd_region, bio);
+		return BLK_QC_T_NONE;
+	}
 
 	bio_endio(bio);
 	return BLK_QC_T_NONE;
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index a19e535830d9..1caa13f1523f 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1091,8 +1091,7 @@ int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
 	if (!nd_region->flush)
 		rc = generic_nvdimm_flush(nd_region);
 	else {
-		if (nd_region->flush(nd_region, bio))
-			rc = -EIO;
+		rc = nd_region->flush(nd_region, bio);
 	}
 
 	return rc;
-- 
2.20.1

