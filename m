Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BA6C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADEE620836
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgHAByp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 21:54:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:54462 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgHAByp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 21:54:45 -0400
IronPort-SDR: MDpn8FcBlzeOSpnnMQpbzhfEe4Y4VVF+6zWDpamX8mSxmhzRQpzMLNCaNaX7BdWP4N/eyLZ59w
 9wFXWhBQ9znA==
X-IronPort-AV: E=McAfee;i="6000,8403,9699"; a="131959841"
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800"; 
   d="scan'208";a="131959841"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 18:54:44 -0700
IronPort-SDR: Tl5QQepecrA3auUMETKGZRd3DePmMCT48Exe5Rrc2ZUX0CUQ7Yt48pWQOyb224ITJeZGB3OiQY
 rRv+gilspRhQ==
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800"; 
   d="scan'208";a="331340904"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 18:54:44 -0700
Subject: [PATCH] ACPI: NFIT: Fix ARS zero-sized allocation
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Fri, 31 Jul 2020 18:38:26 -0700
Message-ID: <159624590643.3037264.14157533719042907758.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pending commit in -next "devres: handle zero size in devm_kmalloc()"
triggers a boot regression due to the ARS implementation expecting NULL
from a zero-sized allocation. Avoid the zero-sized allocation by
skipping ARS, otherwise crashes with the following signature when
de-referencing ZERO_SIZE_PTR.

     BUG: kernel NULL pointer dereference, address: 0000000000000018
     #PF: supervisor read access in kernel mode
     #PF: error_code(0x0000) - not-present page
     RIP: 0010:__acpi_nfit_scrub+0x28a/0x350 [nfit]
     [..]
     Call Trace:
       ? acpi_nfit_query_poison+0x6a/0x180 [nfit]
       acpi_nfit_scrub+0x36/0xb0 [nfit]
       process_one_work+0x23c/0x580
       worker_thread+0x50/0x3b0

Otherwise the implementation correctly aborts when NULL is returned from
devm_kzalloc() in ars_status_alloc().

Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index fb775b967c52..26dd208a0d63 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3334,7 +3334,7 @@ static void acpi_nfit_init_ars(struct acpi_nfit_desc *acpi_desc,
 static int acpi_nfit_register_regions(struct acpi_nfit_desc *acpi_desc)
 {
 	struct nfit_spa *nfit_spa;
-	int rc;
+	int rc, do_sched_ars = 0;
 
 	set_bit(ARS_VALID, &acpi_desc->scrub_flags);
 	list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
@@ -3346,7 +3346,7 @@ static int acpi_nfit_register_regions(struct acpi_nfit_desc *acpi_desc)
 		}
 	}
 
-	list_for_each_entry(nfit_spa, &acpi_desc->spas, list)
+	list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
 		switch (nfit_spa_type(nfit_spa->spa)) {
 		case NFIT_SPA_VOLATILE:
 		case NFIT_SPA_PM:
@@ -3354,6 +3354,13 @@ static int acpi_nfit_register_regions(struct acpi_nfit_desc *acpi_desc)
 			rc = ars_register(acpi_desc, nfit_spa);
 			if (rc)
 				return rc;
+
+			/*
+			 * Kick off background ARS if at least one
+			 * region successfully registered ARS
+			 */
+			if (!test_bit(ARS_FAILED, &nfit_spa->ars_state))
+				do_sched_ars++;
 			break;
 		case NFIT_SPA_BDW:
 			/* nothing to register */
@@ -3372,8 +3379,10 @@ static int acpi_nfit_register_regions(struct acpi_nfit_desc *acpi_desc)
 			/* don't register unknown regions */
 			break;
 		}
+	}
 
-	sched_ars(acpi_desc);
+	if (do_sched_ars)
+		sched_ars(acpi_desc);
 	return 0;
 }
 

