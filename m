Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF46C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C65A020656
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgDWVGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:06:20 -0400
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:55610 "EHLO
        2.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgDWVGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 17:06:19 -0400
X-Greylist: delayed 9220 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Apr 2020 17:06:18 EDT
Received: from player796.ha.ovh.net (unknown [10.110.115.143])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id 4039C12D866
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 20:37:25 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player796.ha.ovh.net (Postfix) with ESMTPSA id 839B011A47C92;
        Thu, 23 Apr 2020 18:37:18 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH 3/3] docs: sysctl/kernel: document firmware_config
Date:   Thu, 23 Apr 2020 20:36:51 +0200
Message-Id: <20200423183651.15365-3-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423183651.15365-1-steve@sk2.org>
References: <20200423183651.15365-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16169330038890581381
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrgeelgdeljecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the firmware fallback mechanisms documentation and the
implementation in drivers/base/firmware_loader/fallback.c.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index d4bbdaf96ebc..cb6d5302b595 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -265,6 +265,19 @@ domain names are in general different. For a detailed discussion
 see the ``hostname(1)`` man page.
 
 
+firmware_config
+===============
+
+See :doc:`/driver-api/firmware/fallback-mechanisms`.
+
+The entries in this directory allow the firmware loader helper
+fallback to be controlled:
+
+* ``force_sysfs_fallback``, when set to 1, forces the use of the
+  fallback;
+* ``ignore_sysfs_fallback``, when set to 1, ignores any fallback.
+
+
 ftrace_dump_on_oops
 ===================
 
-- 
2.20.1

