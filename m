Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C338C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6FE4206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sior-be.20150623.gappssmtp.com header.i=@sior-be.20150623.gappssmtp.com header.b="YprpFTHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgIHKcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729434AbgIHKcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:32:42 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7566DC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 03:32:41 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c8so15458776edv.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 03:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sior-be.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MmrpT2iDfcYtx9VDEEtRqqNAR2mycMe15/tVKCQ8MG8=;
        b=YprpFTHDhaFJkK9f7pzFydwp9te82djacbA8HsrEjou8mk/fBmT1bvs+JV2SJeabVS
         tJUfWRGJIb9jdBS1fdy8gYELiWbTNweOBSy0jE+Xwch3YplVvSsVrHAmW3t59+0uVLp8
         7kIdyod3dn/JF1NTJAellP5qa7EpRyNbAll8NAI6vPYX7Da/yM7sNS+4kJT+jS1OWs7a
         c0tYZrgODcyLtPZeGFrlumXWiOazks2s8p7cEOfRdq1UXLlzrcX5fqapCxstZjK8LctE
         pMX7jwwl175NCouTZJ7U4ZGsCvHwEkv6rgZA33DY8vvrFAaV7rLkBH6Z+XXkxuENlnVj
         T8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MmrpT2iDfcYtx9VDEEtRqqNAR2mycMe15/tVKCQ8MG8=;
        b=HoFSv72VZfB8jzX/ecKznI30fPV+0WygKiGFl46DC+S9A6Q1Te7pkN4ai9IrQbuJMN
         fCsqKb1B306sCJyXbQAaibDQViXh7OlmHQOjnlv65989ZdugraXMV4L0d9tqtFo0kdmP
         ri6xG86kmsa4+0emYWeCeucdAsE2jUyKOX4uz5pS4451qPppwjt/TROX5C/pFhonKUCP
         3a3pXf1ixNIx7qa+4TPZreopPy1gJTg5DHdSZ3rfablwj04DFjK1el0yFNfUDmvv5Opj
         r5UV+iQA7SBAmOWw80HyAAJpbjBu0yfruRQo1CDqBWbHE3AOIkKl+IbuUgrgHZxa1Qt6
         +1RA==
X-Gm-Message-State: AOAM530khVdWdkOR7QpvHpfmSyvLKieNronMDxjBOe6aboYmb/bSWRw8
        G/l7DaJaAqxr+p6dMG1pimDTgg==
X-Google-Smtp-Source: ABdhPJy1342pFfoFTIRUwWKdwb/ygHnwZo9GAVPV1Q2EnNid3WdNBcuTVxSomezSuPgbneDfModeZQ==
X-Received: by 2002:a50:aa94:: with SMTP id q20mr25548359edc.119.1599561160112;
        Tue, 08 Sep 2020 03:32:40 -0700 (PDT)
Received: from aws.localdomain ([94.107.139.190])
        by smtp.gmail.com with ESMTPSA id j10sm17302091ejf.116.2020.09.08.03.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 03:32:39 -0700 (PDT)
From:   Alejandro Sior <aho@sior.be>
Cc:     Alejandro Sior <aho@sior.be>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fixed NULL pointer dereference in handle_edid functions for GPUs that do not support EDID
Date:   Tue,  8 Sep 2020 12:32:25 +0200
Message-Id: <20200908103226.27616-1-aho@sior.be>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function intel_vgpu_reg_rw_edid of gvt/kvmgt.c, pos can get equal to NULL for GPUs that do not
properly support EDID. In those cases, when pos gets passed to the handle_edid functions, it
gets added a short offset then it's dereferenced in memcpy's, leading to a kernel
oops: null pointer dereference.

More concretely, that kernel oops renders Broadwell GPUs users
completely unable to set up virtual machines with virtual GPU passthrough (virtual machines
hang indefinitely when trying to make use of the virtual GPU), and make
them have huge problems when trying to remove the virtual GPUs once the
kernel oops has happened (writing 1 in the vGPU remove file just makes
the operation hang undefinitely, again, and the kernel is unable to shutdown
since the vGPU removing hangs indefinitely). More information on the
issues that this causes are described in details in this github issue post: https://github.com/intel/gvt-linux/issues/170#issuecomment-685806160

This patch solves this problem by checking is pos is equal to NULL, and
if it is, it sets ret to a nagative value, making the module simply indicate that the access to EDID region has failed, without any fatal repercussion.

When this patch is applied, Broadwell GPU users do not suffer from that
kernel oops anymore, and thus do not encounter any of
the described problems and get able to set up virtual machines
with GPU passthrough without problems.
Users of GPUs with proper EDID support, are of course, still able to
benefit from the EDID features.

Signed-off-by: Alejandro W. Sior <aho@sior.be>

---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index ad8a9df49f29..49163363ba4a 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -557,7 +557,9 @@ static size_t intel_vgpu_reg_rw_edid(struct intel_vgpu *vgpu, char *buf,
 		(struct vfio_edid_region *)kvmgt_vdev(vgpu)->region[i].data;
 	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
 
-	if (pos < region->vfio_edid_regs.edid_offset) {
+	if (pos == NULL) {
+		ret = -EINVAL;
+	} else if (pos < region->vfio_edid_regs.edid_offset) {
 		ret = handle_edid_regs(vgpu, region, buf, count, pos, iswrite);
 	} else {
 		pos -= EDID_BLOB_OFFSET;
-- 
2.28.0

