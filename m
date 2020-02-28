Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5F8C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BC324695
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VA8FU8oS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgB1JXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:23:40 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57700 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgB1JXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:23:39 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01S9HpmW025441;
        Fri, 28 Feb 2020 09:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=nZWlIAb25RKmpdimMBAR/YlDxxn7XYHb1GVQxtT07sg=;
 b=VA8FU8oSws/28udQzHALpUPBiYzyBnUjB5OAFd2W3yXTsz118oZnNZsuTwpOwKb89XWf
 SHT4LG5++yWxPCqsw9eyKPCdwbNKCITTl9uHyAD3wLfBvLdanup70G6ZqjedO/6xKlhO
 780qHl4zrIskSfsbZCJ7y1Zxepjr/VSj8AzpeXjiM/9yYyRZzOdtbBSyhM/gtcuIlPZq
 zbEoDDF4uJVM4PqF5RNirWICCyzW3L/89CVq6cb98ckizL0IVpSqp1xV2P/2dSU+pdcb
 FkvjYhqpdnkp4be+kZlhBRVfSJQ53WFW+uzH6h7528ncGWzaD8uyN4Q9FC+HYVQmZPYf 1w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2yehxrw3sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 09:23:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01S9MMeF121341;
        Fri, 28 Feb 2020 09:23:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2ydcsdfhr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 09:23:30 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01S9NS4V026416;
        Fri, 28 Feb 2020 09:23:28 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Feb 2020 01:23:27 -0800
Date:   Fri, 28 Feb 2020 12:23:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] drm: prevent a harmless integer overflow in
 drm_legacy_sg_alloc()
Message-ID: <20200228092321.axulddmkxrujkmas@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an integer overflow when we round up to PAGE_SIZE, but it's
harmless because we never re-use "request->size" for anything meaningful.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This code predates git.

 drivers/gpu/drm/drm_scatter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_scatter.c b/drivers/gpu/drm/drm_scatter.c
index d5c386154246..ca520028b2cb 100644
--- a/drivers/gpu/drm/drm_scatter.c
+++ b/drivers/gpu/drm/drm_scatter.c
@@ -99,6 +99,9 @@ int drm_legacy_sg_alloc(struct drm_device *dev, void *data,
 	if (!drm_core_check_feature(dev, DRIVER_SG))
 		return -EOPNOTSUPP;
 
+	if (request->size > SIZE_MAX - PAGE_SIZE)
+		return -EINVAL;
+
 	if (dev->sg)
 		return -EINVAL;
 
-- 
2.11.0

