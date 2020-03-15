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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE13DC5ACC2
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 19:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A151120722
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 19:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRcNDYRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgCOTQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 15:16:49 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40343 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbgCOTQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 15:16:46 -0400
Received: by mail-pj1-f66.google.com with SMTP id bo3so5862960pjb.5;
        Sun, 15 Mar 2020 12:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eovzZ3kqQ8LWP7qRD6GFAmQY5h+MQlshBlGVHRZ0WS4=;
        b=RRcNDYRssy/5F/i6fSsXIrzZIurGe7f0t/4Mw66MPPKQffthBAgpxwOksDd9+dfgaQ
         he1hqnwJw8pX6Ae2IXDZ5BqhMoAP75d2X6iQ7XcyCaaxX69+gWFGmBOB0iZeLA0UVMrw
         hiFXCEsTh5j3aQv5+oe4hbvVchgdBGB3bKSFAQN5Da5ytD5w3yciM18yjVivsQfnPRUd
         5Jlu8e4+48mHQUELnWlqVAVetxjKJ1J4pDHPgZQVE9XnBtKeAZ5lQjNlgMBAEFQaNZlM
         Dh5dvjE7eY+FJm9nhWYEe8pkYfHmvZB9mR2zl3De3Tn72c0ffbcD0+cI/o/MG8MxMe8c
         djdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eovzZ3kqQ8LWP7qRD6GFAmQY5h+MQlshBlGVHRZ0WS4=;
        b=Xcf237LBEtzWUpz2EzmsK4CyksZoiGYXrKmSI7tJP2pFfnq+PPn4TeXzhX/f9TiRcM
         +/WW+jWPry9dQKkio9yvcL0aEpDJmwQyemf+oWzUM/WgoCSnIVHEV1gqeZOtI8+nSAEO
         s8YS3MVh0VGb/odD909ZFsilhrj78Ebe2TOf8e4Pm6bKvMnXF92e+WvExFccaTeIkKGp
         BdXADx1PM+8yvfVbAoZkLX1q0I0XgcuEZgCrX0fwUwKRFSt+8v7roK/+JmQyaF2Sb2ql
         +UbYJ2Aa6Olqi7s6oH5DQYVYHzG7B9UPY018E/VaQKLIPhp0YKZHjGmZ8RRUEsHY89hr
         u/cQ==
X-Gm-Message-State: ANhLgQ0eQQW9hGd9egvUW/vxWim7lzNTkoe9OkPR81L0Qa+o9Ev22dZj
        AiUcfKhb1CzWFWqMCtGHiyA=
X-Google-Smtp-Source: ADFU+vtGG84O3T3lRIFGnx5viv8DsI8lcGdsQ6bREhmqtjVIuQIaYeJAZgzlqOUyH0BhSNIlodiyAQ==
X-Received: by 2002:a17:902:7c02:: with SMTP id x2mr5325875pll.30.1584299804620;
        Sun, 15 Mar 2020 12:16:44 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-24-4-25-55.hsd1.ca.comcast.net. [24.4.25.55])
        by smtp.gmail.com with ESMTPSA id 13sm61431882pgo.13.2020.03.15.12.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 12:16:44 -0700 (PDT)
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
Subject: [PATCH v2 3/6] usb: gadget: aspeed: allow to set usb strings in device tree
Date:   Sun, 15 Mar 2020 12:16:29 -0700
Message-Id: <20200315191632.12536-4-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200315191632.12536-1-rentao.bupt@gmail.com>
References: <20200315191632.12536-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

If "vhub,string-descriptor" device tree property is defined, the driver
will load string descriptors from device tree; otherwise, the default
string descriptors will be used.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 No change in v2:
   - the patch is added into the series since v2.

 drivers/usb/gadget/udc/aspeed-vhub/hub.c | 58 +++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index 35edf37553f0..421631d86a17 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -941,9 +941,61 @@ static int ast_vhub_str_alloc_add(struct ast_vhub *vhub,
 	return 0;
 }
 
+static const struct {
+	const char *name;
+	u8 id;
+} str_id_map[] = {
+	{"manufacturer",	AST_VHUB_STR_MANUF},
+	{"product",		AST_VHUB_STR_PRODUCT},
+	{"serial-number",	AST_VHUB_STR_SERIAL},
+	{},
+};
+
+static int ast_vhub_of_parse_str_desc(struct ast_vhub *vhub,
+				      const struct device_node *desc_np)
+{
+	u32 langid;
+	int ret = 0;
+	int i, offset;
+	const char *str;
+	struct device_node *child;
+	struct usb_string str_array[AST_VHUB_STR_INDEX_MAX];
+	struct usb_gadget_strings lang_str = {
+		.strings = (struct usb_string *)str_array,
+	};
+
+	for_each_child_of_node(desc_np, child) {
+		if (of_property_read_u32(child, "reg", &langid))
+			continue; /* no language identifier specified */
+
+		if (!usb_validate_langid(langid))
+			continue; /* invalid language identifier */
+
+		lang_str.language = langid;
+		for (i = offset = 0; str_id_map[i].name; i++) {
+			str = of_get_property(child, str_id_map[i].name, NULL);
+			if (str) {
+				str_array[offset].s = str;
+				str_array[offset].id = str_id_map[i].id;
+				offset++;
+			}
+		}
+		str_array[offset].id = 0;
+		str_array[offset].s = NULL;
+
+		ret = ast_vhub_str_alloc_add(vhub, &lang_str);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 static int ast_vhub_init_desc(struct ast_vhub *vhub)
 {
 	int ret;
+	struct device_node *desc_np;
+	const struct device_node *vhub_np = vhub->pdev->dev.of_node;
 
 	/* Initialize vhub Device Descriptor. */
 	memcpy(&vhub->vhub_dev_desc, &ast_vhub_dev_desc,
@@ -960,7 +1012,11 @@ static int ast_vhub_init_desc(struct ast_vhub *vhub)
 
 	/* Initialize vhub String Descriptors. */
 	INIT_LIST_HEAD(&vhub->vhub_str_desc);
-	ret = ast_vhub_str_alloc_add(vhub, &ast_vhub_strings);
+	desc_np = of_get_child_by_name(vhub_np, "vhub-strings");
+	if (desc_np)
+		ret = ast_vhub_of_parse_str_desc(vhub, desc_np);
+	else
+		ret = ast_vhub_str_alloc_add(vhub, &ast_vhub_strings);
 
 	return ret;
 }
-- 
2.17.1

