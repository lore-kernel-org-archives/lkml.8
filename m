Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C6CC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 14:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C10AC207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 14:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598108316;
	bh=4ljmxDjZ6NN9Cod5PD3WwfQrZr4wIAWG8YJxHM7brf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zkj8HsZhYX87jJuAoJLUHhIXyDTFeHaWW/OfN006CZHQyoELcHTTbokjRSA34rNVD
	 hUitMoamf5BLc9YuxgIsmnAYC72/9A5twfEY3OR9T6LFiNXhlV0PuiCU+KqY6pnbX8
	 x1K4ozElGgpm4wL2cBb1+5bWd7Mt2iQnr8cb3ud4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgHVO6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 10:58:35 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:47411 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgHVO5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 10:57:12 -0400
Received: from oscar.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 07MEuKVQ025434;
        Sat, 22 Aug 2020 23:56:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 07MEuKVQ025434
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1598108182;
        bh=95U6Fk7JxWZcBC6emSKUXU+RPpgimScrngM3/3sca3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kn4xDBCCwLj7T9hZXgeNdDZx9dRv46QZyU0AzvXPdaLSOCSt5AIVBC6GvSMqXxZjb
         WniWd+hSDKcCrWCR6rhfdq1srppx93gY5comjtWcvDFykJq2NI1XEXe46mjGziJFL0
         UY+3cHGXXt1qyIo3n1dS+Ghm+n+fOA0oHMxA9zzrlSnkREngWIUefgMnoQG2bCz97I
         Oi+yUPRDn0SLawTDdDhRrEeVNXT5EG/YmKPRIRN7b1hEh1XcVjT2mA7jp78TGsvwAB
         PqtPeZugYxm049U/Mu7hNAK7k3WNUHGIt7/ts8w9RJIunFJQKFGr/zDM8SccwzL54z
         Jhav+pwhUUWkQ==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Roeder <tmroeder@google.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/10] gen_compile_commands: parse only the first line of .*.cmd files
Date:   Sat, 22 Aug 2020 23:56:09 +0900
Message-Id: <20200822145618.1222514-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200822145618.1222514-1-masahiroy@kernel.org>
References: <20200822145618.1222514-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the allmodconfig build, this script takes about 5 sec on my
machine. Most of the run-time is consumed for needless regex matching.

We know the format of .*.cmd file; the first line is the build command.
There is no need to parse the rest.

With this optimization, now it runs 4 times faster.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
---

(no changes since v2)

Changes in v2:
  - Remove the unneeded variable 'line'

 scripts/gen_compile_commands.py | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index c458696ef3a7..1bcf33a93cb9 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -125,11 +125,8 @@ def main():
             filepath = os.path.join(dirpath, filename)
 
             with open(filepath, 'rt') as f:
-                for line in f:
-                    result = line_matcher.match(line)
-                    if not result:
-                        continue
-
+                result = line_matcher.match(f.readline())
+                if result:
                     try:
                         entry = process_line(directory, dirpath,
                                              result.group(1), result.group(2))
-- 
2.25.1

