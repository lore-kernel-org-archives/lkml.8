Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DEFC1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B15E20735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lMYrLx5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgCQRic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:38:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38624 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgCQRia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:38:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02HHHqVk056217;
        Tue, 17 Mar 2020 17:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=HhYQtNzT7W8ofZ1VIhf3mFuaTo9RNACqiUJRCIPqvIw=;
 b=lMYrLx5QWiZ+xiLWVnB/bSb6CnfNPhPAbqlPt4I+93thcy4JFREQZV+KJm/EUJTbewk8
 dyjRdONeiG9pWWmQjOtsW+OkFv8qyqJU3oeM5TPBPf4EMKv/nYRfTbrm2/4M+1Ib4UDr
 FPm1wJkMB2AcVfxw455pwwi/PDXs9Rea0H4bWDt0tK3AFhZBF1XlosVYYDhY23m+iQnS
 y7K0z4Dvu9sV1IZX6evOOfEswKHvZrVsJIqPB0B/JR7HJJd6dP3orqOHm2Bhi5dMY/uH
 DLazI99Wrpa1t+Q+k5vLXbXfrh+o+yztN1rcq5BGUOK7gl2OLgyOtbS9ROrsnM0Db8B4 ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2yrqwn671a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Mar 2020 17:38:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02HHJjBa102500;
        Tue, 17 Mar 2020 17:35:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2ys92dmrug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Mar 2020 17:35:59 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02HHZrdG015128;
        Tue, 17 Mar 2020 17:35:53 GMT
Received: from dhcp-10-175-196-233.vpn.oracle.com (/10.175.196.233)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Mar 2020 10:35:53 -0700
From:   Alan Maguire <alan.maguire@oracle.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        alex.dewar@gmx.co.uk, erelx.geron@intel.com,
        johannes.berg@intel.com, arnd@arndb.de,
        linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH] arch/um: falloc.h needs to be directly included for older libc
Date:   Tue, 17 Mar 2020 17:35:34 +0000
Message-Id: <1584466534-13248-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9563 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=686
 mlxscore=0 spamscore=0 bulkscore=0 adultscore=82 suspectscore=3
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170069
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9563 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=748
 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0 suspectscore=3
 malwarescore=0 priorityscore=1501 clxscore=1011 adultscore=45
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building UML with glibc 2.17 installed, compilation
of arch/um/os-Linux/file.c fails due to failure to find
FALLOC_FL_PUNCH_HOLE and FALLOC_FL_KEEP_SIZE definitions.

It appears that /usr/include/bits/fcntl-linux.h (indirectly
included by /usr/include/fcntl.h) does not include falloc.h
with an older glibc, whereas a more up-to-date version
does.

Adding the direct include to file.c resolves the issue
and does not cause problems for more recent glibc.

Fixes: 50109b5a03b4 ("um: Add support for DISCARD in the UBD Driver")
Cc: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 arch/um/os-Linux/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index fbda105..5c819f8 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -8,6 +8,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <signal.h>
+#include <linux/falloc.h>
 #include <sys/ioctl.h>
 #include <sys/mount.h>
 #include <sys/socket.h>
-- 
1.8.3.1

