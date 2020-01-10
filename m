Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0733AC33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DB420842
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6O4jlfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgAJXY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 18:24:58 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33644 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbgAJXY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 18:24:56 -0500
Received: by mail-qk1-f196.google.com with SMTP id d71so3623082qkc.0;
        Fri, 10 Jan 2020 15:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lKAaRI+qny5owK6vpx9vqe3tT/EASWXktBmYILK1Mfs=;
        b=u6O4jlfMkYBmXT56NGy+JdgFcILfCzVVCqhPL1Lmg2+995slwtwdqyw3ikunUx5Bpu
         4QE9NGY7muRXc1pSBbJRi2DUusXVglb+eLrzjA/PHTr9CKfXNHN61IVYompJsK0A7N/P
         9jfVJF8D82GE0KLCRoHjpkFqjSTOPlKas3j3yuITRkgHfWhPMqnAyLO6ZWnV7fGg7ZTV
         R00Eylm1qKs0gifvsX24/3BW3g0+e/7tX+WD2y9w2tlc5gotpcQmortPmOk8sQzDT9Gk
         sRow2ceiTP1sdBPJu6PY9oT/uGqIXjNTNEwrxuzculNxReZ1sy0aljUlARi8xm//vHZU
         5+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lKAaRI+qny5owK6vpx9vqe3tT/EASWXktBmYILK1Mfs=;
        b=IfjCNl6yUS5cBQTuN+APMkJkFXZ+MG0sZ9gCYeVqaGQJvYqIwJiGuPXpRhwD+i8U20
         W4kHT2z3bqyDtOJmPWIfm10C1ZAANxhOeS/50a8kqyeQ8e7Sr4uA8nN4j4XL5wQb/XI6
         a6UKXsQpB/+vq5UectshcJylXkU0vxRrkEmk8R9fThqny2m9dSQ+iazG5OUQq9EYXB3F
         Lz6ycAsFRKhRTtRIJfEcRzGAaKXkWk75KB6MG2ohNHi//cLNUcVZU/Bod5admEV/WHAj
         v3lzX0YgT7zHLR+RnKedYMtFpoMBdHrXMjD2q7McKnKp+ETStbzFDXlGdKT8sRLuKnIN
         wg6g==
X-Gm-Message-State: APjAAAVLNfFYt/7UJJmjwkAnthZbgTNy33VN7JKE7PGBRxwMc2kWr52O
        RUdIkXoJY3h93ba1nkEEg+Y=
X-Google-Smtp-Source: APXvYqwq3pRWBI9u5dbk8GTLz2Ts3jAsJTsAnx+g29BO0WUzjb6at/0LoRz3P7kurTPl/uwYboKGRQ==
X-Received: by 2002:a05:620a:1327:: with SMTP id p7mr5726392qkj.148.1578698695844;
        Fri, 10 Jan 2020 15:24:55 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id i2sm1774752qte.87.2020.01.10.15.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 15:24:55 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     mchehab+samsung@kernel.org, corbet@lwn.net
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v4 3/9] Documentation: nfsroot.rst: COSMETIC: refill a paragraph
Date:   Fri, 10 Jan 2020 20:24:25 -0300
Message-Id: <58c50f6ba94a0a2f212c4d2a42f64ffb40336b68.1578697871.git.dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1578697871.git.dwlsalmeida@gmail.com>
References: <cover.1578697871.git.dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Refill a paragraph to eliminate long lines.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/admin-guide/nfs/nfsroot.rst | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/nfs/nfsroot.rst b/Documentation/admin-guide/nfs/nfsroot.rst
index 9249be637833..82a4fda057f9 100644
--- a/Documentation/admin-guide/nfs/nfsroot.rst
+++ b/Documentation/admin-guide/nfs/nfsroot.rst
@@ -15,13 +15,14 @@ Mounting the root filesystem via NFS (nfsroot)
 
 
 
-In order to use a diskless system, such as an X-terminal or printer server
-for example, it is necessary for the root filesystem to be present on a
-non-disk device. This may be an initramfs (see Documentation/filesystems/ramfs-rootfs-initramfs.txt),
-a ramdisk (see Documentation/admin-guide/initrd.rst) or a
-filesystem mounted via NFS. The following text describes on how to use NFS
-for the root filesystem. For the rest of this text 'client' means the
-diskless system, and 'server' means the NFS server.
+In order to use a diskless system, such as an X-terminal or printer server for
+example, it is necessary for the root filesystem to be present on a non-disk
+device. This may be an initramfs (see
+Documentation/filesystems/ramfs-rootfs-initramfs.txt), a ramdisk (see
+Documentation/admin-guide/initrd.rst) or a filesystem mounted via NFS. The
+following text describes on how to use NFS for the root filesystem. For the rest
+of this text 'client' means the diskless system, and 'server' means the NFS
+server.
 
 
 
-- 
2.24.1

