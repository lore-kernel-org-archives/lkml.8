Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DE3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 20:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B2A2073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 20:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="LnFroqji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgAVURi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 15:17:38 -0500
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:41191 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVURi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 15:17:38 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jan 2020 15:17:38 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1579724258;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=MJa4eYt3crjAenr4CmXGe3xMFCLr5PGiS6d0YsXiFss=;
  b=LnFroqjiqxM8eXxkIKkY+4o7YPw3beto/bqa1OUQ+XKZPnocHa31uKHw
   gEKS18lcjY/oJydfArkgMXGbXkbSKgccIx70x4xR8iRu75pPPZ5dVzGY2
   g6xXKfwGi/yfQWDKCHoY9wdAgAaMdWVeqiD+xce46R20m4Qqm/DCdtFt3
   o=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=igor.druzhinin@citrix.com; spf=Pass smtp.mailfrom=igor.druzhinin@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  igor.druzhinin@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="igor.druzhinin@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
  igor.druzhinin@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="igor.druzhinin@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: TaUqzM78xDduaVYHQYABbgc2RX5soS0fqo+gu6ahOmZnliE9XG165ViAidcFXDPe5C7WJDiskD
 RtlvoRkTnx74PwdcwhiG7h3JByPXH1KF/czSSrWh+X4n6oc0NcpZk5yyGecXTZ3XwqrJchhpjL
 H6GVEjxuTq4Bh4jcTWQ4QTFDAMyb/ayPQg0/cPIfpFNNzSwnYI2AD4V15F2yuENc3hZPrsmGhB
 7E77TP4yCJYzZBVd61hpTV3nRoF3VNgTC9RfWBgdmAVbp8N7t7OwJ0S8FLNDRqdB91jLvOiW3m
 zu8=
X-SBRS: 2.7
X-MesageID: 11306633
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.70,350,1574139600"; 
   d="scan'208";a="11306633"
From:   Igor Druzhinin <igor.druzhinin@citrix.com>
To:     <intel-gvt-dev@lists.freedesktop.org>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <zhenyuw@linux.intel.com>, <zhi.a.wang@intel.com>,
        <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
        <rodrigo.vivi@intel.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        "Igor Druzhinin" <igor.druzhinin@citrix.com>
Subject: [PATCH] drm/i915/gvt: fix high-order allocation failure on late load
Date:   Wed, 22 Jan 2020 20:10:24 +0000
Message-ID: <1579723824-25711-1-git-send-email-igor.druzhinin@citrix.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the module happens to be loaded later at runtime there is a chance
memory is already fragmented enough to fail allocation of firmware
blob storage and consequently GVT init. Since it doesn't seem to be
necessary to have the blob contiguous, use vmalloc() instead to avoid
the issue.

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
---
 drivers/gpu/drm/i915/gvt/firmware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/firmware.c b/drivers/gpu/drm/i915/gvt/firmware.c
index 049775e..b0c1fda 100644
--- a/drivers/gpu/drm/i915/gvt/firmware.c
+++ b/drivers/gpu/drm/i915/gvt/firmware.c
@@ -146,7 +146,7 @@ void intel_gvt_free_firmware(struct intel_gvt *gvt)
 		clean_firmware_sysfs(gvt);
 
 	kfree(gvt->firmware.cfg_space);
-	kfree(gvt->firmware.mmio);
+	vfree(gvt->firmware.mmio);
 }
 
 static int verify_firmware(struct intel_gvt *gvt,
@@ -229,7 +229,7 @@ int intel_gvt_load_firmware(struct intel_gvt *gvt)
 
 	firmware->cfg_space = mem;
 
-	mem = kmalloc(info->mmio_size, GFP_KERNEL);
+	mem = vmalloc(info->mmio_size);
 	if (!mem) {
 		kfree(path);
 		kfree(firmware->cfg_space);
-- 
2.7.4

