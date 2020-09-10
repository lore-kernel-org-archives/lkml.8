Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83909C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 11:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471142075B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 11:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="QsIexGgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbgIJL4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 07:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730461AbgIJLwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 07:52:39 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA194C061786
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 04:27:08 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v23so7720498ljd.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 04:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V+CYbVm4iZfylHr6znJ5scB0pwHaun1/ypbLhvCUlfc=;
        b=QsIexGgIAuGkeoJXnsOrSqsMS8jJL57GWSjVe7NGaxMs8A+Z7aCmpgDxGYUqY0Wtm+
         xjwsavqFNoYEe8AZBkXDebkYkDwOF9fC5DA+s3ivpdvf3qUA1GABJGQcVMbHUikjm2W9
         WAU3Xxm5RFedDwnZk3oaimOg6pP8quIBa7Vao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V+CYbVm4iZfylHr6znJ5scB0pwHaun1/ypbLhvCUlfc=;
        b=Zn2uCZcE+QwOej0KPflcaZEAOMFqfn6zQXYr8lPiTskGsN7UNacL0o7OJIVl3Rl66A
         IHojLm9virFzMAizx2+6hLdpkmwORPOlgL8H27pEeX8PCJxw39WyRrlfcuW04+3aOPIj
         2t8jv8iGEbdr3ta1gfLfjEtOV+aezW2jcwsXCkqhduymNN0FVZh00cDrOgEqti4NkFyA
         la0xTTyxNPFkNzu4skfmaYjz8CLmxBQepV8Gx8gNUARnZ4Vf6WKif4omPTj9CLlGeGvL
         ijYB55CCdGpNC6g0DXeVsfznlgXQ38cl/Ox/I19eTU/7fUQdU3EdEmIiZw2vlk/Qbvnm
         /kGg==
X-Gm-Message-State: AOAM533zdpwIUTuYkkQz1vBY4wkCXAsopfLv1yO8LNVmZODI0S6wD94g
        BK9R7L8M3FMe5P2OQo+7NIZmvg==
X-Google-Smtp-Source: ABdhPJyidIcrotwPAJy0jwKnzx667zz0YB0vd99e5F0WuTdgY1Swt9HojTbruWyoJNzTvib83UsJzw==
X-Received: by 2002:a05:651c:ce:: with SMTP id 14mr4321344ljr.18.1599737227016;
        Thu, 10 Sep 2020 04:27:07 -0700 (PDT)
Received: from prevas-ravi.prevas.se (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id i187sm1280792lfd.65.2020.09.10.04.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 04:27:06 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/setlocalversion: make git describe output more reliable
Date:   Thu, 10 Sep 2020 13:26:57 +0200
Message-Id: <20200910112701.13853-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building for an embedded target using Yocto, we're sometimes
observing that the version string that gets built into vmlinux (and
thus what uname -a reports) differs from the path under /lib/modules/
where modules get installed in the rootfs, but only in the length of
the -gabc123def suffix. Hence modprobe always fails.

The problem is that Yocto has the concept of "sstate" (shared state),
which allows different developers/buildbots/etc. to share build
artifacts, based on a hash of all the metadata that went into building
that artifact - and that metadata includes all dependencies (e.g. the
compiler used etc.). That normally works quite well; usually a clean
build (without using any sstate cache) done by one developer ends up
being binary identical to a build done on another host. However, one
thing that can cause two developers to end up with different builds
[and thus make one's vmlinux package incompatible with the other's
kernel-dev package], which is not captured by the metadata hashing, is
this `git describe`: The output of that can be affected by

(1) git version: before 2.11 git defaulted to a minimum of 7, since
2.11 (git.git commit e6c587) the default is dynamic based on the
number of objects in the repo
(2) hence even if both run the same git version, the output can differ
based on how many remotes are being tracked (or just lots of local
development branches or plain old garbage)
(3) and of course somebody could have a core.abbrev config setting in
~/.gitconfig

So in order to avoid `uname -a` output relying on such random details
of the build environment which are rather hard to ensure are
consistent between developers and buildbots, use an explicit
--abbrev=15 option (and for consistency, also use rev-parse --short=15
for the unlikely case of no signed tags being usable).

Now, why is 60 bits enough for everyone? It's not mathematically
guaranteed that git won't have to use 16 in some git repo, but it is
beyond unlikely: Even in a repo with 100M objects, the probability
that any given commit (i.e. the one being described) clashes with some
other object in the first 15 hex chars is less than 1e-10, and
currently a git repo tracking Linus', -stable and -rt only has around
10M objects.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
I could probably fix things by adding a 'git config --local
core.abbrev 15' step to the Yocto build process after the repo to
build from has been cloned but before building has started. But in the
interest of binary reproducibility outside of just Yocto builds, I
think it's better if this lives in the kernel.

 scripts/setlocalversion | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 20f2efd57b11..c5262f0d953d 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -45,7 +45,7 @@ scm_version()
 
 	# Check for git and a git repo.
 	if test -z "$(git rev-parse --show-cdup 2>/dev/null)" &&
-	   head=$(git rev-parse --verify --short HEAD 2>/dev/null); then
+	   head=$(git rev-parse --verify --short=15 HEAD 2>/dev/null); then
 
 		# If we are at a tagged commit (like "v2.6.30-rc6"), we ignore
 		# it, because this version is defined in the top level Makefile.
@@ -59,7 +59,7 @@ scm_version()
 			fi
 			# If we are past a tagged commit (like
 			# "v2.6.30-rc5-302-g72357d5"), we pretty print it.
-			if atag="$(git describe 2>/dev/null)"; then
+			if atag="$(git describe --abbrev=15 2>/dev/null)"; then
 				echo "$atag" | awk -F- '{printf("-%05d-%s", $(NF-1),$(NF))}'
 
 			# If we don't have a tag at all we print -g{commitish}.
-- 
2.23.0

