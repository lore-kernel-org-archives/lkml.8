Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDEAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 04:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B4A120873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 04:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwJEyyvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgE0ElB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 00:41:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26930 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725294AbgE0ElB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 00:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590554459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=62bWFuqjjYRHCtiXetCYD/KJZfcErk/k0VhDChgAXO8=;
        b=dwJEyyvSETF9zX3PtBrzHLr22eVX34elyMtkFqnM7uFvcw1qXDQLOBuggb3gYgwY9oz+Sr
        b9U+qg3PdSRcjtYpzgA2VI5C8uF3PGMd6jNNqS+7LvvLyfN1q+vAKx1kLeyzYEPscf5y+3
        DWUY2IDceWHQgDZrA3VeLzlk5TePNyE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-xqNSEbk6MrGVzz-G0Lg49A-1; Wed, 27 May 2020 00:40:55 -0400
X-MC-Unique: xqNSEbk6MrGVzz-G0Lg49A-1
Received: by mail-pj1-f72.google.com with SMTP id m7so1519408pjh.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 21:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=62bWFuqjjYRHCtiXetCYD/KJZfcErk/k0VhDChgAXO8=;
        b=YRooqK42a4O5T/bJA7TIOa6Q+TfMXRZgCOa/kwlDiQqo0i4TGhWbGbSTQl3zwNR34z
         ylK0buHatdWe36q7bUEpkyFMgrm7f+5Ah6STT/XSZZngErtTqHxyGl9FpWPLyotN/67B
         MqLl17tRc1JeJoOMeD+DynN7PvxQjAf1OXPS+b3P+d8SFURblkuFVd49paeqbf/FvjsX
         S1IWsARFP3UWJ5HomC1+1hT3B2g4ZPqs+BC5WRbiahjvo/xV6ee1nKBDpQnmSg5+ak7R
         PvU3EiJpoYhnh+FYXIx5SPVyVE72ngTFdDKoHXd8Y5dvlVXOWOI55/Z7ZBAoMi55TBiP
         rCHw==
X-Gm-Message-State: AOAM533eJFbC5LdOspfx2LM/S73svY+jeaGz+5AtMhDLEmo6OISYfCK7
        veYo4VrcPmd2XHzOGqxqJyowYIn5rGZPM2of/HFRFJA0T+9Y8dDGVj/eaL45kB0RW9fEijBWURo
        RftLPiNM+zdJuJ8dy07N+sVA8
X-Received: by 2002:a17:90a:f0d8:: with SMTP id fa24mr2767946pjb.93.1590554454367;
        Tue, 26 May 2020 21:40:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3AhxFWNIq2AkpKBB4NtPMQm+6oHtFAst619gt2ptZM930h8Bs8vT/fc6lIcLSTn64wdYb6w==
X-Received: by 2002:a17:90a:f0d8:: with SMTP id fa24mr2767930pjb.93.1590554454100;
        Tue, 26 May 2020 21:40:54 -0700 (PDT)
Received: from hsiangkao-HP-ZHAN-66-Pro-G1.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id mt3sm926663pjb.23.2020.05.26.21.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 21:40:53 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Chengguang Xu <cgxu519@mykernel.net>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] xattr: fix EOPNOTSUPP if fs and security xattrs disabled
Date:   Wed, 27 May 2020 12:40:37 +0800
Message-Id: <20200527044037.30414-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit f549d6c18c0e ("[PATCH] Generic VFS fallback for security xattrs")
introduces a behavior change of listxattr path therefore listxattr(2)
won't report EOPNOTSUPP correctly if fs and security xattrs disabled.
However it was clearly recorded in manpage all the time.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Chengguang Xu <cgxu519@mykernel.net>
Cc: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---

Noticed when reviewing Chengguang's patch for erofs [1] (together
with ext2, f2fs). I'm not sure if it's the best approach but it
seems that security_inode_listsecurity() has other users and it
mainly focus on reporting these security xattrs...

[1] https://lore.kernel.org/r/20200526090343.22794-1-cgxu519@mykernel.net

Thanks,
Gao Xiang

 fs/xattr.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 91608d9bfc6a..f339a67db521 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -352,13 +352,15 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t size)
 	error = security_inode_listxattr(dentry);
 	if (error)
 		return error;
-	if (inode->i_op->listxattr && (inode->i_opflags & IOP_XATTR)) {
-		error = inode->i_op->listxattr(dentry, list, size);
-	} else {
-		error = security_inode_listsecurity(inode, list, size);
-		if (size && error > size)
-			error = -ERANGE;
-	}
+
+	if (inode->i_op->listxattr && (inode->i_opflags & IOP_XATTR))
+		return inode->i_op->listxattr(dentry, list, size);
+
+	if (!IS_ENABLED(CONFIG_SECURITY))
+		return -EOPNOTSUPP;
+	error = security_inode_listsecurity(inode, list, size);
+	if (size && error > size)
+		error = -ERANGE;
 	return error;
 }
 EXPORT_SYMBOL_GPL(vfs_listxattr);
-- 
2.24.0

