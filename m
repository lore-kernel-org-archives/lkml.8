Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D3EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73BC52065F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgGHRTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:19:16 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:39918 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgGHRTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:19:15 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 50C1ABC06E;
        Wed,  8 Jul 2020 17:19:12 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     jack@suse.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: DISKQUOTA
Date:   Wed,  8 Jul 2020 19:19:05 +0200
Message-Id: <20200708171905.15396-1-grandmaster@al2klimov.de>
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
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 Documentation/filesystems/quota.rst | 2 +-
 fs/quota/Kconfig                    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/quota.rst b/Documentation/filesystems/quota.rst
index a30cdd47c652..6508c4520ba5 100644
--- a/Documentation/filesystems/quota.rst
+++ b/Documentation/filesystems/quota.rst
@@ -31,7 +31,7 @@ the above events to userspace. There they can be captured by an application
 and processed accordingly.
 
 The interface uses generic netlink framework (see
-http://lwn.net/Articles/208755/ and http://people.suug.ch/~tgr/libnl/ for more
+https://lwn.net/Articles/208755/ and http://people.suug.ch/~tgr/libnl/ for more
 details about this layer). The name of the quota generic netlink interface
 is "VFS_DQUOT". Definitions of constants below are in <linux/quota.h>.
 Since the quota netlink protocol is not namespace aware, quota netlink messages
diff --git a/fs/quota/Kconfig b/fs/quota/Kconfig
index 7218314ca13f..d1ceb76adb71 100644
--- a/fs/quota/Kconfig
+++ b/fs/quota/Kconfig
@@ -15,7 +15,7 @@ config QUOTA
 	  Ext3, ext4 and reiserfs also support journaled quotas for which
 	  you don't need to run quotacheck(8) after an unclean shutdown.
 	  For further details, read the Quota mini-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>, or the documentation provided
+	  <https://www.tldp.org/docs.html#howto>, or the documentation provided
 	  with the quota tools. Probably the quota support is only useful for
 	  multi user systems. If unsure, say N.
 
-- 
2.27.0

