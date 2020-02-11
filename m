Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2089C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB83A20661
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="WOnWH855"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbgBKRml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:42:41 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:34294 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728797AbgBKRmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:42:40 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BHgTGV007804;
        Tue, 11 Feb 2020 18:42:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=RDDGxzn9ujSpMGf3xyClXU8q9LiJT2dp9a7bhWHwHaE=;
 b=WOnWH8557Fafslre+IfU0FrL6wbdVb1sKjSWV37mfbkF9SY2IINGpl5FcdrcLcGNyzHN
 SIaQe+OlGU6/SC96BtMmz75WZVCqG58cuFcNrnCh8CSwAh4ae8UrEzeR4+4oveGp80V4
 SaMQK2g5sEi/1ShRtcwsBjPpas5AzmR9QwPe8alPjQfyztB+2rtPQJnkT76u2yIKoTk2
 /61HchnUFmPsTW9e42jsk+Oq9mKWhUFuRCgvM557mzvjkR9WK57WdHQFxpsyqjTjLhHN
 Dq8I+ZyUOcredGxtC0NkWFQbQvbvLF00qFSbohBBK646ZwRB7n8olJjDeBeEejmapCip Dg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1ufh7phr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Feb 2020 18:42:30 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D1AAB10005C;
        Tue, 11 Feb 2020 18:42:22 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B6E1E2C8E8C;
        Tue, 11 Feb 2020 18:42:22 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 11 Feb 2020 18:42:22
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        <arnaud.pouliquen@st.com>, Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v5 0/3] add support for co-processor loaded and booted before kernel
Date:   Tue, 11 Feb 2020 18:42:02 +0100
Message-ID: <20200211174205.22247-1-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-11_05:2020-02-10,2020-02-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduce the support of a preloaded firmware. In this case
the load of the firmware is skipped. It is platform driver responsibility
to implement the right firmware load ops according to HW specificities.

V4[1] to V5 update:
  - add stm32 platform implementation  

[1]. https://patchwork.kernel.org/patch/11265869/

Arnaud Pouliquen (1):
  dt-bindings: remoteproc: stm32: add syscon bindings preloaded fw
    support

Fabien Dessenne (1):
  remoteproc: stm32: add support for co-processor booted before kernel

Loic Pallardy (1):
  remoteproc: add support for co-processor loaded and booted before
    kernel

 .../bindings/remoteproc/st,stm32-rproc.yaml   |  21 ++
 drivers/remoteproc/remoteproc_core.c          |  67 ++++--
 drivers/remoteproc/stm32_rproc.c              | 205 ++++++++++++++++--
 include/linux/remoteproc.h                    |   2 +
 4 files changed, 267 insertions(+), 28 deletions(-)

-- 
2.17.1

