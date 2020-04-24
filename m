Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DC9C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1FF420CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgDXCJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 22:09:01 -0400
Received: from m17616.mail.qiye.163.com ([59.111.176.16]:10025 "EHLO
        m17616.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgDXCJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:09:01 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17616.mail.qiye.163.com (Hmail) with ESMTPA id 870BF1065B6;
        Fri, 24 Apr 2020 10:08:48 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, kernel@vivo.com,
        Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH v3] io: correct doc-mismatches for io mem ops
Date:   Thu, 23 Apr 2020 19:08:31 -0700
Message-Id: <20200424020831.30494-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VNS05LS0tLSkJLTEhPQllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PyI6PRw5DDg5DlYDAzQvGToR
        Gi4KCTVVSlVKTkNMTUJPSkhNT09PVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUhITkk3Bg++
X-HM-Tid: 0a71a9f1ce729374kuws870bf1065b6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor mismatches exist between funtion documentations and parameter
definitions. Also a dash '-' is needed between a function name and
its description.

Function definitions are as following:
static inline void memset_io(volatile void __iomem *addr, int value,
			     size_t size)
static inline void memcpy_fromio(void *buffer,
				 const volatile void __iomem *addr,
				 size_t size)
static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
			       size_t size)

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
---
 include/asm-generic/io.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index d39ac997dda8..83ac47bfa33a 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1049,10 +1049,10 @@ static inline void *bus_to_virt(unsigned long address)
 #ifndef memset_io
 #define memset_io memset_io
 /**
- * memset_io	Set a range of I/O memory to a constant value
+ * memset_io -	Set a range of I/O memory to a constant value
  * @addr:	The beginning of the I/O-memory range to set
- * @val:	The value to set the memory to
- * @count:	The number of bytes to set
+ * @value:	The value to set the memory to
+ * @size:	The number of bytes to set
  *
  * Set a range of I/O memory to a given value.
  */
@@ -1066,10 +1066,10 @@ static inline void memset_io(volatile void __iomem *addr, int value,
 #ifndef memcpy_fromio
 #define memcpy_fromio memcpy_fromio
 /**
- * memcpy_fromio	Copy a block of data from I/O memory
- * @dst:		The (RAM) destination for the copy
- * @src:		The (I/O memory) source for the data
- * @count:		The number of bytes to copy
+ * memcpy_fromio -	Copy a block of data from I/O memory
+ * @buffer:		The (RAM) destination for the copy
+ * @addr:		The (I/O memory) source for the data
+ * @size:		The number of bytes to copy
  *
  * Copy a block of data from I/O memory.
  */
@@ -1084,10 +1084,10 @@ static inline void memcpy_fromio(void *buffer,
 #ifndef memcpy_toio
 #define memcpy_toio memcpy_toio
 /**
- * memcpy_toio		Copy a block of data into I/O memory
- * @dst:		The (I/O memory) destination for the copy
- * @src:		The (RAM) source for the data
- * @count:		The number of bytes to copy
+ * memcpy_toio -	Copy a block of data into I/O memory
+ * @addr:		The (I/O memory) destination for the copy
+ * @buffer:		The (RAM) source for the data
+ * @size:		The number of bytes to copy
  *
  * Copy a block of data to I/O memory.
  */
-- 
2.17.1

