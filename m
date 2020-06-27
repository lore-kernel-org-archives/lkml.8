Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F97EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 10:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4734320B80
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 10:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgF0KcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 06:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgF0KcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 06:32:05 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6575C03E979;
        Sat, 27 Jun 2020 03:32:04 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 25EF6BC1D5;
        Sat, 27 Jun 2020 10:32:01 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        corbet@lwn.net, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: kdump
Date:   Sat, 27 Jun 2020 12:31:51 +0200
Message-Id: <20200627103151.71942-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
          If both the HTTP and HTTPS versions
          return 200 OK and serve the same content:
            Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See https://lkml.org/lkml/2020/6/26/837

 Documentation/admin-guide/kdump/kdump.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 2da65fef2a1c..8cfa35f777f5 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -65,20 +65,20 @@ Install kexec-tools
 
 2) Download the kexec-tools user-space package from the following URL:
 
-http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools.tar.gz
+https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools.tar.gz
 
 This is a symlink to the latest version.
 
 The latest kexec-tools git tree is available at:
 
 - git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
-- http://www.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
+- https://www.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
 
 There is also a gitweb interface available at
-http://www.kernel.org/git/?p=utils/kernel/kexec/kexec-tools.git
+https://www.kernel.org/git/?p=utils/kernel/kexec/kexec-tools.git
 
 More information about kexec-tools can be found at
-http://horms.net/projects/kexec/
+https://horms.net/projects/kexec/
 
 3) Unpack the tarball with the tar command, as follows::
 
@@ -511,7 +511,7 @@ dump kernel.
 You can also use the Crash utility to analyze dump files in Kdump
 format. Crash is available on Dave Anderson's site at the following URL:
 
-   http://people.redhat.com/~anderson/
+   https://people.redhat.com/~anderson/
 
 Trigger Kdump on WARN()
 =======================
-- 
2.27.0

