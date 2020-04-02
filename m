Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13F9C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6136820737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XymilC0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390005AbgDBRis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:38:48 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:48639 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388677AbgDBRir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:38:47 -0400
Received: by mail-pf1-f201.google.com with SMTP id d16so3532500pfo.15
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NI0Kiq/sBep8uH+bGoMdp+/XVSJu96oWCrFI/ppsJuU=;
        b=XymilC0+8zjoS6aqUQvbDKpbxG1xuxlcy5XK1oX8f86l5HbkEmItujb3V3DieUwDsS
         6F6hPVDf7oSlFi+YtCIgpd6I96IGdaQM1ZCYhokBEAKJOYwltiqJa0ffhCx04UqnxMFO
         Uw70OqmKkpPbMqlQxgpysWe9N7BAz71tYLeHhZxlhBvmrl+Gq/J277bG3lILRQkz1cBh
         dngvfNsA3HPxtUIXDCGGnW+r6bTsyXhYiXpQDboV+OlckctH17+fRoWTEjpNVQeK9iqN
         xt7hMa2CY+DCQvDbGhGimiLE6tED+OzmOzwfM68A8JGwdcxM449sZQuv1g42RXXO5bU+
         vGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NI0Kiq/sBep8uH+bGoMdp+/XVSJu96oWCrFI/ppsJuU=;
        b=YyFZvIl573vtBhk6XpU/ZTmVXELEyq73Mca+X0BSGVXuqjInUhJn+K8KMHB4IPqm2q
         kNMIlAv89V3CkZ6Mk2a3CGj8GJkfJ6V51toXlKdxDpNKsNfK2ViPVMXkKrsYrh9Kq3EP
         BfUxzfR9+tpHce2aqlalheJnBCYaR0oxqrSzVlTGNaRyo25DdiXDKexP918J/yxZXu3T
         +EuVxWJAMZKgMeMJG8rJMAbwaRolARj9x3TTdpEd3xraVAXVuYTh6TONYfqv5bULT53U
         ZyC874R6kBTS3MINHmQDhSfWD2UtMKz/RPwBsckc4VLkv/eqiISIewR3A8Cf0TgCD7Tk
         YUvg==
X-Gm-Message-State: AGi0PuYLUbbhPYRFl4qrbfzZKNuBO3bwZUTR6MTOydW1fWozYjUAE/hA
        t2RTVIx0975Su9TTziBCtIpv7kMKcDa2
X-Google-Smtp-Source: APiQypJ1XJpXWlwo1vDKom37brStxOJ9dfhZWzCVQIEnxK21Q6WUr6jX8FGkVEAoDrUEJjPjFmJEdIktzwfj
X-Received: by 2002:a17:90a:8085:: with SMTP id c5mr4557030pjn.186.1585849126457;
 Thu, 02 Apr 2020 10:38:46 -0700 (PDT)
Date:   Thu,  2 Apr 2020 10:38:42 -0700
Message-Id: <20200402173842.96013-1-maskray@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH] Documentation/llvm: fix the name of llvm-size
From:   Fangrui Song <maskray@google.com>
To:     corbet@lwn.net, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tool is called llvm-size, not llvm-objsize.

Fixes: fcf1b6a35c16 ("Documentation/llvm: add documentation on building w/ Clang/LLVM")
Signed-off-by: Fangrui Song <maskray@google.com>
---
 Documentation/kbuild/llvm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
index d6c79eb4e23e..eefbdfa3e4d9 100644
--- a/Documentation/kbuild/llvm.rst
+++ b/Documentation/kbuild/llvm.rst
@@ -51,7 +51,7 @@ LLVM has substitutes for GNU binutils utilities. These can be invoked as
 additional parameters to `make`.
 
 	make CC=clang AS=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \\
-	  OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump OBJSIZE=llvm-objsize \\
+	  OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump OBJSIZE=llvm-size \\
 	  READELF=llvm-readelf HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar \\
 	  HOSTLD=ld.lld
 
-- 
2.26.0.rc2.310.g2932bb562d-goog

