Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1312C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C92208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="yZ/04ioG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733158AbgGaMLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:11:35 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:36287 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733069AbgGaMLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:11:17 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VC8lRR011696;
        Fri, 31 Jul 2020 14:11:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=6k232TKbN5dNjWvgqQw/NJsbYH973zbfMgFlgm/6cZc=;
 b=yZ/04ioG4+TpcjljEmaW7cRvGxqZvTgUvi0Z9D+R9WiLu6GR4dHzrTAjhxo4J9ugD1cO
 d+oLwNxggEqxcu+Nq63yR6+36DIzQ5r5eIH6s7zJTzFwPbA2efNbsIkpBgduJjbI52bv
 VVICfP09SEKGnrPuCi6xXkThtAyleqRiqFtLpq2er32Mdv69PQJ3R9MF/gaaNGIv1FOv
 kwD10Fh9D/QXYHQIKR4vRuKLgRxXPeUdo94gmyHlOPnWNstKuJRk+TE67BV8P1P39y29
 Q1C/woX8m98WBh51aCkn5G9OTEzXpu5prfAnjsnNGdoWlb7PCxI94VmlmjZ0j3TBpeMo Iw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32ga72dcbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:11:10 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 352B410002A;
        Fri, 31 Jul 2020 14:11:10 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 27EA22AE6DD;
        Fri, 31 Jul 2020 14:11:10 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jul 2020 14:11:09
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH 09/13] rpmsg: add override field in channel info
Date:   Fri, 31 Jul 2020 14:10:39 +0200
Message-ID: <20200731121043.24199-10-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731121043.24199-1-arnaud.pouliquen@st.com>
References: <20200731121043.24199-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_04:2020-07-31,2020-07-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The override field is already used in the rpmsg_device.
This allows to force a service name to be associated to
a RPMsg service driver.
Adding this field in the channel info allows to force the channel
creation with a specified RPMsg service driver.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 include/linux/rpmsg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index ef8d1b987d38..4a34a8ea330f 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -52,11 +52,13 @@ struct rpmsg_drv_ctrl_info {
  * @name: name of service
  * @src: local address
  * @dst: destination address
+ * @driver_override: driver name to force a match
  */
 struct rpmsg_channel_info {
 	char name[RPMSG_NAME_SIZE];
 	u32 src;
 	u32 dst;
+	const char *driver_override;
 };
 
 /**
-- 
2.17.1

