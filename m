Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B67C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 21:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D64E1206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 21:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgHPV7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 17:59:02 -0400
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:52998 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728057AbgHPV7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 17:59:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 8CB7A837F24F;
        Sun, 16 Aug 2020 21:58:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bikes71_300276427011
X-Filterd-Recvd-Size: 4266
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sun, 16 Aug 2020 21:58:58 +0000 (UTC)
Message-ID: <3e4a895e7c25e37c0f4727b960b7abdcf0752cbb.camel@perches.com>
Subject: [PATCH] dynamic_debug: Allow kbasename(file) to be output using 'F'
From:   Joe Perches <joe@perches.com>
To:     Jason Baron <jbaron@akamai.com>
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 16 Aug 2020 14:58:57 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow emitting kbasename(file) in the dynamic debug prefix
content before each pr_debug output using flag 'F'.

Update the docs too.

Signed-off-by: Joe Perches <joe@perches.com>
---

fs/ceph uses this, so might as well allow it in dynamic_debug.

Seems harmless enough.

 Documentation/admin-guide/dynamic-debug-howto.rst | 13 +++++++++----
 include/linux/dynamic_debug.h                     |  1 +
 lib/dynamic_debug.c                               |  4 ++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index e5a8def45f3f..31bf6b6a03ca 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -229,20 +229,25 @@ of the characters::
 The flags are::
 
   p    enables the pr_debug() callsite.
+  t    Include thread ID in messages not generated from interrupt context
+  m    Include module name in the printed message
+  F    Include kbasename(file) (file path after the last forward slash)
+       in the printed message
   f    Include the function name in the printed message
   l    Include line number in the printed message
-  m    Include module name in the printed message
-  t    Include thread ID in messages not generated from interrupt context
   _    No flags are set. (Or'd with others on input)
 
 For ``print_hex_dump_debug()`` and ``print_hex_dump_bytes()``, only ``p`` flag
 have meaning, other flags ignored.
 
+A maximum of 64 characters of the above selected content is output.
+If enabled, these are output in the order listed above.
+
 For display, the flags are preceded by ``=``
 (mnemonic: what the flags are currently equal to).
 
-Note the regexp ``^[-+=][flmpt_]+$`` matches a flags specification.
-To clear all flags at once, use ``=_`` or ``-flmpt``.
+Note the regexp ``^[-+=][Fflmpt_]+$`` matches a flags specification.
+To clear all flags at once, use ``=_`` or ``-Fflmpt``.
 
 
 Debug messages during Boot Process
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index aa9ff9e1c0b3..f1d9209c2adc 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -32,6 +32,7 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
+#define _DPRINTK_FLAGS_INCL_FILENAME	(1<<5)
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
 #else
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 1d012e597cc3..5c4b3d0a4c6f 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -86,6 +86,7 @@ static inline const char *trim_prefix(const char *path)
 static struct { unsigned flag:8; char opt_char; } opt_array[] = {
 	{ _DPRINTK_FLAGS_PRINT, 'p' },
 	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
+	{ _DPRINTK_FLAGS_INCL_FILENAME, 'F' },
 	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
 	{ _DPRINTK_FLAGS_INCL_LINENO, 'l' },
 	{ _DPRINTK_FLAGS_INCL_TID, 't' },
@@ -586,6 +587,9 @@ static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 	if (desc->flags & _DPRINTK_FLAGS_INCL_MODNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				desc->modname);
+	if (desc->flags & _DPRINTK_FLAGS_INCL_FILENAME)
+		pos += snprintf(buf + pos, remaining(pos), "%s:",
+				kbasename(desc->filename));
 	if (desc->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				desc->function);

