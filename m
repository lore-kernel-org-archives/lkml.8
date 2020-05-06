Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F5EC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D9EB20721
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y+IKNsl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgEFHXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 03:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728305AbgEFHXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 03:23:32 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30528C061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 00:23:32 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t11so720749pgg.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 00:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aQOpZ08qLj1/ws1BeuDL5FKnb33GCGBWrIdukaDVssI=;
        b=Y+IKNsl0zaKl6T/eoOWDWi18zCQ6C3a+bc7CguIqZo7EmC7n5eDuOiWj83oV4Ayysa
         Iv0SAXAD7rse220viYgokExwuabBT7UIJaqKuswFKAQYOA4k9LX+QkVEGII8LcU8IzBY
         cw1A2cGEAg4QRTrHg9JAcBgvZA27GF1BNNVbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aQOpZ08qLj1/ws1BeuDL5FKnb33GCGBWrIdukaDVssI=;
        b=c9KN20A0EuEXSNLs+Uk7twea7jA7dNqhcL2kHEQKU3/meklyTT3z+I+0LDCUd1nDhX
         AM9Hm+waw5Ys6NIuVp8F4YzqoPVdu+ME3VZqd8WE9p7kiH2vHLa9jefl5qx+xbZjcWqp
         jc7nWSD1cEL56ctV1xS6GSngCSAngZj2J5gtjp6HTNZh1ty++v09diKWlS+ZTOxtJ3/9
         H2JdHnvwZHFEnGfUjXsRmzDGDRmf3C69ftFIgE3UCKCFCUU4lUGmdBtgo4Iviyut22Qr
         oA0heDXP+tUPnPDKUt67f7bTT007UyWiX70wennArOgqKsRU5evz0RJ3hh8ebUCbcx9P
         jZjA==
X-Gm-Message-State: AGi0PuZ5JkoOmV8zVJuQcEpkETOEhjQUJXC87bkDUlvQs/QXjfaJIBbR
        KyReeaUoHueceX373LyUkR0u6wO6BQg=
X-Google-Smtp-Source: APiQypKp+kAdMOwuDuCkVL8EkOYlP3gxs7r+jwCCLD+BaNDjnZq+XsrKIH4ywpA+y6qjYg32QYzYww==
X-Received: by 2002:a62:a106:: with SMTP id b6mr6546509pff.23.1588749811749;
        Wed, 06 May 2020 00:23:31 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3db2:76bf:938b:be05])
        by smtp.gmail.com with ESMTPSA id k6sm3862622pju.44.2020.05.06.00.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 00:23:31 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     robh@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        long.cheng@mediatek.com, changqi.hu@mediatek.com
Cc:     linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, Claire Chang <tientzu@chromium.org>
Subject: [PATCH 1/3] serdev: ttyport: add devt for tty port
Date:   Wed,  6 May 2020 15:23:12 +0800
Message-Id: <20200506072314.112409-2-tientzu@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200506072314.112409-1-tientzu@chromium.org>
References: <20200506072314.112409-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

serial_match_port() uses devt to match devices. However, when serdev
registers a tty port, devt has never been set. This makes
device_find_child() always return NULL.

Assign devt in serdev_tty_port_register() to fix this.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/tty/serdev/serdev-ttyport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index d367803e2044f..9238119173a47 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -267,6 +267,7 @@ struct device *serdev_tty_port_register(struct tty_port *port,
 {
 	struct serdev_controller *ctrl;
 	struct serport *serport;
+	dev_t devt = MKDEV(drv->major, drv->minor_start) + idx;
 	int ret;
 
 	if (!port || !drv || !parent)
@@ -282,6 +283,7 @@ struct device *serdev_tty_port_register(struct tty_port *port,
 	serport->tty_drv = drv;
 
 	ctrl->ops = &ctrl_ops;
+	ctrl->dev.devt = devt;
 
 	port->client_ops = &client_ops;
 	port->client_data = ctrl;
-- 
2.26.2.526.g744177e7f7-goog

