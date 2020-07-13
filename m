Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAD6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A0320738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgGMNJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:09:55 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:46942 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729523AbgGMNJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:09:54 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 2E447BC0D3;
        Mon, 13 Jul 2020 13:09:50 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] erofs: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 15:09:44 +0200
Message-Id: <20200713130944.34419-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not just HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.

 Sorry again to all maintainers who complained about subject lines.
 Now I realized that you want an actually perfect prefixes,
 not just subsystem ones.
 I tried my best...
 And yes, *I could* (at least half-)automate it.
 Impossible is nothing! :)


 fs/erofs/compress.h     | 2 +-
 fs/erofs/data.c         | 2 +-
 fs/erofs/decompressor.c | 2 +-
 fs/erofs/dir.c          | 2 +-
 fs/erofs/erofs_fs.h     | 2 +-
 fs/erofs/inode.c        | 2 +-
 fs/erofs/internal.h     | 2 +-
 fs/erofs/namei.c        | 2 +-
 fs/erofs/super.c        | 2 +-
 fs/erofs/utils.c        | 2 +-
 fs/erofs/xattr.c        | 2 +-
 fs/erofs/xattr.h        | 2 +-
 fs/erofs/zdata.c        | 2 +-
 fs/erofs/zdata.h        | 2 +-
 fs/erofs/zmap.c         | 2 +-
 fs/erofs/zpvec.h        | 2 +-
 16 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 07d279fd5d67..3d452443c545 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2019 HUAWEI, Inc.
- *             http://www.huawei.com/
+ *             https://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #ifndef __EROFS_FS_COMPRESS_H
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 64b56c7df023..03b5a971a8c6 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2017-2018 HUAWEI, Inc.
- *             http://www.huawei.com/
+ *             https://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include "internal.h"
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 7628816f2453..cbadbf55c6c2 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2019 HUAWEI, Inc.
- *             http://www.huawei.com/
+ *             https://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include "compress.h"
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index d28c623dfef9..2776bb832127 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2017-2018 HUAWEI, Inc.
- *             http://www.huawei.com/
+ *             https://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include "internal.h"
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 385fa49c7749..9ad1615f4474 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -3,7 +3,7 @@
  * EROFS (Enhanced ROM File System) on-disk format definition
  *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
- *             http://www.huawei.com/
+ *             https://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #ifndef __EROFS_FS_H
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 7dd4bbe9674f..577fc9df4471 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2017-2018 HUAWEI, Inc.
- *             http://www.huawei.com/
+ *             https://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include "xattr.h"
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 1c077b7bb43d..67a7ec945686 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2017-2018 HUAWEI, Inc.
- *             http://www.huawei.com/
+ *             https://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #ifndef __EROFS_INTERNAL_H
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index 52f201e03c62..5f8cc7346c69 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2017-2018 HUAWEI, Inc.
- *             http://www.huawei.com/
+ *             https://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include "xattr.h"
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 7a13ffb07c23..ddaa516c008a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2017-2018 HUAWEI, Inc.
- *             http://www.huawei.com/
+ *             https://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include <linux/module.h>
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index 52d0be10f1aa..ecb85b3d4013 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
- *             http://www.huawei.com/
+ *             https://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include "internal.h"
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 87e437e7b34f..c8c381eadcd6 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2017-2018 HUAWEI, Inc.
- *             http://www.huawei.com/
+ *             https://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include <linux/security.h>
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
index e4e5093f012c..815304bd335f 100644
--- a/fs/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2017-2018 HUAWEI, Inc.
- *             http://www.huawei.com/
+ *             https://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #ifndef __EROFS_XATTR_H
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index be50a4d9d273..80bf09c4de09 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
- *             http://www.huawei.com/
+ *             https://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include "zdata.h"
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index 9b66c28b3ae9..68c9b29fc0ca 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
- *             http://www.huawei.com/
+ *             https://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #ifndef __EROFS_FS_ZDATA_H
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 736db3a4cdef..7d40d78ea864 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2018-2019 HUAWEI, Inc.
- *             http://www.huawei.com/
+ *             https://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #include "internal.h"
diff --git a/fs/erofs/zpvec.h b/fs/erofs/zpvec.h
index 58556903aa94..1d67cbd38704 100644
--- a/fs/erofs/zpvec.h
+++ b/fs/erofs/zpvec.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2018 HUAWEI, Inc.
- *             http://www.huawei.com/
+ *             https://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
 #ifndef __EROFS_FS_ZPVEC_H
-- 
2.27.0

