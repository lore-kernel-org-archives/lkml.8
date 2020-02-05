Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94091C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B6020659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DsUJBbSQ";
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QP6TQOFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgBEPYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:24:44 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52912 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgBEPYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:24:44 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015FF3LH185647;
        Wed, 5 Feb 2020 15:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=m9gewJPVHDrEhwAN+PDBSGWKOSvNYN9vA2Z00MKrHoc=;
 b=DsUJBbSQ3IxYNbWbc2RIHY7SrB6ciZJ8X7Pp1K+UjRECvTIFAzDI7M40YRI/sg/Lq0oU
 Dy72HhilJdy9e0kLye0XT/du6kchIi2ue+AsuqkTIMuCeIjYMv7P2su2QfC4ViNA0o9H
 KVfL7G1oe4qPmMqsZfyBDP6kxcaz1v0IIQvU3FqCkSO5idjJzopABLaVqNQPVnHGzRvs
 kXhVBu5BiCLEX52j3MQAZYrMw81Yq5Lyk5Fq4XdXE0oUzO243oNG0njcOlrh1dGEzXOM
 Y7+Q++miyX9XkIgK+vKPU34J42bSRggeIaJVdzmgdgBxZ84Gz81bKJddgPFfH1K8Wsfi nA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=m9gewJPVHDrEhwAN+PDBSGWKOSvNYN9vA2Z00MKrHoc=;
 b=QP6TQOFbV5B8yqXdPB0cvCD4v/wkycO9+BSy36VBDzOWzgqIxqhCSGvayh+p6eOQNKGf
 xYeM+VQkj0/zMBQ3a/3sgjmh7aK3+/8xYPc0kwCzSuSGoEo7viW4LyDCy1C7bSqczbpX
 u33o+O6eIISFd/jHP2QuCPt+N7ntSLMJO79oIkuX1j/AYhtNle61N7ewdATdBQS3dicf
 0iE59g0FhvRRQPfryIlpK7pstipSERtDMT8qAD7mGC3xeSt3jW7sA4WLmwAPs5xfMwEV
 g88Qbi1CXhe1ONvYdErY8PraJDm8Ydy8Lwtvt2sYW1lvFHOTyjvXNR/xHwWEYJVLeyGm wg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xykbp3qcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 15:24:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015FE43x043983;
        Wed, 5 Feb 2020 15:24:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xymusyyq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 15:24:39 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 015FOcui002882;
        Wed, 5 Feb 2020 15:24:38 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Feb 2020 07:24:37 -0800
Date:   Wed, 5 Feb 2020 18:24:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] get_maintainer: Prefer MAINTAINER address over S-o-b
Message-ID: <20200205152429.ejgx2on2z4hoycus@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=773
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=843 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_maintainer.pl script looks at git history to create the CC list,
but unfortunately sometimes those email addresses are out of date.  The
script also looks at the MAINTAINERS file, of course, but if it already
found an email address for a maintainer in the git history then the
deduplicate_email() function will remove the second address.

It should save the MAINTAINERS address first, before loading the commit
signer addresses.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
We will have to add a special case if the Dan Williamses ever decide
to work on the same subsystem.

 scripts/get_maintainer.pl | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 34085d146fa2..e5bdd3143a49 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -932,14 +932,14 @@ sub get_maintainers {
 	}
     }
 
-    foreach my $fix (@fixes) {
-	vcs_add_commit_signers($fix, "blamed_fixes");
-    }
-
     foreach my $email (@email_to, @list_to) {
 	$email->[0] = deduplicate_email($email->[0]);
     }
 
+    foreach my $fix (@fixes) {
+	vcs_add_commit_signers($fix, "blamed_fixes");
+    }
+
     foreach my $file (@files) {
 	if ($email &&
 	    ($email_git || ($email_git_fallback &&
-- 
2.11.0

