Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E025C10F26
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 21:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AF3206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 21:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hotdlW0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733263AbgDAVjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:39:22 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:50332 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733234AbgDAVjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 17:39:19 -0400
Received: by mail-pg1-f202.google.com with SMTP id d69so1162764pga.17
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 14:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6jHUkktZYnLJuOeQ47HqdKglnmNwVQppeyvzohEh60E=;
        b=hotdlW0vSo7Oc3YxuZoamTSPRrrrCvU+Z/v14Y5TkSuQsHiFXXabwUoA4+ordhQ+yY
         u+mtyjvIbg9v2Ot3PDkqXjTHa2iEo0J9ObAgkbbzSl9p9j2aK9u2mg8Qq6j6keVwuGy1
         PI5+B5+KEI7XCrqDtNZOh48toONEbTskQx/DIzDE5EiBFSrXEolidC9r3D8u3rsgwsDS
         JZjj4nkITZsbKM/AURXIzmjOhbmgscw5me/yZJZupSNHAZFDco3sglkfZXWOSbuErxSj
         mqYYWH1AEGQEFZe+lb3nZbnwk4Q46t+nE9Rt88CyOSFS6m+XADbiYLljjNdFjlhYlIRy
         Bnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6jHUkktZYnLJuOeQ47HqdKglnmNwVQppeyvzohEh60E=;
        b=s4C4Gwd9jyzEdUtMZqPUCklpNptz1BUnRiakx0Fq9eANMkMP5GDLN86eOCJ/y18bI7
         NKukFYJCYzMnAUbFsD0VZvUGI6Akbo4gGcAmAnuO6Z4EBeyhH2dmU2SYyRpQ19M/8/Qx
         dWR5gJuGEsmpLU6ZMaOlerpL4U2LOnzRgf8ojgEOx/2hcPanvUMh9Wu/SnTy3ugU49Zf
         EU0SBQ3EVvS7nBmx30wj4HF0WG/XbNaQxeny2UCq7V3F5LM7iOwpGMp7UroKQ9oO76w8
         ljvQ2nBldEisbxJ2mK4+CY1csEzeMHVKwXxA3XylGYnnNgQk6CY1T2iIRjI+CFGuweIe
         WfIg==
X-Gm-Message-State: AGi0PubMU0KqSLbkPi8WTyeuFwc6K25kV61jTD3D8PgGuoHZAugdRIs3
        stzOHwVXFKLl9wZ6C81J/A6uNxp0t+k=
X-Google-Smtp-Source: APiQypKviZ9567+jlzh79cNJ6g2InF7Sdo6NYY3WsjYqgIh8KYFj7B9dbw3YAfWPvDLTzocuUWrG0tnX9aM=
X-Received: by 2002:a17:90a:cc10:: with SMTP id b16mr32757pju.29.1585777157804;
 Wed, 01 Apr 2020 14:39:17 -0700 (PDT)
Date:   Wed,  1 Apr 2020 14:39:02 -0700
In-Reply-To: <20200401213903.182112-1-dancol@google.com>
Message-Id: <20200401213903.182112-3-dancol@google.com>
Mime-Version: 1.0
References: <20200326200634.222009-1-dancol@google.com> <20200401213903.182112-1-dancol@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v5 2/3] Teach SELinux about anonymous inodes
From:   Daniel Colascione <dancol@google.com>
To:     timmurray@google.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, sds@tycho.nsa.gov, lokeshgidra@google.com,
        jmorris@namei.org
Cc:     Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change uses the anon_inodes and LSM infrastructure introduced in
the previous patch to give SELinux the ability to control
anonymous-inode files that are created using the new _secure()
anon_inodes functions.

A SELinux policy author detects and controls these anonymous inodes by
adding a name-based type_transition rule that assigns a new security
type to anonymous-inode files created in some domain. The name used
for the name-based transition is the name associated with the
anonymous inode for file listings --- e.g., "[userfaultfd]" or
"[perf_event]".

Example:

type uffd_t;
type_transition sysadm_t sysadm_t : anon_inode uffd_t "[userfaultfd]";
allow sysadm_t uffd_t:anon_inode { create };

(The next patch in this series is necessary for making userfaultfd
support this new interface.  The example above is just
for exposition.)

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 security/selinux/hooks.c            | 53 +++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 ++
 2 files changed, 55 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1659b59fb5d7..6f7222d2e404 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2915,6 +2915,58 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	return 0;
 }
 
+static int selinux_inode_init_security_anon(struct inode *inode,
+					    const struct qstr *name,
+					    const struct inode *context_inode)
+{
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	struct common_audit_data ad;
+	struct inode_security_struct *isec;
+	int rc;
+
+	if (unlikely(!selinux_state.initialized))
+		return 0;
+
+	isec = selinux_inode(inode);
+
+	/*
+	 * We only get here once per ephemeral inode.  The inode has
+	 * been initialized via inode_alloc_security but is otherwise
+	 * untouched.
+	 */
+
+	if (context_inode) {
+		struct inode_security_struct *context_isec =
+			selinux_inode(context_inode);
+		isec->sclass = context_isec->sclass;
+		isec->sid = context_isec->sid;
+	} else {
+		isec->sclass = SECCLASS_ANON_INODE;
+		rc = security_transition_sid(
+			&selinux_state, tsec->sid, tsec->sid,
+			isec->sclass, name, &isec->sid);
+		if (rc)
+			return rc;
+	}
+
+	isec->initialized = LABEL_INITIALIZED;
+
+	/*
+	 * Now that we've initialized security, check whether we're
+	 * allowed to actually create this type of anonymous inode.
+	 */
+
+	ad.type = LSM_AUDIT_DATA_INODE;
+	ad.u.inode = inode;
+
+	return avc_has_perm(&selinux_state,
+			    tsec->sid,
+			    isec->sid,
+			    isec->sclass,
+			    FILE__CREATE,
+			    &ad);
+}
+
 static int selinux_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	return may_create(dir, dentry, SECCLASS_FILE);
@@ -6923,6 +6975,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(inode_free_security, selinux_inode_free_security),
 	LSM_HOOK_INIT(inode_init_security, selinux_inode_init_security),
+	LSM_HOOK_INIT(inode_init_security_anon, selinux_inode_init_security_anon),
 	LSM_HOOK_INIT(inode_create, selinux_inode_create),
 	LSM_HOOK_INIT(inode_link, selinux_inode_link),
 	LSM_HOOK_INIT(inode_unlink, selinux_inode_unlink),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 986f3ac14282..263750b6aaac 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -248,6 +248,8 @@ struct security_class_mapping secclass_map[] = {
 	  {"open", "cpu", "kernel", "tracepoint", "read", "write"} },
 	{ "lockdown",
 	  { "integrity", "confidentiality", NULL } },
+	{ "anon_inode",
+	  { COMMON_FILE_PERMS, NULL } },
 	{ NULL }
   };
 
-- 
2.26.0.rc2.310.g2932bb562d-goog

