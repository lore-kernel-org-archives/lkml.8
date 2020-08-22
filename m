Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E83AC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 14:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB7542078D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 14:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598108288;
	bh=RrzpRfmgtD7P1y4aujWiCzCuDDtkcATAv6yS7R2jfjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=by0izx0xRICk0A0I5esNVOmcwe11AQRWNTHWzOOrR+g8tcHAMa3gpjCLt95n1XE81
	 dsk87qNDRrrPk0TFCnXbNn5lU8RBpd/o0vTdQtVTPY7kSWBslg7TV43IbXdf36jmoW
	 Z4RCaURRyHBAcgJp6SJ/8RfeMN1vgEzhxSd2Q2YE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgHVO56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 10:57:58 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:47438 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbgHVO5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 10:57:13 -0400
Received: from oscar.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 07MEuKVY025434;
        Sat, 22 Aug 2020 23:56:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 07MEuKVY025434
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1598108188;
        bh=gGF1fPLTpTUcjBBymKMSRSRXlTzNhlWRVku6EwQu2/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C9+Lh+l4D0h2JrO7yHcAGRans6Y85EQbBH9Oy6eIepJkRn2DY2tvHqhB2EFgc6k9/
         Zf2Xo61a4gZ4nGv0tGbLTLY6xrsFJSBH+PU060XcXNI+IX7otMrluh+VIb9ZDGuAn3
         sPXZXVK6WiDlbSat15k8Nh1K2oa8PSW8XUMUkcC5XC547DDX5YKqWzzGRsk5TSE9r8
         k9XG6LQYypfLjJ8D5suTW1coFqrsM116apQzvG6LvgBBIq/XVtBBiyhoi8YTfjgyDk
         fmW7TyuI8b4BMnZX5Ki6liaZ/h8VtJpIYeEhXj9sbF9ODyBw9IHCmeOGjgx6ZZDpLx
         iTU8NTzd2GN0g==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Roeder <tmroeder@google.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/10] gen_compile_commands: remove the warning about too few .cmd files
Date:   Sat, 22 Aug 2020 23:56:17 +0900
Message-Id: <20200822145618.1222514-10-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200822145618.1222514-1-masahiroy@kernel.org>
References: <20200822145618.1222514-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This warning was useful when users previously needed to manually
build the kernel and run this script.

Now you can simply do 'make compile_commands.json', which updates
all the necessary build artifacts and automatically creates the
compilation database. There is no more worry for a mistake like
"Oh, I forgot to build the kernel".

Now, this warning is rather annoying.

You can create compile_commands.json for an external module:

  $ make M=/path/to/your/external/module compile_commands.json

Then, this warning is displayed since there are usually less than
300 files in a single module.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v3:
  - New patch

 scripts/gen_compile_commands.py | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index f370375b2f70..1de745577e6d 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -21,11 +21,6 @@ _FILENAME_PATTERN = r'^\..*\.cmd$'
 _LINE_PATTERN = r'^cmd_[^ ]*\.o := (.* )([^ ]*\.c)$'
 _VALID_LOG_LEVELS = ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL']
 
-# A kernel build generally has over 2000 entries in its compile_commands.json
-# database. If this code finds 300 or fewer, then warn the user that they might
-# not have all the .cmd files, and they might need to compile the kernel.
-_LOW_COUNT_THRESHOLD = 300
-
 
 def parse_arguments():
     """Sets up and parses command-line arguments.
@@ -236,11 +231,6 @@ def main():
     with open(output, 'wt') as f:
         json.dump(compile_commands, f, indent=2, sort_keys=True)
 
-    count = len(compile_commands)
-    if count < _LOW_COUNT_THRESHOLD:
-        logging.warning(
-            'Found %s entries. Have you compiled the kernel?', count)
-
 
 if __name__ == '__main__':
     main()
-- 
2.25.1

