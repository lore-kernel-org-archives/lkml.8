Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7962AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 21:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 466F721744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 21:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TmMFppo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgGaVVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 17:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgGaVVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 17:21:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BEFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 14:21:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z5so24115825ybo.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 14:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=i/6g5tBqm9jtVTxFQ6mjEF5i7ODAQOG9RPxhHc38Q0E=;
        b=TmMFppo2f1ne0ZzxJly6nu9N02OmXEp4mNiqT8vVmBm3+NL56+GQxl+mihbz32wP1W
         hwZ66L2+AkvTw885iJV/T7c3p7ISQjXJLRBrthFYoJ9KHHb4XitBkBy2NANucPIZ+/na
         FhwLvGi/1i2Lie7kOBBxhPlFxKNZLO6our/44LegiGL/cBQWG4SKIacgwKvJEhu5vouG
         zpo0TSWGsEUFILnGXI1LVyj+R0Ru+LLziZnkxMZx8Sb8+hsZSVl+Zan0GMey9MRCYzlZ
         YvqTae4paQL2l8JfAhHGjqyWBppnsVE26rTt2jqG4MMFoFa32rYRXPjyYu9/vFPNZMhz
         7fcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=i/6g5tBqm9jtVTxFQ6mjEF5i7ODAQOG9RPxhHc38Q0E=;
        b=aVjrvNQIPaddamAdErtw5h3rgh2pfQ/2qwipMeHBCOxkEdE37xNcYzmyCEGCsxIxF3
         9i+NSMF2zXiX/z2d1hji/ucrD/q8zsBqzZG4tuYRCxDLIDu4incVYC/h1hOfTGi37nIS
         43pg4Veza6or8KejhAP0P7im0N+MHwSAuHNIKU2Biu4UgxTVghYaZzk9DaKu9i+iwUXG
         l4uWpRrDLPCOwTSf+vTZhb7dacRgyfqIvhKLaOxjODe1W9S+M/T8gLfq0RWZqM+sTVEg
         I1Zx600gqsuu7cJIysBbDLQmY/LzTNrfgC62WJpXtqWBKOj9pSy+Dxs5SoHafqbbHzwq
         lpBg==
X-Gm-Message-State: AOAM533Nw2MR7/LC/j9WxCcNwE+SHdhs5bm9I3AVMefo8tZdwxQ7OlX3
        2XRgYR9DNAtVQl60aVRazEXEHCiENlM=
X-Google-Smtp-Source: ABdhPJx7zFycBHKJrxQB+dPPxG/GmiWi6UbVG3U9EML9Q2umJYC8G0EXw3Xat+QoFEe0ux9LGWq1pV8p7EE=
X-Received: by 2002:a25:3c4:: with SMTP id 187mr9454202ybd.246.1596230507957;
 Fri, 31 Jul 2020 14:21:47 -0700 (PDT)
Date:   Fri, 31 Jul 2020 14:21:41 -0700
Message-Id: <20200731212141.3709716-1-peskal@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH] gen_compile_commands: Add support for separate kbuild output directory
From:   Peter Kalauskas <peskal@google.com>
To:     tmroeder@google.com
Cc:     linux-kernel@vger.kernel.org, mka@chromium.org,
        Peter Kalauskas <peskal@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for builds that use an output directory different than the
kernel source tree (e.g. make O=/tmp/kernel-obj). This also introduces
support for .cmd files that use absolute paths.

Previously, gen_compile_commands.py only supported builds where the
kernel source tree and the output directory were the same:
 $ make defconfig
 $ make -j32
 $ ./scripts/gen_compile_commands.py

gen_compile_commands.py had flags to support out of tree use, but the
generated compile_commands.json file still assumed that the source tree
and kbuild output directory were the same.

Now, the following cases are supported as well:

 - Absolute output path:
   $ mkdir /tmp/kernel-obj
   $ make O=/tmp/kernel-obj defconfig
   $ make O=/tmp/kernel-obj -j32
   $ ./scripts/gen_compile_commands.py -k /tmp/kernel-obj

 - Relative output path:
   $ mkdir kernel-obj
   $ make O=kernel-obj/ defconfig
   $ make O=kernel-obj/ -j32
   $ ./scripts/gen_compile_commands.py -k kernel-obj

The new argument, -k, is introduced in a way that makes the script
backward compatible with how -d was previously used.

Signed-off-by: Peter Kalauskas <peskal@google.com>
---
 scripts/gen_compile_commands.py | 112 ++++++++++++++++++++++----------
 1 file changed, 77 insertions(+), 35 deletions(-)

diff --git scripts/gen_compile_commands.py scripts/gen_compile_commands.py
index c458696ef3a7..cd3b80bd1942 100755
--- scripts/gen_compile_commands.py
+++ scripts/gen_compile_commands.py
@@ -31,16 +31,24 @@ def parse_arguments():
 
     Returns:
         log_level: A logging level to filter log output.
-        directory: The directory to search for .cmd files.
+        source_directory: The directory of the kernel source tree.
+        kbuild_output_directory: The directory to search for .cmd files.
         output: Where to write the compile-commands JSON file.
     """
     usage = 'Creates a compile_commands.json database from kernel .cmd files'
     parser = argparse.ArgumentParser(description=usage)
 
-    directory_help = ('Path to the kernel source directory to search '
+    directory_help = ('Path to the kernel source directory '
                       '(defaults to the working directory)')
     parser.add_argument('-d', '--directory', type=str, help=directory_help)
 
+    kbuild_output_directory_help = (
+        'Path to the kernel output directory to search for .cmd files '
+        '(defaults to match --directory)')
+    parser.add_argument(
+        '-k', '--kbuild-output-directory', type=str,
+        help=kbuild_output_directory_help)
+
     output_help = ('The location to write compile_commands.json (defaults to '
                    'compile_commands.json in the search directory)')
     parser.add_argument('-o', '--output', type=str, help=output_help)
@@ -58,58 +66,91 @@ def parse_arguments():
     if log_level not in _VALID_LOG_LEVELS:
         raise ValueError('%s is not a valid log level' % log_level)
 
-    directory = args.directory or os.getcwd()
-    output = args.output or os.path.join(directory, _DEFAULT_OUTPUT)
-    directory = os.path.abspath(directory)
+    source_directory = args.directory or os.getcwd()
+    kbuild_output_directory = args.kbuild_output_directory or source_directory
+    output = args.output or os.path.join(source_directory, _DEFAULT_OUTPUT)
+    source_directory = os.path.abspath(source_directory)
+    kbuild_output_directory = os.path.abspath(kbuild_output_directory)
 
-    return log_level, directory, output
+    return log_level, source_directory, kbuild_output_directory, output
 
 
-def process_line(root_directory, file_directory, command_prefix, relative_path):
+def process_line(src_dir, kbuild_out_dir, file_dir, cmd_prefix, file_path):
     """Extracts information from a .cmd line and creates an entry from it.
 
     Args:
-        root_directory: The directory that was searched for .cmd files. Usually
+        src_dir: The directory of the kernel source tree.
+        kbuild_out_dir: The directory that was searched for .cmd files. Usually
             used directly in the "directory" entry in compile_commands.json.
-        file_directory: The path to the directory the .cmd file was found in.
-        command_prefix: The extracted command line, up to the last element.
-        relative_path: The .c file from the end of the extracted command.
-            Usually relative to root_directory, but sometimes relative to
-            file_directory and sometimes neither.
+        file_dir: The path to the directory the .cmd file was found in.
+        cmd_prefix: The extracted command line, up to the last element.
+        file_path: The .c file from the end of the extracted command.
+            Usually relative to kbuild_out_dir, but sometimes relative to
+            src_dir and sometimes neither.
 
     Returns:
         An entry to append to compile_commands.
 
     Raises:
-        ValueError: Could not find the extracted file based on relative_path and
-            root_directory or file_directory.
+        ValueError: Could not find the extracted file.
     """
     # The .cmd files are intended to be included directly by Make, so they
     # escape the pound sign '#', either as '\#' or '$(pound)' (depending on the
-    # kernel version). The compile_commands.json file is not interepreted
+    # kernel version). The compile_commands.json file is not interpreted
     # by Make, so this code replaces the escaped version with '#'.
-    prefix = command_prefix.replace('\#', '#').replace('$(pound)', '#')
-
-    cur_dir = root_directory
-    expected_path = os.path.join(cur_dir, relative_path)
-    if not os.path.exists(expected_path):
-        # Try using file_directory instead. Some of the tools have a different
-        # style of .cmd file than the kernel.
-        cur_dir = file_directory
-        expected_path = os.path.join(cur_dir, relative_path)
+    prefix = cmd_prefix.replace('\#', '#').replace('$(pound)', '#')
+
+    # Compile commands are usually run in the top level of the kbuild output
+    # directory
+    working_dir = kbuild_out_dir
+
+    if os.path.isabs(file_path):
+        # This is the most common case when the kbuild output directory is
+        # outside the kernel source tree (e.g. cd src/linux;
+        # make O=/tmp/kernel-obj). In this case, the command is run in
+        # kbuild_out_dir, and file_path is an absolute path to the file being
+        # compiled.
+        if not os.path.exists(file_path):
+            raise ValueError('File %s does not exist' % file_path)
+    else:
+        # Otherwise, try to locate the file using its relative path.
+        #
+        # First, check for the file relative to kbuild_out_dir. This is the most
+        # common case when output directory is the same as the kernel source
+        # directory, or if the output directory is specified using a relative
+        # path (e.g. make, or make O=kernel-obj/)
+        expected_path = os.path.join(kbuild_out_dir, file_path)
+
         if not os.path.exists(expected_path):
-            raise ValueError('File %s not in %s or %s' %
-                             (relative_path, root_directory, file_directory))
+            # Try using file_dir instead. Some of the tools have a different
+            # style of .cmd file than the kernel. In this case, the command is
+            # run in a subdirectory of the kernel source tree. The subdirectory
+            # will match the directory the cmd file was found in (e.g.
+            # /tmp/kernel-obj/tools/objtool/.weak.o.cmd contains a command
+            # that's run in src/linux/tools/objtool/)
+
+            # Translate file_dir to a relative path, and use the relative path
+            # to locate where in the kernel source tree the command may have
+            # been executed.
+            relative_file_dir = os.path.relpath(file_dir, kbuild_out_dir)
+            working_dir = os.path.join(src_dir, relative_file_dir)
+            expected_path = os.path.join(working_dir, file_path)
+
+            if not os.path.exists(expected_path):
+                # At this point, failures are often from tools/objtool/
+                # and tools/lib/subcmd/
+                raise ValueError('File %s not in %s or %s' %
+                                 (file_path, kbuild_out_dir, file_dir))
     return {
-        'directory': cur_dir,
-        'file': relative_path,
-        'command': prefix + relative_path,
+        'directory': working_dir,
+        'file': file_path,
+        'command': prefix + file_path,
     }
 
 
 def main():
     """Walks through the directory and finds and parses .cmd files."""
-    log_level, directory, output = parse_arguments()
+    log_level, src_dir, kbuild_out_dir, out_file = parse_arguments()
 
     level = getattr(logging, log_level)
     logging.basicConfig(format='%(levelname)s: %(message)s', level=level)
@@ -118,7 +159,7 @@ def main():
     line_matcher = re.compile(_LINE_PATTERN)
 
     compile_commands = []
-    for dirpath, _, filenames in os.walk(directory):
+    for dirpath, _, filenames in os.walk(kbuild_out_dir):
         for filename in filenames:
             if not filename_matcher.match(filename):
                 continue
@@ -131,14 +172,15 @@ def main():
                         continue
 
                     try:
-                        entry = process_line(directory, dirpath,
-                                             result.group(1), result.group(2))
+                        entry = process_line(src_dir, kbuild_out_dir,
+                                             dirpath, result.group(1),
+                                             result.group(2))
                         compile_commands.append(entry)
                     except ValueError as err:
                         logging.info('Could not add line from %s: %s',
                                      filepath, err)
 
-    with open(output, 'wt') as f:
+    with open(out_file, 'wt') as f:
         json.dump(compile_commands, f, indent=2, sort_keys=True)
 
     count = len(compile_commands)
-- 
2.28.0.163.g6104cc2f0b6-goog

