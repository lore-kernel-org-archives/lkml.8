Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC2CC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 14:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0802E207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 14:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598108257;
	bh=5yk1kkRJMSsDhsOA+5w1pBH7nd2PwF2x0bjMlmbYyfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zuM3cPmiABMJB+wVjJeb7qYaYqRN3qQKYzwCHuoUKxZd2DEiFth6naMrVvU3IQIaR
	 zuaO594ito+p0dMsfZEunini9R6CQeFlGBo/LiN8z1U6/oQ2Zr6D8qK2hs+K0NQUbW
	 j50HF8QA06yF7H1RJnAOEi/BENbNcXpZP7EvZLaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgHVO5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 10:57:22 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:47410 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgHVO5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 10:57:12 -0400
Received: from oscar.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 07MEuKVR025434;
        Sat, 22 Aug 2020 23:56:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 07MEuKVR025434
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1598108182;
        bh=IBZFRCC+dauuYn3v7p0fADfhiey+2jMphRtB7L0P/CE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Qp4fqRO02umY4vHVytB6cc/5LxtS7YxrjgHlW2Pw96JvedtvpxUsG3mN7ouGROnM
         1sKl0QngqSf0hMA6M6W9ciUUS+q3vrftp7gDLNs6I+E8w0xODDv5bPZFgYZi/IQPrw
         czf9dQRG3is6Ekd94pxyTgbvk0Tsh8TdKRkzjS+pxROA5DmpFNYhREqoA7swV8bvsD
         cYfeIsva7JL47SGTBA0hQDhWtGmPUcT9A/0rui1i67MIiwopZPAlWn9Fh7TFl9BG+z
         S/rO0GEn8owjS7SfEAq737gVbH/Of/C5OBYiTyik3MoKtWZtmbKugTQHgW6kjLNEhf
         1m+7PY06fHuVw==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Roeder <tmroeder@google.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/10] gen_compile_commands: use choices for --log_levels option
Date:   Sat, 22 Aug 2020 23:56:10 +0900
Message-Id: <20200822145618.1222514-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200822145618.1222514-1-masahiroy@kernel.org>
References: <20200822145618.1222514-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'choices' instead of the own code to check if the given parameter
is valid.

I also simplified the help message because, with 'choices', --help
shows the list of valid parameters:

  --log_level {DEBUG,INFO,WARNING,ERROR,CRITICAL}

I started the help message with a lower case, "the level of log ..."
in order to be consistent with the -h option:

  -h, --help            show this help message and exit

The message "show this help ..." comes from the ArgumentParser library
code, and I do not know how to change it. So, I changed our code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

(no changes since v2)

Changes in v2:
  - New patch

 scripts/gen_compile_commands.py | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index 1bcf33a93cb9..535248cf2d7e 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -45,24 +45,18 @@ def parse_arguments():
                    'compile_commands.json in the search directory)')
     parser.add_argument('-o', '--output', type=str, help=output_help)
 
-    log_level_help = ('The level of log messages to produce (one of ' +
-                      ', '.join(_VALID_LOG_LEVELS) + '; defaults to ' +
+    log_level_help = ('the level of log messages to produce (defaults to ' +
                       _DEFAULT_LOG_LEVEL + ')')
-    parser.add_argument(
-        '--log_level', type=str, default=_DEFAULT_LOG_LEVEL,
-        help=log_level_help)
+    parser.add_argument('--log_level', choices=_VALID_LOG_LEVELS,
+                        default=_DEFAULT_LOG_LEVEL, help=log_level_help)
 
     args = parser.parse_args()
 
-    log_level = args.log_level
-    if log_level not in _VALID_LOG_LEVELS:
-        raise ValueError('%s is not a valid log level' % log_level)
-
     directory = args.directory or os.getcwd()
     output = args.output or os.path.join(directory, _DEFAULT_OUTPUT)
     directory = os.path.abspath(directory)
 
-    return log_level, directory, output
+    return args.log_level, directory, output
 
 
 def process_line(root_directory, file_directory, command_prefix, relative_path):
-- 
2.25.1

