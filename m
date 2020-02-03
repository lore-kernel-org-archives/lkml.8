Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AA2C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DD32080C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="YcN4RdPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgBCPHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:07:06 -0500
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:58882 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbgBCPHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1580742426;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=VJnsOBv+HbyyQwVNpnxzDWPoec7REoI1chc1vV9mKGk=;
  b=YcN4RdPme1m4woSo/C0xLjd95G+jOP/bruXmrtVfOCf8TRqL2W1qamyL
   Js7evR2M69mWDpf2OAjLqiTFbMS8kX4rkXJ8S+91NRYGuRBOSVV7iRpFT
   aBi7svoVCOjVqlBcsyUaAOqYP/X82RzPatx6lhHKqriHTlleLyF1NiLR6
   A=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=igor.druzhinin@citrix.com; spf=Pass smtp.mailfrom=igor.druzhinin@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  igor.druzhinin@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="igor.druzhinin@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
  igor.druzhinin@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="igor.druzhinin@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: n3OuRVe8G9eYufmHAZT/P2q6Wa0Z7PfSRehb4qvjsUHNrmDY7kTjv5xRnF+nprqvB4gH049Amu
 8trAFQQCmgcbK/5Ib1odEq2crfCL+oWZO136igJoPR4+WxBZod7RUdE0tweEhCv3hpEq5JJ3q0
 lM0PQ+W3voIT6R378+qVbizA3ZQK1vpZiIzChRAgzMCM6SB+FQdw5japO6k7ZoRbmttWJgi/L7
 EnhslDdgNFtvrDX39N+oOXaxxbj9hPFNMV2PgVzWqiQ2S8iarz6d01XhFHeKwCWlNVQi8n8d/r
 xHk=
X-SBRS: 2.7
X-MesageID: 11848962
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.70,398,1574139600"; 
   d="scan'208";a="11848962"
From:   Igor Druzhinin <igor.druzhinin@citrix.com>
To:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <intel-gfx@lists.freedesktop.org>,
        <intel-gvt-dev@lists.freedesktop.org>
CC:     <zhenyuw@linux.intel.com>, <zhi.a.wang@intel.com>,
        <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
        <rodrigo.vivi@intel.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        "Igor Druzhinin" <igor.druzhinin@citrix.com>
Subject: [PATCH] drm/i915/gvt: more locking for ppgtt mm LRU list
Date:   Mon, 3 Feb 2020 15:07:01 +0000
Message-ID: <1580742421-25194-1-git-send-email-igor.druzhinin@citrix.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the lock was introduced in 72aabfb862e40 ("drm/i915/gvt: Add mutual
lock for ppgtt mm LRU list") one place got lost.

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
---
 drivers/gpu/drm/i915/gvt/gtt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 34cb404..4a48280 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1956,7 +1956,11 @@ void _intel_vgpu_mm_release(struct kref *mm_ref)
 
 	if (mm->type == INTEL_GVT_MM_PPGTT) {
 		list_del(&mm->ppgtt_mm.list);
+
+		mutex_lock(&mm->vgpu->gvt->gtt.ppgtt_mm_lock);
 		list_del(&mm->ppgtt_mm.lru_list);
+		mutex_unlock(&mm->vgpu->gvt->gtt.ppgtt_mm_lock);
+
 		invalidate_ppgtt_mm(mm);
 	} else {
 		vfree(mm->ggtt_mm.virtual_ggtt);
-- 
2.7.4

