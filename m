Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23138C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 17:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE35320781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 17:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597254081;
	bh=+84vL+r6w53WoQuz/nkk+qICrMgemgjRWv+t3f4GPow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oeAM/jjXeVElgnzTP9JCfEMqrUL2SZ8fyQzmvOy0M1z2k/E0n+oABvqzQQFm/EFoz
	 gBeZ1n9uesb1rP8nLcOkY5DnJ/pEvOWb4lFOJ4Sc6GRs7AfMuMN29mkBlZzxNUo2p7
	 sbRKjd3kgAfrC7cG5rY2bnV/3FRqxKgBwt6rslbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgHLRlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 13:41:16 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:55363 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgHLRlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 13:41:12 -0400
Received: from oscar.flets-west.jp (softbank126025067101.bbtec.net [126.25.67.101]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 07CHeC4D012279;
        Thu, 13 Aug 2020 02:40:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 07CHeC4D012279
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1597254014;
        bh=bdhsF+PGnDpUOrgplpToSYPg+6kuHpkICPzCUi4Ew4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q27VHY3b/ONWLVm1yKoov1048y7ZwKoC0NTica0jMpOvPaCQcOcRtFA6wOrn7HlNz
         R6I9epcxlfFFeCJEPk8adkeYB5HlSXRX5m7+F9DycLJ2sRX34llJIDXHXiMUY9Beuy
         ZKXKLpsihPXX8TPvuCM4WPE/7OGGLn5UZ+WLUFGrXsmV/rBFuIFVhqApSNdzaPcNT+
         ourNBeTsH35lhF7Gun/74hF5loeASuSgU8aw0z3PWQn+R/TdPkD0Du6ykKhCzbxmx4
         iBMdmKFP3wmlwYvq9BWzrHn12PdTVKSm7us2Ldwr68OLE9ZFFoQqGnXU3O6aZzwhtS
         /J9KBNA5VaQeg==
X-Nifty-SrcIP: [126.25.67.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Roeder <tmroeder@google.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] gen_compile_commands: parse only the first line of .*.cmd files
Date:   Thu, 13 Aug 2020 02:39:56 +0900
Message-Id: <20200812173958.2307251-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200812173958.2307251-1-masahiroy@kernel.org>
References: <20200812173958.2307251-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the allmodconfig build, this script takes about 5 sec on my
machine. Most of the run-time is consumed for needless regex matching.

We know the format of .*.cmd file; the first line is the build command.
There is no need to parse the remaining.

With this optimization, now it runs in about 1 sec with the allmodconfig
build.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/gen_compile_commands.py | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index c458696ef3a7..19c7338740e7 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -125,11 +125,9 @@ def main():
             filepath = os.path.join(dirpath, filename)
 
             with open(filepath, 'rt') as f:
-                for line in f:
-                    result = line_matcher.match(line)
-                    if not result:
-                        continue
-
+                line = f.readline()
+                result = line_matcher.match(line)
+                if result:
                     try:
                         entry = process_line(directory, dirpath,
                                              result.group(1), result.group(2))
-- 
2.25.1

