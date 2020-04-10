Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94281C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6665920673
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="RlDv/0oQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgDJKlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 06:41:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46997 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgDJKll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 06:41:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id f13so1830875wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 03:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6QLdzKbUmCzenyVGneMFCV9bfKtlfDEGB2GO2r8hJWg=;
        b=RlDv/0oQA02ldjND6rBeHExH4DYeBwroQFO6VsXB7oPjn82aw7DE07jOJwamw79Dfw
         1QDYIJHtvE/Jz7D2sYlCZbKWpcYNbC66gpHtKKIgkZmE2trjcI6BzQZWIoMOCaFgEANN
         JFDUF2l696jXsGCPituOu4pCIg5LhTtzHohm0yYuQQ9niuDn0FTSOu0L2PJuM8kOtNs2
         glB3izUnxmDMea8RJxv2VXkUHVwUjLJei9XBOhihEWGkWvDFwvcJrZmlYEUaV5S3JQlp
         xy4spya55b7BFw5sZB+h11dt4sMgBOadYNHoGxRXu4dwA1jAq/nFyot69yPGoXllofPl
         Ky8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6QLdzKbUmCzenyVGneMFCV9bfKtlfDEGB2GO2r8hJWg=;
        b=qQv6T52y1caWzNTKAPnq6lVcKPjjSb3vU5soWzb0NXdTn9PobmZu7DsaZ/02MP7ktT
         //dfBNk2yyDJuvetuw9WLdKbBGZ3aJn/8lSG34ciJ4X9NCbnGFrxPymssuh2l+6GEetg
         RTuygHo7ANwJvpj7aDRnLr7jFgNqfSkKGfwhPwfu7M/lCSHlU53xxH0kFlL/dtZKouDG
         6nmUULlpu+Lw0s6BzlPW64UCDpei/BZFfLZokx11hFHv1leTQiuX6EgvGNazEFynfwcn
         UTe2sa4AKg2FuS8grc8J0sMcpDaEB4sg2CTP0cGfwbE9gKMDk3/S7JTZuN2r7orXRwsM
         p3DA==
X-Gm-Message-State: AGi0Pub3u4GxK2UO8js2+73UqGegpbubZ3Zw5votkrRw7VuxS3ym7UQq
        F1hrx8T/O5+1GOK0fQztU3g8dw==
X-Google-Smtp-Source: APiQypJnyYw9Xx4D1lPATDBy+l4SIGQVgf2MNMD0X/0FRhYmNKG+qjDW7935nGlXVwfSRsc7tlplHg==
X-Received: by 2002:a5d:5045:: with SMTP id h5mr3844621wrt.86.1586515298588;
        Fri, 10 Apr 2020 03:41:38 -0700 (PDT)
Received: from wittgenstein.fritz.box (ip5f5bd698.dynamic.kabel-deutschland.de. [95.91.214.152])
        by smtp.gmail.com with ESMTPSA id u16sm2345546wro.23.2020.04.10.03.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 03:41:37 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     mtk.manpages@gmail.com
Cc:     cgroups@vger.kernel.org, christian.brauner@ubuntu.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org, oleg@redhat.com, tj@kernel.org
Subject: [PATCH] clone.2: Document CLONE_INTO_CGROUP
Date:   Fri, 10 Apr 2020 12:41:32 +0200
Message-Id: <20200410104132.294639-1-christian@brauner.io>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <CAKgNAkhL0zCj11LS9vfae872YVeRsxdz20sZWuXdi+UjH21=0g@mail.gmail.com>
References: <CAKgNAkhL0zCj11LS9vfae872YVeRsxdz20sZWuXdi+UjH21=0g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 man2/clone.2 | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/man2/clone.2 b/man2/clone.2
index 39cec4c86..8d9aa9f99 100644
--- a/man2/clone.2
+++ b/man2/clone.2
@@ -197,6 +197,7 @@ struct clone_args {
     u64 tls;          /* Location of new TLS */
     u64 set_tid;      /* Pointer to a \fIpid_t\fP array */
     u64 set_tid_size; /* Number of elements in \fIset_tid\fP */
+    u64 cgroup;       /* Target cgroup file descriptor for the child process */
 };
 .EE
 .in
@@ -448,6 +449,25 @@ Specifying this flag together with
 .B CLONE_SIGHAND
 is nonsensical and disallowed.
 .TP
+.BR CLONE_INTO_CGROUP " (since Linux 5.7)"
+.\" commit ef2c41cf38a7559bbf91af42d5b6a4429db8fc68
+By default, the child process will belong to the same cgroup as its parent.
+If this flag is specified the child process will be created in a
+different cgroup than its parent.
+
+When using
+.RB clone3 ()
+the target cgroup can be specified by setting the
+.I cl_args.cgroup
+member to the file descriptor of the target cgroup. The cgroup file
+descriptor must refer to a cgroup in a cgroup v2 hierarchy
+(see
+.BR cgroup (2)).
+
+Note that all usual cgroup v2 process migration restrictions apply. See
+.BR cgroup (2)
+for detailed information.
+.TP
 .BR CLONE_DETACHED " (historical)"
 For a while (during the Linux 2.5 development series)
 .\" added in 2.5.32; removed in 2.6.0-test4

base-commit: ff5de6ecc4338f4b62c3459c99bd1a3a75ee2808
-- 
2.26.0

