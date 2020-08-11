Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FC7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05D41206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v0rqLtrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgHKV2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKV2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:28:07 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B054C061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:28:07 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 195so61704qke.14
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JEHvtyXY0PahDyTNTofnb+o70v/Ji63GK4tErbh+T7U=;
        b=v0rqLtrGjr6RFTcXhotnND/SQoYUh8qkJiSo07+iNVvoBLd/0LvoE9uKnK7QGigI+H
         lOsCUjwqLAQts0bZdwzMbO7m+/6LPejOxPT652Ef1zJyeKkPQSkF9eGFV3/wI4pSMeRp
         isxJ3DUdz3d9fsGLF27K1CDAphFRsyMlDSub4YXU/wtyuwsVmg/UBRfA7fMUtuj8F+1A
         pAnel/CZ/vbYM9gccjLQGsy3Ci7VH0lPDsxbjoTPiLf9Q6OUZzJxdx5r1EEyik+4xG++
         kqzgGblHuxo9mG+yOb/h8tavfSWnv8dalfViOp9SEWna1ZXzs8aeC49uvvL+01l7LkdW
         yAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JEHvtyXY0PahDyTNTofnb+o70v/Ji63GK4tErbh+T7U=;
        b=Wq7XBtkFLJpxYSYZFiXhh5ZbqdmAvKnh4dTvj5x9uHqteRvNE5Te4wNnmQjYDE7/vY
         DunoQx1b15yrcNncltyv0+nIB87bx6EssZ/JQ2wt7JoMM4R2mzCXBaJ5sHpU3Izlya+C
         1j4GV3mtqLit9xzEFjhQOTp9wcA4tuUibMbbt4tHXc+eiXh89b2XHhjTDaoRVFQofj3E
         0kbcTLEAQcBp8+LqNJQ8J5coG4sNiwSZ50e3pCfDxusiibx1p0byNHEqKdd9v+ilqiyr
         8i925nkBivt+LSpIO4ebulRhle9/EZ9NyTbG+I3HS4ENsVQdenYAznkB+s+dIWds0TRn
         kRdQ==
X-Gm-Message-State: AOAM532N7YvPX+Knl6PRse39Hq3Pkcvf1hC9x7IDdMkoEqKXZnXJjXjC
        Zerk3QCW1l/NjCIF1/iQUl3Jr8XHPB/6/WkUmtQMZg==
X-Google-Smtp-Source: ABdhPJwe/D1QnjaomloZ5+oBlMTzK1X7S7cIeykWGHTCWPLu4m/3lcVHUxJZ3HD2LIOfXvjGcgC+f/3kwSG0yIrGgAyxqA==
X-Received: by 2002:a05:6214:1302:: with SMTP id a2mr3525273qvv.156.1597181286277;
 Tue, 11 Aug 2020 14:28:06 -0700 (PDT)
Date:   Tue, 11 Aug 2020 14:27:55 -0700
Message-Id: <20200811212756.3328740-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v2 1/2] kunit: tool: fix running kunit_tool from outside
 kernel tree
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Tim.Bird@sony.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kunit_tool does not work correctly when executed from a path
outside of the kernel tree, so make sure that the current working
directory is correct and the kunit_dir is properly initialized before
running.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 425ef40067e7e..e2caf4e24ecb2 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -237,9 +237,13 @@ def main(argv, linux=None):
 
 	cli_args = parser.parse_args(argv)
 
+	if get_kernel_root_path():
+		os.chdir(get_kernel_root_path())
+
 	if cli_args.subcommand == 'run':
 		if not os.path.exists(cli_args.build_dir):
 			os.mkdir(cli_args.build_dir)
+			create_default_kunitconfig()
 
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
@@ -257,6 +261,7 @@ def main(argv, linux=None):
 		if cli_args.build_dir:
 			if not os.path.exists(cli_args.build_dir):
 				os.mkdir(cli_args.build_dir)
+				create_default_kunitconfig()
 
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
@@ -270,10 +275,6 @@ def main(argv, linux=None):
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
 	elif cli_args.subcommand == 'build':
-		if cli_args.build_dir:
-			if not os.path.exists(cli_args.build_dir):
-				os.mkdir(cli_args.build_dir)
-
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
 
@@ -288,10 +289,6 @@ def main(argv, linux=None):
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
 	elif cli_args.subcommand == 'exec':
-		if cli_args.build_dir:
-			if not os.path.exists(cli_args.build_dir):
-				os.mkdir(cli_args.build_dir)
-
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
 

base-commit: 30185b69a2d533c4ba6ca926b8390ce7de495e29
-- 
2.28.0.236.gb10cc79966-goog

