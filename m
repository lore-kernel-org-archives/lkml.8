Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2D8C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A31E21655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Dsw8paQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgCKKyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 06:54:47 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:10334 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726672AbgCKKyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:54:46 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BAmMbb020941;
        Wed, 11 Mar 2020 11:54:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=IRy9D1FvBh85Csvv50LbM9UmBLsJ3nQIep1ZPwcvyA8=;
 b=Dsw8paQVdyzyhy2T/qHckOtV4F3Z/xzih8eEbFA1r9Q7FLbDwxZjEdoArBaC941D2x9z
 JrB5ZNy0OcLlO2pqYYs1mIhJZBhhMHG3kRUz/0kCXuW3OP+vH/2XY9ANFmr4P4L8y+HZ
 4m3bDTgx/Gt9ZpLxUUfPe8Dkyx6+AjsTY2igl+xqHTfJdPT5GrPPcV7Xo7hWIezZ8FfI
 PVYD+c5cYTBFW/pavaIoAok9k561BxZJL4UEf4JP1Ns4wgeeA4ILu2U8JdVDLClzlzKX
 l9hOthXrRGOrVqF/pMd7pcnQbiLSRES/+qQvJk4z2i3tt4BDiixjDJzGY98KDVWsM7VQ Mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ym1mh29p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Mar 2020 11:54:42 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B103D10003A;
        Wed, 11 Mar 2020 11:54:37 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9F74D2A543D;
        Wed, 11 Mar 2020 11:54:37 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG7NODE2.st.com (10.75.127.20)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Mar 2020 11:54:37
 +0100
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <fabien.dessenne@st.com>, <s-anna@ti.com>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [RFC 0/2] Allow client to recover crashed processor
Date:   Wed, 11 Mar 2020 11:54:30 +0100
Message-ID: <1583924072-20648-1-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_04:2020-03-11,2020-03-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following 2 patches propose some changes to allow user space
client to shutdown and restart a crashed co-processor.
This is required when auto recovery is disabled at framework level or
when auto recovery procedure failed.

Sent as RFC as may be part of Mathieu's proposal for early boot/late
attach support

Loic Pallardy (2):
  remoteproc: sysfs: authorize rproc shutdown when rproc is crashed
  remoteproc: core: keep rproc in crash state in case of recovery
    failure

 drivers/remoteproc/remoteproc_core.c  | 8 +++++++-
 drivers/remoteproc/remoteproc_sysfs.c | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.7.4

