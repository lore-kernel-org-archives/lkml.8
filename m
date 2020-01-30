Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D02C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB8B2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgA3UWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:22:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:20854 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbgA3UWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:22:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 12:22:16 -0800
X-IronPort-AV: E=Sophos;i="5.70,382,1574150400"; 
   d="scan'208";a="222908329"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 12:22:16 -0800
Subject: [PATCH 3/5] libnvdimm/namespace: Enforce memremap_compat_align()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jeff Moyer <jmoyer@redhat.com>, vishal.l.verma@intel.com,
        hch@lst.de, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Thu, 30 Jan 2020 12:06:13 -0800
Message-ID: <158041477336.3889308.4581652885008605170.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158041475480.3889308.655103391935006598.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158041475480.3889308.655103391935006598.stgit@dwillia2-desk3.amr.corp.intel.com>
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
 

