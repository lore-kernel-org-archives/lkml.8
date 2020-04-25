Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B8BC54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 13:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 799572173E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 13:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho9UpzCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgDYNTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 09:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgDYNTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 09:19:17 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD42C09B04B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 06:19:16 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id hi11so5075784pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 06:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DNsgVTOEmh9ABmuJgNs+R+ip51/i8Ff9/P8faGUFA8U=;
        b=ho9UpzCBsRmIGDj5K/xKj/NLskahiBGJzr+KD0wxxebucuGS072Y24sCfKth8oHWCK
         UxqehHqZ5kFyRrxQdVogJS6ExcmqqalCDIpFABzXDtLIZk26MiNbU/eC7AHOgGl059e7
         D3xFrBjlqbDJRlbGv9/trSw/6UD+7w1gpIzwE0OmZ1uytjZpU4VqCthHflSeM6741GJV
         KBJqUrDL0Iq5KLnJnVSacumf+thWz1SOlKsGXrs1dpbo54yA/A7m14rphsflGbc3w8lK
         MehDBNZpfmY+8N5/2E9GwAZDtnMdUBhjNXvCliwyowFmbU1gzLjB2dWlS/8kGIdjUfuh
         oY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DNsgVTOEmh9ABmuJgNs+R+ip51/i8Ff9/P8faGUFA8U=;
        b=b0Pm4Cnr3NepSRES0lKvUahxUSeEzyyBZ/h6iHcZ4VSKqlYTD5OO0UbRKKCpH1z4m+
         VrHtUyRjVNFBrDiLcotusZ+OQbtQIuizgLPPyvg3JLpT6qjZ2SYtT41pbsOiUKFkBtqG
         kX4/8MUUdO/kbLnng6Y9bzYayiHW+GBRnTeC0i5bb4sFk2VfPHqlmTRPFoDHfLcp/3oa
         aDG00CZRjsMxilO7HwpZNqPlV2e/tjYfgEJn6b1t6bCbBBil9CgExVO+w6/awd8bAyC4
         k8B2iQ1xxTaf33jDsBZA44gHd6n6WrL1NGcw2EkAx0hetT/10GOYSibyK0w4dSV53P49
         C/7w==
X-Gm-Message-State: AGi0PuaAtg+XU1R7n1SkEbAEVp0oph+wXZY6OHCD9x5p1m8zoS7CPFKB
        oKDYdIUN79lEuykqfvJjzrw3b7Mbehk=
X-Google-Smtp-Source: APiQypJUrnRM8Ie5Cd30fqcFl5PV4Nsvh4bEOA8rA8JA3YRv7uzzPi2x+gNVN2LSS1vc2Ao7lfEf0w==
X-Received: by 2002:a17:90a:f68d:: with SMTP id cl13mr13019959pjb.107.1587820755679;
        Sat, 25 Apr 2020 06:19:15 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id a22sm8158562pfg.169.2020.04.25.06.19.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Apr 2020 06:19:15 -0700 (PDT)
Date:   Sat, 25 Apr 2020 18:49:08 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: Use the correct style for SPDX License Identifier
Message-ID: <20200425131904.GA9623@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header files related to F2FS File System support.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 fs/f2fs/acl.h     | 2 +-
 fs/f2fs/f2fs.h    | 2 +-
 fs/f2fs/gc.h      | 2 +-
 fs/f2fs/node.h    | 2 +-
 fs/f2fs/segment.h | 2 +-
 fs/f2fs/trace.h   | 2 +-
 fs/f2fs/xattr.h   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/acl.h b/fs/f2fs/acl.h
index b96823c59b15..124868c13f80 100644
--- a/fs/f2fs/acl.h
+++ b/fs/f2fs/acl.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fs/f2fs/acl.h
  *
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0f7753173e19..5c7a499a6d36 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fs/f2fs/f2fs.h
  *
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index bbac9d3787bd..db3c61046aa4 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fs/f2fs/gc.h
  *
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index e05af5df5648..6a2011deea23 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fs/f2fs/node.h
  *
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 7a83bd530812..cba16cca5189 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fs/f2fs/segment.h
  *
diff --git a/fs/f2fs/trace.h b/fs/f2fs/trace.h
index e8075fc5b228..789f6aa727fc 100644
--- a/fs/f2fs/trace.h
+++ b/fs/f2fs/trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * f2fs IO tracer
  *
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index 938fcd20565d..6a192e6c7a9e 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fs/f2fs/xattr.h
  *
-- 
2.17.1

