Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80648C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BB42073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KFh3bUVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCEWlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:41:20 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52232 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgCEWlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:41:20 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 025MfEWG110314;
        Thu, 5 Mar 2020 16:41:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583448074;
        bh=KDMH0YFU9Mx31kpchhyUnkDoDR5x283mB093t2Sod8o=;
        h=From:To:CC:Subject:Date;
        b=KFh3bUVOqdZG7qKNtpU2rtvAAL8f+hwfsrusUIb6AISUzF7Z9GteAZ1isFJ8e637e
         Aq22hcnPqm95X95FFJ+L06+DUEfoVjhp6W2VgdTlr02aH/7x2ivPELLN5pJ+BaZmiZ
         1+uKQfWJNIQZZH2WN44LMtmfM0L7zQhnH6orW/04=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 025MfEFk115081;
        Thu, 5 Mar 2020 16:41:14 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 5 Mar
 2020 16:41:14 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 5 Mar 2020 16:41:14 -0600
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 025MfENq077913;
        Thu, 5 Mar 2020 16:41:14 -0600
Received: from localhost (irmo.dhcp.ti.com [128.247.81.254])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 025MfEo2098943;
        Thu, 5 Mar 2020 16:41:14 -0600
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Tero Kristo <t-kristo@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/2] Misc. rproc fixes around fixed memory region support
Date:   Thu, 5 Mar 2020 16:41:06 -0600
Message-ID: <20200305224108.21351-1-s-anna@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn, Loic,

The following are two different fixes for the same commit 086d08725d34
("remoteproc: create vdev subdevice with specific dma memory pool") added
in 5.1 kernel. This has deviated from the core logic prior to the fixed
memory region support.

Patch 1 fixes an issue for some TI remoteproc drivers which always used
the same CMA pool for allocating vrings, vring buffers and carveouts. It
assigns the same pool (if there exists one) for the separated out
vdev device if there are no specific vdev memory regions, and is a
no-op otherwise.

Patch 2 restores the parenting hierarchy for rpmsg devices so that the
rproc handle can be retrieved by rpmsg drivers using the rproc_get_by_child()
API. 

Following is an example of how the rpmsg-client-sample devices looked on
our Davinci platforms:
1. On 4.19 kernel:
root@omapl138-lcdk# ls -l /sys/bus/rpmsg/devices/
lrwxrwxrwx    1 root     root             0 Nov 17 02:03 virtio0.rpmsg-client-sample.-1.50 -> ../../../devices/platform/11800000.dsp/remoteproc/remoteproc0/virtio0/virtio0.rpmsg-client-sample.-1.50
lrwxrwxrwx    1 root     root             0 Nov 17 02:03 virtio0.rpmsg-client-sample.-1.51 -> ../../../devices/platform/11800000.dsp/remoteproc/remoteproc0/virtio0/virtio0.rpmsg-client-sample.-1.51

2. After the commit 086d08725d34:
root@omapl138-lcdk# ls -l /sys/bus/rpmsg/devices/
lrwxrwxrwx    1 root     root             0 Nov 17 02:05 virtio0.rpmsg-client-sample.-1.50 -> ../../../devices/platform/11800000.dsp/11800000.dsp#vdev0buffer/virtio0/virtio0.rpmsg-client-sample.-1.50
lrwxrwxrwx    1 root     root             0 Nov 17 02:05 virtio0.rpmsg-client-sample.-1.51 -> ../../../devices/platform/11800000.dsp/11800000.dsp#vdev0buffer/virtio0/virtio0.rpmsg-client-sample.-1.51

3. With Patch 2:
root@omapl138-lcdk:/rpmsg/2020lts# ls -l /sys/bus/rpmsg/devices/
lrwxrwxrwx    1 root     root             0 Nov 17 02:00 virtio0.rpmsg-client-sample.-1.50 -> ../../../devices/platform/11800000.dsp/remoteproc/remoteproc0/remoteproc0#vdev0buffer/virtio0/virtio0.rpmsg-client-sample.-1.50
lrwxrwxrwx    1 root     root             0 Nov 17 02:00 virtio0.rpmsg-client-sample.-1.51 -> ../../../devices/platform/11800000.dsp/remoteproc/remoteproc0/remoteproc0#vdev0buffer/virtio0/virtio0.rpmsg-client-sample.-1.51

regards
Suman

Suman Anna (1):
  remoteproc: Fix and restore the parenting hierarchy for vdev

Tero Kristo (1):
  remoteproc: fall back to using parent memory pool if no dedicated
    available

 drivers/remoteproc/remoteproc_core.c   |  2 +-
 drivers/remoteproc/remoteproc_virtio.c | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.23.0

