Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E55C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260D62078B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="gcFdsKuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440336AbgDPQOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:14:32 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45078 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437742AbgDPQOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:14:12 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GGBvCb014929;
        Thu, 16 Apr 2020 18:14:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=fpquh+jz2px/ZRzQXBXoWxq9ttyvReRZKpxc7YwTUiI=;
 b=gcFdsKuqlBMFmcy8cZcFoc0qbVy5F8tON6KTvihhSjHP5HTX6jLZJntZntpbN5WYP0rA
 01SNTexF5PIENY0JQ9hp5Ft8B3/nPa8G+AgABo4f0QOKJJnxlclsynn8bi7VVyVN2ZaK
 fMsrWizODy8CaqD5BsJVPd7TVAfxoIt7qCc9Ek1cfeqx2gWLF0UVjPrnqDrJQC/71BMw
 EGhKpN6m9CM1xuFORY0J8Ldwvbu4AdLvQuXf3YmnktPE9cx/RzIykRFhev4iY1chMdK/
 N9EwtMc53bSdtpNe6SgPLBeyz1JsGT1Qp5mjpX+2rfp0XfHvtkrqcapiIpNmNVYzYXxD Vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30dn75umc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 18:14:08 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8F2B910002A;
        Thu, 16 Apr 2020 18:14:06 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7A3862B2D2A;
        Thu, 16 Apr 2020 18:14:06 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Apr 2020 18:14:06
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [RFC 00/18] remoteproc: Decorelate virtio from core
Date:   Thu, 16 Apr 2020 18:13:13 +0200
Message-ID: <20200416161331.7606-1-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_06:2020-04-14,2020-04-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series proposes to introduce the notion of platform device for the
rproc virtio management. One obective is to allow virtio to declare is
own memory resources without the usage of dma_declare_coherent_memory
that seems deprecated since the introduction of the device tree.

Proposal:
- the rproc virtio is processed in a separate platform and could be handled
  as a generic platform device.
- Several vdev devices can be declared in DT:
    - which allows to declare their own memory regions and answer to [1].
    - as next steps it would be also possible to:
       - declare their own mailboxes, rpmsg drivers, ...
       - use dma-range to handle the pa<->da translation at virtio level

Several notions are introduced here:
- Virtio platform registration which allows to decorelate virtio from the
  remote proc core device. 
- Synchronization of the child devices relying on component bind/unbind.
  This mechanism ensures the synchronization of the child devices before
  the boot of the remote processor and before the release of the resources
  on the remote processor shutdown.
- Ability to populate child devices declared in rproc device tree node.
- Possibility to declare the memory regions reserved to a virtio devices in
  the devicetree.

Known limitations:
- the patchset has been tested on a st32mP1 plaform only
- it is based on the v5.6 (need to evoluate depending on V5.7 and on going
  patchsets).
- The virtio memory allocation does not take into account memory
  controllers such as IOMMU and MPU.

Arnaud Pouliquen (18):
  remoteproc: Store resource table address in rvdev
  remoteproc: Introduce virtio device add/remove functions in core.
  remoteproc: Move rvdev management in rproc_virtio
  remoteproc: Add rproc_get_by_node helper
  remoteproc: Create platform device for vdev
  remoteproc: Add component in core for child devices synchronization
  remoteproc: Add component bind/unbind for virtio platform
  remoteproc: Externalize carveout functions
  remoteproc: Move vring management from core to virtio
  remoteproc: Add capability to populate rproc subnode devices
  remoteproc: Add child node component in rproc match list
  remoteproc: Support of pre-registered virtio device
  remoteproc: Add memory default allocator helper
  remoteproc: Add pa to da translation API
  remoteproc: associate memory entry to a device
  remoteproc: Parse virtio node for memory region
  remoteproc: stm32: add the pa to da ops.
  ARM: dts: stm32: Declare a virtio device

 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi   |  10 +
 drivers/remoteproc/remoteproc_core.c     | 469 ++++++++++++-----------
 drivers/remoteproc/remoteproc_internal.h |  23 +-
 drivers/remoteproc/remoteproc_virtio.c   | 415 ++++++++++++++++++--
 drivers/remoteproc/stm32_rproc.c         |   1 +
 include/linux/remoteproc.h               |  27 +-
 6 files changed, 673 insertions(+), 272 deletions(-)

-- 
2.17.1

