Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F62C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302342068D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="KGN04Gs7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgEZSen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgEZSen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:34:43 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7EEC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:34:41 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q8so5228763qkm.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X6aXjORE3d23i1StkTonhzGHIalGKnrHwR2gVaYOR1Q=;
        b=KGN04Gs7yNeKZzj8Lcyig10HxzNnFYhK42ZHpbQ7VNBeH5oOdHxr0avRB6BsoYRpdg
         HHf0NqmqHMxFxlPGrp/dyvpQBszyjEKVlw2KCc1XphtusuGVsAUn7O1bVuxVSvUHzDAO
         qDMbPlvkjYEKPQMSqNb3avW9ZnJ1JV677JoYBfxCY8u2Sr2CGJV7eb2fYyH7YyCp1xfS
         BvD8LhMMJltV/8TSjKAidYgKWQplesk60AeoWpiEIsKiT1shwbBy0mYHMo8JS2ky0+sA
         cMfCEn2PRi6ogyHzvbfD+0swY8H9NjiTzeEUn4ariY/8fTEGzx/HoNwF6w30WHKRhxEb
         fquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X6aXjORE3d23i1StkTonhzGHIalGKnrHwR2gVaYOR1Q=;
        b=aKhkD0+9dJBGjMP5bAV02TgW5ACeIT83Xx2ZDzeYn7Fwgz6RpsAF2E64J2mPiv4FU/
         esae6H2SL96z1V2p37nl8cTWwUFFsrnqIlUN8GVuPz4CzM029EUSuBdVdyba4/jTEwz+
         aoe6pXdhhDmtMkuQ5gMFwaBntNlSyt4iSc+hRRKu+esQ6KYJcTIcqA1SCHqKuyoc5kSX
         1idB2dFJRIJ7Q89bB+4jgEzSH4IKuNXJidmi66XU2zZDV06sMhtKYSln264g/LUQr4En
         +WoICS35yFrjbrq+RgFAP85rukVZhvlSx89FiT/iGuK5zZThjbKollEgYa7ntp8uY5gM
         +rhg==
X-Gm-Message-State: AOAM532rHyVGGQbtaSF8fm/KrRaMVbbEndsgaeNr0kcCYfDWeeog41EJ
        dNXSWUw3+VRUsN73NPjvkywQew==
X-Google-Smtp-Source: ABdhPJx197AECqahGr2mrLzhHicRNVl3wRfVxYHrdKQzzsTRV2BokxzXwXPWx0y9cHLpDk04xJuo0A==
X-Received: by 2002:a37:484e:: with SMTP id v75mr142237qka.79.1590518080875;
        Tue, 26 May 2020 11:34:40 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id l22sm342526qki.45.2020.05.26.11.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 11:34:40 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com, skhan@linuxfoundation.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [fixup] kunit: use --build_dir=.kunit as default
Date:   Tue, 26 May 2020 15:34:36 -0300
Message-Id: <20200526183436.47026-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make KUnit easier to use, and to avoid overwriting object and
.config files, the default KUnit build directory is set to .kunit

 * Related bug: https://bugzilla.kernel.org/show_bug.cgi?id=205221

Fixed up minor merge conflicts - Shuah Khan <skhan@linuxfoundation.org>

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
version after merge on kunit brach:
 * fix identation (tabs instead of spaces)
---
 tools/testing/kunit/kunit.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index b01838b6f5f9..b3490271a103 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -169,7 +169,7 @@ def add_common_opts(parser):
 	parser.add_argument('--build_dir',
 			    help='As in the make command, it specifies the build '
 			    'directory.',
-			    type=str, default='', metavar='build_dir')
+                            type=str, default='.kunit', metavar='build_dir')
 	parser.add_argument('--make_options',
 			    help='X=Y make option, can be repeated.',
 			    action='append')
@@ -245,12 +245,11 @@ def main(argv, linux=None):
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
-		if cli_args.build_dir:
-			if not os.path.exists(cli_args.build_dir):
-				os.mkdir(cli_args.build_dir)
-			kunit_kernel.kunitconfig_path = os.path.join(
-				cli_args.build_dir,
-				kunit_kernel.kunitconfig_path)
+		if not os.path.exists(cli_args.build_dir):
+			os.mkdir(cli_args.build_dir)
+		kunit_kernel.kunitconfig_path = os.path.join(
+			cli_args.build_dir,
+			kunit_kernel.kunitconfig_path)
 
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
-- 
2.26.2

