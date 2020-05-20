Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1994EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA49C207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YRc3iz02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgETMBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:01:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60536 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgETMBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:01:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KBvY8D173181;
        Wed, 20 May 2020 12:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=68JDAbvefgoH93PS1ZCGMUKwpNrUM0Es7ihpXKYD3SQ=;
 b=YRc3iz024NVv0RIMObb+nH8HqskR8SsNAB++dS9Ryu9eT2P9OAxdFZHQa/zungABs/84
 F61hJvddLjsvEq9YKKQAVNgsXanV/ROCEjrzJ4B0MP6TwH9tZSi8hCgygDPClnGyrWAe
 dy7dBmUb9FsTHxckibNELYF5Y+IwA1PAHTaX/sIi2UPcwXUHfrk+ksYOqUWIbMO+CWsd
 zvyYqtdZ7GnaGGZL3iTcTENkxUgFaNEMJAxWKN1E8nSFe8gsk98z1R6PuEIl2dnSnnO2
 Z8wEOj28LtiOiTF0wq6cKBLHdyftmpqvdVzAvlpR2l60IF1iZju45zqks7BmPQYTPULp tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31501r96wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 12:01:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KBsR7x107085;
        Wed, 20 May 2020 12:01:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 314gm6xwa3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 12:01:06 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04KC13SD003438;
        Wed, 20 May 2020 12:01:03 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 05:01:02 -0700
Date:   Wed, 20 May 2020 15:00:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        Rui Huang <ray.huang@amd.com>,
        Kenneth Feng <kenneth.feng@amd.com>,
        Yintian Tao <yttao@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amdgpu: off by on in amdgpu_device_attr_create_groups()
 error handling
Message-ID: <20200520120054.GB172354@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 cotscore=-2147483648
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This loop in the error handling code should start a "i - 1" and end at
"i == 0".  Currently it starts a "i" and ends at "i == 1".  The result
is that it removes one attribute that wasn't created yet, and leaks the
zeroeth attribute.

Fixes: 4e01847c38f7 ("drm/amdgpu: optimize amdgpu device attribute code")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index b75362bf0742..ee4a8e44fbeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1931,7 +1931,7 @@ static int amdgpu_device_attr_create_groups(struct amdgpu_device *adev,
 					    uint32_t mask)
 {
 	int ret = 0;
-	uint32_t i = 0;
+	int i;
 
 	for (i = 0; i < counts; i++) {
 		ret = amdgpu_device_attr_create(adev, &attrs[i], mask);
@@ -1942,9 +1942,8 @@ static int amdgpu_device_attr_create_groups(struct amdgpu_device *adev,
 	return 0;
 
 failed:
-	for (; i > 0; i--) {
+	while (--i >= 0)
 		amdgpu_device_attr_remove(adev, &attrs[i]);
-	}
 
 	return ret;
 }
-- 
2.26.2

