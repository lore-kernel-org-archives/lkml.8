Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49166C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180CE20814
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xR5FMYiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbgFHQ3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:29:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32976 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbgFHQ3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:29:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058G8YAa145658;
        Mon, 8 Jun 2020 16:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=04Il17JgmO/yFBoVWabXMI9zWbJmJBkARiQl8/paJGA=;
 b=xR5FMYiQJIN6zTJejYqSu2UZBMXU7pU1+JKan9x178k/67WykfcQIm9DqbetVnFlSmnn
 0bcd8/dbPizTQ6pZ1ew2Rg8XBhiOalcAnAMBodckSk+1CeVRBikrdQeHhhr7BCmgB6Zn
 sZu7satUxRvKDd++ksn4pZ4o6wGURvkMbhteCTDunYl7AInZGGy0jKaya3fe/c98n/CE
 ZYaS2k4u8N0VVsOxr2EoSExocsMNH5tcYWRnr+/5LYPZZx6PAuv3fUVmM5EsqqcPc1UP
 eOjpt460/X2Of1vwTK8hZHwxB/J55yGSCKjfjdp+8CWEk2/HGc3lbiR8YbQXbchFSBBu kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31g3smqqnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 16:29:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058GEYMh114574;
        Mon, 8 Jun 2020 16:29:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31gmwq5yjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 16:29:02 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 058GSxih024264;
        Mon, 8 Jun 2020 16:29:00 GMT
Received: from localhost.localdomain (/10.211.9.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jun 2020 09:28:59 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, hch@lst.de, sagi@grimberg.me,
        chaitanya.kulkarni@wdc.com, kbusch@kernel.org, axboe@fb.com
Subject: [PATCH 1/2] nvmet-loop: remove unused 'target_ctrl' in nvme_loop_ctrl
Date:   Mon,  8 Jun 2020 09:20:01 -0700
Message-Id: <20200608162002.17017-2-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608162002.17017-1-dongli.zhang@oracle.com>
References: <20200608162002.17017-1-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=1
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This field is never used since the introduction of nvme loopback by
commit 3a85a5de29ea ("nvme-loop: add a NVMe loopback host driver").

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/nvme/target/loop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 0d54e730cbf2..e8fa70c15143 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -36,7 +36,6 @@ struct nvme_loop_ctrl {
 	struct nvme_loop_iod	async_event_iod;
 	struct nvme_ctrl	ctrl;
 
-	struct nvmet_ctrl	*target_ctrl;
 	struct nvmet_port	*port;
 };
 
-- 
2.17.1

