Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA70C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 23:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013162076C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 23:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cZNIZJdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgCSXBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 19:01:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36534 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbgCSXBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 19:01:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JMw39N111982;
        Thu, 19 Mar 2020 23:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=wtKkOMzpj5yF3znT+VYDwakqpbRDOd9bsKsjl4H7//g=;
 b=cZNIZJdoCYwNQ2jj+oiAbDILtY7zR06HmPoW58zrquNUj3stxD87WskEBrfksB6LheRG
 ui4CnzGsqgNkYQLA1ZFB7v9/HqgdyvvhWkS6OBKZhEq1bL2oUfQc8Y3b9iqP2nRa/5y1
 izkfVagy8ltlb5M+PP3ZHX6D0Fjv+jcuIWkpOAFodZTYbVgn3HdlMw0ARK5sDcOSyu4g
 0Dy8C6baM1H7Vsavb9ll40ns7wLF517kiO6cFKFsjw6zPadKTzCQp6TormidBSo8zFSW
 EaBdiCrSTv9WJYgd+Z4G8QeZT3QhPOPmSPwZO+qB6iM3TqTcYFNGNbjD13F313VcN3qc ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2yub27aw14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 23:01:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JMwDRM022431;
        Thu, 19 Mar 2020 23:01:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2ys92nh796-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 23:01:19 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02JN1Ils007236;
        Thu, 19 Mar 2020 23:01:19 GMT
Received: from toshiba-tecra.hsd1.ca.comcast.net (/10.159.250.146)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Mar 2020 16:01:18 -0700
From:   Victor Erminpour <victor.erminpour@oracle.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: Prefer 'python3' when building htmldocs
Date:   Thu, 19 Mar 2020 16:00:42 -0700
Message-Id: <1584658842-778-1-git-send-email-victor.erminpour@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9565 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=1
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003190092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9565 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 suspectscore=1
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003190092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer 'python3' and 'sphinx-build-3' when building htmldocs.
Building htmldocs fails on systems that don't have 'python'
and 'sphinx-build' installed, but do have 'python3' and
'sphinx-build-3' available.

Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
---
 Documentation/Makefile | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d77bb607aea4..00c400523e15 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -11,6 +11,7 @@ endif
 
 # You can set these variables from the command line.
 SPHINXBUILD   = sphinx-build
+SPHINXBUILD3  = sphinx-build-3
 SPHINXOPTS    =
 SPHINXDIRS    = .
 _SPHINXDIRS   = $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst))
@@ -61,11 +62,23 @@ loop_cmd = $(echo-cmd) $(cmd_$(1)) || exit;
 # $5 reST source folder relative to $(srctree)/$(src),
 #    e.g. "media" for the linux-tv book-set at ./Documentation/media
 
+HAVE_PYTHON3 := $(shell if which $(PYTHON3) >/dev/null 2>&1; then echo 1; else echo 0; fi)
+HAVE_SPHINX3 := $(shell if which $(SPHINXBUILD3) >/dev/null 2>&1; then echo 1; else echo 0; fi)
+PYTHON_BIN = $(PYTHON)
+
+# If we have both python3 and sphinx-build-3,
+# prefer python3 over python.
+ifeq ($(HAVE_PYTHON3),1)
+    ifeq ($(HAVE_SPHINX3),1)
+        PYTHON_BIN = $(PYTHON3)
+    endif
+endif
+
 quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
       cmd_sphinx = $(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/media $2 && \
 	PYTHONDONTWRITEBYTECODE=1 \
 	BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(srctree)/$(src)/$5/$(SPHINX_CONF)) \
-	$(PYTHON) $(srctree)/scripts/jobserver-exec \
+	$(PYTHON_BIN) $(srctree)/scripts/jobserver-exec \
 	$(SHELL) $(srctree)/Documentation/sphinx/parallel-wrapper.sh \
 	$(SPHINXBUILD) \
 	-b $2 \
