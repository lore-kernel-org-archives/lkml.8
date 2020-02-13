Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E961C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574D220659
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgBMSHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:07:02 -0500
Received: from 2.mo4.mail-out.ovh.net ([46.105.72.36]:37976 "EHLO
        2.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMSHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:07:02 -0500
Received: from player715.ha.ovh.net (unknown [10.110.171.125])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id CA302224801
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 18:48:30 +0100 (CET)
Received: from sk2.org (cre33-1_migr-88-122-126-116.fbx.proxad.net [88.122.126.116])
        (Authenticated sender: steve@sk2.org)
        by player715.ha.ovh.net (Postfix) with ESMTPSA id 41F56F2A6677;
        Thu, 13 Feb 2020 17:48:25 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH 2/6] docs: merge debugging-modules.txt into sysctl/kernel.rst
Date:   Thu, 13 Feb 2020 18:46:57 +0100
Message-Id: <20200213174701.3200366-3-steve@sk2.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213174701.3200366-1-steve@sk2.org>
References: <20200213174701.3200366-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10082996616245562757
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrieekgddutdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpdekkedruddvvddruddviedrudduieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejudehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fits nicely in sysctl/kernel.rst, merge it (and rephrase it)
instead of linking to it.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 16 ++++++++++++++-
 Documentation/debugging-modules.txt         | 22 ---------------------
 2 files changed, 15 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/debugging-modules.txt

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 1de8f0b199b1..1aacd7a24f5a 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -388,7 +388,21 @@ This flag controls the L2 cache of G3 processor boards. If
 modprobe
 ========
 
-See Documentation/debugging-modules.txt.
+This gives the full path of the modprobe command which the kernel will
+use to load modules. This can be used to debug module loading
+requests:
+
+::
+
+    echo '#! /bin/sh' > /tmp/modprobe
+    echo 'echo "$@" >> /tmp/modprobe.log' >> /tmp/modprobe
+    echo 'exec /sbin/modprobe "$@"' >> /tmp/modprobe
+    chmod a+x /tmp/modprobe
+    echo /tmp/modprobe > /proc/sys/kernel/modprobe
+
+This only applies when the *kernel* is requesting that the module be
+loaded; it won’t have any effect if the module is being loaded
+explicitly using ``modprobe`` from userspace.
 
 
 modules_disabled
diff --git a/Documentation/debugging-modules.txt b/Documentation/debugging-modules.txt
deleted file mode 100644
index 172ad4aec493..000000000000
--- a/Documentation/debugging-modules.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Debugging Modules after 2.6.3
------------------------------
-
-In almost all distributions, the kernel asks for modules which don't
-exist, such as "net-pf-10" or whatever.  Changing "modprobe -q" to
-"succeed" in this case is hacky and breaks some setups, and also we
-want to know if it failed for the fallback code for old aliases in
-fs/char_dev.c, for example.
-
-In the past a debugging message which would fill people's logs was
-emitted.  This debugging message has been removed.  The correct way
-of debugging module problems is something like this:
-
-echo '#! /bin/sh' > /tmp/modprobe
-echo 'echo "$@" >> /tmp/modprobe.log' >> /tmp/modprobe
-echo 'exec /sbin/modprobe "$@"' >> /tmp/modprobe
-chmod a+x /tmp/modprobe
-echo /tmp/modprobe > /proc/sys/kernel/modprobe
-
-Note that the above applies only when the *kernel* is requesting
-that the module be loaded -- it won't have any effect if that module
-is being loaded explicitly using "modprobe" from userspace.
-- 
2.24.1

