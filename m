Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E2DC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27DA2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgBRNjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 08:39:31 -0500
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:56434 "EHLO
        1.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgBRNjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:39:31 -0500
Received: from player779.ha.ovh.net (unknown [10.110.103.129])
        by mo2.mail-out.ovh.net (Postfix) with ESMTP id 3EA5B1CA159
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 14:00:37 +0100 (CET)
Received: from sk2.org (cre33-1_migr-88-122-126-116.fbx.proxad.net [88.122.126.116])
        (Authenticated sender: steve@sk2.org)
        by player779.ha.ovh.net (Postfix) with ESMTPSA id B4C08F777501;
        Tue, 18 Feb 2020 13:00:31 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2 5/8] docs: document stop-a in sysctl/kernel.rst
Date:   Tue, 18 Feb 2020 13:59:20 +0100
Message-Id: <20200218125923.685-6-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218125923.685-1-steve@sk2.org>
References: <20200218125923.685-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16137804843222060421
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrjeekgdegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpdekkedruddvvddruddviedrudduieenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This describes the SPARC-specific stop-a sysctl entry, which was
previously listed in kernel.rst but not documented.

Base on the implementation in arch/sparc/kernel/setup_{32,64}.c and
kernel/panic.c.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 76ff10f6f63a..795d8e695f50 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1068,6 +1068,16 @@ compilation sees a 1% slowdown, other systems and workloads may vary.
 stop-a (SPARC only)
 ===================
 
+Controls Stop-A:
+
+= ====================================
+0 Stop-A has no effect.
+1 Stop-A breaks to the PROM (default).
+= ====================================
+
+Stop-A is always enabled on a panic, so that the user can return to
+the boot PROM.
+
 
 sysrq
 =====
-- 
2.20.1

