Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A98DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2508320717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbgGUT2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:28:02 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:48692 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729497AbgGUT2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 15:28:01 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 4E006BC148;
        Tue, 21 Jul 2020 19:27:56 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] staging: comedi: pcl: Replace HTTP links with HTTPS ones
Date:   Tue, 21 Jul 2020 21:27:50 +0200
Message-Id: <20200721192750.67925-1-grandmaster@al2klimov.de>
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


 drivers/staging/comedi/drivers/pcl711.c | 2 +-
 drivers/staging/comedi/drivers/pcl724.c | 2 +-
 drivers/staging/comedi/drivers/pcl726.c | 2 +-
 drivers/staging/comedi/drivers/pcl730.c | 2 +-
 drivers/staging/comedi/drivers/pcl812.c | 2 +-
 drivers/staging/comedi/drivers/pcl816.c | 2 +-
 drivers/staging/comedi/drivers/pcl818.c | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/comedi/drivers/pcl711.c b/drivers/staging/comedi/drivers/pcl711.c
index a5937206bf1c..2dbf69e30965 100644
--- a/drivers/staging/comedi/drivers/pcl711.c
+++ b/drivers/staging/comedi/drivers/pcl711.c
@@ -508,6 +508,6 @@ static struct comedi_driver pcl711_driver = {
 };
 module_comedi_driver(pcl711_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi driver for PCL-711 compatible boards");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/pcl724.c b/drivers/staging/comedi/drivers/pcl724.c
index 9c174f1f2fcf..1a5799278a7a 100644
--- a/drivers/staging/comedi/drivers/pcl724.c
+++ b/drivers/staging/comedi/drivers/pcl724.c
@@ -148,6 +148,6 @@ static struct comedi_driver pcl724_driver = {
 };
 module_comedi_driver(pcl724_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi driver for 8255 based ISA and PC/104 DIO boards");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/pcl726.c b/drivers/staging/comedi/drivers/pcl726.c
index 0963d85873a9..58b3d07ae907 100644
--- a/drivers/staging/comedi/drivers/pcl726.c
+++ b/drivers/staging/comedi/drivers/pcl726.c
@@ -418,6 +418,6 @@ static struct comedi_driver pcl726_driver = {
 };
 module_comedi_driver(pcl726_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi driver for Advantech PCL-726 & compatibles");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/pcl730.c b/drivers/staging/comedi/drivers/pcl730.c
index 3d1e9150e5b5..32a29129e6e8 100644
--- a/drivers/staging/comedi/drivers/pcl730.c
+++ b/drivers/staging/comedi/drivers/pcl730.c
@@ -345,6 +345,6 @@ static struct comedi_driver pcl730_driver = {
 };
 module_comedi_driver(pcl730_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi low-level driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/pcl812.c b/drivers/staging/comedi/drivers/pcl812.c
index aefc1b849cf7..b87ab3840eee 100644
--- a/drivers/staging/comedi/drivers/pcl812.c
+++ b/drivers/staging/comedi/drivers/pcl812.c
@@ -1331,6 +1331,6 @@ static struct comedi_driver pcl812_driver = {
 };
 module_comedi_driver(pcl812_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi low-level driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/pcl816.c b/drivers/staging/comedi/drivers/pcl816.c
index d87cf6d4a161..c368a337a0ae 100644
--- a/drivers/staging/comedi/drivers/pcl816.c
+++ b/drivers/staging/comedi/drivers/pcl816.c
@@ -691,6 +691,6 @@ static struct comedi_driver pcl816_driver = {
 };
 module_comedi_driver(pcl816_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi low-level driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/pcl818.c b/drivers/staging/comedi/drivers/pcl818.c
index 0af5315d4357..63e3011158f2 100644
--- a/drivers/staging/comedi/drivers/pcl818.c
+++ b/drivers/staging/comedi/drivers/pcl818.c
@@ -1132,6 +1132,6 @@ static struct comedi_driver pcl818_driver = {
 };
 module_comedi_driver(pcl818_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi low-level driver");
 MODULE_LICENSE("GPL");
-- 
2.27.0

