Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97647C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69C732075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598036607;
	bh=OxxODlaBZhAq+4BoFGtzeAOFDFghljs6LHnF4hlclzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vetgo0x7gaVESm+uYkN36W6rRYqIlF++y8GNy3DBT0ATkfhs8UhHXu/dWWQZN9xI2
	 cfVimVDl2UzVc5eMfEYxI7v9LS1E+BTqCz88DzHDXMhMpl427EE11+EDYM6vcCmhj0
	 1YchRY7ubNcrNSzCEXxEJx9MpU38iKtUYFtZ0efk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHUTDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:03:25 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:62788 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgHUTCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:02:54 -0400
Received: from oscar.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 07LJ23eW027595;
        Sat, 22 Aug 2020 04:02:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 07LJ23eW027595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1598036527;
        bh=mg0M4bAejUOuEVILMgIjbEef+kFqOFGf8lqJ8WZirB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=llJj/4JUV1O9m1gvCaXK72idAQ40EKl7Tmu8UsrlZrFSn61y0ZV7ZgT+5VxnqdjwB
         Zj2B/FG9/35+AFcDrk0TyMxq05SxCGDe0cOgiPW4gurpPdEpgqtezYmxHrWb3eXWRd
         Mz31RPgyN/OEzZm5cRtFtmDnNfgQp4u2wS/cOEGmtbOffaVwRNSF+fWtF9OdJisnjV
         YEGRXRAfLh9NMIA2gGcB8L2X+s+yL8Clpsy9dfGBcf39+2cJBZMCMTJDw7RHVry0/4
         zTJPCfZMKjMYTsznIMvmX9hjZZCZWVGUeoihWi0sk2xXhwg8+0Q1SZ3QwYnzxQztkt
         2dBb4V14G6/nw==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Roeder <tmroeder@google.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] gen_compile_commands: reword the help message of -d option
Date:   Sat, 22 Aug 2020 04:01:54 +0900
Message-Id: <20200821190159.1033740-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821190159.1033740-1-masahiroy@kernel.org>
References: <20200821190159.1033740-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think the help message of the -d option is somewhat misleading.

  Path to the kernel source directory to search (defaults to the working directory)

The part "kernel source directory" is the source of the confusion.
Some people misunderstand as if this script did not support separate
output directories.

Actually, this script also works for out-of-tree builds. You can
use the -d option to point to the object output directory, not to
the source directory. It should match to the O= option used in the
previous kernel build, and then appears in the "directory" field of
compile_commands.json.

Reword the help message.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - New patch

 scripts/gen_compile_commands.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index 1b9899892d99..5f6318da01a2 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -31,13 +31,13 @@ def parse_arguments():
 
     Returns:
         log_level: A logging level to filter log output.
-        directory: The directory to search for .cmd files.
+        directory: The work directory where the objects were built
         output: Where to write the compile-commands JSON file.
     """
     usage = 'Creates a compile_commands.json database from kernel .cmd files'
     parser = argparse.ArgumentParser(description=usage)
 
-    directory_help = ('Path to the kernel source directory to search '
+    directory_help = ('specify the output directory used for the kernel build '
                       '(defaults to the working directory)')
     parser.add_argument('-d', '--directory', type=str, help=directory_help)
 
-- 
2.25.1

