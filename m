Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AA2C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 09:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 303C72073E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 09:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HWfhjFwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgHHJez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 05:34:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60538 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgHHJez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 05:34:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0789Iwqm072107;
        Sat, 8 Aug 2020 09:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=aequKrZ1KJ/UX89lx0SVGQ55fnja0qVj925mD877PtE=;
 b=HWfhjFwZ+icFpDeQLMRFN1v5i9hnwVRzAkGQ0PWNkowGn7Ku6oHA5h9M2kcE5txMRA5u
 VMhZiTKchQh3eEdWig95IYtpOIeWIXdf17LvNnW/ovahgS13jt9yM+Pt6Di5tSnn88qu
 aCkMLCOSMry2R1PDi4WXQEKBJoZ3xXKzz916r9ZONtuoVTqUDAozZUtcQVJF7uu2QYa/
 vUGCK/JOI0zmoyGsJ0PaByRPS+7qXixOwTIowqxpzWm7dOhkPk+e5/355pop4RjkTNj6
 7HM4hV80lFg5UTPcXDHZ2yKkIeACCCg0mma3FQCTPqIdnEah8JJ8+1/yzVb+gBQRIkN8 BA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 32sm0m8p2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 08 Aug 2020 09:34:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0789J7lv068917;
        Sat, 8 Aug 2020 09:32:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 32skv0gqjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Aug 2020 09:32:48 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0789WmoT013985;
        Sat, 8 Aug 2020 09:32:48 GMT
Received: from mwanda (/10.175.188.11)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 08 Aug 2020 02:32:47 -0700
Date:   Sat, 8 Aug 2020 12:32:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <eli@mellanox.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] vdpa/mlx5: Fix pointer math in mlx5_vdpa_get_config()
Message-ID: <20200808093241.GB115053@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9706 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008080067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9706 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008080067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a pointer math bug here so if "offset" is non-zero then this
will copy memory from beyond the end of the array.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 3ec44a4f0e45..9d1637cf772e 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1758,7 +1758,7 @@ static void mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 
 	if (offset + len < sizeof(struct virtio_net_config))
-		memcpy(buf, &ndev->config + offset, len);
+		memcpy(buf, (u8 *)&ndev->config + offset, len);
 }
 
 static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset, const void *buf,
-- 
2.27.0

