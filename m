Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A58C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 20:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B05420674
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 20:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgGMUHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 16:07:48 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:44718 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgGMUHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 16:07:48 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id EF43CBC09D;
        Mon, 13 Jul 2020 20:07:44 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     jack@suse.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] udf: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 22:07:38 +0200
Message-Id: <20200713200738.37800-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
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


 Documentation/filesystems/udf.rst | 2 +-
 fs/udf/ecma_167.h                 | 2 +-
 fs/udf/super.c                    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/udf.rst b/Documentation/filesystems/udf.rst
index d9badbf285b2..f9489ddbb767 100644
--- a/Documentation/filesystems/udf.rst
+++ b/Documentation/filesystems/udf.rst
@@ -72,4 +72,4 @@ For the latest version and toolset see:
 
 Documentation on UDF and ECMA 167 is available FREE from:
 	- http://www.osta.org/
-	- http://www.ecma-international.org/
+	- https://www.ecma-international.org/
diff --git a/fs/udf/ecma_167.h b/fs/udf/ecma_167.h
index 736ebc5dc441..185c3e247648 100644
--- a/fs/udf/ecma_167.h
+++ b/fs/udf/ecma_167.h
@@ -2,7 +2,7 @@
  * ecma_167.h
  *
  * This file is based on ECMA-167 3rd edition (June 1997)
- * http://www.ecma.ch
+ * https://www.ecma.ch
  *
  * Copyright (c) 2001-2002  Ben Fennema
  * Copyright (c) 2017-2019  Pali Rohár <pali@kernel.org>
diff --git a/fs/udf/super.c b/fs/udf/super.c
index f747bf72edbe..1c42f544096d 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -11,8 +11,8 @@
  *  This code is based on version 2.00 of the UDF specification,
  *  and revision 3 of the ECMA 167 standard [equivalent to ISO 13346].
  *    http://www.osta.org/
- *    http://www.ecma.ch/
- *    http://www.iso.org/
+ *    https://www.ecma.ch/
+ *    https://www.iso.org/
  *
  * COPYRIGHT
  *  This file is distributed under the terms of the GNU General Public
-- 
2.27.0

