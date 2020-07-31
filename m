Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2241C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 11:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFAE32087C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 11:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ogyDXSxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732782AbgGaLrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 07:47:46 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34120 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732244AbgGaLrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 07:47:45 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VBaYq8031435;
        Fri, 31 Jul 2020 13:47:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=XwUX+1Y6zwoUw9ojrP+epdZ01TEQ51665ZcqVjIVZrc=;
 b=ogyDXSxTFP1b3/TpTPcCGcLRYHp0qjgIOz1A7a/SC17vZnFt4Z2G8syXylcJHcxxRvFi
 NYBpzI3rccMbIcg6fsSwCV4Ykh85EJGmXqpE5VqV0EWJKmfNvS1O5MMEb+0GOz+i0vuR
 DK2Yxl3eGAkGpe0eL15Bfd9973+Isji7pH6XUzi2MqQtPG9CB8frDdwYZ2fBBh3Z6ccZ
 5TvG+ranqChxarlpZjLq5FKv08raB6+IS43x8Qpx0x7aXz5NqUfAZGgbb1b5CZSDBhhF
 F1P1atq8zXuOXN1B4kTIf+pumUZj2pjrvN5l74ubiiA38udmhjxDNz/HjE+lCv8KdUFe 4Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32gbmgp665-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 13:47:40 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2AC9B10002A;
        Fri, 31 Jul 2020 13:47:40 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1AF47221061;
        Fri, 31 Jul 2020 13:47:40 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jul 2020 13:47:39
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH 0/9] introduce name service announcement rpmsg driver
Date:   Fri, 31 Jul 2020 13:47:23 +0200
Message-ID: <20200731114732.12815-1-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_04:2020-07-31,2020-07-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NS announcement is implemented by several backends, but could be
considered as part the RPMsg protocol. 
In this case it should be managed as a reserved rpmsg service and so
implemented on top of the rpmsg protocol.

This series introduces the rpmsg_ns driver that handles the name service
announcement. The virtio backend is updated in consequence to use this
service.

Applies cleanly on Bjorn rpmsg-next branch (ddd1930d6e3e)

Arnaud Pouliquen (9):
  rpmsg: virtio: rename rpmsg_create_channel
  rpmsg: core: add channel creation internal API
  rpmsg: virtio: add rpmsg channel device ops
  rpmsg: define the name service announcement as reserved address
  rpmsg: introduce reserved rpmsg driver for ns announcement
  rpmsg: virtio: use rpmsg ns device for the ns announcement
  rpmsg: ns: add name service announcement service
  rpmsg: virtio: use rpmsg_ns driver to manage ns announcement
  rpmsg: ns: name service announcement endianness

 drivers/rpmsg/Kconfig            |   9 ++
 drivers/rpmsg/Makefile           |   1 +
 drivers/rpmsg/rpmsg_core.c       |  37 ++++++
 drivers/rpmsg/rpmsg_internal.h   |  32 +++++
 drivers/rpmsg/rpmsg_ns.c         | 175 +++++++++++++++++++++++++
 drivers/rpmsg/virtio_rpmsg_bus.c | 213 +++++++++----------------------
 include/linux/rpmsg.h            |   9 ++
 7 files changed, 325 insertions(+), 151 deletions(-)
 create mode 100644 drivers/rpmsg/rpmsg_ns.c

-- 
2.17.1

