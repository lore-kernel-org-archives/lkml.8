Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722FAC2BA17
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C0C2082F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="sCxEbPsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390694AbgDCL3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 07:29:36 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:42676 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgDCL3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 07:29:35 -0400
Received: by mail-lj1-f178.google.com with SMTP id q19so6512128ljp.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 04:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UDV67uaM0olVe42g3gcRUTFOTLKxm8Yf483YPZ3Dud8=;
        b=sCxEbPsBTakoE1xknw2RtO2rz8oxNAb6cCS8SzCviLU+wXJ5m+DFbQMKB/W7GcAtYQ
         D/0LK1slWaUCNicIxwMSPPcXyy0SuopgawhAqBDv8LGru/h2Rz//tPVcOCiAX0SeMfie
         Rtmac2n0Qy8TbXeXOE4KNNFMQCPwok9lSTX2O0YBd41GsuzvfaBW+oKM/+RQaey1e1CJ
         F7HBir5eC9AV6iJ3nDVZiaM9M6YOksUJ7CwPnmOYtDbgDLtLnz60hL49JSVAixZuYBQv
         zN9NlOYVLhwtvCwlZiirwMvkOanRxXL2qLV3wkgtzXR8972SVxScB7hqZL3eWlOC48Ye
         rPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDV67uaM0olVe42g3gcRUTFOTLKxm8Yf483YPZ3Dud8=;
        b=mnxP2P+/YvjPdXFRfDsGn7tFfdtAMQUQwE/2p4tBXsEGJTesjSf9HCN3TC9cOYvdK9
         et3FaS0g1v6T8rSCoxrvMBxWgj07nAzkwsPdKmJ75ZyqgAspBsg7HI0DE8/hnAkkPFdy
         OrVRm37vQkyEr3twy9pc1t/k6bpF41/4nup6esj9PH1VInfijhd03gvx5IZJSMOBrkne
         y3L3TpbSDa5nmp3F6y27rRpwplwfComrmYLFVK711r7hfcunhH3KseH6OB2NfNTEuIZY
         spVnIx1jxHu8voNpErn/QZ/9pPexoVw3/AF/nrlRCDZoVsz/HgVVYBcQyWXs8MgRej0e
         oVXA==
X-Gm-Message-State: AGi0PuYIdTG2Mb0PN6Ek/cibk9vUtLYvnJLH+2Cne2oc/WrAY901pdlZ
        pz2yiVoQ+7p1NarUwAuGv/Bxug==
X-Google-Smtp-Source: APiQypKJovl0REGHDL9yO1HGUDFWiM4HR9jobJ/t8s9UpGtLW4jkkAHDaE6pZx5lnJh/RuFHjMKwQA==
X-Received: by 2002:a2e:3203:: with SMTP id y3mr4372576ljy.54.1585913373250;
        Fri, 03 Apr 2020 04:29:33 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g5sm4839412ljl.106.2020.04.03.04.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 04:29:32 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 720FE101331; Fri,  3 Apr 2020 14:29:31 +0300 (+03)
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 3/8] khugepaged: Drain all LRU caches before scanning pages
Date:   Fri,  3 Apr 2020 14:29:23 +0300
Message-Id: <20200403112928.19742-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a page in LRU add cache offsets page refcount and gives
false-negative on PageLRU(). It reduces collapse success rate.

Drain all LRU add caches before scanning. It happens relatively
rare and should not disturb the system too much.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/khugepaged.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 14d7afc90786..fdc10ffde1ca 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2065,6 +2065,8 @@ static void khugepaged_do_scan(void)
 
 	barrier(); /* write khugepaged_pages_to_scan to local stack */
 
+	lru_add_drain_all();
+
 	while (progress < pages) {
 		if (!khugepaged_prealloc_page(&hpage, &wait))
 			break;
-- 
2.26.0

