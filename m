Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8166BC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503DC24688
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="rpf//dWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgA1WQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:16:34 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:27282 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbgA1WQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 17:16:28 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580249787; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=i+aFwz/XZq1hLfURdhwYcNPvIQ+jYpVpqGRNNihkjB8=; b=rpf//dWaZOcXCJXtNqKfYRzad8IL5IuKtG6mo+Tiu2StbJojwRS1t4yCsKLmar5Is11tighK
 pgE210Ez3ZnHl4a7cxpnuduUH2BjrNl60fUWRTTtO6QYWE8ZFRLSgZIRmulWPn/3v/sn0IdW
 kyxFYiOLRlFZzbWU17Ld6jl+oyg=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e30b2b3.7fa7b9276068-smtp-out-n01;
 Tue, 28 Jan 2020 22:16:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B852EC447A5; Tue, 28 Jan 2020 22:16:18 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B3BD1C433CB;
        Tue, 28 Jan 2020 22:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3BD1C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     iommu@lists.linux-foundation.org
Cc:     robin.murphy@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sharat Masetty <smasetty@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Joerg Roedel <joro@8bytes.org>,
        freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v1 0/6] iommu/arm-smmu: Auxiliary domain and per instance pagetables
Date:   Tue, 28 Jan 2020 15:16:04 -0700
Message-Id: <1580249770-1088-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clients have a requirement to sandbox memory mappings for security and
advanced features like SVM. This series adds support to enable per-instance
pagetables as auxiliary domains in the arm-smmu driver and adds per-instance
support for the Adreno GPU.

This patchset builds on the split pagetable support from [1]. In that series the
TTBR1 address space is programmed for the default ("master") domain and enables
support for auxiliary domains. Each new auxiliary domain will allocate a
pagetable which the leaf driver can program through the usual IOMMU APIs. It can
also query the physical address of the pagetable.

In the SMMU driver the first auxiliary domain will enable and program the TTBR0
space. Subsequent auxiliary domains won't touch the hardware. Similarly when
the last auxiliary domain is detached the TTBR0 region will be disabled again.

In the Adreno driver each new file descriptor instance will create a new
auxiliary domain / pagetable and use it for all the memory allocations of that
instance. The driver will query the base address of each pagetable and switch
them dynamically using the built-in table switch capability of the GPU. If any
of these features fail the driver will automatically fall back to using the
default (global) pagetable.

This patchset had previously been submitted as [2] but has been significantly
modified since then.

Jordan

[1] https://lists.linuxfoundation.org/pipermail/iommu/2020-January/041438.html
[2] https://patchwork.freedesktop.org/series/57441/


Jordan Crouse (6):
  iommu: Add DOMAIN_ATTR_PTBASE
  arm/smmu: Add auxiliary domain support for arm-smmuv2
  drm/msm/adreno: ADd support for IOMMU auxiliary domains
  drm/msm: Add support to create target specific address spaces
  drm/msm/gpu: Add ttbr0 to the memptrs
  drm/msm/a6xx: Support per-instance pagetables

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c |  89 +++++++++++++
 drivers/gpu/drm/msm/msm_drv.c         |  22 +++-
 drivers/gpu/drm/msm/msm_gpu.h         |   2 +
 drivers/gpu/drm/msm/msm_iommu.c       |  72 +++++++++++
 drivers/gpu/drm/msm/msm_mmu.h         |   3 +
 drivers/gpu/drm/msm/msm_ringbuffer.h  |   1 +
 drivers/iommu/arm-smmu.c              | 230 +++++++++++++++++++++++++++++++---
 drivers/iommu/arm-smmu.h              |   3 +
 include/linux/iommu.h                 |   2 +
 9 files changed, 405 insertions(+), 19 deletions(-)

-- 
2.7.4
