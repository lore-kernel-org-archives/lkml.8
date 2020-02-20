Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA02C11D24
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00044208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="fPbfSEvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgBTVkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:40:32 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54677 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgBTVkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 16:40:31 -0500
Received: by mail-pj1-f67.google.com with SMTP id dw13so44402pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 13:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SdMXiwQ30NtFiXHtEOV93iERJEGx/98ZsoX3dNQE1dU=;
        b=fPbfSEvNBWFRQJpPerpnQOFFuOaBUykwN5G3Mb0OQ7ESFAV1G/GfvLFLh4E3x3/orj
         QZCmolJ9+ZBm5kA1lEKjya5v3YRWAUVVCgsmHJw/YllODFWn0M7bvPEZKPWO774L79om
         s55nEDeEVHyK7FWNTHPn5gY3+LQCa6Bo1B7oaST1i7SlzC8KFee1OwVT9Ej3jyChQNsS
         j7X2PGbnxZTx1QHEbBQkl0Fz6gXj4H5hsbWYgzwl/xDvjDJORlmfK/IRMcOaxh7BRY0t
         0hqAwWZ6QzKEjbrElt6rupJuyeLob1dQGRK0IGhyLqaJtqJlFOiVp+fNqn0EVfy+KHLd
         wZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SdMXiwQ30NtFiXHtEOV93iERJEGx/98ZsoX3dNQE1dU=;
        b=Vg+2DXZnLv8pYqH0tFUqeZbaAI8h4FEkjH8NZucD1z7/Co5kk3ihSaLQhFVE/UxDGP
         uVcFouJD6I64Zk/Imb0PRdvX/oTTWaFmyAuiLGNsQGSUdz/x7daqv6j9up40CFf9sTZ5
         HnbO2s0LsKv98p2ft+30b3Ysh+rcWnomrgZsywuQiDs1M6tx0vzjZ1ZDkjwzeKroOdId
         RDphlCObk5G9dGU6v2nuPqVa9Nvp0AigHJTR/Ptd8h/42RNvd2USj3hQu28vS6UZtiDb
         rSwWO7IdfZnyb5+VHyGOBTwsiOFtls7PPngWvdAW7esfHafyFj+TkzQ8meKjUpBCni13
         lrng==
X-Gm-Message-State: APjAAAUPCKQCFljMQezQBlkiXz8n4uXhjsiGsDgrWwyeWIsGZ9+X9xpA
        l0B9mZk6cKHDD8ZeLpMAdgA9Zw==
X-Google-Smtp-Source: APXvYqxoWg8UWtAn7qZl+URGKHfmSgJlNhTD6bwEWpMBVPmnFq43cZPNxCZ2yrsn44C6bIEQW6nsKQ==
X-Received: by 2002:a17:90a:ac0e:: with SMTP id o14mr6116479pjq.11.1582234830293;
        Thu, 20 Feb 2020 13:40:30 -0800 (PST)
Received: from cisco.hsd1.co.comcast.net ([2001:420:c0c8:1008::8b3])
        by smtp.gmail.com with ESMTPSA id h3sm386289pjs.0.2020.02.20.13.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 13:40:29 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH] doc: fix filesystems/porting.rst whitespace
Date:   Thu, 20 Feb 2020 14:40:09 -0700
Message-Id: <20200220214009.11645-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we start with spaces instead of tabs, rst seems to get confused and
italicize some things (presumably because of the `*'s).

Instead, let's switch to using leading tabs as we do elsewhere in the file.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 Documentation/filesystems/porting.rst | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index f18506083ced..898e1d0c6e98 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -57,12 +57,13 @@ Turn your foo_read_super() into a function that would return 0 in case of
 success and negative number in case of error (-EINVAL unless you have more
 informative error value to report).  Call it foo_fill_super().  Now declare::
 
-  int foo_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
-  {
-	return get_sb_bdev(fs_type, flags, dev_name, data, foo_fill_super,
-			   mnt);
-  }
+	int foo_get_sb(struct file_system_type *fs_type,
+		       int flags, const char *dev_name, void *data,
+		       struct vfsmount *mnt)
+	{
+		return get_sb_bdev(fs_type, flags, dev_name, data, foo_fill_super,
+				   mnt);
+	}
 
 (or similar with s/bdev/nodev/ or s/bdev/single/, depending on the kind of
 filesystem).
@@ -181,10 +182,10 @@ can be used as examples of very different filesystems.
 iget4() and the read_inode2 callback have been superseded by iget5_locked()
 which has the following prototype::
 
-    struct inode *iget5_locked(struct super_block *sb, unsigned long ino,
-				int (*test)(struct inode *, void *),
-				int (*set)(struct inode *, void *),
-				void *data);
+	struct inode *iget5_locked(struct super_block *sb, unsigned long ino,
+				   int (*test)(struct inode *, void *),
+				   int (*set)(struct inode *, void *),
+				   void *data);
 
 'test' is an additional function that can be used when the inode
 number is not sufficient to identify the actual file object. 'set'
-- 
2.20.1

