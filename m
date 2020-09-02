Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E69C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 059CC207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJf++ii9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgIBS1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:27:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726124AbgIBS1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599071262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=r9emBHr/2qzqbe1N7/F0ClffTYkORuHlwLsykNV5pTY=;
        b=bJf++ii9AU6vnfaTxEKJJlKjlqmLZKZO74yWx5BAY5KojbF6zvELGudUx3DQGMlMlA/259
        BKCWPjZXQk2+ssz0l6gCUoi/0009fpsyt8IXSaXFS4kGRze26HNwzgcTdbdhGvDLAWceHS
        LLhinUd8jrr1SIrvPqVPNYVdd1Zp0uY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-oeNJSwhgNZe7MfD_K5HBiQ-1; Wed, 02 Sep 2020 14:27:40 -0400
X-MC-Unique: oeNJSwhgNZe7MfD_K5HBiQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D03D51DE02;
        Wed,  2 Sep 2020 18:27:38 +0000 (UTC)
Received: from trippy.localdomain (ovpn-114-249.rdu2.redhat.com [10.10.114.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2527D5C221;
        Wed,  2 Sep 2020 18:27:38 +0000 (UTC)
From:   Mark Salter <msalter@redhat.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     Khuong Dinh <khuong@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/perf: xgene_pmu: Fix uninitialized resource struct
Date:   Wed,  2 Sep 2020 14:27:29 -0400
Message-Id: <20200902182729.27415-1-msalter@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This splat was reported on newer Fedora kernels booting on certain
X-gene based machines:

 xgene-pmu APMC0D83:00: X-Gene PMU version 3
 Unable to handle kernel read from unreadable memory at virtual \
 address 0000000000004006
 ...
 Call trace:
  string+0x50/0x100
  vsnprintf+0x160/0x750
  devm_kvasprintf+0x5c/0xb4
  devm_kasprintf+0x54/0x60
  __devm_ioremap_resource+0xdc/0x1a0
  devm_ioremap_resource+0x14/0x20
  acpi_get_pmu_hw_inf.isra.0+0x84/0x15c
  acpi_pmu_dev_add+0xbc/0x21c
  acpi_ns_walk_namespace+0x16c/0x1e4
  acpi_walk_namespace+0xb4/0xfc
  xgene_pmu_probe_pmu_dev+0x7c/0xe0
  xgene_pmu_probe.part.0+0x2c0/0x310
  xgene_pmu_probe+0x54/0x64
  platform_drv_probe+0x60/0xb4
  really_probe+0xe8/0x4a0
  driver_probe_device+0xe4/0x100
  device_driver_attach+0xcc/0xd4
  __driver_attach+0xb0/0x17c
  bus_for_each_dev+0x6c/0xb0
  driver_attach+0x30/0x40
  bus_add_driver+0x154/0x250
  driver_register+0x84/0x140
  __platform_driver_register+0x54/0x60
  xgene_pmu_driver_init+0x28/0x34
  do_one_initcall+0x40/0x204
  do_initcalls+0x104/0x144
  kernel_init_freeable+0x198/0x210
  kernel_init+0x20/0x12c
  ret_from_fork+0x10/0x18
 Code: 91000400 110004e1 eb08009f 540000c0 (38646846)
 ---[ end trace f08c10566496a703 ]---

This was due to use of an uninitialized local resource struct in the xgene
pmu driver. A pointer to that struct gets to __devm_ioremap_resource()
where the name field is passed to devm_kasprintf() and dereferenced. The
struct was never initialized, so the name pointer is whatever happened to
be underlying it on the stack. This has been the case since the original
checkin of xgene_pmu.c, but there was a recent change to use the name field
in __devm_ioremap_resource() which revealed the problem.

Fixes: 832c927d119b ("perf: xgene: Add APM X-Gene SoC Performance Monitoring Unit driver")
Signed-off-by: Mark Salter <msalter@redhat.com>
---
 drivers/perf/xgene_pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index edac28cd25dd..fdbbd0804b92 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1483,6 +1483,7 @@ xgene_pmu_dev_ctx *acpi_get_pmu_hw_inf(struct xgene_pmu *xgene_pmu,
 		return NULL;
 
 	INIT_LIST_HEAD(&resource_list);
+	memset(&res, 0, sizeof(res));
 	rc = acpi_dev_get_resources(adev, &resource_list,
 				    acpi_pmu_dev_add_resource, &res);
 	acpi_dev_free_resource_list(&resource_list);
-- 
2.26.2

