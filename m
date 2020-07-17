Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492F7C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2709E207FB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I+dyJzmv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgGQJCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgGQJCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:02:23 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78705C08C5C0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 02:02:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so10183707wru.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 02:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lOFGBT6nwlFy0K7Ws6AFSkHqfysSAoC6A9Svh8/QEaE=;
        b=I+dyJzmvgNapS+HZBn0cj8uQT6TcP/EpgOQWPNLIxDpFpvDL0KTg370JTPJywBn0HI
         pjyVjokB+jJQC5kojB5YkrMyhKBhMu4NUxZ15fCyYr2R+91ooLseg6rCTZFtANPHAfTP
         2urkeGfKYlD6dNC15mTsREoriTyXUTIMkvOFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lOFGBT6nwlFy0K7Ws6AFSkHqfysSAoC6A9Svh8/QEaE=;
        b=XrdJ2qbkmOFRqcs3KSisnBxmbnNEN22zSwXth4gZtr9yMr3ZngJNBhoTOAa8z5APTh
         TV2ibLBtm7rWpbvakvHqRd9sxTsygztP4l8rmtAEHo/RY1kabW5aYgSoXX8BpOXne5X9
         hxIr2/NAJcRvXO28jtSVPaIegHPHXp3GP1OsckHYZBHv1XIeTMxnAboVbBwxj0jK+h3b
         Xem0q9FGpLK1ddQwO9k2Z8srqoEop/sFYF6HofadzaktdddfSmbYAv9ZXlne9l0O662p
         xY+sroFfiQnDE5DkcULS68MeeYRVhXka4Tp83dKI8cAFKN0OFLD0XWRHvgVFqU4ZBkGY
         eq1w==
X-Gm-Message-State: AOAM531IR5K7qSV1gEiX9/sZPeNOMitd3MrumWMn41hMzyRBePooi8RE
        K8ZTnnGuFjxfaBWdLzyGYq/DAg==
X-Google-Smtp-Source: ABdhPJwkv3GP+yoO3aa/iB4f6cPcSvVw1dbgZ9MfmiPOeUBDzWZ8OJvFBpiqSmc2rP6fWRRYfcIk0w==
X-Received: by 2002:adf:e3c5:: with SMTP id k5mr9415590wrm.121.1594976542001;
        Fri, 17 Jul 2020 02:02:22 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id w7sm12360705wmc.32.2020.07.17.02.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 02:02:21 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Lori Hikichi <lori.hikichi@broadcom.com>,
        Robert Richter <rrichter@marvell.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v2 2/2] i2c: iproc: add slave pec support
Date:   Fri, 17 Jul 2020 14:31:55 +0530
Message-Id: <20200717090155.10383-3-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717090155.10383-1-rayagonda.kokatanur@broadcom.com>
References: <20200717090155.10383-1-rayagonda.kokatanur@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Iproc supports PEC computation and checking in both Master
and Slave mode.

This patch adds support for PEC in slave mode.

As per hw spec, PEC ERROR status bits are [29:28] in S_RX_OFFSET
register, hence this patch corrects the S_RX_PEC_ERR_SHIFT.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
Changes from v1:
 -Address review comments from Andy Shevchenko
  Update commit message,
  Rewrite bcm_iproc_smbus_check_slave_pec() to remove local
  variable ret and type casting,
  Use positive condition.

 drivers/i2c/busses/i2c-bcm-iproc.c | 49 +++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 8a3c98866fb7..cfa7b044209e 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -93,6 +93,7 @@
 #define S_CMD_STATUS_MASK            0x07
 #define S_CMD_STATUS_SUCCESS         0x0
 #define S_CMD_STATUS_TIMEOUT         0x5
+#define S_CMD_PEC_SHIFT              8
 
 #define IE_OFFSET                    0x38
 #define IE_M_RX_FIFO_FULL_SHIFT      31
@@ -138,7 +139,9 @@
 #define S_RX_OFFSET                  0x4c
 #define S_RX_STATUS_SHIFT            30
 #define S_RX_STATUS_MASK             0x03
-#define S_RX_PEC_ERR_SHIFT           29
+#define S_RX_PEC_ERR_SHIFT           28
+#define S_RX_PEC_ERR_MASK            0x3
+#define S_RX_PEC_ERR                 0x1
 #define S_RX_DATA_SHIFT              0
 #define S_RX_DATA_MASK               0xff
 
@@ -205,6 +208,8 @@ struct bcm_iproc_i2c_dev {
 	/* bytes that have been read */
 	unsigned int rx_bytes;
 	unsigned int thld_bytes;
+
+	bool en_s_pec;
 };
 
 /*
@@ -321,6 +326,23 @@ static void bcm_iproc_i2c_check_slave_status(
 	}
 }
 
+static int bcm_iproc_smbus_check_slave_pec(struct bcm_iproc_i2c_dev *iproc_i2c,
+					   u32 val)
+{
+	u8 err_status;
+
+	if (!iproc_i2c->en_s_pec)
+		return 0;
+
+	err_status = (val >> S_RX_PEC_ERR_SHIFT) & S_RX_PEC_ERR_MASK;
+	if (err_status == S_RX_PEC_ERR) {
+		dev_err(iproc_i2c->device, "Slave PEC error\n");
+		return -EBADMSG;
+	}
+
+	return 0;
+}
+
 static bool bcm_iproc_i2c_slave_isr(struct bcm_iproc_i2c_dev *iproc_i2c,
 				    u32 status)
 {
@@ -347,6 +369,8 @@ static bool bcm_iproc_i2c_slave_isr(struct bcm_iproc_i2c_dev *iproc_i2c,
 			iproc_i2c_wr_reg(iproc_i2c, S_TX_OFFSET, value);
 
 			val = BIT(S_CMD_START_BUSY_SHIFT);
+			if (iproc_i2c->en_s_pec)
+				val |= BIT(S_CMD_PEC_SHIFT);
 			iproc_i2c_wr_reg(iproc_i2c, S_CMD_OFFSET, val);
 
 			/*
@@ -361,9 +385,19 @@ static bool bcm_iproc_i2c_slave_isr(struct bcm_iproc_i2c_dev *iproc_i2c,
 			value = (u8)((val >> S_RX_DATA_SHIFT) & S_RX_DATA_MASK);
 			i2c_slave_event(iproc_i2c->slave,
 					I2C_SLAVE_WRITE_RECEIVED, &value);
-			if (rx_status == I2C_SLAVE_RX_END)
-				i2c_slave_event(iproc_i2c->slave,
-						I2C_SLAVE_STOP, &value);
+			if (rx_status == I2C_SLAVE_RX_END) {
+				int ret;
+
+				ret = bcm_iproc_smbus_check_slave_pec(iproc_i2c,
+								      val);
+				if (ret)
+					i2c_slave_event(iproc_i2c->slave,
+							I2C_SLAVE_PEC_ERR,
+							&value);
+				else
+					i2c_slave_event(iproc_i2c->slave,
+							I2C_SLAVE_STOP, &value);
+			}
 		}
 	} else if (status & BIT(IS_S_TX_UNDERRUN_SHIFT)) {
 		/* Master read other than start */
@@ -372,6 +406,8 @@ static bool bcm_iproc_i2c_slave_isr(struct bcm_iproc_i2c_dev *iproc_i2c,
 
 		iproc_i2c_wr_reg(iproc_i2c, S_TX_OFFSET, value);
 		val = BIT(S_CMD_START_BUSY_SHIFT);
+		if (iproc_i2c->en_s_pec)
+			val |= BIT(S_CMD_PEC_SHIFT);
 		iproc_i2c_wr_reg(iproc_i2c, S_CMD_OFFSET, val);
 	}
 
@@ -1065,6 +1101,11 @@ static int bcm_iproc_i2c_reg_slave(struct i2c_client *slave)
 	if (slave->flags & I2C_CLIENT_TEN)
 		return -EAFNOSUPPORT;
 
+	/* Enable partial slave HW PEC support if requested by the client */
+	iproc_i2c->en_s_pec = !!(slave->flags & I2C_CLIENT_PEC);
+	if (iproc_i2c->en_s_pec)
+		dev_info(iproc_i2c->device, "Enable PEC\n");
+
 	iproc_i2c->slave = slave;
 	bcm_iproc_i2c_slave_init(iproc_i2c, false);
 	return 0;
-- 
2.17.1

