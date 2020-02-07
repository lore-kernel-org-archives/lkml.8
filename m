Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A8EC35250
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9135F214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gDNjzVrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgBGSCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:02:52 -0500
Received: from mail-yb1-f201.google.com ([209.85.219.201]:39280 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGSCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 13:02:52 -0500
Received: by mail-yb1-f201.google.com with SMTP id a140so2713347ybg.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 10:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iKjEZXvKKVcsWaI7ym2KttzdoB/EiCc42gBxG/ve1HE=;
        b=gDNjzVrHvKMFTQCFsIM4J+qmSZzKqJ6pjINTMCtV6GCnxkS9bWToX/Y7xbkb+A3BDU
         BG7girIrsDQZf30Fla4zwIn/uYke9+gN9WYJ37tHJS0UCJ1NOXhqpu6CXZy5gt76lVq1
         hMFOpKyvDkQSFnaL/WVIg1c4lfLL/MZHN+OC6qHtiUWwLxPdlVOZVQTG7GkNpejL+Wtp
         RyyWyJ1obapU77yE+1ZScpmgkSaWzo84v3k9Bss2jm1uk2sl9MOYTfuNUd87dh9m6/qv
         zwDaDmlEWABrXP0KCozHVo39yHMf4vTFKGS2u2BsFFf/esrXDo19vauBjGw6p/GWCA2Z
         AtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iKjEZXvKKVcsWaI7ym2KttzdoB/EiCc42gBxG/ve1HE=;
        b=pLN3NcegJCkyMnVY2BZsnUExN4ytTG5GJhRKYBEkh5NSAUr8IBOm8X7/91iV17cgyg
         WUufo10y+Xlt51gF+TYYxB2Z417g1iVbP1L8aZgdJlDPLn/DuinjvMNdsRCkrp0lhJdQ
         7EVUdgiuURQlwR7jGE+CielGselI2Tgmj7TuUloS0hhkU9YS28OKCl+SoZGU35xxHY39
         pyDW0TTdMF4vh2piZOD4JT4kjhHCLBfrDK/FQXpBe0d+97TGLIvk0RPAZvEtYQIErxSt
         4yYP6ZnzpwZvrK1/6fHudeMnsySd9wc4a3UoFw8RJmgShCas3sP0gf8STFBE7BWxP9yQ
         liOw==
X-Gm-Message-State: APjAAAWgRDA3xIfcRVKD2ure7maF+jYihWByY8Q4IPvnuBfYlmZ34Tdf
        Z+dV0Oy9/c5vbc1uvAghDyoCqkCMO1+Poh8=
X-Google-Smtp-Source: APXvYqzHR4qUgqPBjFg2Eg15cywA5UDtWrs7vMReQKmbNj/hxk/GoJLGmLAct4ku6gkiSA6xO4UPiZNVNtyqGtg=
X-Received: by 2002:a25:c04f:: with SMTP id c76mr306526ybf.355.1581098571073;
 Fri, 07 Feb 2020 10:02:51 -0800 (PST)
Date:   Fri,  7 Feb 2020 10:01:49 -0800
Message-Id: <20200207180148.235161-1-smoreland@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v3] security: selinux: allow per-file labeling for bpffs
From:   Steven Moreland <smoreland@google.com>
To:     paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Cc:     "Connor O'Brien" <connoro@google.com>,
        Steven Moreland <smoreland@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Connor O'Brien <connoro@google.com>

Add support for genfscon per-file labeling of bpffs files. This allows
for separate permissions for different pinned bpf objects, which may
be completely unrelated to each other.

Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: Steven Moreland <smoreland@google.com>
---
 security/selinux/hooks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d9e8b2131a65..18f8cd47729c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -699,6 +699,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	if (!strcmp(sb->s_type->name, "debugfs") ||
 	    !strcmp(sb->s_type->name, "tracefs") ||
 	    !strcmp(sb->s_type->name, "binderfs") ||
+	    !strcmp(sb->s_type->name, "bpf") ||
 	    !strcmp(sb->s_type->name, "pstore"))
 		sbsec->flags |= SE_SBGENFS;
 
-- 
2.25.0.341.g760bfbb309-goog

v2 -> v3
- on selinux next branch (instead of master)
