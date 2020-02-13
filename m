Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE764C352A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 01:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82D720714
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 01:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgBMBEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 20:04:35 -0500
Received: from mga18.intel.com ([134.134.136.126]:32614 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729185AbgBMBEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 20:04:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 17:04:33 -0800
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; 
   d="scan'208";a="233956351"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 17:04:33 -0800
Subject: [PATCH v2 2/4] libnvdimm/namespace: Enforce memremap_compat_align()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        vishal.l.verma@intel.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Wed, 12 Feb 2020 16:48:29 -0800
Message-ID: <158155490897.3343782.14216276134794923581.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pmem driver on PowerPC crashes with the following signature when
instantiating misaligned namespaces that map their capacity via
memremap_pages().

    BUG: Unable to handle kernel data access at 0xc001000406000000
    Faulting instruction address: 0xc000000000090790
    NIP [c000000000090790] arch_add_memory+0xc0/0x130
    LR [c000000000090744] arch_add_memory+0x74/0x130
    Call Trace:
     arch_add_memory+0x74/0x130 (unreliable)
     memremap_pages+0x74c/0xa30
     devm_memremap_pages+0x3c/0xa0
     pmem_attach_disk+0x188/0x770
     nvdimm_bus_probe+0xd8/0x470

With the assumption that only memremap_pages() has alignment
constraints, enforce memremap_compat_align() for
pmem_should_map_pages(), nd_pfn, or nd_dax cases.

Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Link: https://lore.kernel.org/r/158041477336.3889308.4581652885008605170.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/namespace_devs.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 032dc61725ff..aff1f32fdb4f 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1739,6 +1739,16 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
 		return ERR_PTR(-ENODEV);
 	}
 
+	if (pmem_should_map_pages(dev) || nd_pfn || nd_dax) {
+		struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
+		resource_size_t start = nsio->res.start;
+
+		if (!IS_ALIGNED(start | size, memremap_compat_align())) {
+			dev_dbg(&ndns->dev, "misaligned, unable to map\n");
+			return ERR_PTR(-EOPNOTSUPP);
+		}
+	}
+
 	if (is_namespace_pmem(&ndns->dev)) {
 		struct nd_namespace_pmem *nspm;
 

