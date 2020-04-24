Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C75C55191
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15B7520776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KS9Cb8tH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgDXKov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:44:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43390 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDXKou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 06:44:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03OAhLnQ188027;
        Fri, 24 Apr 2020 10:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=lgSP9yyrfb8QaHVkQK0ooYCi2f+LrM6wpIAQEd3T7CQ=;
 b=KS9Cb8tHhEhD76v8cXXgn+iW/pQMkkluNk2x2Qb3L7lzbaY9JWX3VC1xEddwGrogmD9U
 pf/uOVWPf3/x+Dtv2w4hvRsK7nRxR0ROsFpDNj3YbgcAcEt3rVxOjYg3gNF67fNnXboX
 zYsY70KOt0yWfBonHNJ62YmK44QTHaEv3i6QMOC8haaI1eMhIm9Sgq3hWzirLKH75X4D
 3zslvB8aDRPJWRg0fBpv+GGypve25ILxGBQ6vlU8camFknP78T/gwx53ryJgiOaCGhKf
 IAYLLCCzqXHuVtHEIhdQSmfB4XOVELpIPcWQh3m75NgIv43EQ/fGmp8aMp4WqmnwzAq2 IQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30ketdknqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 10:44:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03OAgfgd129915;
        Fri, 24 Apr 2020 10:42:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30gbbptmsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 10:42:44 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03OAgfuS018654;
        Fri, 24 Apr 2020 10:42:42 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Apr 2020 03:42:41 -0700
Date:   Fri, 24 Apr 2020 13:42:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: wfx: check ssidlen and prevent an array overflow
Message-ID: <20200424104235.GA416402@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to cap "ssidlen" to prevent a memcpy() overflow.

Fixes: 40115bbc40e2 ("staging: wfx: implement the rest of mac80211 API")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/wfx/sta.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/sta.c b/drivers/staging/wfx/sta.c
index c73dbb3a0de8c..3bff0f1e3d9ba 100644
--- a/drivers/staging/wfx/sta.c
+++ b/drivers/staging/wfx/sta.c
@@ -479,7 +479,9 @@ static void wfx_do_join(struct wfx_vif *wvif)
 		ssidie = ieee80211_bss_get_ie(bss, WLAN_EID_SSID);
 	if (ssidie) {
 		ssidlen = ssidie[1];
-		memcpy(ssid, &ssidie[2], ssidie[1]);
+		if (ssidlen > IEEE80211_MAX_SSID_LEN)
+			ssidlen = IEEE80211_MAX_SSID_LEN;
+		memcpy(ssid, &ssidie[2], ssidlen);
 	}
 	rcu_read_unlock();
 
-- 
2.26.1

