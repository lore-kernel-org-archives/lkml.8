Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BCCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C3CB208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgE1CHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 22:07:14 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:12624 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725849AbgE1CHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:07:13 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 27 May 2020 19:07:10 -0700
Received: from ubuntu.eng.vmware.com (unknown [10.20.113.240])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 89A35B2720;
        Wed, 27 May 2020 22:07:13 -0400 (EDT)
From:   Ronak Doshi <doshir@vmware.com>
To:     <netdev@vger.kernel.org>
CC:     Ronak Doshi <doshir@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/4] vmxnet3: upgrade to version 4
Date:   Wed, 27 May 2020 19:07:02 -0700
Message-ID: <20200528020707.10036-1-doshir@vmware.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: doshir@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmxnet3 emulation has recently added several new features which includes
offload support for tunnel packets, support for new commands the driver
can issue to emulation, change in descriptor fields, etc. This patch
series extends the vmxnet3 driver to leverage these new features.

Compatibility is maintained using existing vmxnet3 versioning mechanism as
follows:
 - new features added to vmxnet3 emulation are associated with new vmxnet3
   version viz. vmxnet3 version 4.
 - emulation advertises all the versions it supports to the driver.
 - during initialization, vmxnet3 driver picks the highest version number
 supported by both the emulation and the driver and configures emulation
 to run at that version.

In particular, following changes are introduced:

Patch 1:
  This patch introduces utility macros for vmxnet3 version 4 comparison
  and updates Copyright information.

Patch 2:
  This patch implements get_rss_hash_opts and set_rss_hash_opts methods
  to allow querying and configuring different Rx flow hash configurations
  which can be used to support UDP/ESP RSS.

Patch 3:
  This patch introduces segmentation and checksum offload support for
  encapsulated packets. This avoids segmenting and calculating checksum
  for each segment and hence gives performance boost.

Patch 4:
  With all vmxnet3 version 4 changes incorporated in the vmxnet3 driver,
  with this patch, the driver can configure emulation to run at vmxnet3
  version 4.

Ronak Doshi (4):
  vmxnet3: prepare for version 4 changes
  vmxnet3: add support to get/set rx flow hash
  vmxnet3: add geneve and vxlan tunnel offload support
  vmxnet3: update to version 4

 drivers/net/vmxnet3/Makefile          |   2 +-
 drivers/net/vmxnet3/upt1_defs.h       |   5 +-
 drivers/net/vmxnet3/vmxnet3_defs.h    |  31 +++-
 drivers/net/vmxnet3/vmxnet3_drv.c     | 164 ++++++++++++++++++---
 drivers/net/vmxnet3/vmxnet3_ethtool.c | 267 +++++++++++++++++++++++++++++++++-
 drivers/net/vmxnet3/vmxnet3_int.h     |  25 +++-
 6 files changed, 452 insertions(+), 42 deletions(-)

-- 
2.11.0

