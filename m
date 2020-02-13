Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2125C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789A92073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608338;
	bh=hezexXoqhoHQQYWxAbijaaWThtMnIPAMPMWTUGaVRq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KbJuW1s56O0uEvBzngKcktOU0eYLS6QcpQwyO5xBltytoxblvTT6vh8I9Hx0pobdG
	 LvFGTQLL/DGai9xBHqBfdly+nVTx5uKwYwdLl1mpM6K33ATCF5yaCrNw75YCf2/V9f
	 LCA1RfdkKKX1FPDO0i6v67uwznTxPFPjoSqfxHbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgBMPi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:38:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728831AbgBMP3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:29:09 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2590F24676;
        Thu, 13 Feb 2020 15:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607749;
        bh=hezexXoqhoHQQYWxAbijaaWThtMnIPAMPMWTUGaVRq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FQSCmGFKKngHi9+mT87qff0UWT9AJ8/sIGVnyFVpNN9/Uxx1JVdRLg2DafjCWTGxB
         JKjuxeL6ECgxS8Cw94mEMk/kyLTYtWQkW2aHaufrZdDwrLAE2Ri6oMbP7GNacWiBU/
         tY65tavrAS9ck3w7tUrw7KW6DH2zeOM3S0uNfo30=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 5.5 108/120] selinux: fix regression introduced by move_mount(2) syscall
Date:   Thu, 13 Feb 2020 07:21:44 -0800
Message-Id: <20200213151936.963056082@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
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
@@ -2762,6 +2762,14 @@ static int selinux_mount(const char *dev
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
@@ -6904,6 +6912,8 @@ static struct security_hook_list selinux
 	LSM_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
 	LSM_HOOK_INIT(sb_add_mnt_opt, selinux_add_mnt_opt),
 
+	LSM_HOOK_INIT(move_mount, selinux_move_mount),
+
 	LSM_HOOK_INIT(dentry_init_security, selinux_dentry_init_security),
 	LSM_HOOK_INIT(dentry_create_files_as, selinux_dentry_create_files_as),
 


