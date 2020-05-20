Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74068C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE4E2070A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o4m1NTL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgETNKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 09:10:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47878 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETNKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 09:10:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KD8JFi064189;
        Wed, 20 May 2020 13:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=R7gtf0kiWbCNJ0UhI5MwvQ47qSSl1HmSUaTx5bHu6G0=;
 b=o4m1NTL434XJQbAkIuOB//h3s4FworvA3R42ve4vzv2KBNyiMoH/EbmcxuhOlXbZd+A9
 vJW4rNRvhlnDIx2czecGKoM7wSEB7Cm4Lt0EGB05DA1cOixhUrZ2Uk434gcFJoJr4h30
 EvBTF06GCH/PagknjE+aV2ROHM1ySQqhjKRMgDwfwkqEXlYbNtDw4UfSzcqXBnc626oh
 rQYKowjZKekgM+ykGLa/pW7YGTtZdX3t4A6hKcwuW799AcWvhQafXS7J6Ej6Nl/+rxAb
 sKyP2sKE+2DnK+TCtqHM1Hz9D1ld0gFjEnAevWLNbstcYQpLpg0tNinE6yVGMpu3/Tst GQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3127krb14d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 13:10:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KD8SBh188047;
        Wed, 20 May 2020 13:08:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 314gm724eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 13:08:30 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04KD8Lud010719;
        Wed, 20 May 2020 13:08:21 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 06:08:20 -0700
Date:   Wed, 20 May 2020 16:08:12 +0300
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
Subject: [PATCH v2] drm/amdgpu: off by on in
 amdgpu_device_attr_create_groups() error handling
Message-ID: <20200520130812.GA177222@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520125209.GP3041@kadam>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200113
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
v2: style change

 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c           | 3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index b75362bf0742..e809534fabd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1942,9 +1942,8 @@ static int amdgpu_device_attr_create_groups(struct amdgpu_device *adev,
 	return 0;
 
 failed:
-	for (; i > 0; i--) {
+	while (i--)
 		amdgpu_device_attr_remove(adev, &attrs[i]);
-	}
 
 	return ret;
 }
