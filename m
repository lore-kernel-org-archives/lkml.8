Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124A0C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE5DC21775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="uUHsgiAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgG1Gis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:38:48 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36104 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726790AbgG1Gir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:38:47 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06S6SICR018009;
        Tue, 28 Jul 2020 08:38:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=qmwJq+3D0GJBCPkFrePoSga3huVJSD32b8tD9JrjayE=;
 b=uUHsgiAxcAanxVtP5Odl9kdz1oPfAkJWPq2wW1/g/KbENSD2L1SHsBTMmRvUWlzX913R
 t+cY/ypnzs9W1YsQYWOd1KDX/dvTc3B+pdtGhkU+xwmpW+CZrSx6MMbymGbXXtjQbhA+
 rfJuLslFm2PqncFsHlB/pZxvZ4sdjIIjZcV/2jKYGWkZFi4fXtnoEwFCS1UNVPoZRKAL
 t5TikiJbCLp9XzjwDyfE+hDU7xFKGGHB51RxUK6ETf3SNAqLOJa6d7YVNcvySsjjLt8w
 x07wbRpVDV+LvHKggX+JFUGSjzXC1kNTiGuWCPHZ5IrjNl+jZDVe1HOFpDudacnyWGin ew== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32ga71vqg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jul 2020 08:38:33 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C51E610002A;
        Tue, 28 Jul 2020 08:38:32 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B4FFB210F96;
        Tue, 28 Jul 2020 08:38:32 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 28 Jul 2020 08:38:32
 +0200
From:   Alain Volmat <alain.volmat@st.com>
To:     <hugues.fruchet@st.com>, <mchehab@kernel.org>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <yannick.fertre@st.com>, <hans.verkuil@cisco.com>,
        <linux-media@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alain.volmat@st.com>
Subject: [PATCH 0/2] Error handling fixes in stm32-dcmi driver
Date:   Tue, 28 Jul 2020 08:37:56 +0200
Message-ID: <1595918278-9724-1-git-send-email-alain.volmat@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-28_01:2020-07-27,2020-07-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie implements fixes in error path of the stm32-dcmi driver.
As part of it, it also fixes the way video device is handled in
order to ensure that it is only created when the attached sensor
is well initialized. (current implementation leads to having a
video device always created and but never deleted upon removal of
the module if sensor initialization is failing)

Alain Volmat (2):
  media: stm32-dcmi: create video dev within notifier bound
  media: stm32-dcmi: fix probe error path & module remove

 drivers/media/platform/stm32/stm32-dcmi.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

