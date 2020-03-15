Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0866C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 19:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CC2206B1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 19:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjbNEwM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgCOTQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 15:16:44 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54791 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbgCOTQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 15:16:44 -0400
Received: by mail-pj1-f65.google.com with SMTP id np9so296223pjb.4;
        Sun, 15 Mar 2020 12:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5gxpV7JB+0bFUt/kU5rYLHIq/2ry55hJR4QU1nC9mRw=;
        b=rjbNEwM/XgZEinoND9gGIEJmVXVX0IanV6iiJpzvEKbgkrF/FYCqlwIoWUXcBa2+c/
         yIYS7nZrQpACubLkCOlWVSzJcvGltPWfy6osRa8MiOCJFO74iwIYa5oAq2deqKWDAgx5
         vJIwK1bDlkX8vEKx+6vXlGCoz+VaAiKCmyBGkVphf8x4yOueYmEXIfKIxNm16CN5cwv+
         FN8kwokDMxYMHUGamnUhx3PK1KVr2j2v89KLITk1XOPZNqYqEZhBEkX0hDlHGROA/nV+
         lztSZKFuoprzHWSvFf7mXNvbijq/sQRLZA2zHQqdbfuCJ8Bgw5MiF1ijls/NIobvhsop
         riIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5gxpV7JB+0bFUt/kU5rYLHIq/2ry55hJR4QU1nC9mRw=;
        b=W+RV7u5CisVxIIcte9P+19V2PwsddECqQ0qwHvOEDeMQsU7qP+pcI++K/fOpjUd/GJ
         TyQ4swGtDXUcNT3ZliN1vLTxNDBgRnOoDa2+v/UjMMQQpIEV0PLj22Q8mFxvNMSPFplH
         tMboYB4cCgtttHGdcZ2RBPTLohka4Zkgjy9yxqewzLkNBh9sq0U98HTYAPpNlL/awPzQ
         1rU9EeOhuQmGSTPz+gPbMaQRSIc3krHxv1cOXZMLjO5sruohg3Op6rZLDq+/AtpHPej4
         yiyqhc5MDPCkjb2FXpTRghF6aKgLeNOt+IU1semP1P+j83s1YKX3DRk1XXLSCRKcVrwv
         RLkA==
X-Gm-Message-State: ANhLgQ3VEM7B+NGtmR3SkeSUB0145tXUDvWeLxPgH6iaDaUc2dcyKEQK
        KLMguxCu3Z2lnbCgXbDJVLs=
X-Google-Smtp-Source: ADFU+vvPigWemmbDaZCwov3VlDQsV3Pr9WZu55/E9xaVXXoXBXL4qctLgdHRc/GF5GsrKHAcIT2RcA==
X-Received: by 2002:a17:902:ee93:: with SMTP id a19mr11882497pld.258.1584299802773;
        Sun, 15 Mar 2020 12:16:42 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-24-4-25-55.hsd1.ca.comcast.net. [24.4.25.55])
        by smtp.gmail.com with ESMTPSA id 13sm61431882pgo.13.2020.03.15.12.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 12:16:42 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v2 2/6] usb: gadget: add "usb_validate_langid" function
Date:   Sun, 15 Mar 2020 12:16:28 -0700
Message-Id: <20200315191632.12536-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200315191632.12536-1-rentao.bupt@gmail.com>
References: <20200315191632.12536-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

The USB LANGID validation code in "check_user_usb_string" function is
moved to "usb_validate_langid" function which can be used by other usb
gadget drivers.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 No change in v2:
   - the patch is added into the series since v2.

 drivers/usb/gadget/configfs.c  | 14 +-------------
 drivers/usb/gadget/usbstring.c | 24 ++++++++++++++++++++++++
 include/linux/usb/gadget.h     |  3 +++
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 32b637e3e1fa..822ef0470c5f 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -13,8 +13,6 @@
 int check_user_usb_string(const char *name,
 		struct usb_gadget_strings *stringtab_dev)
 {
-	unsigned primary_lang;
-	unsigned sub_lang;
 	u16 num;
 	int ret;
 
@@ -22,17 +20,7 @@ int check_user_usb_string(const char *name,
 	if (ret)
 		return ret;
 
-	primary_lang = num & 0x3ff;
-	sub_lang = num >> 10;
-
-	/* simple sanity check for valid langid */
-	switch (primary_lang) {
-	case 0:
-	case 0x62 ... 0xfe:
-	case 0x100 ... 0x3ff:
-		return -EINVAL;
-	}
-	if (!sub_lang)
+	if (!usb_validate_langid(num))
 		return -EINVAL;
 
 	stringtab_dev->language = num;
diff --git a/drivers/usb/gadget/usbstring.c b/drivers/usb/gadget/usbstring.c
index 7c24d1ce1088..58a4d3325090 100644
--- a/drivers/usb/gadget/usbstring.c
+++ b/drivers/usb/gadget/usbstring.c
@@ -65,3 +65,27 @@ usb_gadget_get_string (const struct usb_gadget_strings *table, int id, u8 *buf)
 	return buf [0];
 }
 EXPORT_SYMBOL_GPL(usb_gadget_get_string);
+
+/**
+ * usb_validate_langid - validate usb language identifiers
+ * @lang: usb language identifier
+ *
+ * Returns true for valid language identifier, otherwise false.
+ */
+bool usb_validate_langid(u16 langid)
+{
+	u16 primary_lang = langid & 0x3ff;	/* bit [9:0] */
+	u16 sub_lang = langid >> 10;		/* bit [15:10] */
+
+	switch (primary_lang) {
+	case 0:
+	case 0x62 ... 0xfe:
+	case 0x100 ... 0x3ff:
+		return false;
+	}
+	if (!sub_lang)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(usb_validate_langid);
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 124462d65eac..1a05227bdfae 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -773,6 +773,9 @@ struct usb_gadget_string_container {
 /* put descriptor for string with that id into buf (buflen >= 256) */
 int usb_gadget_get_string(const struct usb_gadget_strings *table, int id, u8 *buf);
 
+/* check if the given language identifier is valid */
+bool usb_validate_langid(u16 langid);
+
 /*-------------------------------------------------------------------------*/
 
 /* utility to simplify managing config descriptors */
-- 
2.17.1

