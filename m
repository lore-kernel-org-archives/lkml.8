Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAF4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DF2E207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XiDxFzSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgETMAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:00:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39196 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETMAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:00:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KBvw0S100740;
        Wed, 20 May 2020 12:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=zYw0CIqLQPQjZf813z+RcnjB+lAB2/Yov6H6AlW2Ba0=;
 b=XiDxFzSvYv5EPCuvFARWejtgr2wJvPaXE2ITysQ0m3iDDhY6XtgJla57x7E/1oYu8/V3
 bHL2qLY410MKcFcZapZiWuKWtKEB9E0juKbvFQcnO9Gs1cJp33sSoidCoc5QECdrowsv
 oHEyvEEBgwySs7Kp4KK314ifOQpDNEbop52hjeGeu6DSWsORM0W+dOsmGtRPNwo0JBXU
 BZSzaYR+FoRhnogsahbY7GKo3o4ZCBRB84o9zQt4VajIVIvEFIIpvSCxGViiTHHJdmF/
 ee85S+PMV4/a/da6AKiMvOBzoW+6pE7qJjRUtG+CEyGqdm+qs+TYfYFDe3hUTH1z5fry Qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31284m2p0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 12:00:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KBrABx064080;
        Wed, 20 May 2020 12:00:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3150205ke2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 12:00:33 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04KC0Pds014045;
        Wed, 20 May 2020 12:00:25 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 05:00:25 -0700
Date:   Wed, 20 May 2020 15:00:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>,
        Akira Shimahara <akira215corp@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] w1_therm: Free the correct variable
Message-ID: <20200520120019.GA172354@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=2 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005200104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that we change "p_args" to point to the middle of the
string so when we free it at the end of the function it's not freeing
the same pointer that we originally allocated.

Fixes: e2c94d6f5720 ("w1_therm: adding alarm sysfs entry")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
From static analysis.  I guess it must not cause too much of a problem
at run time?

 drivers/w1/slaves/w1_therm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index cc4b88056b33..a6c85e486671 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1526,8 +1526,9 @@ static ssize_t alarms_store(struct device *device,
 	int temp, ret = -EINVAL;
 	char *token = NULL;
 	s8 tl, th, tt;	/* 1 byte per value + temp ring order */
-	char *p_args = kmalloc(size, GFP_KERNEL);
+	char *p_args, *orig;
 
+	p_args = orig = kmalloc(size, GFP_KERNEL);
 	/* Safe string copys as buf is const */
 	if (!p_args) {
 		dev_warn(device,
@@ -1611,7 +1612,7 @@ static ssize_t alarms_store(struct device *device,
 
 free_m:
 	/* free allocated memory */
-	kfree(p_args);
+	kfree(orig);
 
 	return size;
 }
-- 
2.26.2

