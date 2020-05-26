Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58626C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A1B206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgEZSmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:42:20 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:37560 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgEZSmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:42:19 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jdeWm-0004bd-Ge; Tue, 26 May 2020 12:42:16 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jdeWl-0004ZB-Jd; Tue, 26 May 2020 12:42:16 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 26 May 2020 13:38:26 -0500
Message-ID: <871rn6a6e5.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jdeWl-0004ZB-Jd;;;mid=<871rn6a6e5.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19LRaZTE99szAlTGkTt2wniDdqgfpvuPi8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [GIT PULL] Please pull exec fix for v5.7
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull the exec-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-linus

   HEAD: a4ae32c71fe90794127b32d26d7ad795813b502e exec: Always set cap_ambient in cap_bprm_set_creds

While working on my exec cleanups I found a bug in exec that winds
up miscomputing the ambient credentials during exec.  Andy appears
as to credentials are computed for both the script and the interpreter.

From the original patch description:

[3] Linux very confusingly processes both the script and the interpreter
    if applicable, for reasons that elude me.  The results from thinking
    about a script's file capabilities and/or setuid bits are mostly
    discarded.

The only value in struct cred that gets changed in cap_bprm_set_creds
that I could find that might persist between the script and the
interpreter was cap_ambient.  Which is fixed with this trivial change.

Eric

From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 25 May 2020 12:56:15 -0500
Subject: [PATCH] exec: Always set cap_ambient in cap_bprm_set_creds

An invariant of cap_bprm_set_creds is that every field in the new cred
structure that cap_bprm_set_creds might set, needs to be set every
time to ensure the fields does not get a stale value.

The field cap_ambient is not set every time cap_bprm_set_creds is
called, which means that if there is a suid or sgid script with an
interpreter that has neither the suid nor the sgid bits set the
interpreter should be able to accept ambient credentials.
Unfortuantely because cap_ambient is not reset to it's original value
the interpreter can not accept ambient credentials.

Given that the ambient capability set is expected to be controlled by
the caller, I don't think this is particularly serious.  But it is
definitely worth fixing so the code works correctly.

I have tested to verify my reading of the code is correct and the
interpreter of a sgid can receive ambient capabilities with this
change and cannot receive ambient capabilities without this change.

Cc: stable@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Fixes: 58319057b784 ("capabilities: ambient capabilities")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 security/commoncap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/commoncap.c b/security/commoncap.c
index f4ee0ae106b2..0ca31c8bc0b1 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -812,6 +812,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 	int ret;
 	kuid_t root_uid;
 
+	new->cap_ambient = old->cap_ambient;
 	if (WARN_ON(!cap_ambient_invariant_ok(old)))
 		return -EPERM;
 
-- 
2.20.1
