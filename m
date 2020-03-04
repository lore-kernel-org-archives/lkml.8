Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0B6C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E89208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387558AbgCDCYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 21:24:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:22869 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387400AbgCDCYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 21:24:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 18:24:19 -0800
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="232467854"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 18:24:19 -0800
Subject: [PATCH v4 2/5] libnvdimm/pfn: Prevent raw mode fallback if
 pfn-infoblock valid
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        vishal.l.verma@intel.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Tue, 03 Mar 2020 18:08:13 -0800
Message-ID: <158328769377.2223916.18385460083366544789.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158328768294.2223916.16551505954326988623.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158328768294.2223916.16551505954326988623.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EOPNOTSUPP return code from the pmem driver indicates that the
namespace has a configuration that may be valid, but the current kernel
does not support it. Expand this to all of the nd_pfn_validate() error
conditions after the infoblock has been verified as self consistent.

This prevents exposing the namespace to I/O when the infoblock needs to
be corrected, or the system needs to be put into a different
configuration (like changing the page size on PowerPC).

Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/pfn_devs.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index a5c25cb87116..79fe02d6f657 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -561,14 +561,14 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 			dev_dbg(&nd_pfn->dev, "align: %lx:%lx mode: %d:%d\n",
 					nd_pfn->align, align, nd_pfn->mode,
 					mode);
-			return -EINVAL;
+			return -EOPNOTSUPP;
 		}
 	}
 
 	if (align > nvdimm_namespace_capacity(ndns)) {
 		dev_err(&nd_pfn->dev, "alignment: %lx exceeds capacity %llx\n",
 				align, nvdimm_namespace_capacity(ndns));
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 
 	/*
@@ -581,7 +581,7 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 	if (offset >= resource_size(&nsio->res)) {
 		dev_err(&nd_pfn->dev, "pfn array size exceeds capacity of %s\n",
 				dev_name(&ndns->dev));
-		return -EBUSY;
+		return -EOPNOTSUPP;
 	}
 
 	if ((align && !IS_ALIGNED(nsio->res.start + offset + start_pad, align))
@@ -589,7 +589,7 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 		dev_err(&nd_pfn->dev,
 				"bad offset: %#llx dax disabled align: %#lx\n",
 				offset, align);
-		return -ENXIO;
+		return -EOPNOTSUPP;
 	}
 
 	return 0;

