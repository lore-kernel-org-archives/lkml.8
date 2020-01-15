Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4CFC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 05:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24382187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 05:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jfHeTIBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgAOFzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 00:55:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51532 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgAOFzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 00:55:04 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00F5r3Qt081179;
        Wed, 15 Jan 2020 05:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=1gZPAr1kpJ4E3uZiP+aqnRfB8p5P/qwOcYU0dMQ64EQ=;
 b=jfHeTIBssvKTq+TbH1r8jsxyu97FsGIelhDNSyahj6GqsHhdo483FQbaDCDKg0XiH9aC
 liESUFHETLW2pwO6rC3GknaiB6jlXSYLN216WufVP3G44gggE1T8iOR82gaW2CP1zAR+
 9AMjylIuS8kOmk9IHdR5DsjywBmUistEuedYUm9aVhp8sN3fq20j1oe/A97DsmQ5f732
 xZdtrAsbxmq63TRiGV+zd967uSJmXvt8e7O/d76Cn4fickPBOC52HuMdCn70MiCl7kDJ
 uOLVSxYragoZuDhpTF99ZGHoh6Zj7+P0fbPHUnBsosx74qW864iaTZRvXXNBvzftxpPH TQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xf73yj7tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 05:54:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00F5s2cm099491;
        Wed, 15 Jan 2020 05:54:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xh2sdvmp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 05:54:44 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00F5sbZs009520;
        Wed, 15 Jan 2020 05:54:37 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Jan 2020 21:54:37 -0800
Date:   Wed, 15 Jan 2020 08:54:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Lee Schermerhorn <lee.schermerhorn@hp.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        syzbot <syzbot+e64a13c5369a194d67df@syzkaller.appspotmail.com>,
        aarcange@redhat.com, hughd@google.com, mhocko@suse.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
        viro@zeniv.linux.org.uk, yang.shi@linux.alibaba.com
Subject: [PATCH] mm/mempolicy.c: Fix out of bounds write in mpol_parse_str()
Message-ID: <20200115055426.vdjwvry44nfug7yy@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006a8b8f059c24672a@google.com>
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9500 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001150047
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9500 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001150047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What we are trying to do is change the '=' character to a NUL terminator
and then at the end of the function we restore it back to an '='.  The
problem is there are two error paths where we jump to the end of the
function before we have replaced the '=' with NUL.  We end up putting
the '=' in the wrong place (possibly one element before the start of
the buffer).

Reported-by: syzbot+e64a13c5369a194d67df@syzkaller.appspotmail.com
Fixes: 095f1fc4ebf3 ("mempolicy: rework shmem mpol parsing and display")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 mm/mempolicy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 067cf7d3daf5..1340c5c496b5 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2817,6 +2817,9 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 	char *flags = strchr(str, '=');
 	int err = 1, mode;
 
+	if (flags)
+		*flags++ = '\0';	/* terminate mode string */
+
 	if (nodelist) {
 		/* NUL-terminate mode or flags string */
 		*nodelist++ = '\0';
@@ -2827,9 +2830,6 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 	} else
 		nodes_clear(nodes);
 
-	if (flags)
-		*flags++ = '\0';	/* terminate mode string */
-
 	mode = match_string(policy_modes, MPOL_MAX, str);
 	if (mode < 0)
 		goto out;
-- 
2.11.0

