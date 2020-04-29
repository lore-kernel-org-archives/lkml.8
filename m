Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA6DC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D604421D92
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgD2NLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:11:41 -0400
Received: from m17616.mail.qiye.163.com ([59.111.176.16]:33194 "EHLO
        m17616.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgD2NLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:11:35 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.227])
        by m17616.mail.qiye.163.com (Hmail) with ESMTPA id E621A108DC2;
        Wed, 29 Apr 2020 21:11:24 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Wang Wenhu <wenhu.wang@vivo.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] doc: thermal: add cpu-idle-cooling to index tree
Date:   Wed, 29 Apr 2020 06:11:09 -0700
Message-Id: <20200429131109.80891-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVKQ01CQkJMQkxDSUpLT1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRw6Cyo4EDg#T004Ckg6NU89
        FzUwClZVSlVKTkNDSk1OQ0JLSU1KVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlMWVdZCAFZQUlLSUw3Bg++
X-HM-Tid: 0a71c6103cda9374kuwse621a108dc2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpu-idle-cooling.rst to the index list for user reference through
self-compiled htmldocs or online documentation tree of kernel.

Like: https://www.kernel.org/doc/html/latest/driver-api/thermal/index.html

Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/driver-api/thermal/cpu-idle-cooling.rst | 3 +++
 Documentation/driver-api/thermal/index.rst            | 1 +
 2 files changed, 4 insertions(+)

diff --git a/Documentation/driver-api/thermal/cpu-idle-cooling.rst b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
index a1c3edecae00..b9f34ceb2a38 100644
--- a/Documentation/driver-api/thermal/cpu-idle-cooling.rst
+++ b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
@@ -1,3 +1,6 @@
+================
+CPU Idle Cooling
+================
 
 Situation:
 ----------
diff --git a/Documentation/driver-api/thermal/index.rst b/Documentation/driver-api/thermal/index.rst
index 5ba61d19c6ae..4cb0b9b6bfb8 100644
--- a/Documentation/driver-api/thermal/index.rst
+++ b/Documentation/driver-api/thermal/index.rst
@@ -8,6 +8,7 @@ Thermal
    :maxdepth: 1
 
    cpu-cooling-api
+   cpu-idle-cooling
    sysfs-api
    power_allocator
 
-- 
2.17.1

