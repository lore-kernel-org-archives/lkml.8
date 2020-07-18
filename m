Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF6EC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 13:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E232070E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 13:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgGRNfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 09:35:03 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:46842 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgGRNfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 09:35:03 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 2AD8BBC070;
        Sat, 18 Jul 2020 13:34:58 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, corbet@lwn.net,
        nico@fluxnic.net, sam@ravnborg.org, lukas@wunner.de,
        ebiggers@google.com, nivedita@alum.mit.edu,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] tty: vt: Replace HTTP links with HTTPS ones
Date:   Sat, 18 Jul 2020 15:34:52 +0200
Message-Id: <20200718133452.24290-1-grandmaster@al2klimov.de>
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

 If there are any URLs to be removed completely
 or at least not (just) HTTPSified:
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


 Documentation/driver-api/serial/n_gsm.rst | 2 +-
 drivers/tty/vt/vt.c                       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/serial/n_gsm.rst b/Documentation/driver-api/serial/n_gsm.rst
index 286e7ff4d2d9..87dfcd54a96b 100644
--- a/Documentation/driver-api/serial/n_gsm.rst
+++ b/Documentation/driver-api/serial/n_gsm.rst
@@ -5,7 +5,7 @@ GSM 0710 tty multiplexor HOWTO
 This line discipline implements the GSM 07.10 multiplexing protocol
 detailed in the following 3GPP document:
 
-	http://www.3gpp.org/ftp/Specs/archive/07_series/07.10/0710-720.zip
+	https://www.3gpp.org/ftp/Specs/archive/07_series/07.10/0710-720.zip
 
 This document give some hints on how to use this driver with GPRS and 3G
 modems connected to a physical serial port.
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 48a8199f7845..df8a25fabedf 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2530,7 +2530,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 
 /* is_double_width() is based on the wcwidth() implementation by
  * Markus Kuhn -- 2007-05-26 (Unicode 5.0)
- * Latest version: http://www.cl.cam.ac.uk/~mgk25/ucs/wcwidth.c
+ * Latest version: https://www.cl.cam.ac.uk/~mgk25/ucs/wcwidth.c
  */
 struct interval {
 	uint32_t first;
-- 
2.27.0

