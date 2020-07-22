Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2F7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64F1F2065F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lIqA+wb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbgGVNMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:12:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54632 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgGVNMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:12:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06MD2V2x060390;
        Wed, 22 Jul 2020 13:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=H6OI4tcr8wow3U56AqfGZEMBDcuV/mhh8Eb/HpVwG9w=;
 b=lIqA+wb/oZm7K8Uet3pMXINcRcTqRNJaFFeiIcZ2eiKqDXQVr7tVV2WGVlYWFWpi3Lke
 TQ1dhTK4VKhDJr882taVrTXDhEkMQ7fJxROclXQDvAs1is5pB4/Lob0HFEPs0Vp2wEUe
 Mz3dnIHbGZgkYsfPizN/6raxzu561bai3JjtLnHYARJm0yCRxBzYETgpm8JiRB/h2S7K
 KF9sn6Uz6zyeKOnm5cbS/tkIvZFHCpW/bVXoDUVrzdnnJKlv4Dmo5/TIG3/WtJaOtE4z
 OM0rxyBjLoGk6AZPoE6MhgkZQp3QeuYWnkHCp68XfUMXhUH4afga2XOZkNnHrZAjuyy2 Ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32brgrk6qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jul 2020 13:12:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06MD9CdL047315;
        Wed, 22 Jul 2020 13:12:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 32ep0q8eed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jul 2020 13:12:05 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06MD7095018628;
        Wed, 22 Jul 2020 13:07:00 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Jul 2020 13:06:59 +0000
Date:   Wed, 22 Jul 2020 16:06:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jamal Shareef <jamal.k.shareef@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: vchiq: Fix refcounting bug in buffer_from_host()
Message-ID: <20200722130651.GC220681@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9689 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007220097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9689 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1011 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007220096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we fail to queue the buffer then it can never be dequeued.  This can
lead to a forever loop in stop_streaming() when we wait for everything
to finish.

Fixes: 70ec64ccdaac ("staging: bcm2835-camera: Ensure all buffers are returned on disable")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
From static analysis.  Not tested.  Please review carefully etc.

 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index dc767730db43..65dd2a55b3da 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -441,6 +441,8 @@ buffer_from_host(struct vchiq_mmal_instance *instance,
 	ret = vchiq_queue_kernel_message(instance->service_handle, &m,
 					 sizeof(struct mmal_msg_header) +
 					 sizeof(m.u.buffer_from_host));
+	if (ret)
+		atomic_dec(&port->buffers_with_vpu);
 
 	vchiq_release_service(instance->service_handle);
 
-- 
2.27.0

