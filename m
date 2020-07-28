Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765E4C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D552070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O6EF1b8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgG1Hcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgG1Hcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 03:32:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32449C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 00:32:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b127so6729998ybh.21
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 00:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=DpK+2SdGdyPZ4USsui5L2+ozA8NnkYVB7Ef4YkZgDHI=;
        b=O6EF1b8YQUuAnfH+V0f3DoV1MARX+vycSPRUCvp6ysS9A3x0lF8kEzkMXv35N76c90
         byeVulwqilohyz8z2O79ZhVDirzVMbSoJNS9qpBzhqt8nW5JK6BavAsV+1WDeGRpl7HG
         Zzo1VdPrhrDH6QXVMFZniMXX+fEvzs/KTSinx0o5GPE7gmdsc2YxVWONDLw3yQUecNPk
         bIPhUqb+/3iC73Nj8AfdJikTicZSbBTR6yhn7M+SsrNCTgkfl1XgUoxNNRGClwHNr/se
         G62RICelzlRFQDS0uZZlqCaBOtP9mJ19AQPlJONgJLohvwTGI61jZbMnitslv4aZ6UVG
         NlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=DpK+2SdGdyPZ4USsui5L2+ozA8NnkYVB7Ef4YkZgDHI=;
        b=X3mxyXd+3R63MJyOexSysc+2WKYovIIxSfPsoi2PxkZ2SWY3BU7d0nKtw5TX+XlCrf
         Yq55MWPnuUngE1c86Ce8Y5L+SLdQ1a+P1fQqotPM/FYUpWAMCXg3K2rdKR6tSDJfRK5t
         wfYyUOZdykvJ/zeHzjO0D6HVQFWiAnijwFp/P1ICTQ77spZj30rLTGMXI4CTi5QRW2fA
         uYvxWOmLJR8conFUYKisNl0xKx7nBIpq2ekU8mcIcp4ROTuZv//ODXmbvnAh7Tfy5XB5
         ax5wJrmdl4Ew0pgxmq53pHppXmGFpwJ+isn3DBqVTMWPSmLkdZzYaKQFNe84w2ClOk6R
         V2SQ==
X-Gm-Message-State: AOAM5303vS3OA/+8zd1n8aMeVcDsscSub00v8YggmUQ/iAjJg57Fch/8
        m8icBFSfFegCYCqgIOHsijqBSfs6ogBk
X-Google-Smtp-Source: ABdhPJxJoSMx7T9ET5f8UjAYX2Cky5oBQZ764w5cRoTcjaSql758njpgCfITmUIx4xDcLbkEKvqGw85UDW0i
X-Received: by 2002:a5b:992:: with SMTP id c18mr41024065ybq.252.1595921564297;
 Tue, 28 Jul 2020 00:32:44 -0700 (PDT)
Date:   Tue, 28 Jul 2020 00:32:41 -0700
Message-Id: <20200728073241.3625015-1-gthelen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH] selftests: more general make nesting support
From:   Greg Thelen <gthelen@google.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

selftests can be built from the toplevel kernel makefile (e.g. make
kselftest-all) or directly (make -C tools/testing/selftests all).

The toplevel kernel makefile explicitly disables implicit rules with
"MAKEFLAGS +=3D -rR", which is passed to tools/testing/selftests.  Some
selftest makefiles require implicit make rules, which is why
commit 67d8712dcc70 ("selftests: Fix build failures when invoked from
kselftest target") reenables implicit rules by clearing MAKEFLAGS if
MAKELEVEL=3D1.

So far so good.  However, if the toplevel makefile is called from an
outer makefile then MAKELEVEL will be elevated, which breaks the
MAKELEVEL equality test.
Example wrapped makefile error:
  $ cat ~/Makefile
  all:
  	$(MAKE) defconfig
  	$(MAKE) kselftest-all
  $ make -sf ~/Makefile
    futex_wait_timeout.c /src/tools/testing/selftests/kselftest_harness.h  =
 /src/tools/testing/selftests/kselftest.h ../include/futextest.h ../include=
/atomic.h ../include/logging.h -lpthread -lrt -o /src/tools/testing/selftes=
ts/futex/functional/futex_wait_timeout
  make[4]: futex_wait_timeout.c: Command not found

Rather than checking $(MAKELEVEL), check for $(LINK.c), which is a more
direct side effect of "make -R".  This enables arbitrary makefile
nesting.

Signed-off-by: Greg Thelen <gthelen@google.com>
---
 tools/testing/selftests/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Mak=
efile
index 1195bd85af38..289a2e4b3f6f 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -84,10 +84,10 @@ endif
 # of the targets gets built.
 FORCE_TARGETS ?=3D
=20
-# Clear LDFLAGS and MAKEFLAGS if called from main
-# Makefile to avoid test build failures when test
-# Makefile doesn't have explicit build rules.
-ifeq (1,$(MAKELEVEL))
+# Clear LDFLAGS and MAKEFLAGS when implicit rules are missing.  This provi=
des
+# implicit rules to sub-test Makefiles which avoids build failures in test
+# Makefile that don't have explicit build rules.
+ifeq (,$(LINK.c))
 override LDFLAGS =3D
 override MAKEFLAGS =3D
 endif
--=20
2.28.0.rc0.142.g3c755180ce-goog

