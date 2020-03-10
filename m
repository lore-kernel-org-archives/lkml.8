Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518DCC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CDF21D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgCJSg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:36:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53921 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJSg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:36:57 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1jBjkM-0006GP-MW
        for linux-kernel@vger.kernel.org; Tue, 10 Mar 2020 18:36:54 +0000
Received: by mail-wr1-f72.google.com with SMTP id c16so6316343wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 11:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M+NOQNpvhvH3Mta8jMCkiQEkAzDoTgoDN+MCQM8KMJk=;
        b=DjK4kvN8hGxKDI2uJa5SYhOdA3Cw5aIXsF1e37Tf7HlUVGVlcMcEW1D22nwqjiGKw4
         3uOSIh48pP11pB3rqeZPCj4xSsMT6gRSbYRHvPqkglblsvy3VSsJqtMthQMDHAckE1Nn
         i0Xhg9j6ejpfhN/bPmfsiQ1o0XR7XuNd0STW/dUOfgC4ScxEtlU/WYkHXTtCRIr+WyPr
         ECiiJu3oPlqng02hgLaE+Wm51bOn0iMjaXuzmuiSoFJYkJl2p3fGQ/g7UXPqShooZfuY
         DWEi4hfT3E3k96e4dJYPgIG0tLDJifls9Jbu72Vqukhl1BI/85SUNGt47XuOFbpNw5DG
         UWqw==
X-Gm-Message-State: ANhLgQ04r1zmA+G7Bz1eAkhQq2/IfoTkS3WIjLIEWwRR0BCTSIF3MrLo
        yRAYZaS1t1vbULrwvjmFmVhlydjEGh4k0LTNo0T5M0IM21MoqYVF6Q1XQBJKryw1eCXTB4AFoJK
        L9SbXsiEql2F+qQUeCmy+l6akGabHbcU5pIUO7+LKVw==
X-Received: by 2002:adf:de10:: with SMTP id b16mr27529287wrm.145.1583865414207;
        Tue, 10 Mar 2020 11:36:54 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsCf8pVbjwUxH536PBWlDZKzwrtesqkq2+TuE8mRLhskWkQRt8m4pbkZ9wA7tWmh7D1Hfn+dg==
X-Received: by 2002:adf:de10:: with SMTP id b16mr27529263wrm.145.1583865413988;
        Tue, 10 Mar 2020 11:36:53 -0700 (PDT)
Received: from localhost (189-47-87-73.dsl.telesp.net.br. [189.47.87.73])
        by smtp.gmail.com with ESMTPSA id h18sm4816377wmm.6.2020.03.10.11.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 11:36:52 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org, swood@redhat.com,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        mingo@kernel.org, gpiccoli@canonical.com, kernel@gpiccoli.net
Subject: [PATCH v2] Documentation: Better document the softlockup_panic sysctl
Date:   Tue, 10 Mar 2020 15:36:49 -0300
Message-Id: <20200310183649.23163-1-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9c44bc03fff4 ("softlockup: allow panic on lockup") added the
softlockup_panic sysctl, but didn't add information about it to the file
Documentation/admin-guide/sysctl/kernel.rst (which in that time certainly
wasn't rst and had other name!).

This patch just adds the respective documentation and references it from
the corresponding entry in Documentation/admin-guide/kernel-parameters.txt.

This patch was strongly based on Scott Wood's commit d22881dc13b6
("Documentation: Better document the hardlockup_panic sysctl").

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 ++++----
 Documentation/admin-guide/sysctl/kernel.rst     | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04615690e69e..b24fb0d11955 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4578,10 +4578,10 @@
 			Format: <integer>
 
 			A nonzero value instructs the soft-lockup detector
-			to panic the machine when a soft-lockup occurs. This
-			is also controlled by CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC
-			which is the respective build-time switch to that
-			functionality.
+			to panic the machine when a soft-lockup occurs. It is
+			also controlled by the kernel.softlockup_panic sysctl
+			and CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC, which is the
+			respective build-time switch to that functionality.
 
 	softlockup_all_cpu_backtrace=
 			[KNL] Should the soft-lockup detector generate
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 1c48ab4bfe30..335696d3360d 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1036,6 +1036,20 @@ NMI.
 = ============================================
 
 
+softlockup_panic
+=================
+
+This parameter can be used to control whether the kernel panics
+when a soft lockup is detected.
+
+= ============================================
+0 Don't panic on soft lockup.
+1 Panic on soft lockup.
+= ============================================
+
+This can also be set using the softlockup_panic kernel parameter.
+
+
 soft_watchdog
 =============
 
-- 
2.25.1

