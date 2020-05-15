Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1923C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C482A2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgEOQI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:08:26 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:45488 "EHLO
        4.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbgEOQI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:08:26 -0400
Received: from player758.ha.ovh.net (unknown [10.110.115.173])
        by mo2.mail-out.ovh.net (Postfix) with ESMTP id 116B41D7521
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 18:02:55 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player758.ha.ovh.net (Postfix) with ESMTPSA id 59D39126FF844;
        Fri, 15 May 2020 16:02:43 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] docs: sysctl/kernel: document ngroups_max
Date:   Fri, 15 May 2020 18:02:22 +0200
Message-Id: <20200515160222.7994-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13632114599481396613
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrleekgdelfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepteegudfgleekieekteeggeetveefueefteeugfduieeitdfhhedtfeefkedvfeefnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejheekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a read-only export of NGROUPS_MAX, so this patch also changes
the declarations in kernel/sysctl.c to const.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 9 +++++++++
 kernel/sysctl.c                             | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 0d427fd10941..5f12ee07665c 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -459,6 +459,15 @@ Notes:
      successful IPC object allocation. If an IPC object allocation syscall
      fails, it is undefined if the value remains unmodified or is reset to -1.
 
+
+ngroups_max
+===========
+
+Maximum number of supplementary groups, _i.e._ the maximum size which
+``setgroups`` will accept. Exports ``NGROUPS_MAX`` from the kernel.
+
+
+
 nmi_watchdog
 ============
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8a176d8727a3..2ba9f449d273 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -146,7 +146,7 @@ static unsigned long dirty_bytes_min = 2 * PAGE_SIZE;
 static int maxolduid = 65535;
 static int minolduid;
 
-static int ngroups_max = NGROUPS_MAX;
+static const int ngroups_max = NGROUPS_MAX;
 static const int cap_last_cap = CAP_LAST_CAP;
 
 /*
@@ -883,7 +883,7 @@ static struct ctl_table kern_table[] = {
 #endif
 	{
 		.procname	= "ngroups_max",
-		.data		= &ngroups_max,
+		.data		= (void *)&ngroups_max,
 		.maxlen		= sizeof (int),
 		.mode		= 0444,
 		.proc_handler	= proc_dointvec,

base-commit: 1ae7efb388540adc1653a51a3bc3b2c9cef5ec1a
-- 
2.20.1

