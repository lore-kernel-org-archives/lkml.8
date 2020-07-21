Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C969DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD249206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbgGUTiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:38:16 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:50286 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729928AbgGUTiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 15:38:16 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id BE6A4BC17B;
        Tue, 21 Jul 2020 19:38:12 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] staging: comedi: pcm: Replace HTTP links with HTTPS ones
Date:   Tue, 21 Jul 2020 21:38:06 +0200
Message-Id: <20200721193806.68010-1-grandmaster@al2klimov.de>
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


 drivers/staging/comedi/drivers/pcm3724.c | 2 +-
 drivers/staging/comedi/drivers/pcmad.c   | 2 +-
 drivers/staging/comedi/drivers/pcmda12.c | 2 +-
 drivers/staging/comedi/drivers/pcmmio.c  | 2 +-
 drivers/staging/comedi/drivers/pcmuio.c  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/comedi/drivers/pcm3724.c b/drivers/staging/comedi/drivers/pcm3724.c
index 5779e005c0cb..0cb1ad060402 100644
--- a/drivers/staging/comedi/drivers/pcm3724.c
+++ b/drivers/staging/comedi/drivers/pcm3724.c
@@ -222,6 +222,6 @@ static struct comedi_driver pcm3724_driver = {
 };
 module_comedi_driver(pcm3724_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi driver for Advantech PCM-3724 Digital I/O board");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/pcmad.c b/drivers/staging/comedi/drivers/pcmad.c
index fe5449bb1716..eec89a0afb2f 100644
--- a/drivers/staging/comedi/drivers/pcmad.c
+++ b/drivers/staging/comedi/drivers/pcmad.c
@@ -144,6 +144,6 @@ static struct comedi_driver pcmad_driver = {
 };
 module_comedi_driver(pcmad_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi low-level driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/pcmda12.c b/drivers/staging/comedi/drivers/pcmda12.c
index 33e463b193a1..14ab1f0d1e9f 100644
--- a/drivers/staging/comedi/drivers/pcmda12.c
+++ b/drivers/staging/comedi/drivers/pcmda12.c
@@ -160,6 +160,6 @@ static struct comedi_driver pcmda12_driver = {
 };
 module_comedi_driver(pcmda12_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi low-level driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/pcmmio.c b/drivers/staging/comedi/drivers/pcmmio.c
index 72af1776f785..24a9568d3378 100644
--- a/drivers/staging/comedi/drivers/pcmmio.c
+++ b/drivers/staging/comedi/drivers/pcmmio.c
@@ -772,6 +772,6 @@ static struct comedi_driver pcmmio_driver = {
 };
 module_comedi_driver(pcmmio_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi driver for Winsystems PCM-MIO PC/104 board");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/pcmuio.c b/drivers/staging/comedi/drivers/pcmuio.c
index 743fb226e2e4..7e1fc6ffb48c 100644
--- a/drivers/staging/comedi/drivers/pcmuio.c
+++ b/drivers/staging/comedi/drivers/pcmuio.c
@@ -619,6 +619,6 @@ static struct comedi_driver pcmuio_driver = {
 };
 module_comedi_driver(pcmuio_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi low-level driver");
 MODULE_LICENSE("GPL");
-- 
2.27.0

