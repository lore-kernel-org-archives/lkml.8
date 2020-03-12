Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E97C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DB3206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgCLSom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:44:42 -0400
Received: from 5.mo178.mail-out.ovh.net ([46.105.51.53]:39016 "EHLO
        5.mo178.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgCLSom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:44:42 -0400
X-Greylist: delayed 1198 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2020 14:44:40 EDT
Received: from player759.ha.ovh.net (unknown [10.108.57.139])
        by mo178.mail-out.ovh.net (Postfix) with ESMTP id 988C2953F3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 19:07:44 +0100 (CET)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player759.ha.ovh.net (Postfix) with ESMTPSA id 3FFD5106367DE;
        Thu, 12 Mar 2020 18:07:36 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Daniel W . S . Almeida" <dwlsalmeida@gmail.com>,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] docs: driver-api/gpio/driver.rst: fix code blocks
Date:   Thu, 12 Mar 2020 19:06:51 +0100
Message-Id: <20200312180650.1365059-1-steve@sk2.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8822551671076179420
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddvhedgudduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejheelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two code blocks have duplicate declarations (:: and explicit
.. code-block), this fixes them, addressing these warnings:

	Documentation/driver-api/gpio/driver.rst:425: WARNING: Unexpected indentation.
	Documentation/driver-api/gpio/driver.rst:423: WARNING: Inline emphasis start-string without end-string.
	Documentation/driver-api/gpio/driver.rst:427: WARNING: Block quote ends without a blank line; unexpected unindent.
	Documentation/driver-api/gpio/driver.rst:429: WARNING: Inline emphasis start-string without end-string.
	Documentation/driver-api/gpio/driver.rst:429: WARNING: Inline emphasis start-string without end-string.
	Documentation/driver-api/gpio/driver.rst:429: WARNING: Inline emphasis start-string without end-string.
	Documentation/driver-api/gpio/driver.rst:433: WARNING: Inline emphasis start-string without end-string.
	Documentation/driver-api/gpio/driver.rst:446: WARNING: Unexpected indentation.
	Documentation/driver-api/gpio/driver.rst:440: WARNING: Inline emphasis start-string without end-string.
	Documentation/driver-api/gpio/driver.rst:440: WARNING: Inline emphasis start-string without end-string.
	Documentation/driver-api/gpio/driver.rst:447: WARNING: Block quote ends without a blank line; unexpected unindent.
	Documentation/driver-api/gpio/driver.rst:449: WARNING: Definition list ends without a blank line; unexpected unindent.
	Documentation/driver-api/gpio/driver.rst:462: WARNING: Unexpected indentation.
	Documentation/driver-api/gpio/driver.rst:460: WARNING: Inline emphasis start-string without end-string.
	Documentation/driver-api/gpio/driver.rst:462: WARNING: Inline emphasis start-string without end-string.
	Documentation/driver-api/gpio/driver.rst:465: WARNING: Block quote ends without a blank line; unexpected unindent.
	Documentation/driver-api/gpio/driver.rst:467: WARNING: Inline emphasis start-string without end-string.
	Documentation/driver-api/gpio/driver.rst:467: WARNING: Inline emphasis start-string without end-string.
	Documentation/driver-api/gpio/driver.rst:467: WARNING: Inline emphasis start-string without end-string.
	Documentation/driver-api/gpio/driver.rst:471: WARNING: Inline emphasis start-string without end-string.
	Documentation/driver-api/gpio/driver.rst:478: WARNING: Inline emphasis start-string without end-string.

Fixes: 4e29b70d5437 ("Documentation: gpio: driver.rst: Fix warnings")
Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/driver-api/gpio/driver.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/gpio/driver.rst b/Documentation/driver-api/gpio/driver.rst
index 871922529332..9809f593c0ab 100644
--- a/Documentation/driver-api/gpio/driver.rst
+++ b/Documentation/driver-api/gpio/driver.rst
@@ -416,7 +416,7 @@ The preferred way to set up the helpers is to fill in the
 struct gpio_irq_chip inside struct gpio_chip before adding the gpio_chip.
 If you do this, the additional irq_chip will be set up by gpiolib at the
 same time as setting up the rest of the GPIO functionality. The following
-is a typical example of a cascaded interrupt handler using gpio_irq_chip::
+is a typical example of a cascaded interrupt handler using gpio_irq_chip:
 
 .. code-block:: c
 
@@ -453,7 +453,7 @@ is a typical example of a cascaded interrupt handler using gpio_irq_chip::
   return devm_gpiochip_add_data(dev, &g->gc, g);
 
 The helper support using hierarchical interrupt controllers as well.
-In this case the typical set-up will look like this::
+In this case the typical set-up will look like this:
 
 .. code-block:: c
 

base-commit: 7d3d3254adaa61cba896f71497f56901deb618e5
-- 
2.24.1

