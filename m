Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999CCC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 23:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77F6A206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 23:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D+lY/P9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgEEXki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 19:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727895AbgEEXki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 19:40:38 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2850DC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 16:40:38 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 18so67667pfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 16:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=4UsiQEJlpHvNjogsTjRtwbhweGbFHrJ8/i8ZZUfmC+w=;
        b=D+lY/P9QNjNJywA54T1ZcFj3iJODBKhVN5RtyicD4nWTr4Q2phgjlsSKAxueTVo0Qc
         PzVJAePs4v5jk0HhmK21d0FovIQ4gAYOws8PsNMC2+Y67uRorPwmHVSs4QnYpTC75W4U
         vMRlsKEliNJNFNxvQzj94SnYglwufcwogLX2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4UsiQEJlpHvNjogsTjRtwbhweGbFHrJ8/i8ZZUfmC+w=;
        b=Y9o3oxoXx602Eqges2zKlv1Ia94zV261bAdwvT81silMOBBCAgMtz5AXpktpkRAgaC
         7ZDxDbX7scI3UKFuRfW84QZwtuiO2m6fMD8NJdInofRKZa4WTt+ieG3LDiK8LZ1y8MTr
         dallt07Y2MHmftR0j+g8vAljxjex5pNpJHpXOlCB79AboojcMIHBhMpa7xuXw16tFiYk
         gxvjD2W0+Bg/AfUc11lEZKaKXucffFs4hheClgSNrGJEriCx5SRWBV2EyDUjrvM598G2
         A32+t1xr88qaSNlTn52uc+K5ZXUbd9VK52BvOsvEvzbAK/f3c0ouf5xHIXiuI3JFH0MP
         u8pQ==
X-Gm-Message-State: AGi0PuZVT6zZHIU1aB+h/VSwoFEOgc0Ifuduq6ch0qkagWfXRINDT5TU
        n9rBLksI5b8l27n0OpPV3kMordsBqEg=
X-Google-Smtp-Source: APiQypJgtWzUVi0Gq7Ko8Hj2XUWBKGf2u62N8+xeB16/nLRESC0J3TehMvK+QlU6UBeylr3nflUnCg==
X-Received: by 2002:a62:6341:: with SMTP id x62mr5732071pfb.289.1588722037677;
        Tue, 05 May 2020 16:40:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g6sm2940247pjx.48.2020.05.05.16.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 16:40:36 -0700 (PDT)
Date:   Tue, 5 May 2020 16:40:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] securityfs: Add missing d_delete() call on removal
Message-ID: <202005051626.7648DC65@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After using simple_unlink(), a call to d_delete() is needed in addition
to dput().

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Is this correct? I went looking around and there are a lot of variations
on the simple_unlink() pattern...

Many using explicit locking and combinations of d_drop(), __d_drop(), etc.


Some missing d_delete()?

security/inode.c:			simple_unlink(dir, dentry);
security/inode.c-		d_delete(dentry);
security/inode.c-		dput(dentry);
--
arch/powerpc/platforms/cell/spufs/inode.c:			simple_unlink(d_inode(dir), dentry);
arch/powerpc/platforms/cell/spufs/inode.c-			/* XXX: what was dcache_lock protecting here? Other
arch/powerpc/platforms/cell/spufs/inode.c-			 * filesystems (IB, configfs) release dcache_lock
arch/powerpc/platforms/cell/spufs/inode.c-			 * before unlink */
arch/powerpc/platforms/cell/spufs/inode.c-			dput(dentry);

Should use d_delete() instead of d_drop()?

arch/s390/hypfs/inode.c:			simple_unlink(d_inode(parent), dentry);
arch/s390/hypfs/inode.c-	}
arch/s390/hypfs/inode.c-	d_drop(dentry);
arch/s390/hypfs/inode.c-	dput(dentry);
arch/s390/hypfs/inode.c-	inode_unlock(d_inode(parent));
arch/s390/hypfs/inode.c-}

Correct?

drivers/android/binderfs.c:		simple_unlink(parent_inode, dentry);
drivers/android/binderfs.c-		d_delete(dentry);
drivers/android/binderfs.c-		dput(dentry);
--
fs/nfsd/nfsctl.c:	ret = simple_unlink(dir, dentry);
fs/nfsd/nfsctl.c-	d_delete(dentry);
fs/nfsd/nfsctl.c-	dput(dentry);
--
net/sunrpc/rpc_pipe.c:	ret = simple_unlink(dir, dentry);
net/sunrpc/rpc_pipe.c-	if (!ret)
net/sunrpc/rpc_pipe.c-		fsnotify_unlink(dir, dentry);
net/sunrpc/rpc_pipe.c-	d_delete(dentry);
net/sunrpc/rpc_pipe.c-	dput(dentry);
--
security/apparmor/apparmorfs.c:			simple_unlink(dir, dentry);
security/apparmor/apparmorfs.c-		d_delete(dentry);
security/apparmor/apparmorfs.c-		dput(dentry);

---
 security/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/inode.c b/security/inode.c
index 6c326939750d..606f390d21d2 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -306,6 +306,7 @@ void securityfs_remove(struct dentry *dentry)
 			simple_rmdir(dir, dentry);
 		else
 			simple_unlink(dir, dentry);
+		d_delete(dentry);
 		dput(dentry);
 	}
 	inode_unlock(dir);
-- 
2.20.1


-- 
Kees Cook
