Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37AEC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732B420787
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390619AbgDCJMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:12:00 -0400
Received: from retiisi.org.uk ([95.216.213.190]:49912 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388221AbgDCJL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 05:11:59 -0400
Received: from lanttu.localdomain (lanttu.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::c1:2])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id E54F6634C8B;
        Fri,  3 Apr 2020 12:11:07 +0300 (EEST)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        mchehab@kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Perches <joe@perches.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH v2 1/1] lib/vsprintf: Add support for printing V4L2 and DRM fourccs
Date:   Fri,  3 Apr 2020 12:11:56 +0300
Message-Id: <20200403091156.7814-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a printk modifier %ppf (for pixel format) for printing V4L2 and DRM
pixel formats denoted by 4ccs. The 4cc encoding is the same for both so
the same implementation can be used.

Suggested-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
since v1:

- Improve documentation (add -BE suffix, refer to "FourCC".

- Use '%p4cc' conversion specifier instead of '%ppf'.

- Fix 31st bit handling in printing FourCC codes.

- Use string() correctly, to allow e.g. proper field width handling.

- Remove loop, use put_unaligned_le32() instead.

 Documentation/core-api/printk-formats.rst | 12 +++++++++++
 lib/vsprintf.c                            | 25 +++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 8ebe46b1af39..550568520ab6 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -545,6 +545,18 @@ For printing netdev_features_t.
 
 Passed by reference.
 
+V4L2 and DRM FourCC code (pixel format)
+---------------------------------------
+
+::
+
+	%p4cc
+
+Print a FourCC code used by V4L2 or DRM. The "-BE" suffix is added on big endian
+formats.
+
+Passed by reference.
+
 Thanks
 ======
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 7c488a1ce318..93eea6a320da 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1721,6 +1721,28 @@ char *netdev_bits(char *buf, char *end, const void *addr,
 	return special_hex_number(buf, end, num, size);
 }
 
+static noinline_for_stack
+char *fourcc_string(char *buf, char *end, const u32 *fourcc,
+		    struct printf_spec spec, const char *fmt)
+{
+#define FOURCC_STRING_BE	"-BE"
+	char s[sizeof(*fourcc) + sizeof(FOURCC_STRING_BE)] = { 0 };
+
+	if (check_pointer(&buf, end, fourcc, spec))
+		return buf;
+
+	if (fmt[1] != 'c' || fmt[2] != 'c')
+		return error_string(buf, end, "(%p4?)", spec);
+
+	put_unaligned_le32(*fourcc & ~BIT(31), s);
+
+	if (*fourcc & BIT(31))
+		strscpy(s + sizeof(*fourcc), FOURCC_STRING_BE,
+			sizeof(FOURCC_STRING_BE));
+
+	return string(buf, end, s, spec);
+}
+
 static noinline_for_stack
 char *address_val(char *buf, char *end, const void *addr,
 		  struct printf_spec spec, const char *fmt)
@@ -2131,6 +2153,7 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
  *       correctness of the format string and va_list arguments.
  * - 'K' For a kernel pointer that should be hidden from unprivileged users
  * - 'NF' For a netdev_features_t
+ * - '4cc' V4L2 or DRM FourCC code, with "-BE" suffix on big endian formats.
  * - 'h[CDN]' For a variable-length buffer, it prints it as a hex string with
  *            a certain separator (' ' by default):
  *              C colon
@@ -2223,6 +2246,8 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		return restricted_pointer(buf, end, ptr, spec);
 	case 'N':
 		return netdev_bits(buf, end, ptr, spec, fmt);
+	case '4':
+		return fourcc_string(buf, end, ptr, spec, fmt);
 	case 'a':
 		return address_val(buf, end, ptr, spec, fmt);
 	case 'd':
-- 
2.20.1

