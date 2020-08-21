Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF260C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD01420738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598036614;
	bh=p+zJsDjR4SP7DhiBXUof0cVW54VN6X5d90+Lt5fVszM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QDXRwPUqv4iVxJK3LVndkiZc2BR33Ss0rAOXMkT5zJ3q9Yv8+XJvKXTECJeLEodtP
	 yKTk4D2veeVd/yHDreLKWZYouHdt3phPLQLYaFzjF5gsnL+40PboLzXuRTq17JEhzz
	 ykdjq5i2pAjQ/uX063u/vkypPhQVt6IGRTaWsiWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHUTDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:03:33 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:62786 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHUTCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:02:54 -0400
Received: from oscar.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 07LJ23eY027595;
        Sat, 22 Aug 2020 04:02:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 07LJ23eY027595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1598036528;
        bh=3PUSp7mVBqud9anwd0ucZBfkurt/2z7oLee7GQu34i8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kc68fjPEb+zFm8L/7ee629y34L35PVghuM7M0EXEFkfIWkRnXZ4FDNrWqVaTqSDAp
         PVBoUnzdZKado9qH6wX4RkqECQXKFjcomS55/PmekmIRzsic3VgH37DhMxcEFLr8GJ
         cqy7gGI32nzCfSpnQWffgEJslr4VGmdeC71m6yuweoIQkP7f/hVGODzkgcdOBjBwuy
         91RWRKRB+57FP6uIsaMLdtPXx+zm40jkMK32ZWScKlNA6kpw9dTb275y2/51uwOcU3
         PXLq/z9Pz8W1AafAG8H9eNcMQKJ/a5+hB1HXakEPGL5CYQ1iQrQuYWKySps1RnF1/j
         f0kjHh1sN5OKw==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Roeder <tmroeder@google.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] gen_compile_commands: move directory walk to a generator function
Date:   Sat, 22 Aug 2020 04:01:56 +0900
Message-Id: <20200821190159.1033740-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821190159.1033740-1-masahiroy@kernel.org>
References: <20200821190159.1033740-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, this script walks under the specified directory (default to
the current directory), then parses all .cmd files found.

Split it into a separate helper function because the next commit will
add more helpers to pick up .cmd files associated with given file(s).

There is no point to build and return a huge list at once. I used a
generator so it works in the for-loop with less memory.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - New patch

 scripts/gen_compile_commands.py | 44 ++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index 3ed958b64658..6dec7e2c4098 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -33,6 +33,7 @@ def parse_arguments():
         log_level: A logging level to filter log output.
         directory: The work directory where the objects were built
         output: Where to write the compile-commands JSON file.
+        paths: The list of directories to handle to find .cmd files
     """
     usage = 'Creates a compile_commands.json database from kernel .cmd files'
     parser = argparse.ArgumentParser(description=usage)
@@ -56,7 +57,28 @@ def parse_arguments():
 
     return (args.log_level,
             os.path.abspath(args.directory),
-            args.output)
+            args.output,
+            [args.directory])
+
+
+def cmdfiles_in_dir(directory):
+    """Generate the iterator of .cmd files found under the directory.
+
+    Walk under the given directory, and yield every .cmd file found.
+
+    Args:
+        directory: The directory to search for .cmd files.
+
+    Yields:
+        The path to a .cmd file.
+    """
+
+    filename_matcher = re.compile(_FILENAME_PATTERN)
+
+    for dirpath, _, filenames in os.walk(directory):
+        for filename in filenames:
+            if filename_matcher.match(filename):
+                yield os.path.join(dirpath, filename)
 
 
 def process_line(root_directory, command_prefix, file_path):
@@ -94,31 +116,29 @@ def process_line(root_directory, command_prefix, file_path):
 
 def main():
     """Walks through the directory and finds and parses .cmd files."""
-    log_level, directory, output = parse_arguments()
+    log_level, directory, output, paths = parse_arguments()
 
     level = getattr(logging, log_level)
     logging.basicConfig(format='%(levelname)s: %(message)s', level=level)
 
-    filename_matcher = re.compile(_FILENAME_PATTERN)
     line_matcher = re.compile(_LINE_PATTERN)
 
     compile_commands = []
-    for dirpath, _, filenames in os.walk(directory):
-        for filename in filenames:
-            if not filename_matcher.match(filename):
-                continue
-            filepath = os.path.join(dirpath, filename)
 
-            with open(filepath, 'rt') as f:
+    for path in paths:
+        cmdfiles = cmdfiles_in_dir(path)
+
+        for cmdfile in cmdfiles:
+            with open(cmdfile, 'rt') as f:
                 result = line_matcher.match(f.readline())
                 if result:
                     try:
-                        entry = process_line(directory,
-                                             result.group(1), result.group(2))
+                        entry = process_line(directory, result.group(1),
+                                             result.group(2))
                         compile_commands.append(entry)
                     except ValueError as err:
                         logging.info('Could not add line from %s: %s',
-                                     filepath, err)
+                                     cmdfile, err)
 
     with open(output, 'wt') as f:
         json.dump(compile_commands, f, indent=2, sort_keys=True)
-- 
2.25.1

