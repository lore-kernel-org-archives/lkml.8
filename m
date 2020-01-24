Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09276C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D648A214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388325AbgAXPR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:17:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387690AbgAXPR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:17:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7568821556;
        Fri, 24 Jan 2020 15:17:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1iv0i5-000qEC-DN; Fri, 24 Jan 2020 10:17:25 -0500
Message-Id: <20200124151725.301018939@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 24 Jan 2020 10:16:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 07/14] Documentation: bootconfig: Fix typos in bootconfig documentation
References: <20200124151651.852781301@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Fix typos in bootconfig.rst according to Randy's suggestions.

Link: http://lkml.kernel.org/r/157949059219.25888.16939971423610233631.stgit@devnote2

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/admin-guide/bootconfig.rst | 32 +++++++++++++-----------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index c8f7cd4cf44e..4d617693c0c8 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -11,20 +11,22 @@ Boot Configuration
 Overview
 ========
 
-The boot configuration is expanding current kernel cmdline to support
-additional key-value data when boot the kernel in an efficient way.
-This allows adoministrators to pass a structured-Key config file.
+The boot configuration expands the current kernel command line to support
+additional key-value data when booting the kernel in an efficient way.
+This allows administrators to pass a structured-Key config file.
 
 Config File Syntax
 ==================
 
 The boot config syntax is a simple structured key-value. Each key consists
-of dot-connected-words, and key and value are connected by "=". The value
+of dot-connected-words, and key and value are connected by ``=``. The value
 has to be terminated by semi-colon (``;``) or newline (``\n``).
 For array value, array entries are separated by comma (``,``). ::
 
 KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
 
+Unlike the kernel command line syntax, spaces are OK around the comma and ``=``.
+
 Each key word must contain only alphabets, numbers, dash (``-``) or underscore
 (``_``). And each value only contains printable characters or spaces except
 for delimiters such as semi-colon (``;``), new-line (``\n``), comma (``,``),
@@ -35,7 +37,7 @@ quotes (``"VALUE"``) or single-quotes (``'VALUE'``) to quote it. Note that
 you can not escape these quotes.
 
 There can be a key which doesn't have value or has an empty value. Those keys
-are used for checking the key exists or not (like a boolean).
+are used for checking if the key exists or not (like a boolean).
 
 Key-Value Syntax
 ----------------
@@ -63,7 +65,7 @@ at boot time. So you can append similar trees or key-values.
 Comments
 --------
 
-The config syntax accepts shell-script style comments. The comments start
+The config syntax accepts shell-script style comments. The comments starting
 with hash ("#") until newline ("\n") will be ignored.
 
 ::
@@ -108,7 +110,7 @@ update the boot loader and the kernel image itself.
 
 To do this operation, Linux kernel provides "bootconfig" command under
 tools/bootconfig, which allows admin to apply or delete the config file
-to/from initrd image. You can build it by follwoing command::
+to/from initrd image. You can build it by the following command::
 
  # make -C tools/bootconfig
 
@@ -122,7 +124,7 @@ To remove the config from the image, you can use -d option as below::
  # tools/bootconfig/bootconfig -d /boot/initrd.img-X.Y.Z
 
 
-C onfig File Limitation
+Config File Limitation
 ======================
 
 Currently the maximum config size size is 32KB and the total key-words (not
@@ -145,10 +147,10 @@ User can query or loop on key-value pairs, also it is possible to find
 a root (prefix) key node and find key-values under that node.
 
 If you have a key string, you can query the value directly with the key
-using xbc_find_value(). If you want to know what keys exist in the SKC
-tree, you can use xbc_for_each_key_value() to iterate key-value pairs.
+using xbc_find_value(). If you want to know what keys exist in the boot
+config, you can use xbc_for_each_key_value() to iterate key-value pairs.
 Note that you need to use xbc_array_for_each_value() for accessing
-each arraies value, e.g.::
+each array's value, e.g.::
 
  vnode = NULL;
  xbc_find_value("key.word", &vnode);
@@ -157,8 +159,8 @@ each arraies value, e.g.::
       printk("%s ", value);
     }
 
-If you want to focus on keys which has a prefix string, you can use
-xbc_find_node() to find a node which prefix key words, and iterate
+If you want to focus on keys which have a prefix string, you can use
+xbc_find_node() to find a node by the prefix string, and iterate
 keys under the prefix node with xbc_node_for_each_key_value().
 
 But the most typical usage is to get the named value under prefix
@@ -174,8 +176,8 @@ or get the named array under prefix as below::
 This accesses a value of "key.prefix.option" and an array of
 "key.prefix.array-option".
 
-Locking is not needed, since after initialized, the config becomes readonly.
-All data and keys must be copied if you need to modify it.
+Locking is not needed, since after initialization, the config becomes
+read-only. All data and keys must be copied if you need to modify it.
 
 
 Functions and structures
-- 
2.24.1


