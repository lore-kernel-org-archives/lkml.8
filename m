Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DB9C81C82
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 162AA2076A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588022362;
	bh=ZdL7/GwRaX35OzxL5JUHsSU5HzwF/+IsN1pWOUe8/Es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WbfiKjBL8wWfl0fV7ykl2QXgfDffULnEkWVFFF8+jCrdTfDmmTD31oQcKlWCQk3G0
	 evAcVeVTW2QgGu8+UM5HZuf3tJkheqZNR7G0UHfpkaqudcOjEQk9hcjc65qN4YBXnK
	 Q31EdGylYABuc2p20PKZdoHL2fmpTUkURYr0FIJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgD0VTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgD0VRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:17:25 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1411421775;
        Mon, 27 Apr 2020 21:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588022244;
        bh=ZdL7/GwRaX35OzxL5JUHsSU5HzwF/+IsN1pWOUe8/Es=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIjR6JoQax9fddh4+ti9b9BkNs4I3qGscpEPLQkYkHYFd/QWfo4I1L3tQYC+P8kMX
         nluAFAQT1qGbQTWXHSuT+AYHLmr6bsjJCTmaFLvuI8KW9L+6GHYw7d1oOfSCsxBhhh
         T8SgEnGX22Qd1yO/oLjXcgQOhptGGeGf3Y+BcWDQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jTB7y-000Hk9-BD; Mon, 27 Apr 2020 23:17:22 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 07/29] docs: filesystems: convert cifs/cifsroot.txt to ReST
Date:   Mon, 27 Apr 2020 23:16:59 +0200
Message-Id: <28de01ee52283287e4195cf736d7154f122d30d4.1588021877.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588021877.git.mchehab+huawei@kernel.org>
References: <cover.1588021877.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a SPDX header;
- Adjust document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../cifs/{cifsroot.txt => cifsroot.rst}       | 56 +++++++++++--------
 Documentation/filesystems/index.rst           |  1 +
 2 files changed, 33 insertions(+), 24 deletions(-)
 rename Documentation/filesystems/cifs/{cifsroot.txt => cifsroot.rst} (72%)

diff --git a/Documentation/filesystems/cifs/cifsroot.txt b/Documentation/filesystems/cifs/cifsroot.rst
similarity index 72%
rename from Documentation/filesystems/cifs/cifsroot.txt
rename to Documentation/filesystems/cifs/cifsroot.rst
index 947b7ec6ce9e..4930bb443134 100644
--- a/Documentation/filesystems/cifs/cifsroot.txt
+++ b/Documentation/filesystems/cifs/cifsroot.rst
@@ -1,7 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================
 Mounting root file system via SMB (cifs.ko)
 ===========================================
 
 Written 2019 by Paulo Alcantara <palcantara@suse.de>
+
 Written 2019 by Aurelien Aptel <aaptel@suse.com>
 
 The CONFIG_CIFS_ROOT option enables experimental root file system
@@ -32,7 +36,7 @@ Server configuration
 ====================
 
 To enable SMB1+UNIX extensions you will need to set these global
-settings in Samba smb.conf:
+settings in Samba smb.conf::
 
     [global]
     server min protocol = NT1
@@ -41,12 +45,16 @@ settings in Samba smb.conf:
 Kernel command line
 ===================
 
-root=/dev/cifs
+::
+
+    root=/dev/cifs
 
 This is just a virtual device that basically tells the kernel to mount
 the root file system via SMB protocol.
 
-cifsroot=//<server-ip>/<share>[,options]
+::
+
+    cifsroot=//<server-ip>/<share>[,options]
 
 Enables the kernel to mount the root file system via SMB that are
 located in the <server-ip> and <share> specified in this option.
@@ -65,33 +73,33 @@ options
 Examples
 ========
 
-Export root file system as a Samba share in smb.conf file.
+Export root file system as a Samba share in smb.conf file::
 
-...
-[linux]
-	path = /path/to/rootfs
-	read only = no
-	guest ok = yes
-	force user = root
-	force group = root
-	browseable = yes
-	writeable = yes
-	admin users = root
-	public = yes
-	create mask = 0777
-	directory mask = 0777
-...
+    ...
+    [linux]
+	    path = /path/to/rootfs
+	    read only = no
+	    guest ok = yes
+	    force user = root
+	    force group = root
+	    browseable = yes
+	    writeable = yes
+	    admin users = root
+	    public = yes
+	    create mask = 0777
+	    directory mask = 0777
+    ...
 
-Restart smb service.
+Restart smb service::
 
-# systemctl restart smb
+    # systemctl restart smb
 
 Test it under QEMU on a kernel built with CONFIG_CIFS_ROOT and
-CONFIG_IP_PNP options enabled.
+CONFIG_IP_PNP options enabled::
 
-# qemu-system-x86_64 -enable-kvm -cpu host -m 1024 \
-  -kernel /path/to/linux/arch/x86/boot/bzImage -nographic \
-  -append "root=/dev/cifs rw ip=dhcp cifsroot=//10.0.2.2/linux,username=foo,password=bar console=ttyS0 3"
+    # qemu-system-x86_64 -enable-kvm -cpu host -m 1024 \
+    -kernel /path/to/linux/arch/x86/boot/bzImage -nographic \
+    -append "root=/dev/cifs rw ip=dhcp cifsroot=//10.0.2.2/linux,username=foo,password=bar console=ttyS0 3"
 
 
 1: https://wiki.samba.org/index.php/UNIX_Extensions
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index f8781c13aee3..2ad8a207523e 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -59,6 +59,7 @@ Documentation for filesystem implementations.
    befs
    bfs
    btrfs
+   cifs/cifsroot
    ceph
    cramfs
    debugfs
-- 
2.25.4

