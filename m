Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC33BC8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995AD20838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="tylCk9kJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgD3KDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 06:03:08 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:30231 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726378AbgD3KDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 06:03:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588240987; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=k6Jww9+9URymQ1brdiMyrmnMNV87/1Nh4t6HUYL74r0=; b=tylCk9kJMtJNDCz2lsN6dnzIy4r0z9lfsFY8RDBi59g6nRLZtISqX00svQxC0LbkmPnZoL5R
 hBCsIctEyMVYLpMSRb9kbp38PVnBCfCNgW0/+rD3L8WXti2ZZW4eP02qG0zYgBviuJJvaMsi
 x4r1uIRQw8br93iGiLpgY2TsBMs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaaa25a.7f276f31e110-smtp-out-n04;
 Thu, 30 Apr 2020 10:03:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1AF76C4478C; Thu, 30 Apr 2020 10:03:04 +0000 (UTC)
Received: from blr-ubuntu-31.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: svaddagi)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EEBF6C433BA;
        Thu, 30 Apr 2020 10:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EEBF6C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vatsa@codeaurora.org
From:   Srivatsa Vaddagiri <vatsa@codeaurora.org>
To:     konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com,
        jan.kiszka@siemens.com, will@kernel.org,
        stefano.stabellini@xilinx.com
Cc:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org,
        pratikp@codeaurora.org, vatsa@codeaurora.org,
        christoffer.dall@arm.com, alex.bennee@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [RFC/PATCH 0/1] virtio_mmio: hypervisor specific interfaces for MMIO
Date:   Thu, 30 Apr 2020 15:32:55 +0530
Message-Id: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Type-1 hypervisor we are dealing with does not allow for MMIO transport. 
[1] summarizes some of the problems we have in making virtio work on such
hypervisors. This patch proposes a solution for transport problem viz how we can
do config space IO on such a hypervisor. Hypervisor specific methods
introduced allows for seamless IO of config space.

This patch is meant to seek comments. If its considered to be in right
direction, will work on making it more complete and send the next version!

1. https://lkml.org/lkml/2020/4/28/427

Srivatsa Vaddagiri (1):
  virtio: Introduce MMIO ops

 drivers/virtio/virtio_mmio.c | 131 ++++++++++++++++++++++++++-----------------
 include/linux/virtio.h       |  14 +++++
 2 files changed, 94 insertions(+), 51 deletions(-)

-- 
2.7.4

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
