Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A15C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E0542074D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="e6yhRWcD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHYQxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:53:21 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41004 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726104AbgHYQwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:52:21 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PGkqni009695;
        Tue, 25 Aug 2020 18:52:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=mRxpgvYHHmYunvL/dN1QJuAEVm0K612wf/w6woNwEks=;
 b=e6yhRWcDdRkm6q9Em2x9JA25JfzH/eJYwLA1cL8oCPOJPvEMiUE3jV94n9vYmuLJhTv7
 HU+/9VYE4PjC9TgyYAjn7Jr8XeU2EAQhvfhwW1BTHGjP4juE6tk23iiiLJE9TPJNRbWI
 oniyPoj7emnFHKN42RNQP6M1DE19XlaTau6MjW2T6Fg/F9gNFZaYayApT1Cy8kW2KgE1
 huxuoEesy2TttOmzOlTgNEHptuvwHMhAOE3RTw4GNEQxxTFX5g5SSaQnSFeqJ15/w6yX
 BLtedrJVxII+Y0VBypSDb4kpnhXigu2f5WWWH6fFd8xGAZuCRkhH868LE3an2npNih2t kA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 332t8fpmnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 18:52:13 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C3A2910002A;
        Tue, 25 Aug 2020 18:52:12 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B52432A5E44;
        Tue, 25 Aug 2020 18:52:12 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug 2020 18:52:12
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH v2 0/8] introduce name service announcement rpmsg driver
Date:   Tue, 25 Aug 2020 18:48:59 +0200
Message-ID: <20200825164907.3642-1-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_06:2020-08-25,2020-08-25 signatures=0
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

Applies cleanly on Bjorn for-next branch (ca69dba7f13a)

Main updates from V1 to V2:
- Integrate Mathieu's comments:
  - rework the rpmsg_create_channel and rpmsg_release_channel error management.
  - merge patch "[9/9] rpmsg: ns: name service announcement endianness"
    in other pathes.

V1: https://patchwork.kernel.org/project/linux-remoteproc/list/?series=327257

Arnaud Pouliquen (8):
  rpmsg: virtio: rename rpmsg_create_channel
  rpmsg: core: add channel creation internal API
  rpmsg: virtio: add rpmsg channel device ops
  rpmsg: define the name service announcement as reserved address
  rpmsg: introduce reserved rpmsg driver for ns announcement
  rpmsg: virtio: use rpmsg ns device for the ns announcement
  rpmsg: ns: add name service announcement service
  rpmsg: virtio: use rpmsg_ns driver to manage ns announcement

 drivers/rpmsg/Kconfig            |   9 ++
 drivers/rpmsg/Makefile           |   1 +
 drivers/rpmsg/rpmsg_core.c       |  45 +++++++
 drivers/rpmsg/rpmsg_internal.h   |  32 +++++
 drivers/rpmsg/rpmsg_ns.c         | 174 +++++++++++++++++++++++++
 drivers/rpmsg/virtio_rpmsg_bus.c | 213 +++++++++----------------------
 include/linux/rpmsg.h            |   9 ++
 7 files changed, 332 insertions(+), 151 deletions(-)
 create mode 100644 drivers/rpmsg/rpmsg_ns.c

-- 
2.17.1

