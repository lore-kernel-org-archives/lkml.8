Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2673C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F5F2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgBRNgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 08:36:15 -0500
Received: from 11.mo1.mail-out.ovh.net ([188.165.48.29]:40429 "EHLO
        11.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgBRNgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:36:15 -0500
X-Greylist: delayed 1793 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Feb 2020 08:36:13 EST
Received: from player779.ha.ovh.net (unknown [10.108.42.174])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id 28E691AFCCC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 14:00:57 +0100 (CET)
Received: from sk2.org (cre33-1_migr-88-122-126-116.fbx.proxad.net [88.122.126.116])
        (Authenticated sender: steve@sk2.org)
        by player779.ha.ovh.net (Postfix) with ESMTPSA id 4B9ACF77764B;
        Tue, 18 Feb 2020 13:00:51 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2 7/8] docs: add a script to check sysctl docs
Date:   Tue, 18 Feb 2020 13:59:22 +0100
Message-Id: <20200218125923.685-8-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218125923.685-1-steve@sk2.org>
References: <20200218125923.685-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16143434340172320133
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrjeekgdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucfkpheptddrtddrtddrtddpkeekrdduvddvrdduvdeirdduudeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This script allows sysctl documentation to be checked against the
kernel source code, to identify missing or obsolete entries. Running
it against 5.5 shows for example that sysctl/kernel.rst has two
obsolete entries and is missing 52 entries.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/admin-guide/sysctl/kernel.rst |   3 +
 scripts/check-sysctl-docs                   | 181 ++++++++++++++++++++
 2 files changed, 184 insertions(+)
 create mode 100755 scripts/check-sysctl-docs

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index a67c218c4066..3d21e076aea4 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -2,6 +2,9 @@
 Documentation for /proc/sys/kernel/
 ===================================
 
+.. See scripts/check-sysctl-docs to keep this up to date
+
+
 Copyright (c) 1998, 1999,  Rik van Riel <riel@nl.linux.org>
 
 Copyright (c) 2009,        Shen Feng<shen@cn.fujitsu.com>
diff --git a/scripts/check-sysctl-docs b/scripts/check-sysctl-docs
new file mode 100755
index 000000000000..b3b47c188a2d
--- /dev/null
+++ b/scripts/check-sysctl-docs
@@ -0,0 +1,181 @@
+#!/usr/bin/gawk -f
+# SPDX-License-Identifier: GPL-2.0-only
+
+# Script to check sysctl documentation against source files
+#
+# Copyright © 2020 Stephen Kitt
+
+# Example invocation:
+#	scripts/check-sysctl-docs -vtable="kernel" \
+#		Documentation/admin-guide/sysctl/kernel.rst \
+#		$(git grep -l register_sysctl_table)
+#
+# Specify -vdebug=1 to see debugging information
+
+BEGIN {
+    if (!table) {
+	print "Please specify the table to look for using the table variable" > "/dev/stderr"
+	exit 1
+    }
+}
+
+# The following globals are used:
+# children: maps ctl_table names and procnames to child ctl_table names
+# documented: maps documented entries (each key is an entry)
+# entries: maps ctl_table names and procnames to counts (so
+#          enumerating the subkeys for a given ctl_table lists its
+#          procnames)
+# files: maps procnames to source file names
+# paths: maps ctl_path names to paths
+# curpath: the name of the current ctl_path struct
+# curtable: the name of the current ctl_table struct
+# curentry: the name of the current proc entry (procname when parsing
+#           a ctl_table, constructed path when parsing a ctl_path)
+
+
+# Remove punctuation from the given value
+function trimpunct(value) {
+    while (value ~ /^["&]/) {
+	value = substr(value, 2)
+    }
+    while (value ~ /[]["&,}]$/) {
+	value = substr(value, 1, length(value) - 1)
+    }
+    return value
+}
+
+# Print the information for the given entry
+function printentry(entry) {
+    seen[entry]++
+    printf "* %s from %s", entry, file[entry]
+    if (documented[entry]) {
+	printf " (documented)"
+    }
+    print ""
+}
+
+
+# Stage 1: build the list of documented entries
+FNR == NR && /^=+$/ {
+    if (prevline ~ /Documentation for/) {
+	# This is the main title
+	next
+    }
+
+    # The previous line is a section title, parse it
+    $0 = prevline
+    if (debug) print "Parsing " $0
+    inbrackets = 0
+    for (i = 1; i <= NF; i++) {
+	if (length($i) == 0) {
+	    continue
+	}
+	if (!inbrackets && substr($i, 1, 1) == "(") {
+	    inbrackets = 1
+	}
+	if (!inbrackets) {
+	    token = trimpunct($i)
+	    if (length(token) > 0 && token != "and") {
+		if (debug) print trimpunct($i)
+		documented[trimpunct($i)]++
+	    }
+	}
+	if (inbrackets && substr($i, length($i), 1) == ")") {
+	    inbrackets = 0
+	}
+    }
+}
+
+FNR == NR {
+    prevline = $0
+    next
+}
+
+
+# Stage 2: process each file and find all sysctl tables
+BEGINFILE {
+    delete children
+    delete entries
+    delete paths
+    curpath = ""
+    curtable = ""
+    curentry = ""
+    if (debug) print "Processing file " FILENAME
+}
+
+/^static struct ctl_path/ {
+    match($0, /static struct ctl_path ([^][]+)/, tables)
+    curpath = tables[1]
+    if (debug) print "Processing path " curpath
+}
+
+/^static struct ctl_table/ {
+    match($0, /static struct ctl_table ([^][]+)/, tables)
+    curtable = tables[1]
+    if (debug) print "Processing table " curtable
+}
+
+/^};$/ {
+    curpath = ""
+    curtable = ""
+    curentry = ""
+}
+
+curpath && /\.procname[\t ]*=[\t ]*".+"/ {
+    match($0, /.procname[\t ]*=[\t ]*"([^"]+)"/, names)
+    if (curentry) {
+	curentry = curentry "/" names[1]
+    } else {
+	curentry = names[1]
+    }
+    if (debug) print "Setting path " curpath " to " curentry
+    paths[curpath] = curentry
+}
+
+curtable && /\.procname[\t ]*=[\t ]*".+"/ {
+    match($0, /.procname[\t ]*=[\t ]*"([^"]+)"/, names)
+    curentry = names[1]
+    if (debug) print "Adding entry " curentry " to table " curtable
+    entries[curtable][curentry]++
+    file[curentry] = FILENAME
+}
+
+/\.child[\t ]*=/ {
+    child = trimpunct($NF)
+    if (debug) print "Linking child " child " to table " curtable " entry " curentry
+    children[curtable][curentry] = child
+}
+
+/register_sysctl_table\(.*\)/ {
+    match($0, /register_sysctl_table\(([^)]+)\)/, tables)
+    if (debug) print "Registering table " tables[1]
+    if (children[tables[1]][table]) {
+	for (entry in entries[children[tables[1]][table]]) {
+	    printentry(entry)
+	}
+    }
+}
+
+/register_sysctl_paths\(.*\)/ {
+    match($0, /register_sysctl_paths\(([^)]+), ([^)]+)\)/, tables)
+    if (debug) print "Attaching table " tables[2] " to path " tables[1]
+    if (paths[tables[1]] == table) {
+	for (entry in entries[tables[2]]) {
+	    printentry(entry)
+	}
+    }
+    split(paths[tables[1]], components, "/")
+    if (length(components) > 1 && components[1] == table) {
+	# Count the first subdirectory as seen
+	seen[components[2]]++
+    }
+}
+
+
+END {
+    for (entry in documented) {
+	if (!seen[entry]) {
+	    print "No implementation for " entry
+	}
+    }
+}
-- 
2.20.1

