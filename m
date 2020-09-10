Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A07DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7DE72075B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599747721;
	bh=NuAQLLVniMTiSvD3NX63hR8Ps+um5HbA+yYGRbERCBs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Ztp/CcoIMvMNv/mcHU3GzBSM2SmnHv08FD7JXz9BqTzlJ1aZ2h1Xvohj3FoNgVkuG
	 b3LiL1mWvKHEFqyPq8fsg6poaY7sG7VT4EPBC7u9+848T2E0ZEIuGLIxL+fnbgSjQV
	 itewryprQCbQY/N26XhcBWKEhhaY07Vi7DQYovJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbgIJOVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 10:21:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731116AbgIJOKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:10:31 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53784206BE;
        Thu, 10 Sep 2020 14:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599746451;
        bh=NuAQLLVniMTiSvD3NX63hR8Ps+um5HbA+yYGRbERCBs=;
        h=From:To:Cc:Subject:Date:From;
        b=yEH2terUPqcySCZBBnx0Y3G3VIqdcs4YJwkjozcORo2pbdBF+K5w1y21JQDosuyP/
         QrQN4hg/IYGip/gdhoH/ctYL6c2c9p4nXXbZ94MEaczBUdlrXwsCHHN80KDpU8jeyN
         dH4Ubyx3F5KI623tIiGNT0mJ0TLEe3G3NxjZmASs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Lijun Ou <oulijun@huawei.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next 00/10] Prepare drivers to move QP allocation to ib_core
Date:   Thu, 10 Sep 2020 17:00:36 +0300
Message-Id: <20200910140046.1306341-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

This series mainly changes mlx4, mlx5, and mthca drivers to future
change of QP allocation scheme.

The rdmavt driver will be sent separately.

Thanks

Leon Romanovsky (10):
  RDMA/mlx5: Embed GSI QP into general mlx5_ib QP
  RDMA/mlx5: Reuse existing fields in parent QP storage object
  RDMA/mlx5: Change GSI QP to have same creation flow like other QPs
  RDMA/mlx5: Delete not needed GSI QP signature QP type
  RDMA/mlx4: Embed GSI QP into general mlx4_ib QP
  RDMA/mlx4: Prepare QP allocation to remove from the driver
  RDMA/core: Align write and ioctl checks of QP types
  RDMA/drivers: Remove udata check from special QP
  RDMA/mthca: Combine special QP struct with mthca QP
  RDMA/i40iw: Remove intermediate pointer that points to the same struct

 drivers/infiniband/core/uverbs_cmd.c         |  17 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c      |  57 ++--
 drivers/infiniband/hw/i40iw/i40iw_verbs.c    |   9 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.h    |   1 -
 drivers/infiniband/hw/mlx4/mlx4_ib.h         |  25 +-
 drivers/infiniband/hw/mlx4/qp.c              | 285 ++++++++-----------
 drivers/infiniband/hw/mlx5/gsi.c             | 138 +++------
 drivers/infiniband/hw/mlx5/main.c            |   6 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h         |  28 +-
 drivers/infiniband/hw/mlx5/qp.c              |  50 ++--
 drivers/infiniband/hw/mthca/mthca_dev.h      |   2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c |  17 +-
 drivers/infiniband/hw/mthca/mthca_provider.h |  27 +-
 drivers/infiniband/hw/mthca/mthca_qp.c       |  75 +++--
 drivers/infiniband/hw/qedr/verbs.c           |   8 -
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c |   3 +-
 16 files changed, 329 insertions(+), 419 deletions(-)

--
2.26.2

