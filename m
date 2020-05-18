Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0BDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C19D620671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="gzTIjf10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbgERSS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731559AbgERRz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:55:56 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3C3C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 10:55:56 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g14so542520wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 10:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bAdNBlANOE194kXAkMzs8wkwLbdmMZKVzS7nRAabSx0=;
        b=gzTIjf10gpIkG8zPGdhSboUtjnxE2wdlyz+lcTb6y+vDqZANzuEWOloXv/+55QJx3P
         Id/QaiwCpZNSFbDSLMi750vq3rM4sB7FtcXIFBDjtjy2r6amW5caSDAaO74p9eR7GQ4V
         GKPquEbSy/LdmHP89ioSUV5vzb6Sx6k0weZMRoHrJJpQ+llJ5Nud8Qh6SaKzJ7h9yO+h
         23wERq3aVksJk/PoeACaB0WtZD5CFPVObYqaIq/xe2qq7LPHezjXlfY7Y0i6AwqnFFCK
         zrwJkcM1+rgKkMNnGz6K9tIQrvurV+dMIBStlFk8C1ucRIddZurStfA/ui5OL38PkMQN
         CSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bAdNBlANOE194kXAkMzs8wkwLbdmMZKVzS7nRAabSx0=;
        b=VvbY2k9PbDN7lUMbYMtSiGSCzbo8WlHqWx5jplgcwsSM5ifUgu+apb701DfxpzAZBQ
         Bb0UL07A0S2ZGTyraSfA7rbfVieMYUPCHrM7P/yLByV4DFbuFjSZWWoxg59/qzJQE2rv
         RHWxFI03gHeuxtBNlHCdZemiMsy4Ft/hcSaVfFYrGrmew1UFAx80yZUrFQCG82ASW/Pu
         FX7eTPTIGQVOVAKN0HQkkqaOitLDP/Ab7R0bW2NaeusJEzJIs33q/+qbJr/gCECHHXCJ
         U2L7BXvzwhOot+KuFbm5J3BIMWfGn7F3rao8ohsvMWdrSui8EVWOzUiDDrugkpxnp7dD
         1fDQ==
X-Gm-Message-State: AOAM532HqOaScrB36jcQAZeyczimn487cUnqoYLyJT7qOxXUD73+SIkC
        dxqXIjnHTDjVf/ETXjdjFdb2hw==
X-Google-Smtp-Source: ABdhPJyVhEVa6wUfN5Iclx7RIJ1MPf7e+9V56eLAnJDuJP2dgTk8ixex8477YXQfniRzR3z2bqxrnQ==
X-Received: by 2002:a1c:7212:: with SMTP id n18mr555920wmc.129.1589824554821;
        Mon, 18 May 2020 10:55:54 -0700 (PDT)
Received: from wittgenstein.fritz.box (ip5f5af183.dynamic.kabel-deutschland.de. [95.90.241.131])
        by smtp.gmail.com with ESMTPSA id w9sm19178579wrc.27.2020.05.18.10.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 10:55:54 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     mtk.manpages@gmail.com
Cc:     cgroups@vger.kernel.org, christian.brauner@ubuntu.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org, oleg@redhat.com, tj@kernel.org
Subject: [PATCH v2] clone.2: Document CLONE_INTO_CGROUP
Date:   Mon, 18 May 2020 19:55:49 +0200
Message-Id: <20200518175549.3400948-1-christian@brauner.io>
X-Mailer: git-send-email 2.26.2
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
/* v2 */
- Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>:
  - Fix various types and add examples and how to specify the file
    descriptor.
---
 man2/clone.2 | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/man2/clone.2 b/man2/clone.2
index 8b70b78a4..33594ddc5 100644
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
@@ -448,6 +449,48 @@ Specifying this flag together with
 .B CLONE_SIGHAND
 is nonsensical and disallowed.
 .TP
+.BR CLONE_INTO_CGROUP " (since Linux 5.7)"
+.\" commit ef2c41cf38a7559bbf91af42d5b6a4429db8fc68
+By default, the child process will be placed in the same version 2
+cgroup as its parent.
+If this flag is specified the child process will be created in a
+different cgroup than its parent.
+Note, that
+.BR CLONE_INTO_CGROUP
+is limited to version 2 cgroups. To use this feature, callers
+need to raise
+.BR CLONE_INTO_CGROUP
+in
+.I cl_args.flags
+and pass a directory file descriptor (see the
+.BR O_DIRECTORY
+flag for the
+.BR open (2)
+syscall) in the
+.I cl_args.cgroup.
+The caller may also pass an
+.BR O_PATH
+(see
+.BR open (2))
+file descriptor for the target cgroup.
+Note, that all usual version 2 cgroup migration restrictions (see
+.BR cgroups (7)
+for details) apply.
+
+Spawning a process into a cgroup different from the parent's cgroup
+makes it possible for a service manager to directly spawn new
+services into dedicated cgroups. This allows eliminating accounting
+jitter which would be caused by the new process living in the
+parent's cgroup for a short amount of time before being
+moved into the target cgroup. This flag also allows the creation of
+frozen child process by spawning them into a frozen cgroup (see
+.BR cgroups (7)
+for a description of the freezer feature in version 2 cgroups).
+For threaded applications or even thread implementations which
+make use of cgroups to limit individual threads it is possible to
+establish a fixed cgroup layout before spawning each thread
+directly into its target cgroup.
+.TP
 .BR CLONE_DETACHED " (historical)"
 For a while (during the Linux 2.5 development series)
 .\" added in 2.5.32; removed in 2.6.0-test4

base-commit: aa02339ca45030711b42a1af12e3ee3405c1c5c7
-- 
2.26.2

