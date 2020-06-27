Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79162C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 15:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53B3D218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 15:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0Cb6Bvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgF0PTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 11:19:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32229 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725975AbgF0PTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 11:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593271154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=eLwTLImb7enkGubyMMaYkyOwPQksw78zQ5jTtq8zfrE=;
        b=Y0Cb6Bvsir3aa1db6ppz8sYkSlikeR1bmkgCF2zQFePuXnNL91TM/HQpVtDmwROf1GJHUg
        QZKBuAo+C/1zPcXjRJ41BH37buXkW2ul6o0xTiyNLwMB7fIik5GmAA60QuAcjF9VZgtZxv
        WtEktcySZ6qK0yciOvF13Lc9XN5ovak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-v65Xn0LINXan-uUb1hG0ag-1; Sat, 27 Jun 2020 11:19:12 -0400
X-MC-Unique: v65Xn0LINXan-uUb1hG0ag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81C96107ACCA;
        Sat, 27 Jun 2020 15:19:11 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40EF460BF4;
        Sat, 27 Jun 2020 15:19:06 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        nhorman@redhat.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v9 05/11] start normalization containerid support
Date:   Sat, 27 Jun 2020 11:18:05 -0400
Message-Id: <1593271091-30188-6-git-send-email-rgb@redhat.com>
In-Reply-To: <1593271091-30188-1-git-send-email-rgb@redhat.com>
References: <1593271091-30188-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 auparse/auparse-defs.h           |  3 ++-
 auparse/interpret.c              | 10 ++++++++++
 auparse/normalize_record_map.h   |  2 ++
 auparse/typetab.h                |  2 ++
 bindings/python/auparse_python.c |  1 +
 5 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/auparse/auparse-defs.h b/auparse/auparse-defs.h
index 27bfa943612c..a9b144df3462 100644
--- a/auparse/auparse-defs.h
+++ b/auparse/auparse-defs.h
@@ -87,7 +87,8 @@ typedef enum {  AUPARSE_TYPE_UNCLASSIFIED,  AUPARSE_TYPE_UID, AUPARSE_TYPE_GID,
 	AUPARSE_TYPE_PROCTITLE, AUPARSE_TYPE_HOOK,
 	AUPARSE_TYPE_NETACTION, AUPARSE_TYPE_MACPROTO,
 	AUPARSE_TYPE_IOCTL_REQ, AUPARSE_TYPE_ESCAPED_KEY,
-	AUPARSE_TYPE_ESCAPED_FILE, AUPARSE_TYPE_FANOTIFY } auparse_type_t;
+	AUPARSE_TYPE_ESCAPED_FILE, AUPARSE_TYPE_FANOTIFY, AUPARSE_TYPE_CONTID
+} auparse_type_t;
 
 /* This type determines what escaping if any gets applied to interpreted fields */
 typedef enum { AUPARSE_ESC_RAW, AUPARSE_ESC_TTY, AUPARSE_ESC_SHELL,
diff --git a/auparse/interpret.c b/auparse/interpret.c
index e23c3533877b..14fcc72148c8 100644
--- a/auparse/interpret.c
+++ b/auparse/interpret.c
@@ -2843,6 +2843,13 @@ static const char *print_seccomp_code(const char *val)
 	return out;
 }
 
+static const char *print_contid(const char *val)
+{
+	if (strcmp(val, "18446744073709551615") == 0 || strcmp(val, "-1") == 0)
+		return strdup("unset");
+	return strdup(val);
+}
+
 int lookup_type(const char *name)
 {
 	int i;
@@ -3083,6 +3090,9 @@ unknown:
 		case AUPARSE_TYPE_FANOTIFY:
 			out = print_fanotify(id->val);
 			break;
+		case AUPARSE_TYPE_CONTID:
+			out = print_contid(id->val);
+			break;
 		case AUPARSE_TYPE_MAC_LABEL:
 		case AUPARSE_TYPE_UNCLASSIFIED:
 		default:
diff --git a/auparse/normalize_record_map.h b/auparse/normalize_record_map.h
index fee778e76db7..7332249c7b34 100644
--- a/auparse/normalize_record_map.h
+++ b/auparse/normalize_record_map.h
@@ -25,6 +25,7 @@
 
 _S(AUDIT_USER, "sent-message")
 _S(AUDIT_LOGIN, "changed-login-id-to")
+_S(AUDIT_CONTAINER_OP, "changed-container-id-to")
 _S(AUDIT_USER_AUTH, "authenticated")
 _S(AUDIT_USER_ACCT, "was-authorized")
 _S(AUDIT_USER_MGMT, "modified-user-account")
@@ -84,6 +85,7 @@ _S(AUDIT_FEATURE_CHANGE, "changed-audit-feature")
 //_S(AUDIT_REPLACE,"")
 _S(AUDIT_KERN_MODULE, "loaded-kernel-module")
 _S(AUDIT_FANOTIFY, "accessed-policy-controlled-file")
+_S(AUDIT_CONTAINER_ID, "has-container-id")
 _S(AUDIT_AVC, "accessed-mac-policy-controlled-object")
 _S(AUDIT_MAC_POLICY_LOAD, "loaded-selinux-policy")
 _S(AUDIT_MAC_STATUS, "changed-selinux-enforcement-to")
diff --git a/auparse/typetab.h b/auparse/typetab.h
index 0391e87f731c..0c160bb56c3b 100644
--- a/auparse/typetab.h
+++ b/auparse/typetab.h
@@ -142,3 +142,5 @@ _S(AUPARSE_TYPE_IOCTL_REQ,	"ioctlcmd"	)
 _S(AUPARSE_TYPE_FANOTIFY,	"resp"		)
 _S(AUPARSE_TYPE_ESCAPED,	"sw"		)
 _S(AUPARSE_TYPE_ESCAPED,	"root_dir"	)
+_S(AUPARSE_TYPE_CONTID,		"contid"	)
+_S(AUPARSE_TYPE_CONTID,		"old-contid"	)
diff --git a/bindings/python/auparse_python.c b/bindings/python/auparse_python.c
index 1ba59cf78527..947d018cf594 100644
--- a/bindings/python/auparse_python.c
+++ b/bindings/python/auparse_python.c
@@ -2376,6 +2376,7 @@ initauparse(void)
     PyModule_AddIntConstant(m, "AUPARSE_ESC_TTY", AUPARSE_ESC_TTY);
     PyModule_AddIntConstant(m, "AUPARSE_ESC_SHELL", AUPARSE_ESC_SHELL);
     PyModule_AddIntConstant(m, "AUPARSE_ESC_SHELL_QUOTE", AUPARSE_ESC_SHELL_QUOTE);
+    PyModule_AddIntConstant(m, "AUPARSE_TYPE_CONTID", AUPARSE_TYPE_CONTID);
 
 #ifdef IS_PY3K
     return m;
-- 
1.8.3.1

