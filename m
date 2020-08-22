Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1C5C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D3D207CD
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R53OrZZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgHVE3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 00:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgHVE2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:28:36 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E17C061575
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 21:28:36 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t11so1792157plr.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 21:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dtHtIWl6J8kIFWKXyZWws3NaZY5n+Lcb3UuZs+GuLv4=;
        b=R53OrZZWGDIlIq1se/YzOjwMVMXn4r1O33D1gHWELFMDJddknNzoTdyoDOZjJxRSC+
         0BA8PkFUN5wcjq4ZPW5+yV9S8gKYo17gG6reRRjvQ+HdSiL+Fe/hRBEMvq+AYQqzch91
         RABhbEfIDTyk7Bl0wqiPe1T1elJOPCYEyrq8dIhksxYbFMj54FFIFs1+/EfoUXZ3LfQ3
         birdcw54W2pRGqRm7F5VKjAfUxvS58PKB7NuWisieG/zBgiqlFHOri9AMan2sSUFs0oL
         Pq/VUxGQxAWQxKtVlHaFrONvuBcCPxZ/3pkXFse6GnPCcTuwJLVop4SWI1qibS4eth2B
         eXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dtHtIWl6J8kIFWKXyZWws3NaZY5n+Lcb3UuZs+GuLv4=;
        b=M6VlEgJS2ZQ3QawI3+VCpS0tWqdxAyE83vzW4TO/9xO9E5+jByXzLBrFerRmztFqIw
         mJtvgthug2fwkO8lq5L8ZhUlBsUl8W2ZgvT+4ZyFPslnaT0+es1JJ10u0qViIRAn9jMl
         3KzuE6HI/Pj6ZgwTI7O2UeO+2vTCGrMU11oQXQLh75WIbs1eAXXwdP0AMrz6N+YDIYwU
         K4FmtSesk0QeIlNnDiptxUbVo7pU1OB0iC2IJJzEM7Nwa4O870R+6WtR3mOTOWCMz5Ju
         p0c7eBpfT7nI6ysSVcgywrrWr8t3PdD6DFoZUua/H4PPYk2pfUWOiKbWDkNvdzJh+NTW
         tHLA==
X-Gm-Message-State: AOAM531tKDJeATPFs3csaNcaeGPZM+8+DpiIXlnIRo/kdbPXfI0vgMtY
        1YnDOjHl8PNvWLLaHE/+WPo=
X-Google-Smtp-Source: ABdhPJw20iJdex84y+BAqAEu6iBpS8k4sg6GOf+cwWHA6VnqRrDPHBAvJkMquof+YQNxHnXJtXlhmA==
X-Received: by 2002:a17:90b:4397:: with SMTP id in23mr4651060pjb.102.1598070515318;
        Fri, 21 Aug 2020 21:28:35 -0700 (PDT)
Received: from jacob-builder.jf.intel.com ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id q5sm3341582pgi.31.2020.08.21.21.28.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 21:28:34 -0700 (PDT)
From:   Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>, Wu Hao <hao.wu@intel.com>
Subject: [PATCH v2 9/9] iommu/vt-d: Store guest PASID during bind
Date:   Fri, 21 Aug 2020 21:35:18 -0700
Message-Id: <1598070918-21321-10-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOASID core maintains the guest-host mapping in the form of SPID and
IOASID. This patch assigns the guest PASID (if valid) as SPID while
binding guest page table with a host PASID. This mapping will be used
for lookup and notifications.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index d8a5efa75095..4c958b1aec4c 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -406,6 +406,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 		if (data->flags & IOMMU_SVA_GPASID_VAL) {
 			svm->gpasid = data->gpasid;
 			svm->flags |= SVM_FLAG_GUEST_PASID;
+			ioasid_attach_spid(data->hpasid, data->gpasid);
 		}
 		svm->iommu = iommu;
 		/*
@@ -517,6 +518,7 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 				ioasid_attach_data(pasid, NULL);
 				ioasid_notify(pasid, IOASID_UNBIND,
 					IOASID_NOTIFY_SET);
+				ioasid_attach_spid(pasid, INVALID_IOASID);
 				kfree(svm);
 			}
 		}
-- 
2.7.4

