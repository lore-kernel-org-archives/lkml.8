Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607D4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373F0206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="cobgFH5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgIAIde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:33:34 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:30226 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgIAIdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1598949212;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rfRW5+bl+qCIe+HR0i2S+LLMqYFuztw2ljG4SK2rpSY=;
  b=cobgFH5TbY8yIEDxANvKOXAhaYk/nQ8yyGxSUg3bR4PPP/k98ctDl3Ta
   QJMGNI/vR08mUI1hL211ZQYVJZg7Odehl0289OsI8WGTZYl7J33OG9Yfv
   MSr63G44Ezmzmr1M4xEjjZPWn8BLJf3K1L+ULGhUX2QykfPSPPkLDZNqT
   I=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: Gjn7i185+YEUIKot2BoXXzYXkOG4zv/dbnSJSGJh/8iittMRR/+2+79/Z27aJIpb/vwzQTArOv
 R47sk99jf88ZGQSNTRehWVcFN+uWUOlb49/FB4g3FMNsM7GyKquitD9NoFaPIPLg/AP8MEvEWP
 fwkwF/lnnc0p474ESAeUZTBD5RfUqIXZh4Nnkj8y3kFJ/fIcPxgnAI+GoYAxfB3phnT1+OIrdo
 K8fq7RhQ2rbIAmhlPDTRFY4lVXDR3mA3DoCF4fl2PLh4Gsos3aHeb/CSbKe+/G5Eta7CyaYmZY
 xMY=
X-SBRS: 2.7
X-MesageID: 25850300
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.76,378,1592884800"; 
   d="scan'208";a="25850300"
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        <xen-devel@lists.xenproject.org>
Subject: [PATCH v5 0/3] xen/balloon: fixes for memory hotplug
Date:   Tue, 1 Sep 2020 10:33:23 +0200
Message-ID: <20200901083326.21264-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following series contain some fixes in order to split Xen
unpopulated memory handling from the ballooning driver using the
ZONE_DEVICE functionality, so that physical memory regions used to map
foreign pages are not tied to memory hotplug.

Note this is currently only available for x86 due to Arm using an
identity map for dom0 p2m and thus needing special handling.

Thanks, Roger.

Roger Pau Monne (3):
  xen/balloon: add header guard
  memremap: rename MEMORY_DEVICE_DEVDAX to MEMORY_DEVICE_GENERIC
  xen: add helpers to allocate unpopulated memory

 drivers/dax/device.c                    |   2 +-
 drivers/gpu/drm/xen/xen_drm_front_gem.c |   9 +-
 drivers/xen/Kconfig                     |  11 ++
 drivers/xen/Makefile                    |   1 +
 drivers/xen/balloon.c                   |   4 +-
 drivers/xen/grant-table.c               |   4 +-
 drivers/xen/privcmd.c                   |   4 +-
 drivers/xen/unpopulated-alloc.c         | 185 ++++++++++++++++++++++++
 drivers/xen/xenbus/xenbus_client.c      |   6 +-
 drivers/xen/xlate_mmu.c                 |   4 +-
 include/linux/memremap.h                |   9 +-
 include/xen/balloon.h                   |   4 +
 include/xen/xen.h                       |   9 ++
 mm/memremap.c                           |   2 +-
 14 files changed, 232 insertions(+), 22 deletions(-)
 create mode 100644 drivers/xen/unpopulated-alloc.c

-- 
2.28.0

