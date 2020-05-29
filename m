Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6391C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D99E2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nToWXUFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgE2M21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:28:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46020 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgE2M20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:28:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04TCIEJP178159;
        Fri, 29 May 2020 12:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=SPN5tu+DzLP7xBB4KSi//zwtdPV66GdUhG62R2cTY4I=;
 b=nToWXUFw4kJZDlysmEvIsKeVLkepx9hSd50G9dnoZToELIBbfKayfmu36dEboJODFILF
 mtmVKJKkdukQEJUX2NMAqdI5mUNh3FX1+3JADM0FcmSYQeRoN+uObN0M+mliMrf9MLI5
 4C5H6tZd9+SLYUFWH8mrmgx45QCu+dIwOHTDK5IVT/HEEU5vpK/g+oRNQOIIHSpfAavt
 BKsValVH25RcAwYWLqFhIHMcwqGulcBfj71pxqiuATFsQttAJWYuKhj+84/o2kdBfbaS
 Q0Z2/S6VGB69j2LKYebY+He7+MlJJ67tn33683gDhSTGMXkz+hGlUScnhFJRoHUqKnFj Hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 318xe1t3fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 May 2020 12:28:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04TCD9FQ137625;
        Fri, 29 May 2020 12:28:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 317ddubyvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 May 2020 12:28:01 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04TCRwnp016835;
        Fri, 29 May 2020 12:27:58 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 May 2020 05:27:58 -0700
Date:   Fri, 29 May 2020 15:27:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] x86/resctrl: fix a NULL vs IS_ERR() static checker warning
Message-ID: <20200529122744.GA1217265@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 cotscore=-2147483648 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callers don't expect *d_cdp to be set to an error pointer, they only
check for NULL.  This leads to a static checker warning:

    arch/x86/kernel/cpu/resctrl/rdtgroup.c:2648 __init_one_rdt_domain()
    warn: 'd_cdp' could be an error pointer

I don't think this will lead to a real life bug, but it's easy enough to
change it to be NULL.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 23b4b61319d3f..3f844f14fc0a6 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1117,6 +1117,7 @@ static int rdt_cdp_peer_get(struct rdt_resource *r, struct rdt_domain *d,
 	_d_cdp = rdt_find_domain(_r_cdp, d->id, NULL);
 	if (WARN_ON(IS_ERR_OR_NULL(_d_cdp))) {
 		_r_cdp = NULL;
+		_d_cdp = NULL;
 		ret = -EINVAL;
 	}
 
-- 
2.26.2

