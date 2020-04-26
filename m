Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC0BC55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 11:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B460206CD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 11:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgDZLql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 07:46:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:11883 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgDZLql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 07:46:41 -0400
IronPort-SDR: emfsV1nJO5DXxl5YdCDYCl2S5jvETiQ7opsZgRrKPj+0SrVef6la0wRMgSRETWCSLjMT0ejSII
 cS6WyVpwRgxw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2020 04:46:40 -0700
IronPort-SDR: VNEDvZCaD87Y9n22c6z2qwAYujkX3KIqTeXjGQVjkzV1/G8fZTjwvJHny8kJaAPzL3eh2DTyVN
 yK7K0QwDy+FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,320,1583222400"; 
   d="scan'208";a="275155029"
Received: from unknown (HELO localhost.localdomain.bj.intel.com) ([10.240.193.79])
  by orsmga002.jf.intel.com with ESMTP; 26 Apr 2020 04:46:37 -0700
From:   Zhu Lingshan <lingshan.zhu@intel.com>
To:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        jasowang@redhat.com
Cc:     lulu@redhat.com, dan.daly@intel.com, cunming.liang@intel.com,
        Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH V4 0/3] vdpa: Support config interrupt in vhost_vdpa
Date:   Sun, 26 Apr 2020 19:43:23 +0800
Message-Id: <1587901406-27400-1-git-send-email-lingshan.zhu@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes two patches, one introduced
config interrupt support in VDPA core, the other
one implemented config interrupt in IFCVF.

changes from V3:
move changes in driver/vhost/vhost.c to a 
separated patch.

changes from V2:
move VHOST_FILE_UNBIND to the uapi header.

changes from V1:
vdpa: more efficient code to handle eventfd unbind.
ifcvf: add VIRTIO_NET_F_STATUS feature bit.

Zhu Lingshan (3):
  vdpa: Support config interrupt in vhost_vdpa
  vhost: replace -1 with  VHOST_FILE_UNBIND in iotcls
  vdpa: implement config interrupt in IFCVF

 drivers/vdpa/ifcvf/ifcvf_base.c |  3 +++
 drivers/vdpa/ifcvf/ifcvf_base.h |  3 +++
 drivers/vdpa/ifcvf/ifcvf_main.c | 22 ++++++++++++++++++-
 drivers/vhost/vdpa.c            | 47 +++++++++++++++++++++++++++++++++++++++++
 drivers/vhost/vhost.c           |  8 +++----
 include/uapi/linux/vhost.h      |  4 ++++
 6 files changed, 82 insertions(+), 5 deletions(-)

-- 
1.8.3.1

