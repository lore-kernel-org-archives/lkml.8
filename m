Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B38C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD04206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607869;
	bh=30lIdOgIR4E5Pr2Mp9zRhzVtOzIvckW45ctdrOnh4AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F4wB1w65afGIpfPgE5VSMiYjtdmmmEa4IfSXHNfAXcvdf2bglvvaQ6sqAKkPUVjWY
	 nH1i496kJMnFVbhwStxSMo3g833fKgcQLNkuWX0+4Abuh1JLFjghGH15KGOwhvVrEg
	 aPvD/C2jSjEwrcMO8KKoX3dGgvAWqOzUTJwUhAA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388011AbgBMPbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:31:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:52460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387471AbgBMP1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:46 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 833A3222C2;
        Thu, 13 Feb 2020 15:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607665;
        bh=30lIdOgIR4E5Pr2Mp9zRhzVtOzIvckW45ctdrOnh4AM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=flr+kXadkGPgkWfDBQ5iBakSQwip1NlFXJPWxGM2tbx5P4R4KXlzqzDmgFmb7+nCt
         jtsTM7DVmNMBJfgumC7sZfaNsRhY09r7wuPgwe4/dlzfPSZyE56FBY8i/ZBtUSYahF
         0sSRXZm4kGN8+iF7uR3qOQordvdYoWNMZRYSfJ1s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 5.4 86/96] selinux: fix regression introduced by move_mount(2) syscall
Date:   Thu, 13 Feb 2020 07:21:33 -0800
Message-Id: <20200213151911.459785249@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151839.156309910@linuxfoundation.org>
References: <20200213151839.156309910@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Smalley <sds@tycho.nsa.gov>

commit 98aa00345de54b8340dc2ddcd87f446d33387b5e upstream.

commit 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts around")
introduced a new move_mount(2) system call and a corresponding new LSM
security_move_mount hook but did not implement this hook for any existing
LSM.  This creates a regression for SELinux with respect to consistent
checking of mounts; the existing selinux_mount hook checks mounton
permission to the mount point path.  Provide a SELinux hook
implementation for move_mount that applies this same check for
consistency.  In the future we may wish to add a new move_mount
filesystem permission and check as well, but this addresses
the immediate regression.

Fixes: 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts around")
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/hooks.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2766,6 +2766,14 @@ static int selinux_mount(const char *dev
 		return path_has_perm(cred, path, FILE__MOUNTON);
 }
 
+static int selinux_move_mount(const struct path *from_path,
+			      const struct path *to_path)
+{
+	const struct cred *cred = current_cred();
+
+	return path_has_perm(cred, to_path, FILE__MOUNTON);
+}
+
 static int selinux_umount(struct vfsmount *mnt, int flags)
 {
 	const struct cred *cred = current_cred();
@@ -6835,6 +6843,8 @@ static struct security_hook_list selinux
 	LSM_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
 	LSM_HOOK_INIT(sb_add_mnt_opt, selinux_add_mnt_opt),
 
+	LSM_HOOK_INIT(move_mount, selinux_move_mount),
+
 	LSM_HOOK_INIT(dentry_init_security, selinux_dentry_init_security),
 	LSM_HOOK_INIT(dentry_create_files_as, selinux_dentry_create_files_as),
 


