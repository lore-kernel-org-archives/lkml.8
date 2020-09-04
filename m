Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AB8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 861C3206E7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="iirBcZw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgIDPsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgIDPrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:47:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94138C0619EB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:46:59 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s13so6473747wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+T4nqXaC8fjBrWkDJbcI/m89Hs0Il9eeYVZ91EUv4bE=;
        b=iirBcZw4EgxyAFB9yrfqfHzrbIqBRMnGr84pnWLTSHWiDS/j7p4d7c1IpfTuH6U0yE
         kqQ+3Cup4oeN2ka7rRGBWA1VgzzhuxJJja+zLHmjZw2eXRU3Yosp3+5A4U7XPXJ5vbVj
         B0EwMLnRv8Z1xZQRMOZVAeXAcgdCFJ6591m6BtMaR7vygL5ntSU++35wP4FwhLKD8mki
         n4OL3b5QGP86X4QLHPRhSu46PuWJoc+QP4LeR4B2yVVJitaWtbOymwB3MJF/uM5Vx81y
         RLijD9+Rt/EUhWQrtLvqh/+1KBK6+11K8JaHcwSvMvX79X8NocXKzJGbiecv0fBZjslV
         A7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+T4nqXaC8fjBrWkDJbcI/m89Hs0Il9eeYVZ91EUv4bE=;
        b=oz99CJO6ncHyYF3WzWsq/vr05+5VYICoddVqjKDW9lTNxKDKf+/YM7W7D4l85Lozrk
         cex9J/wNvn9zMbGTV7W4ko7KpGtklofuF6vFOW67JsbeN47tRCEuG9wvFR9tpM81Bt/b
         praIYTJmjWzHolHGKptPPEPw4k8LnpPHvScBcVWR5Y2OOf2sv50//8Z3wL6ykCnqU9IT
         QRbOlUAuKkYtl2coegGLinhpMvC4Alr4uoiEUgkZnCVK2GMYs9xHyzO/htac56vym0WN
         n1n4VoQi9HE8sDZ+sCd7XdrIaQ+sX/fqsSggEkFC/6NfMEi7oe88ftftE34rFXtxRoi7
         +fTQ==
X-Gm-Message-State: AOAM530J5p8DOHCFoDCdMpY04l84eZyTY09Rz/NgVs3L19V16Dtxmszg
        HK3Yfvr6eoaw3Xe8U5ry70dTMA==
X-Google-Smtp-Source: ABdhPJyjc2MlVjuY6G3UNUTfVft9wTllA8VYq1OpvEDtNds22hkn1ilbEsjGyby0vTpaSIVU2cgT8Q==
X-Received: by 2002:a7b:cb0d:: with SMTP id u13mr8555846wmj.144.1599234418241;
        Fri, 04 Sep 2020 08:46:58 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q4sm11983375wru.65.2020.09.04.08.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:46:57 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 23/23] Documentation: gpio: add documentation for gpio-mockup
Date:   Fri,  4 Sep 2020 17:45:47 +0200
Message-Id: <20200904154547.3836-24-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200904154547.3836-1-brgl@bgdev.pl>
References: <20200904154547.3836-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There's some documentation for gpio-mockup's debugfs interface in the
driver's source but it's not much. Add proper documentation for this
testing module.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../admin-guide/gpio/gpio-mockup.rst          | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/admin-guide/gpio/gpio-mockup.rst

diff --git a/Documentation/admin-guide/gpio/gpio-mockup.rst b/Documentation/admin-guide/gpio/gpio-mockup.rst
new file mode 100644
index 000000000000..1d452ee55f8d
--- /dev/null
+++ b/Documentation/admin-guide/gpio/gpio-mockup.rst
@@ -0,0 +1,87 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+GPIO Testing Driver
+===================
+
+The GPIO Testing Driver (gpio-mockup) provides a way to create simulated GPIO
+chips for testing purposes. There are two ways of configuring the chips exposed
+by the module. The lines can be accessed using the standard GPIO character
+device interface as well as manipulated using the dedicated debugfs directory
+structure.
+
+Creating simulated chips using debugfs
+--------------------------------------
+
+When the gpio-mockup module is loaded (or builtin) it creates its own directory
+in debugfs. Assuming debugfs is mounted at /sys/kernel/debug/, the directory
+will be located at /sys/kernel/debug/gpio-mockup/. Inside this directory there
+are two attributes: new_device and delete_device.
+
+New chips can be created by writing a single line containing a number of
+options to "new_device". For example:
+
+.. code-block:: sh
+
+    $ echo "label=my-mockup num_lines=4 named_lines" > /sys/kernel/debug/gpio-mockup/new_device
+
+Supported options:
+
+    num_lines=<num_lines> - number of GPIO lines to expose
+
+    label=<label> - label of the dummy chip
+
+    named_lines - defines whether dummy lines should be named, the names are
+                  of the form X-Y where X is the chip's label and Y is the
+                  line's offset
+
+Note: only num_lines is mandatory.
+
+Chips can be dynamically removed by writing the chip's label to
+"delete_device". For example:
+
+.. code-block:: sh
+
+    echo "gpio-mockup.0" > /sys/kernel/debug/gpio-mockup/delete_device
+
+Creating simulated chips using module params
+--------------------------------------------
+
+Note: this is an older, now deprecated method kept for backward compatibility
+for user-space tools.
+
+When loading the gpio-mockup driver a number of parameters can be passed to the
+module.
+
+    gpio_mockup_ranges
+
+        This parameter takes an argument in the form of an array of integer
+        pairs. Each pair defines the base GPIO number (if any) and the number
+        of lines exposed by the chip. If the base GPIO is -1, the gpiolib
+        will assign it automatically.
+
+        Example: gpio_mockup_ranges=-1,8,-1,16,405,4
+
+        The line above creates three chips. The first one will expose 8 lines,
+        the second 16 and the third 4. The base GPIO for the third chip is set
+        to 405 while for two first chips it will be assigned automatically.
+
+    gpio_named_lines
+
+        This parameter doesn't take any arguments. It lets the driver know that
+        GPIO lines exposed by it should be named.
+
+        The name format is: gpio-mockup-X-Y where X is the letter associated
+        with the mockup chip and Y is the line offset.
+
+Manipulating simulated lines
+----------------------------
+
+Each mockup chip creates its own subdirectory in /sys/kernel/debug/gpio-mockup/.
+The directory is named after the chip's label. A symlink is also created, named
+after the chip's name, which points to the label directory.
+
+Inside each subdirectory, there's a separate attribute for each GPIO line. The
+name of the attribute represents the line's offset in the chip.
+
+Reading from a line attribute returns the current value. Writing to it (0 or 1)
+changes its pull.
-- 
2.26.1

