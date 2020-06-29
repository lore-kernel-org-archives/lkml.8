Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B87C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64FD2206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jOLEqH8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388705AbgF2VSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729796AbgF2Swu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F52FC02E2D5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:05:03 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z15so5407910wrl.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mu+wXsRAPVJI2BbUnA6whI4V192flwFfYNz4LkoWH3w=;
        b=jOLEqH8u8fh6v6UYWj7y6Sg98lssQOe4aTyeSL0IikxGXCqZutLG6GKlQ9BXJNekwO
         pA0FLrP45RJazv/O776JiqFwBiM9SSicqTdF0HmAHU3jsaAj1VlHgzlj9wY/GzgB17pM
         ubWy6qfRPbBvZ8J3w1kxyXFv/IeI5waIMPcfmr2zcYZvZlRxT2dwWNaRuE4Puv/HfYYT
         nIkmrT8A+p9sCGg0k4ohno1ddfnIdqPqRPEFbj0iJclDIK6PzXYisbdjyd+W2gD3vfvk
         Zsevyfjt6lHQNZDymm97hSlwNKvxpXflu4E4I+3qDDPb+o+TP01B05fqRjFg7PI25dmS
         Rl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mu+wXsRAPVJI2BbUnA6whI4V192flwFfYNz4LkoWH3w=;
        b=M1F2eHRpOPY56+Ka/3WO5iuq9VSCsYZqR5t4chatvmvvI4DnC+MBOmTwR55STlR3JN
         8YYPL8VtnvUoJ+ZwbXt6L5MC+94YFsXOKQyS92ZvppxE90a+v7fVRGkLgmOAVft+wz35
         FlsglnIqYilVwHEgWpJJXG7j+WagZXnH4hdE5tZYxlLcqGnYt8Goe8bmRSrdDIjwWNLP
         VAwXGku/KfGGDc1dlzk7ieRKHOk4nrxLtAQsfclfOtYWEN/PeptI++1mROf2lobKd5xS
         0UuincSCqgWJ4xDV2Pj0FKKgg8jugfqHRGxZPcm0sh5CVxwJgPpPwEmLoAvEe12AFEom
         rMog==
X-Gm-Message-State: AOAM531fa1YjB0z+zSnBGEzP2cDB9zveA5KkUj0KPsKn33ItPrkKj4Cu
        i4Rb+pPl4Md2tNHQQCdHW7ienQ==
X-Google-Smtp-Source: ABdhPJznnVAOrd15Z7Gc4f8Mk9Y3wkQjwCks7QOJqn2xOTJTvoqY/62dUv1+U/NtBEe3EVYh+Ui3rw==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr17241252wrs.228.1593439501944;
        Mon, 29 Jun 2020 07:05:01 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p14sm15394928wrj.14.2020.06.29.07.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:05:00 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Masayuki Ohtak <masa-korg@dsn.okisemi.com>,
        Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Subject: [PATCH 13/20] misc: pch_phub: Provide descriptions for 'chip' argument
Date:   Mon, 29 Jun 2020 15:04:35 +0100
Message-Id: <20200629140442.1043957-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629140442.1043957-1-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason (probably copy 'n' paste) kerneldoc descriptions
were missing for all instances of 'chip'.  Providing them squashes
the following W=1 kernel build warnings:

 drivers/misc/pch_phub.c:145: warning: Function parameter or member 'chip' not described in 'pch_phub_read_modify_write_reg'
 drivers/misc/pch_phub.c:282: warning: Function parameter or member 'chip' not described in 'pch_phub_read_serial_rom'
 drivers/misc/pch_phub.c:296: warning: Function parameter or member 'chip' not described in 'pch_phub_write_serial_rom'
 drivers/misc/pch_phub.c:334: warning: Function parameter or member 'chip' not described in 'pch_phub_read_serial_rom_val'
 drivers/misc/pch_phub.c:350: warning: Function parameter or member 'chip' not described in 'pch_phub_write_serial_rom_val'
 drivers/misc/pch_phub.c:450: warning: Function parameter or member 'chip' not described in 'pch_phub_read_gbe_mac_addr'
 drivers/misc/pch_phub.c:462: warning: Function parameter or member 'chip' not described in 'pch_phub_write_gbe_mac_addr'

Cc: Masayuki Ohtak <masa-korg@dsn.okisemi.com>
Cc: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/pch_phub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/misc/pch_phub.c b/drivers/misc/pch_phub.c
index 60828af7506a3..95ba82a8625b0 100644
--- a/drivers/misc/pch_phub.c
+++ b/drivers/misc/pch_phub.c
@@ -135,6 +135,7 @@ static DEFINE_MUTEX(pch_phub_mutex);
 
 /**
  * pch_phub_read_modify_write_reg() - Reading modifying and writing register
+ * @chip:		Pointer to the PHUB register structure
  * @reg_addr_offset:	Register offset address value.
  * @data:		Writing value.
  * @mask:		Mask value.
@@ -274,6 +275,7 @@ static void pch_phub_restore_reg_conf(struct pci_dev *pdev)
 
 /**
  * pch_phub_read_serial_rom() - Reading Serial ROM
+ * @chip:		Pointer to the PHUB register structure
  * @offset_address:	Serial ROM offset address to read.
  * @data:		Read buffer for specified Serial ROM value.
  */
@@ -288,6 +290,7 @@ static void pch_phub_read_serial_rom(struct pch_phub_reg *chip,
 
 /**
  * pch_phub_write_serial_rom() - Writing Serial ROM
+ * @chip:		Pointer to the PHUB register structure
  * @offset_address:	Serial ROM offset address.
  * @data:		Serial ROM value to write.
  */
@@ -326,6 +329,7 @@ static int pch_phub_write_serial_rom(struct pch_phub_reg *chip,
 
 /**
  * pch_phub_read_serial_rom_val() - Read Serial ROM value
+ * @chip:		Pointer to the PHUB register structure
  * @offset_address:	Serial ROM address offset value.
  * @data:		Serial ROM value to read.
  */
@@ -342,6 +346,7 @@ static void pch_phub_read_serial_rom_val(struct pch_phub_reg *chip,
 
 /**
  * pch_phub_write_serial_rom_val() - writing Serial ROM value
+ * @chip:		Pointer to the PHUB register structure
  * @offset_address:	Serial ROM address offset value.
  * @data:		Serial ROM value.
  */
@@ -444,6 +449,7 @@ static int pch_phub_gbe_serial_rom_conf_mp(struct pch_phub_reg *chip)
 /**
  * pch_phub_read_gbe_mac_addr() - Read Gigabit Ethernet MAC address
  * @offset_address:	Gigabit Ethernet MAC address offset value.
+ * @chip:		Pointer to the PHUB register structure
  * @data:		Buffer of the Gigabit Ethernet MAC address value.
  */
 static void pch_phub_read_gbe_mac_addr(struct pch_phub_reg *chip, u8 *data)
@@ -456,6 +462,7 @@ static void pch_phub_read_gbe_mac_addr(struct pch_phub_reg *chip, u8 *data)
 /**
  * pch_phub_write_gbe_mac_addr() - Write MAC address
  * @offset_address:	Gigabit Ethernet MAC address offset value.
+ * @chip:		Pointer to the PHUB register structure
  * @data:		Gigabit Ethernet MAC address value.
  */
 static int pch_phub_write_gbe_mac_addr(struct pch_phub_reg *chip, u8 *data)
-- 
2.25.1

