Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D83CC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77AA82083E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825187;
	bh=7jw05OWTpoGSzrigMFDCv1fn3HTWY8WK7WIiiMyCcDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pqrtuFg7zEXZXAIjk1J0pfl9Pr4b17QfIGSMYjC+Bod0hsIHq7VbhjTojoGyu6iJi
	 c130YQSbsLL6AkuhGgxM21PMv5QILuwlGR/Q2ZrdWXMgcoaDWQFN55+lNVDmtK7Bgm
	 sLumgss5m7NxLWypnrbURsrMG/gczO2L6HxNTyI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733159AbgERSG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729488AbgERSGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:06:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 099AD20671;
        Mon, 18 May 2020 18:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589825182;
        bh=7jw05OWTpoGSzrigMFDCv1fn3HTWY8WK7WIiiMyCcDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZApVvlMftK88H952Y5Z69+ZI7PrHiJ2UvNDS6u89mWzUOMEfzKewPwUBfMjktGDX+
         RKT0+ZE3/yFkK9gkWloGRiT9Yk0k+22t7Rfg0S0nwvybhOb6RxtAmxICHnVvqb1dws
         2dFl9cqAJnYQAtFlp8HgaKqNmF5CkI+/vTIFfliE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 5.6 160/194] exec: Move would_dump into flush_old_exec
Date:   Mon, 18 May 2020 19:37:30 +0200
Message-Id: <20200518173544.535588494@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com>

commit f87d1c9559164294040e58f5e3b74a162bf7c6e8 upstream.

I goofed when I added mm->user_ns support to would_dump.  I missed the
fact that in the case of binfmt_loader, binfmt_em86, binfmt_misc, and
binfmt_script bprm->file is reassigned.  Which made the move of
would_dump from setup_new_exec to __do_execve_file before exec_binprm
incorrect as it can result in would_dump running on the script instead
of the interpreter of the script.

The net result is that the code stopped making unreadable interpreters
undumpable.  Which allows them to be ptraced and written to disk
without special permissions.  Oops.

The move was necessary because the call in set_new_exec was after
bprm->mm was no longer valid.

To correct this mistake move the misplaced would_dump from
__do_execve_file into flos_old_exec, before exec_mmap is called.

I tested and confirmed that without this fix I can attach with gdb to
a script with an unreadable interpreter, and with this fix I can not.

Cc: stable@vger.kernel.org
Fixes: f84df2a6f268 ("exec: Ensure mm->user_ns contains the execed files")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/exec.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1277,6 +1277,8 @@ int flush_old_exec(struct linux_binprm *
 	 */
 	set_mm_exe_file(bprm->mm, bprm->file);
 
+	would_dump(bprm, bprm->file);
+
 	/*
 	 * Release all of the old mmap stuff
 	 */
@@ -1820,8 +1822,6 @@ static int __do_execve_file(int fd, stru
 	if (retval < 0)
 		goto out;
 
-	would_dump(bprm, bprm->file);
-
 	retval = exec_binprm(bprm);
 	if (retval < 0)
 		goto out;


