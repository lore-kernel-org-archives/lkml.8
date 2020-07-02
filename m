Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215E5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF52C20890
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgGBUFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:05:51 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:58610 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgGBUFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 16:05:50 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 3EF90BC122;
        Thu,  2 Jul 2020 20:05:47 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: vsprintf
Date:   Thu,  2 Jul 2020 22:05:36 +0200
Message-Id: <20200702200536.13389-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spam: Yes
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
          If both the HTTP and HTTPS versions
          return 200 OK and serve the same content:
            Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See https://lkml.org/lkml/2020/6/26/837

 Documentation/core-api/printk-formats.rst | 4 ++--
 lib/vsprintf.c                            | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 8c9aba262b1e..1beac4719e43 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -317,7 +317,7 @@ colon-separators. Leading zeros are always used.
 
 The additional ``c`` specifier can be used with the ``I`` specifier to
 print a compressed IPv6 address as described by
-http://tools.ietf.org/html/rfc5952
+https://tools.ietf.org/html/rfc5952
 
 Passed by reference.
 
@@ -341,7 +341,7 @@ The additional ``p``, ``f``, and ``s`` specifiers are used to specify port
 flowinfo a ``/`` and scope a ``%``, each followed by the actual value.
 
 In case of an IPv6 address the compressed IPv6 address as described by
-http://tools.ietf.org/html/rfc5952 is being used if the additional
+https://tools.ietf.org/html/rfc5952 is being used if the additional
 specifier ``c`` is given. The IPv6 address is surrounded by ``[``, ``]`` in
 case of additional specifiers ``p``, ``f`` or ``s`` as suggested by
 https://tools.ietf.org/html/draft-ietf-6man-text-addr-representation-07
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 259e55895933..31a674dd2674 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2134,7 +2134,7 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
  *       [4] or [6] and is able to print port [p], flowinfo [f], scope [s]
  * - '[Ii][4S][hnbl]' IPv4 addresses in host, network, big or little endian order
  * - 'I[6S]c' for IPv6 addresses printed as specified by
- *       http://tools.ietf.org/html/rfc5952
+ *       https://tools.ietf.org/html/rfc5952
  * - 'E[achnops]' For an escaped buffer, where rules are defined by combination
  *                of the following flags (see string_escape_mem() for the
  *                details):
-- 
2.27.0

