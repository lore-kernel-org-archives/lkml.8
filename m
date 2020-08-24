Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD12C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86FB7204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h53JpEW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgHXWX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 18:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHXWX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 18:23:29 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFB5C061574;
        Mon, 24 Aug 2020 15:23:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c15so10647180wrs.11;
        Mon, 24 Aug 2020 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IfUS4URwAi9r1GH23nLJXNeKi/lPL1y8e7MUKSPEyJk=;
        b=h53JpEW4YIJmyyVBDXBjaDiiHabRPoQDtG9UAFheRNC4uDo5OxZgXllhXKrUnud+gC
         rsk0MMTDvZG/VhY9AsqPv1TGHfvX98ooecgUYKr69PaL+wq0jbnm2maQ7xI3lKy2QbmU
         BAWrYfgk4SJ2YhgH6uSX+PrM1x4hgsbPwtGj3k6q7cSFMCGW7P7UEXrgPsPechZtauhu
         TVzyrdCuO/fOw2l36+Fain+nuGerXvns/OtZVk9JfcYkitEtBY6JrA90G87yKe9bDHXw
         6oKylGSpRwzkisXJQI21HgsBkZatEm+1Md/c4qhorX0wC2NzbmS3qSdM2+Y1So6Q/wKF
         hpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IfUS4URwAi9r1GH23nLJXNeKi/lPL1y8e7MUKSPEyJk=;
        b=qs9iISbCWSXv8JAxu/obU+WQlnU6t2xUs+0P7O8AICGCXg97dEDso0Q61uRskssG3s
         cme2/bpukVEstfj+Dq0yw+o1aX1jwTYhlBnbuoP+HW7s89+fbQuH5qlHvogu4DRb4kYU
         Tc4W1IKlgxETVvWL3PfXW3Ieq0Kbcj5fRGd5tjZbkOSbH2tHlrDe0u15MQTdOG2DHd+G
         aRxkRezj+HGPgXTaBKxQvPeZYT6DYgt+9AAT29+4e2RUTfDabCndFXY35B9aHlQWRel6
         66LZKzIPqK58YTjIhaIY2vb9GrHGTX7IOJxRwbrTs2VC6nlhYpl2IHI6v2JMme8OHXao
         /cMA==
X-Gm-Message-State: AOAM530jzHzvckMaQlbhNWmj5pCk1YdXID8+t5fZ7I2pXNqBZTbujLgh
        tpEB63TxiKKFKZ6aj4sazEN4SxQi97rYoMtC
X-Google-Smtp-Source: ABdhPJwtNgrtupYuEecY4fweDInf/YX+rSI1iRu+EDXbSQJDjJjbadB9q0kUBoYvYlnRYZxj6dFypQ==
X-Received: by 2002:adf:f58c:: with SMTP id f12mr7286242wro.45.1598307807824;
        Mon, 24 Aug 2020 15:23:27 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id 5sm1838236wmz.22.2020.08.24.15.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 15:23:27 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        accessrunner-general@lists.sourceforge.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: atm: don't use snprintf() for sysfs attrs
Date:   Mon, 24 Aug 2020 23:23:20 +0100
Message-Id: <20200824222322.22962-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/cpu.c: don't use snprintf() for sysfs attrs

As per the documentation (Documentation/filesystems/sysfs.rst),
snprintf() should not be used for formatting values returned by sysfs.

In all of these cases, sprintf() suffices as we know that the formatted
strings will be less than PAGE_SIZE in length.

Issue identified by Coccinelle.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/usb/atm/cxacru.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index ea66f8f385bae..e62a770a5d3bf 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -230,12 +230,12 @@ CXACRU__ATTR_INIT(_name)
 
 static ssize_t cxacru_sysfs_showattr_u32(u32 value, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%u\n", value);
+	return sprintf(buf, "%u\n", value);
 }
 
 static ssize_t cxacru_sysfs_showattr_s8(s8 value, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", value);
+	return sprintf(buf, "%d\n", value);
 }
 
 static ssize_t cxacru_sysfs_showattr_dB(s16 value, char *buf)
@@ -255,8 +255,8 @@ static ssize_t cxacru_sysfs_showattr_bool(u32 value, char *buf)
 	static char *str[] = { "no", "yes" };
 
 	if (unlikely(value >= ARRAY_SIZE(str)))
-		return snprintf(buf, PAGE_SIZE, "%u\n", value);
-	return snprintf(buf, PAGE_SIZE, "%s\n", str[value]);
+		return sprintf(buf, "%u\n", value);
+	return sprintf(buf, "%s\n", str[value]);
 }
 
 static ssize_t cxacru_sysfs_showattr_LINK(u32 value, char *buf)
@@ -264,8 +264,8 @@ static ssize_t cxacru_sysfs_showattr_LINK(u32 value, char *buf)
 	static char *str[] = { NULL, "not connected", "connected", "lost" };
 
 	if (unlikely(value >= ARRAY_SIZE(str) || str[value] == NULL))
-		return snprintf(buf, PAGE_SIZE, "%u\n", value);
-	return snprintf(buf, PAGE_SIZE, "%s\n", str[value]);
+		return sprintf(buf, "%u\n", value);
+	return sprintf(buf, "%s\n", str[value]);
 }
 
 static ssize_t cxacru_sysfs_showattr_LINE(u32 value, char *buf)
@@ -275,8 +275,8 @@ static ssize_t cxacru_sysfs_showattr_LINE(u32 value, char *buf)
 		"waiting", "initialising"
 	};
 	if (unlikely(value >= ARRAY_SIZE(str)))
-		return snprintf(buf, PAGE_SIZE, "%u\n", value);
-	return snprintf(buf, PAGE_SIZE, "%s\n", str[value]);
+		return sprintf(buf, "%u\n", value);
+	return sprintf(buf, "%s\n", str[value]);
 }
 
 static ssize_t cxacru_sysfs_showattr_MODU(u32 value, char *buf)
@@ -288,8 +288,8 @@ static ssize_t cxacru_sysfs_showattr_MODU(u32 value, char *buf)
 			"ITU-T G.992.2 (G.LITE)"
 	};
 	if (unlikely(value >= ARRAY_SIZE(str)))
-		return snprintf(buf, PAGE_SIZE, "%u\n", value);
-	return snprintf(buf, PAGE_SIZE, "%s\n", str[value]);
+		return sprintf(buf, "%u\n", value);
+	return sprintf(buf, "%s\n", str[value]);
 }
 
 /*
@@ -309,8 +309,7 @@ static ssize_t mac_address_show(struct device *dev,
 	if (instance == NULL || instance->usbatm->atm_dev == NULL)
 		return -ENODEV;
 
-	return snprintf(buf, PAGE_SIZE, "%pM\n",
-		instance->usbatm->atm_dev->esi);
+	return sprintf(buf, "%pM\n", instance->usbatm->atm_dev->esi);
 }
 
 static ssize_t adsl_state_show(struct device *dev,
@@ -326,8 +325,8 @@ static ssize_t adsl_state_show(struct device *dev,
 
 	value = instance->card_info[CXINF_LINE_STARTABLE];
 	if (unlikely(value >= ARRAY_SIZE(str)))
-		return snprintf(buf, PAGE_SIZE, "%u\n", value);
-	return snprintf(buf, PAGE_SIZE, "%s\n", str[value]);
+		return sprintf(buf, "%u\n", value);
+	return sprintf(buf, "%s\n", str[value]);
 }
 
 static ssize_t adsl_state_store(struct device *dev,
-- 
2.28.0

