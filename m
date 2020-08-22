Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C58C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE3592078A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDx6zyFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgHVUWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 16:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgHVUWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 16:22:47 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057EBC061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:22:47 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id p25so4325547qkp.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=+liW2VVAo4Ummi/U4epDsdZoqMsSVzRSRmM1RH5MGeg=;
        b=MDx6zyFUkAG3v05fhMwGsIQ59KC18AeVurthSd4ZhyxAs+Ahs+u7DaVbZvMuxh162B
         GogdvncX8buGFPP4u8A+Fap+ZPmcuWHkRTF/mtldd9BD8qTJIZSo4onoKKO+dCnW/cPP
         9e58BpLcGkDSHFnxMVGxw6q2cmDCtKxlHdpSKoQ5s9JI3aXMo44LzzlhXp8qAkrsfPBQ
         XiVUCZjNbg0bzEJIr3NCBqKhiMq9wahKRze+Gri4aQ0NMbuF/kfz2Jh3/gKr+3C/5Y2E
         NFf9LaJiwKvRMgl2DSkDpJOnmsenxhGyLuEhcKNMsIDguINR0R8caAdY2DpwHl4f4hSV
         6GRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+liW2VVAo4Ummi/U4epDsdZoqMsSVzRSRmM1RH5MGeg=;
        b=YOs5gSmw1JDs1E+7m+eqK+fqcSRp4VTHuetuIbYF6IOOKCfceYhX0e8cMuC/nnoxKr
         GPcn2fBSINAvx/5e3zlfEFenCOZf3ouwsS/b1ZPi8F2PbguQOAKeUQKXeqIZofV9SWls
         GTMPNzm5QrHXxcCm16RUwWrhQRiwhdn9Oxd2l8nzDqVlJI2i+3hMKAMonz2SPcsEIO00
         b7MOjuR2fZF3UBkLQRnj1s+eFFcHcpWVytwj//iwUWK/Fioy4D2KLHKMCYafmLKWGcuH
         4HAJa8frDvAwOUqZR53SAkJk5Kyfts7NGUe7AeMc8/NnegZDPLC3+dSkOB2ataNq+yNV
         e5iw==
X-Gm-Message-State: AOAM530Nu9iXQQ2AJ1XrP9z5YgIUPyOoGFacgqjNQGj2yMBSaY5NwDmj
        05Rbjqgts1djIO4W/KBzBFYFbcfrrcNjIQ==
X-Google-Smtp-Source: ABdhPJw2ouqGhT0Nv4Emc7sIzQEgEIl/K8+gOGNRyDtOMudejCAJSA/lZmxbTpW0q6VdCaGySKz5Hw==
X-Received: by 2002:a37:4811:: with SMTP id v17mr7955883qka.166.1598127766161;
        Sat, 22 Aug 2020 13:22:46 -0700 (PDT)
Received: from archlaptop.localdomain ([71.219.109.128])
        by smtp.gmail.com with ESMTPSA id a3sm6358219qtj.21.2020.08.22.13.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 13:22:45 -0700 (PDT)
Date:   Sat, 22 Aug 2020 16:21:31 -0400
From:   Ethan Edwards <ethancarteredwards@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     abbotti@mev.co.uk, linux-kernel@vger.kernel.org,
        hsweeten@visionengravers.com, devel@driverdev.osuosl.org
Subject: [PATCH] drivers: staging: comedi: fixed duplicate words from
 checkpatch
Message-ID: <20200822202131.53kpj2gg35af6vud@archlaptop.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed various different checkpatch duplicate word warnings, the TODO
file said to fix checkpatch warnings.

My old email didn't CC the mailing lists, ignore the old one, sorry.

Signed-off-by: Ethan Edwards <ethancarteredwards@gmail.com>
---
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

