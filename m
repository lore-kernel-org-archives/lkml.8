Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14826C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC01F2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="LySdmacw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgDMMEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgDMMEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:04:42 -0400
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 08:04:42 EDT
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D67C03BC89
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 04:58:20 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id o10so6832314qtr.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 04:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oHLps9o08dbvxE02Dvj/jt0RoFc0VpbMXtuiKFoxLZE=;
        b=LySdmacwY+3ux5rursX79HmuxJceTvKyk9bpz+AOfNV99t68btXJuf6UgsaXMltmy5
         tZDP2KmUMiyMJTIPp270VRv5tG2bOVOWia5u11Xi3SQUTMT44OrdkWoScr5iMKTMaH5y
         2sc8k2WH3JCjDMhVMZwL3w8iS6YYCH6E+PrZdz3SGYbjRWOwUW99GNqCi6TBZEmd/nGm
         KoT3fKvfOj7CbAsKXvrnf/7OklsAlHCZOk1I6tGiolX8RyMyldjt3i3pDeH+kCanbVUs
         ML53t9cnnaiRDCF+gD8lwNk66Sa8OkufkZp66eEKeGLDLThS8szLRlnyS1lm5xbvE74T
         gS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oHLps9o08dbvxE02Dvj/jt0RoFc0VpbMXtuiKFoxLZE=;
        b=K2r9T2JEutZQBq81V+9sRZ7Y4vQFXdgymCcOfjfxEYqsR8mDnae6wnTYBmtIfDxpUD
         KzScr6bt55xSbcN1Gne6qBmk6EvKSagZMeOxG5ayhmBtEJxABq5vNlqrDIOL8CWK2dRz
         helXpjYTwq2twHUOUCpEk8ck1pi8JsTepTHdI5uVfx+Jzrx8WblFRNRnlUgM4eUExTMl
         41Drll4b6WBfsN4na5b/sjf5vznT5QiM1HtJPHYLjsWvULP1G5UyTsN6z9eylUdYXzss
         7lOAHOsgAiG82aq0Y62NxGr4sdTYPzY/AtsXvpzAlgXUrz9pR/BXZRMvx2qqcowVa8T+
         rrpA==
X-Gm-Message-State: AGi0PubvtwO8b+pSAoz8KWSNLCh/l2zgMjZak98Yh092fYu5+cpvYfZn
        Y3GlSNTzM/G3oh0QJlXR6frc9dXgrW4=
X-Google-Smtp-Source: APiQypKofBoxZQiSMjHok5wcXaet362PDl853ajJ57KknzIVzKWUJoZUlUM+Vp5OOyWbvXiTN3xmoA==
X-Received: by 2002:ac8:3686:: with SMTP id a6mr8822273qtc.317.1586779099732;
        Mon, 13 Apr 2020 04:58:19 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id s14sm5129124qts.70.2020.04.13.04.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 04:58:19 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     linux-kbuild@vger.kernel.org
Cc:     masahiroy@kernel.org, michal.lkml@markovi.net,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org
Subject: [PATCH] kbuild: arch/$(SUBARCH)/include/generated/ aren't cleaned by mrproper
Date:   Mon, 13 Apr 2020 08:58:15 -0300
Message-Id: <20200413115815.141587-1-vitor@massaru.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug was introduced in this commit a788b2ed81abe

Related bug: https://bugzilla.kernel.org/show_bug.cgi?id=205219

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 70def4907036..e1a79796032e 100644
--- a/Makefile
+++ b/Makefile
@@ -532,7 +532,8 @@ outputmakefile:
 ifdef building_out_of_srctree
 	$(Q)if [ -f $(srctree)/.config -o \
 		 -d $(srctree)/include/config -o \
-		 -d $(srctree)/arch/$(SRCARCH)/include/generated ]; then \
+		 -d $(srctree)/arch/$(SRCARCH)/include/generated -o \
+		 -d $(srctree)/arch/$(SUBARCH)/include/generated ]; then \
 		echo >&2 "***"; \
 		echo >&2 "*** The source tree is not clean, please run 'make$(if $(findstring command line, $(origin ARCH)), ARCH=$(ARCH)) mrproper'"; \
 		echo >&2 "*** in $(abs_srctree)";\
@@ -1388,6 +1389,7 @@ CLEAN_FILES += modules.builtin modules.builtin.modinfo modules.nsdeps
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include/generated          \
 		  arch/$(SRCARCH)/include/generated .tmp_objdiff \
+		  arch/$(SUBARCH)/include/generated \
 		  debian/ snap/ tar-install/
 MRPROPER_FILES += .config .config.old .version \
 		  Module.symvers \
-- 
2.25.1

