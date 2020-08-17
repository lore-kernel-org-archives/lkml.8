Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46259C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2491320772
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597650632;
	bh=pEmZ0bJwP+2jy7JV6MazNJRUpimkMGqSRi6r/UUBXcE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=JFkejQR2eccuF7l9RCDBZar02l5jKzCZxeBjBSGVxZ1pbsmnGBElpsgatiYgadVlA
	 QyXzRPdEVukdCjLx/l+mca6rcdhVfUUK3bz/XMdQRfgYjfME5hcbPbFHBuXNuw5A/v
	 2P7V2XZpB3+seDvqu7gQGaA8PSF8ReCv+5Pnzbv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHQHua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:50:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgHQHuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:50:20 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEB9D207DF;
        Mon, 17 Aug 2020 07:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597650620;
        bh=pEmZ0bJwP+2jy7JV6MazNJRUpimkMGqSRi6r/UUBXcE=;
        h=From:To:Cc:Subject:Date:From;
        b=iO7lGho8i1sBtrmzrfWbT3D8qOHg90bwGxSGDCjffji/8hjWZ805E7LsJ41smtHML
         YmMkrWO10hX92w47Sn53e6i9zgs85tWOyl5ZPn8xPMERnXY1CVRZ5O7ormvcXWfKzg
         txOZJrIUz1gnaQIhcenhYVN+YbW+sDs8Ty9Q1ezI=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZuL-00Bfbr-OZ; Mon, 17 Aug 2020 09:50:17 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org,
        Chenfeng <puck.chen@hisilicon.com>, devel@driverdev.osuosl.org,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/16] IOMMU driver for Kirin 960/970
Date:   Mon, 17 Aug 2020 09:49:59 +0200
Message-Id: <cover.1597650455.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the Kirin 960/970 iommu.

As on the past series, this starts from the original 4.9 driver from
the 96boards tree:

	https://github.com/96boards-hikey/linux/tree/hikey970-v4.9

The remaining patches add SPDX headers and make it build and run with
the upstream Kernel.

Chenfeng (1):
  iommu: add support for HiSilicon Kirin 960/970 iommu

Mauro Carvalho Chehab (15):
  iommu: hisilicon: remove default iommu_map_sg handler
  iommu: hisilicon: map and unmap ops gained new arguments
  iommu: hisi_smmu_lpae: rebase it to work with upstream
  iommu: hisi_smmu: remove linux/hisi/hisi-iommu.h
  iommu: hisilicon: cleanup its code style
  iommu: hisi_smmu_lpae: get rid of IOMMU_SEC and IOMMU_DEVICE
  iommu: get rid of map/unmap tile functions
  iommu: hisi_smmu_lpae: use the right code to get domain-priv data
  iommu: hisi_smmu_lpae: convert it to probe_device
  iommu: add Hisilicon Kirin970 iommu at the building system
  iommu: hisi_smmu_lpae: cleanup printk macros
  iommu: hisi_smmu_lpae: make OF compatible more standard
  dt: add an spec for the Kirin36x0 SMMU
  dt: hi3670-hikey970.dts: load the SMMU driver on Hikey970
  staging: hikey9xx: add an item about the iommu driver

 .../iommu/hisilicon,kirin36x0-smmu.yaml       |  55 ++
 .../boot/dts/hisilicon/hi3670-hikey970.dts    |   3 +
 drivers/staging/hikey9xx/Kconfig              |   9 +
 drivers/staging/hikey9xx/Makefile             |   1 +
 drivers/staging/hikey9xx/TODO                 |   1 +
 drivers/staging/hikey9xx/hisi_smmu.h          | 196 ++++++
 drivers/staging/hikey9xx/hisi_smmu_lpae.c     | 648 ++++++++++++++++++
 7 files changed, 913 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/hisilicon,kirin36x0-smmu.yaml
 create mode 100644 drivers/staging/hikey9xx/hisi_smmu.h
 create mode 100644 drivers/staging/hikey9xx/hisi_smmu_lpae.c

-- 
2.26.2


