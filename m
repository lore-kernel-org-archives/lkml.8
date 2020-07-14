Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57147C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B38A22225
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgGNHEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:04:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:50389 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbgGNHEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:04:31 -0400
IronPort-SDR: ich8xV8hFnmzCz3xenXCt5Gwp+Pu22XqcldrFpG6x50tDs0YTP3pCyVSc5MvlINldsLKGEd0I+
 MNn2n1F8J6TA==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="146304368"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="146304368"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 00:04:30 -0700
IronPort-SDR: OlctpnIJwdlGQxS+Bsa4EvBdFZhgaMgi6E93HtogmUqsYd+MIKqgpv8ZX2Fg+6KeQMAbeYu29A
 wm1rPhIk0yOg==
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="459583558"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 00:04:29 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 15/15] [dax|pmem]: Enable stray write protection
Date:   Tue, 14 Jul 2020 00:02:20 -0700
Message-Id: <20200714070220.3500839-16-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714070220.3500839-1-ira.weiny@intel.com>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Protecting against stray writes is particularly important for PMEM
because, unlike writes to anonymous memory, writes to PMEM persists
across a reboot.  Thus data corruption could result in permanent loss of
data.  Therefore, there is no option presented to the user.

Enable stray write protection by setting the flag in pgmap which
requests it.  Note if Zone Device Access Protection not be supported
this flag will have no affect.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/dax/device.c  | 2 ++
 drivers/nvdimm/pmem.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 4c0af2eb7e19..884f66d73d32 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -430,6 +430,8 @@ int dev_dax_probe(struct device *dev)
 	}
 
 	dev_dax->pgmap.type = MEMORY_DEVICE_DEVDAX;
+	dev_dax->pgmap.flags |= PGMAP_PROT_ENABLED;
+
 	addr = devm_memremap_pages(dev, &dev_dax->pgmap);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 46c11a09b813..9416a660eede 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -427,6 +427,8 @@ static int pmem_attach_disk(struct device *dev,
 		return -EBUSY;
 	}
 
+	pmem->pgmap.flags |= PGMAP_PROT_ENABLED;
+
 	q = blk_alloc_queue(pmem_make_request, dev_to_node(dev));
 	if (!q)
 		return -ENOMEM;
-- 
2.25.1

