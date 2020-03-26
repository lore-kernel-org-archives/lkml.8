Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7F6C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5CE206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ffjr9V6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgCZUGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 16:06:52 -0400
Received: from mail-qv1-f74.google.com ([209.85.219.74]:49826 "EHLO
        mail-qv1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbgCZUGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:06:51 -0400
Received: by mail-qv1-f74.google.com with SMTP id u12so5745015qvs.16
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 13:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jxOc9o6NdvdCnjWFdn8kUz8yJ8bzL6ZGVJ74OA5uXfY=;
        b=Ffjr9V6LlkXfWH5QWPvkkOxpxxaPg2dBmP9aODBfh2MLONLCpKoT5k6cl3xcUKMvoK
         RQzzut1js/XvxLH1WYNzXDMxzX/EUHXmEsJjRsd0rxdpdtySLJicp7wXKmiALgbYim3E
         6+WdDcZIplOzHSme1fEbEIyao/XjxmX4fDidOvBTabMGEHqP9x9xqJls0Ih4lpPheMUE
         SThJQS41nDzmr15P9GPI0LlcZCAHx3mEzRVxzGHnuqrdlfKC9JYb69H4B7ke/lcJyHhW
         74YCrn8uaVita3ZLizNU2C8Qiv8rvRuFk4BSMQKezoD4iCwQC6QACAFgpb0AjRumR3ud
         DgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jxOc9o6NdvdCnjWFdn8kUz8yJ8bzL6ZGVJ74OA5uXfY=;
        b=aEvKZSi5cCPLtI3YF7hp5v5/5OPZ1LySG3GjJB0jC2hmbWnyXLl4F6lARzvFNQcMQS
         ULViUBWeZoOF1z9tlKMLXML9Oo60KdgxiG39E5lwCvfuEkCF0qIFs/jSsl/QkgKePn8K
         dtlFDOoz3QrYrEziC1WTv8t92zgXJcTIA30KuiIgWDlzR/hu+gL/n5zYb870eC+foVQU
         PFSKVNckJ/SbAdQkXOykxQgL2IUV5Cl0/FUQFObinjMBxR/8UJ/lxKM+Rmf2vT7c0AP3
         2X1tAa9OmCDDfQ3j31F81I1SePcNH1OfQh7M2ZE9C3y5pG3v1A3iLbhMM4CJ83tzpiXF
         HWkg==
X-Gm-Message-State: ANhLgQ0LbE8M8FtMP5crViwfm608Hd9cnsHKW6s2X3h+kDz/m7f+AzUJ
        TxKO+3WrN+1AEJPEHyooYTyrJ3Z41Zs=
X-Google-Smtp-Source: ADFU+vvaexDqyLY8GoD+ICFTM/vR7zLUOM6FxoFEd6oCKQxs/tDvOvNnpUYgLbAaeb0sHk5Q7eX0naECVtc=
X-Received: by 2002:ac8:1c17:: with SMTP id a23mr10721235qtk.239.1585253209979;
 Thu, 26 Mar 2020 13:06:49 -0700 (PDT)
Date:   Thu, 26 Mar 2020 13:06:33 -0700
In-Reply-To: <20200326200634.222009-1-dancol@google.com>
Message-Id: <20200326200634.222009-3-dancol@google.com>
Mime-Version: 1.0
References: <20200326181456.132742-1-dancol@google.com> <20200326200634.222009-1-dancol@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v4 2/3] Teach SELinux about anonymous inodes
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
2.25.1.696.g5e7596f4ac-goog

