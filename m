Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29750C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0445E20672
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOW0pX1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgDUNwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:52:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44876 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726018AbgDUNwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587477141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ctzOqm9dtwbhRf44FvKp72RdNODJeokpu4mABLVWWLc=;
        b=iOW0pX1knburZPXTdgLmbX841WQ4r6M6+GlaQghwXtAfeGK9gok0Wv0LQweYrxXRpoeTIJ
        CGQ/JOd2/grlWsjC7+WuMxTD+nbjUMIKMk22CTvs8MnwcnrGDNjNm59SP95A0d652b0R+5
        g7qVK4l+y8VMENHrFdca+vTW+0Oq/3w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-xgIySdXoP2q5BseeMWZArA-1; Tue, 21 Apr 2020 09:51:43 -0400
X-MC-Unique: xgIySdXoP2q5BseeMWZArA-1
Received: by mail-wm1-f71.google.com with SMTP id o5so1470946wmo.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 06:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ctzOqm9dtwbhRf44FvKp72RdNODJeokpu4mABLVWWLc=;
        b=hAvZTuqQqwleeRV9raWU6vDX/y2uv79aJBJeLmalZnb2b92fPhUAIv03w3MBGuHnTB
         EKp+13NUm3/az2o7fxYCtSnwkmJ38KzftTbCpFou4sV+8rpwtvLYUoJaFSKe7FAuXY5J
         K1LQMZe2s/eWoh6i6YgJ5OjPvRlOngDJzJFgKF0KaMxuSFzwxnzw5XsZFM3u4WxWe/jA
         ccTZGHvX3ZhEfyPElJkFaFaQt0cs6adz4BGug9tKiVXgI/TWUHbGhRnP/9hdMJxHgGbh
         MaVJPA71Um4O9M342W4mSFwLrcB17TnzVSCYileb+60ZYPMqf09vBNbVP1daXnEvl6uy
         KjHw==
X-Gm-Message-State: AGi0PuaYQ0aX2BwhjHW9VP5443GJbsyfkcYqm+fscgxKQkJQl1OB9fAv
        m2wk0VzYncv8z7akX3hYSQMVUQ/Li9FEucOjJLjMSEInL5oU4xnBagwJCS4VaNMbYdV6a/1SzRy
        SgnCaaRgoCpcN80m8M89OMMf0
X-Received: by 2002:adf:fd0a:: with SMTP id e10mr23759644wrr.160.1587477102569;
        Tue, 21 Apr 2020 06:51:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypKYYb14rVpuN5IdJGjcztA4u7H/3dUDNtMGXdL7LsdIhh9n0qcoiv0NvYygrC3tIbBHwPH97A==
X-Received: by 2002:adf:fd0a:: with SMTP id e10mr23759618wrr.160.1587477102414;
        Tue, 21 Apr 2020 06:51:42 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.194])
        by smtp.gmail.com with ESMTPSA id a187sm3565830wmh.40.2020.04.21.06.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:51:41 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH v2 1/7] apparmor: just use vfs_kern_mount to make .null
Date:   Tue, 21 Apr 2020 15:51:13 +0200
Message-Id: <20200421135119.30007-2-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200421135119.30007-1-eesposit@redhat.com>
References: <20200421135119.30007-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aa_mk_null_file is using simple_pin_fs/simple_release_fs with local
variables as arguments, for what would amount to a simple
vfs_kern_mount/mntput pair if everything was inlined.  Just use
the normal filesystem API since the reference counting is not needed
here (it is a local variable and always 0 on entry and on exit).

There is no functional change intended.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 security/apparmor/apparmorfs.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 280741fc0f5f..36f848734902 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -2525,14 +2525,15 @@ struct path aa_null;
 
 static int aa_mk_null_file(struct dentry *parent)
 {
-	struct vfsmount *mount = NULL;
+	struct file_system_type *type = parent->d_sb->s_type;
+	struct vfsmount *mount;
 	struct dentry *dentry;
 	struct inode *inode;
-	int count = 0;
-	int error = simple_pin_fs(parent->d_sb->s_type, &mount, &count);
+	int error;
 
-	if (error)
-		return error;
+	mount = vfs_kern_mount(type, SB_KERNMOUNT, type->name, NULL);
+	if (IS_ERR(mount))
+		return PTR_ERR(mount);
 
 	inode_lock(d_inode(parent));
 	dentry = lookup_one_len(NULL_FILE_NAME, parent, strlen(NULL_FILE_NAME));
@@ -2561,7 +2562,7 @@ static int aa_mk_null_file(struct dentry *parent)
 	dput(dentry);
 out:
 	inode_unlock(d_inode(parent));
-	simple_release_fs(&mount, &count);
+	mntput(mount);
 	return error;
 }
 
-- 
2.25.2

