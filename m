Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BF4C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE95C2065F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+3lOzZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgHYAbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 20:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgHYAbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:31:12 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4BBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 17:31:12 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 92so2420868qtb.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 17:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=xANOom6za8213SIT9asU21bhuancO+3Fjld5hj7jZ9s=;
        b=d+3lOzZ+Rv4Nlvq69bdhckoKvsBmiGKeS9NHwPjqQueToG0Vjecc1NrCaUlt0cOhnM
         NM61u98rxDIj0BgMKd2GYoCSr/wKGZR7K4KZ4xGQTjb/uWM0M8lgfYF9sOd2OrHZrvRJ
         /MQRLMtbn/z5VOlovh4RQlr2e37vM+Q5wa2TLpJw1MeBcahBUIMvF45f9ATEaprg+enb
         xinOuR6ADDhv+9E2zpkXr7WP5IYB6xP41ONbO6B10K9sb/U8WyJWx1itco4Fnv2eO5qe
         GN6fFG8sZebF5ez1z9ptPQCVpvswWFR287JwnZUYKsgWKn3UrBHuq7e5JrLFox275ddC
         3kSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xANOom6za8213SIT9asU21bhuancO+3Fjld5hj7jZ9s=;
        b=LDKDo7LpTuGbxAMhtdQnLrUONG7QfObGTPyR2TJ7Kx1Rt6ktoOARTzd3BwpGye2WGw
         cJmQbNJx/ndvKq/1kbxkeH+MqBJqRcxT6KyWlCvr2YKfNK3OijN9OlB3rZeNk+AxIWoY
         kUAAyIGiVMGDhpyebwK6WSc1TBFVAGOXR6hEUsvrM7VBfeTIOJRSkZsbZkQ/69KWWbiw
         AiZXJ+prapRqLOmYrlMxp5L68XNnKGi8p9i6fAIr9Hp4+AGER7AXWywDMA1TIHRp61l3
         TYHfJtQQsUYmJzNoPdluymUbpAhCZWp766xZGw3KJ7nTt88rsi1MkHbDlcfMPE69NbkF
         w/jg==
X-Gm-Message-State: AOAM533FhZhAz40M0yfb8QYwWlX++GU+F9Kq7j1CIqRdCAPy/BfQ6v5G
        MN/seyhA8Sh/wR4WEFi8cjY=
X-Google-Smtp-Source: ABdhPJyTUpH2n1QuMbEfMZ8aD/Bwk0jpTQJ+FREvsINy4FLzxMuOMBv34WjMkNlkTuYXLTF9+uoLFw==
X-Received: by 2002:ac8:7395:: with SMTP id t21mr7146636qtp.205.1598315471330;
        Mon, 24 Aug 2020 17:31:11 -0700 (PDT)
Received: from archlaptop.localdomain ([71.219.109.128])
        by smtp.gmail.com with ESMTPSA id v45sm12857859qtc.42.2020.08.24.17.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 17:31:10 -0700 (PDT)
Date:   Mon, 24 Aug 2020 20:29:55 -0400
From:   Ethan Edwards <ethancarteredwards@gmail.com>
To:     gregkh@linuxfoundation.org, abbotti@mev.co.uk
Cc:     linux-kernel@vger.kernel.org, hsweeten@visionengravers.com,
        devel@driverdev.osuosl.org
Subject: [PATCH v2] drivers: staging: comedi: fixed duplicate words from
 checkpatch
Message-ID: <20200825002955.e3wvtwsoqqbc2cvl@archlaptop.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed various different checkpatch duplicate word warnings, the TODO
file said to fix checkpatch warnings.

Signed-off-by: Ethan Edwards <ethancarteredwards@gmail.com>
---
Old email has lines about CC'ing the mailing lists, patch v2 fixes this.
 drivers/staging/comedi/comedi.h                  | 4 ++--
 drivers/staging/comedi/comedidev.h               | 2 +-
 drivers/staging/comedi/drivers/addi_apci_1564.c  | 4 ++--
 drivers/staging/comedi/drivers/comedi_8255.c     | 2 +-
 drivers/staging/comedi/drivers/ni_tiocmd.c       | 2 +-
 drivers/staging/comedi/drivers/pcmuio.c          | 2 +-
 drivers/staging/comedi/drivers/quatech_daqp_cs.c | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/comedi/comedi.h b/drivers/staging/comedi/comedi.h
index 09a940066c0e..b5d00a006dbb 100644
--- a/drivers/staging/comedi/comedi.h
+++ b/drivers/staging/comedi/comedi.h
@@ -680,7 +680,7 @@ struct comedi_rangeinfo {
  * value of 1 volt.
  *
  * The only defined flag value is %RF_EXTERNAL (%0x100), indicating that the
- * the range needs to be multiplied by an external reference.
+ * range needs to be multiplied by an external reference.
  */
 struct comedi_krange {
 	int min;
@@ -970,7 +970,7 @@ enum i8254_mode {
  *   major reasons exist why this caused major confusion for users:
  *   1) The register values are _NOT_ in user documentation, but rather in
  *     arcane locations, such as a few register programming manuals that are
- *     increasingly hard to find and the NI MHDDK (comments in in example code).
+ *     increasingly hard to find and the NI MHDDK (comments in example code).
  *     There is no one place to find the various valid values of the registers.
  *   2) The register values are _NOT_ completely consistent.  There is no way to
  *     gain any sense of intuition of which values, or even enums one should use
diff --git a/drivers/staging/comedi/comedidev.h b/drivers/staging/comedi/comedidev.h
index 0dff1ac057cd..0e1b95ef9a4d 100644
--- a/drivers/staging/comedi/comedidev.h
+++ b/drivers/staging/comedi/comedidev.h
@@ -627,7 +627,7 @@ extern const struct comedi_lrange range_unknown;
  * @range: Array of &struct comedi_krange, one for each range.
  *
  * Each element of @range[] describes the minimum and maximum physical range
- * range and the type of units.  Typically, the type of unit is %UNIT_volt
+ * and the type of units.  Typically, the type of unit is %UNIT_volt
  * (i.e. volts) and the minimum and maximum are in millionths of a volt.
  * There may also be a flag that indicates the minimum and maximum are merely
  * scale factors for an unknown, external reference.
diff --git a/drivers/staging/comedi/drivers/addi_apci_1564.c b/drivers/staging/comedi/drivers/addi_apci_1564.c
index fadefcb5c237..06fc7ed96200 100644
--- a/drivers/staging/comedi/drivers/addi_apci_1564.c
+++ b/drivers/staging/comedi/drivers/addi_apci_1564.c
@@ -544,7 +544,7 @@ static int apci1564_timer_insn_write(struct comedi_device *dev,
 {
 	struct apci1564_private *devpriv = dev->private;
 
-	/* just write the last last to the reload register */
+	/* just write the last to the reload register */
 	if (insn->n) {
 		unsigned int val = data[insn->n - 1];
 
@@ -628,7 +628,7 @@ static int apci1564_counter_insn_write(struct comedi_device *dev,
 	unsigned int chan = CR_CHAN(insn->chanspec);
 	unsigned long iobase = devpriv->counters + APCI1564_COUNTER(chan);
 
-	/* just write the last last to the reload register */
+	/* just write the last to the reload register */
 	if (insn->n) {
 		unsigned int val = data[insn->n - 1];
 
diff --git a/drivers/staging/comedi/drivers/comedi_8255.c b/drivers/staging/comedi/drivers/comedi_8255.c
index 3298725b9ba5..b7ca465933ee 100644
--- a/drivers/staging/comedi/drivers/comedi_8255.c
+++ b/drivers/staging/comedi/drivers/comedi_8255.c
@@ -248,7 +248,7 @@ EXPORT_SYMBOL_GPL(subdev_8255_mm_init);
  * subdev_8255_regbase - get offset of 8255 registers or call-back context
  * @s: comedi subdevice
  *
- * Returns the 'regbase' parameter that was previously passed to to
+ * Returns the 'regbase' parameter that was previously passed to
  * subdev_8255_init() or subdev_8255_mm_init() to set up the subdevice.
  * Only valid if the subdevice was set up successfully.
  */
diff --git a/drivers/staging/comedi/drivers/ni_tiocmd.c b/drivers/staging/comedi/drivers/ni_tiocmd.c
index 2a9f7e9821a7..ab6d9e8269f3 100644
--- a/drivers/staging/comedi/drivers/ni_tiocmd.c
+++ b/drivers/staging/comedi/drivers/ni_tiocmd.c
@@ -286,7 +286,7 @@ int ni_tio_cmdtest(struct comedi_device *dev,
 		 * This should be done, but we don't yet know the actual
 		 * register values.  These should be tested and then documented
 		 * in the ni_route_values/ni_*.csv files, with indication of
-		 * who/when/which/how these these were tested.
+		 * who/when/which/how these were tested.
 		 * When at least a e/m/660x series have been tested, this code
 		 * should be uncommented:
 		 *
diff --git a/drivers/staging/comedi/drivers/pcmuio.c b/drivers/staging/comedi/drivers/pcmuio.c
index 7e1fc6ffb48c..b299d648a0eb 100644
--- a/drivers/staging/comedi/drivers/pcmuio.c
+++ b/drivers/staging/comedi/drivers/pcmuio.c
@@ -48,7 +48,7 @@
  *
  * In the 48-channel version:
  *
- * On subdev 0, the first 24 channels channels are edge-detect channels.
+ * On subdev 0, the first 24 channels are edge-detect channels.
  *
  * In the 96-channel board you have the following channels that can do edge
  * detection:
diff --git a/drivers/staging/comedi/drivers/quatech_daqp_cs.c b/drivers/staging/comedi/drivers/quatech_daqp_cs.c
index 1b1efa4d31f6..fe4408ebf6b3 100644
--- a/drivers/staging/comedi/drivers/quatech_daqp_cs.c
+++ b/drivers/staging/comedi/drivers/quatech_daqp_cs.c
@@ -164,7 +164,7 @@ static int daqp_clear_events(struct comedi_device *dev, int loops)
 
 	/*
 	 * Reset any pending interrupts (my card has a tendency to require
-	 * require multiple reads on the status register to achieve this).
+	 * multiple reads on the status register to achieve this).
 	 */
 	while (--loops) {
 		status = inb(dev->iobase + DAQP_STATUS_REG);
-- 
2.28.0

