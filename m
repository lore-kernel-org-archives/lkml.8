Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD96C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E89BB20771
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbgGMRpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:45:07 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:55568 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729747AbgGMRpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:45:07 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id C4622BC07E;
        Mon, 13 Jul 2020 17:45:03 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        corbet@lwn.net, ocfs2-devel@oss.oracle.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] ocfs2: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 19:44:56 +0200
Message-Id: <20200713174456.36596-1-grandmaster@al2klimov.de>
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

 If there are any URLs to be removed completely or at least not just HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.

 Sorry again to all maintainers who complained about subject lines.
 Now I realized that you want an actually perfect prefixes,
 not just subsystem ones.
 I tried my best...
 And yes, *I could* (at least half-)automate it.
 Impossible is nothing! :)


 Documentation/filesystems/dlmfs.rst | 2 +-
 Documentation/filesystems/ocfs2.rst | 2 +-
 fs/ocfs2/Kconfig                    | 6 +++---
 fs/ocfs2/blockcheck.c               | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/dlmfs.rst b/Documentation/filesystems/dlmfs.rst
index 68daaa7facf9..28dd41a63be2 100644
--- a/Documentation/filesystems/dlmfs.rst
+++ b/Documentation/filesystems/dlmfs.rst
@@ -12,7 +12,7 @@ dlmfs is built with OCFS2 as it requires most of its infrastructure.
 
 :Project web page:    http://ocfs2.wiki.kernel.org
 :Tools web page:      https://github.com/markfasheh/ocfs2-tools
-:OCFS2 mailing lists: http://oss.oracle.com/projects/ocfs2/mailman/
+:OCFS2 mailing lists: https://oss.oracle.com/projects/ocfs2/mailman/
 
 All code copyright 2005 Oracle except when otherwise noted.
 
diff --git a/Documentation/filesystems/ocfs2.rst b/Documentation/filesystems/ocfs2.rst
index 412386bc6506..42ca9a3d4c6e 100644
--- a/Documentation/filesystems/ocfs2.rst
+++ b/Documentation/filesystems/ocfs2.rst
@@ -14,7 +14,7 @@ get "mount.ocfs2" and "ocfs2_hb_ctl".
 
 Project web page:    http://ocfs2.wiki.kernel.org
 Tools git tree:      https://github.com/markfasheh/ocfs2-tools
-OCFS2 mailing lists: http://oss.oracle.com/projects/ocfs2/mailman/
+OCFS2 mailing lists: https://oss.oracle.com/projects/ocfs2/mailman/
 
 All code copyright 2005 Oracle except when otherwise noted.
 
diff --git a/fs/ocfs2/Kconfig b/fs/ocfs2/Kconfig
index aca16624b370..5d11380d8724 100644
--- a/fs/ocfs2/Kconfig
+++ b/fs/ocfs2/Kconfig
@@ -16,9 +16,9 @@ config OCFS2_FS
 	  You'll want to install the ocfs2-tools package in order to at least
 	  get "mount.ocfs2".
 
-	  Project web page:    http://oss.oracle.com/projects/ocfs2
-	  Tools web page:      http://oss.oracle.com/projects/ocfs2-tools
-	  OCFS2 mailing lists: http://oss.oracle.com/projects/ocfs2/mailman/
+	  Project web page:    https://oss.oracle.com/projects/ocfs2
+	  Tools web page:      https://oss.oracle.com/projects/ocfs2-tools
+	  OCFS2 mailing lists: https://oss.oracle.com/projects/ocfs2/mailman/
 
 	  For more information on OCFS2, see the file
 	  <file:Documentation/filesystems/ocfs2.rst>.
diff --git a/fs/ocfs2/blockcheck.c b/fs/ocfs2/blockcheck.c
index eaf042feaf5e..6e07ddb0e3c0 100644
--- a/fs/ocfs2/blockcheck.c
+++ b/fs/ocfs2/blockcheck.c
@@ -124,7 +124,7 @@ u32 ocfs2_hamming_encode(u32 parity, void *data, unsigned int d, unsigned int nr
 		 * parity bits that are part of the bit number
 		 * representation.  Huh?
 		 *
-		 * <wikipedia href="http://en.wikipedia.org/wiki/Hamming_code">
+		 * <wikipedia href="https://en.wikipedia.org/wiki/Hamming_code">
 		 * In other words, the parity bit at position 2^k
 		 * checks bits in positions having bit k set in
 		 * their binary representation.  Conversely, for
-- 
2.27.0

