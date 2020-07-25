Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B0BC433F7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 04:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CCD1206EB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 04:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mg+2IQh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgGYEWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 00:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgGYEWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 00:22:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FDEC0619D3;
        Fri, 24 Jul 2020 21:22:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t10so279270plz.10;
        Fri, 24 Jul 2020 21:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8oLSy6NIqIO8tuAFgf41GCsgIPYtXwqTw/FnwyZVv7E=;
        b=Mg+2IQh6H9pvQGbl5rq5vDonpsYpwNoH1fUyr719/M2/OXjJhaypL2Yw0VxXr7dlhs
         kRpBkLRwn1M9lKqRZYlby9kAz9PUlC6H6ESB4foUZ50MyRezpb13j4eHinZQgQWPU2uI
         9/ANpaWnX+uXLQEOKXivVnmtoqlaS09FS+7i6NqjBV4u8ezUpfgPSmGBeqORYEl7is7V
         +1IJ75l+demo1a205mEH1dxbMiZjbXVhdhbCq6eMlJtjpjmmnTpOAk3cei0BqcVNgvR0
         4XncmadELo4Bs6epdegIyLHs6VAFkGEJa7GkGMKzk8E677+yiAc9Sd8Xk1ZwBBDLIH5z
         VcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8oLSy6NIqIO8tuAFgf41GCsgIPYtXwqTw/FnwyZVv7E=;
        b=W7WE9PHnKi/tFhlsXpZklYkGPAAgcuckQKoqNyAxS2Sf87FNzi0Q/G6RlBWQTPuflZ
         ZQoY/QzF6PdLHB+0wHscMEImf+PvKbXA4pzI4DHtcEFbBWPciT/Gk6zzgGuXyiw4j+TM
         GTHWIdwZsF/m1IQRMNP4kGeF0YsGkoNKhE6AHHRmlAu/4bbBjmDcXvUqoUDHU7UgZl3S
         tRFp9Y9dbucgiIkTxbRWXKJuaz4++vskKgFZv3zQaJPyMUEor4fs3HK7WvUcEH5MSulS
         ECaHT4JrxPcyQe0+PFE2SAyvfUctOMWLKhozdjssz1uZT23wPjO2tsSi6UJ3PnmyBTWF
         s76g==
X-Gm-Message-State: AOAM533B9mXBl9OVra5tLzoYTM0Ld2gcMgo/WC9lFYJwZBoBhwTtje+l
        P74QDPrP7gEZevlaCSx//ldYaLx7
X-Google-Smtp-Source: ABdhPJydafyuSEBfv2C4vc6VKMkdZICgYUF4Rv/tYyWjAPbbj5gakYvH+tfVWe+3Uz5+fC9x/8cZbw==
X-Received: by 2002:a17:90a:3523:: with SMTP id q32mr7850148pjb.185.1595650952099;
        Fri, 24 Jul 2020 21:22:32 -0700 (PDT)
Received: from sol.lan (106-69-185-93.dyn.iinet.net.au. [106.69.185.93])
        by smtp.gmail.com with ESMTPSA id p1sm885320pjp.10.2020.07.24.21.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 21:22:31 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 14/18] tools: gpio: rename nlines to num_lines
Date:   Sat, 25 Jul 2020 12:19:51 +0800
Message-Id: <20200725041955.9985-15-warthog618@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200725041955.9985-1-warthog618@gmail.com>
References: <20200725041955.9985-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename nlines to num_lines to be consistent with other usage for fields
describing the number of entries in an array.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 tools/gpio/gpio-utils.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/gpio/gpio-utils.c b/tools/gpio/gpio-utils.c
index 16a5d9cb9da2..d527980bcb94 100644
--- a/tools/gpio/gpio-utils.c
+++ b/tools/gpio/gpio-utils.c
@@ -38,7 +38,7 @@
  *			such as "gpiochip0"
  * @lines:		An array desired lines, specified by offset
  *			index for the associated GPIO device.
- * @nline:		The number of lines to request.
+ * @num_lines:		The number of lines to request.
  * @flag:		The new flag for requsted gpio. Reference
  *			"linux/gpio.h" for the meaning of flag.
  * @data:		Default value will be set to gpio when flag is
@@ -56,7 +56,7 @@
  *			On failure return the errno.
  */
 int gpiotools_request_linehandle(const char *device_name, unsigned int *lines,
-				 unsigned int nlines, unsigned int flag,
+				 unsigned int num_lines, unsigned int flag,
 				 struct gpiohandle_data *data,
 				 const char *consumer_label)
 {
@@ -78,12 +78,12 @@ int gpiotools_request_linehandle(const char *device_name, unsigned int *lines,
 		goto exit_free_name;
 	}
 
-	for (i = 0; i < nlines; i++)
+	for (i = 0; i < num_lines; i++)
 		req.lineoffsets[i] = lines[i];
 
 	req.flags = flag;
 	strcpy(req.consumer_label, consumer_label);
-	req.lines = nlines;
+	req.lines = num_lines;
 	if (flag & GPIOHANDLE_REQUEST_OUTPUT)
 		memcpy(req.default_values, data, sizeof(req.default_values));
 
@@ -194,20 +194,20 @@ int gpiotools_get(const char *device_name, unsigned int line)
  *			such as "gpiochip0".
  * @lines:		An array desired lines, specified by offset
  *			index for the associated GPIO device.
- * @nline:		The number of lines to request.
+ * @num_lines:		The number of lines to request.
  * @data:		The array of values get from gpiochip.
  *
  * Return:		On success return 0;
  *			On failure return the errno.
  */
 int gpiotools_gets(const char *device_name, unsigned int *lines,
-		   unsigned int nlines, struct gpiohandle_data *data)
+		   unsigned int num_lines, struct gpiohandle_data *data)
 {
 	int fd;
 	int ret;
 	int ret_close;
 
-	ret = gpiotools_request_linehandle(device_name, lines, nlines,
+	ret = gpiotools_request_linehandle(device_name, lines, num_lines,
 					   GPIOHANDLE_REQUEST_INPUT, data,
 					   CONSUMER);
 	if (ret < 0)
@@ -245,7 +245,7 @@ int gpiotools_set(const char *device_name, unsigned int line,
  *			such as "gpiochip0".
  * @lines:		An array desired lines, specified by offset
  *			index for the associated GPIO device.
- * @nline:		The number of lines to request.
+ * @num_lines:		The number of lines to request.
  * @data:		The array of values set to gpiochip, must be
  *			0(low) or 1(high).
  *
@@ -253,11 +253,11 @@ int gpiotools_set(const char *device_name, unsigned int line,
  *			On failure return the errno.
  */
 int gpiotools_sets(const char *device_name, unsigned int *lines,
-		   unsigned int nlines, struct gpiohandle_data *data)
+		   unsigned int num_lines, struct gpiohandle_data *data)
 {
 	int ret;
 
-	ret = gpiotools_request_linehandle(device_name, lines, nlines,
+	ret = gpiotools_request_linehandle(device_name, lines, num_lines,
 					   GPIOHANDLE_REQUEST_OUTPUT, data,
 					   CONSUMER);
 	if (ret < 0)
-- 
2.27.0

