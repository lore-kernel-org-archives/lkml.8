Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6BBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A034B2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgHYQQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:16:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43886 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgHYQQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:16:21 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kAbcR-0004W7-90; Tue, 25 Aug 2020 16:16:19 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Joe Perches <joe@perches.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2] MAINTAINERS: add namespace entry
Date:   Tue, 25 Aug 2020 18:15:57 +0200
Message-Id: <20200825161556.1225970-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Namespace maintainership has never been formalized which has led to
confusion when people need to determine where to send patches and who
should take a look at them. Especially, since we have a dedicated list
containers.lists.linuxfoundation.org already for a long time. In
preparation of this patch I added the containers.lists.linuxfoundation.org
mailing list to be archived on lore.

This will not just make it easier to catch and review patches specific to
namespaces and containers but also for changes not specifically touching
namespaces but which nevertheless will have impact on namespaces and
containers.

Add an entry for Eric (who agreed to this) and me and add a first batch of
files that are relevant. Currently, only a small set of files are added and
only such namespaces that haven't gotten a separate maintainers entry (e.g.
time namespaces). I expect this to grow more entries and/or regular
expressions over time. For now these entries here are sufficient. I intend
to route this patch upstream soon.

Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- fix file ordering (passes cleanly through checkpatch.pl now)
---
 MAINTAINERS | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f0068bceeb61..ef636d00a725 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11892,6 +11892,25 @@ S:	Supported
 W:	https://www.cspi.com/ethernet-products/support/downloads/
 F:	drivers/net/ethernet/myricom/myri10ge/
 
+NAMESPACES AND CONTAINERS
+M:	Christian Brauner <christian.brauner@ubuntu.com>
+M:	Eric W. Biederman <ebiederm@xmission.com>
+L:	containers.lists.linuxfoundation.org
+S:	Supported
+T:	https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/
+T:	https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/
+F:	include/linux/ipc_namespace.h
+F:	include/linux/ns_common.h
+F:	include/linux/nsproxy.h
+F:	include/linux/pid_namespace.h
+F:	include/linux/user_namespace.h
+F:	include/linux/utsname.h
+F:	ipc/namespace.c
+F:	kernel/nsproxy.c
+F:	kernel/pid_namespace.c
+F:	kernel/user_namespace.c
+F:	kernel/utsname.c
+
 NAND FLASH SUBSYSTEM
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 R:	Richard Weinberger <richard@nod.at>

base-commit: d012a7190fc1fd72ed48911e77ca97ba4521bccd
-- 
2.28.0

