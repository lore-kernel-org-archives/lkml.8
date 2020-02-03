Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16EBC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5345720658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZzJZVlY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgBCUkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 15:40:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49350 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726278AbgBCUkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 15:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580762442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pyvOKTyWkhnbfDDvx/t4H+37pFyaHZSbAEznQ9w1oyc=;
        b=TZzJZVlYU0eTggOF8/15pPMtN8SlIXM0ziVGHJ4Fp2/BS0MNaUaQa3RF0OCYrGTA+u1VZr
        rVrVJ649jZOEfrcVc2PDckdFQIZeKCw+R6YR3+3JZg1QfotZghdeAtYiQO9LYFJvyBDzMp
        mRiZiKWNJarJuxw177p8gw4wVF6ckhA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-7l1xuXRFPdWWM4vbT9eVRQ-1; Mon, 03 Feb 2020 15:40:39 -0500
X-MC-Unique: 7l1xuXRFPdWWM4vbT9eVRQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 809C118C8C01;
        Mon,  3 Feb 2020 20:40:38 +0000 (UTC)
Received: from w520.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4853187B1D;
        Mon,  3 Feb 2020 20:40:38 +0000 (UTC)
Date:   Mon, 3 Feb 2020 13:40:37 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: [GIT PULL] VFIO updates for v5.6-rc1
Message-ID: <20200203134037.2fda624f@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit c79f46a282390e0f5b306007bf7b11a46d529538:

  Linux 5.5-rc5 (2020-01-05 14:23:27 -0800)

are available in the Git repository at:

  git://github.com/awilliam/linux-vfio.git tags/vfio-v5.6-rc1

for you to fetch changes up to 7b5372ba04ca1caabed1470d4ec23001cde2eb91:

  vfio: platform: fix __iomem in vfio_platform_amdxgbe.c (2020-01-09 11:32:14 -0700)

----------------------------------------------------------------
VFIO updates for v5.6-rc1

 - Fix nvlink error path (Alexey Kardashevskiy)

 - Update nvlink and spapr to use mmgrab() (Julia Lawall)

 - Update static declaration (Ben Dooks)

 - Annotate __iomem to fix sparse warnings (Ben Dooks)

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      vfio/spapr/nvlink2: Skip unpinning pages on error exit

Ben Dooks (Codethink) (2):
      vfio/mdev: make create attribute static
      vfio: platform: fix __iomem in vfio_platform_amdxgbe.c

Julia Lawall (2):
      vfio: vfio_pci_nvlink2: use mmgrab
      vfio/spapr_tce: use mmgrab

 drivers/vfio/mdev/mdev_sysfs.c                      | 2 +-
 drivers/vfio/pci/vfio_pci_nvlink2.c                 | 8 +++++---
 drivers/vfio/platform/reset/vfio_platform_amdxgbe.c | 4 ++--
 drivers/vfio/vfio_iommu_spapr_tce.c                 | 2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

