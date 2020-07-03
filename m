Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9FFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3194C2084C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DiTMT+9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgGCRmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgGCRl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:41:59 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087EAC061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:41:59 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 22so32760517wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YSysemk6/m3rdKU2ySMi9uU8qYuK0kuhW6Pw5qHpSnI=;
        b=DiTMT+9THBotFZ8hAPsnuIbDSlmH+WPn87U6MQV2wdUqBmGs3uF0tKCXEfU7478vwj
         hwRiHYDh4JpRpasNgymyRlZRKZYPomrYM9TJPmqWfJcxMLGduvnehwmmmjtysVHuv640
         iQFbD58SHTQRqL/gBV171cuR8/WTeYhTRVk7h0EI46cXLbxvMZRbUIA5L7SH2rCkEbw6
         NET+ildSzhaQAlJxNoSvdavC9aTyR7AzdS74FkZ+BefFZx0zPt+xwBXdSFYStsHg0rDd
         ky0+csRp4oiOhk+Bjw68pqKMRSCnHLd+2J+YF8NR5NMSJyMbowwOIgMWQhjToihJ5crY
         Azhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YSysemk6/m3rdKU2ySMi9uU8qYuK0kuhW6Pw5qHpSnI=;
        b=DA3DsatFt/JgjBYs57miVS6NMxDEz8Xd2NrPMkvaSDKjX8/bMeEYC1cy0R2dgistxv
         lEOSdgXiF6muENGpeZ8nTAQ8z4Ex1uTfIERno8v9kLK/tzJEWlcYjv4UZTUaVCjkcunK
         e4HxZkJSdqnyiJOc7lwlpgbto4rLvxYJHGZ1IwhD/BynlcWJvjiMne8vcjNex0vwctUt
         HnkbRNnP5rarDqWVSj/FxGqlXquyjxfBq+MmxZYyo5WdKPhTwZLG0uJwUR2xOfF2xhWy
         2cSTcSUiJD3CzjBGOU25lavvv0xnDJ/fwma+4kQKj2oGQYzihvwwz9vea9O0+hfUo9bR
         Ih0g==
X-Gm-Message-State: AOAM532+j9A9VtuaeXEJh3j+mjnkm/Ug8TQyoIeRBSKW/quoM+RtZFi2
        9kQOwME2bpC9UnZlM6L6RFrCR2sOUTM=
X-Google-Smtp-Source: ABdhPJwq6EJ8i4c07CyyjVONmZU0HR1br30HC+HrU3hY5Q/iNyS39dh2n8CRaJSQcQXq5fDuEcoNRg==
X-Received: by 2002:a1c:9a02:: with SMTP id c2mr8726718wme.16.1593798117749;
        Fri, 03 Jul 2020 10:41:57 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x11sm13625799wmc.26.2020.07.03.10.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:41:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 01/30] usb: mtu3: mtu3_debug: Add forward declaration of 'struct ssusb_mtk'
Date:   Fri,  3 Jul 2020 18:41:19 +0100
Message-Id: <20200703174148.2749969-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703174148.2749969-1-lee.jones@linaro.org>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without it, the build system complains that it was declared inside
the parameter list.

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/usb/mtu3/mtu3_trace.c:11:
 drivers/usb/mtu3/mtu3_debug.h:29:36: warning: ‘struct ssusb_mtk’ declared inside parameter list will not be visible outside of this definition or declaration
 29 | void ssusb_dev_debugfs_init(struct ssusb_mtk *ssusb);
 | ^~~~~~~~~
 drivers/usb/mtu3/mtu3_debug.h:30:35: warning: ‘struct ssusb_mtk’ declared inside parameter list will not be visible outside of this definition or declaration
 30 | void ssusb_dr_debugfs_init(struct ssusb_mtk *ssusb);
 | ^~~~~~~~~
 drivers/usb/mtu3/mtu3_debug.h:31:39: warning: ‘struct ssusb_mtk’ declared inside parameter list will not be visible outside of this definition or declaration
 31 | void ssusb_debugfs_create_root(struct ssusb_mtk *ssusb);
 | ^~~~~~~~~
 drivers/usb/mtu3/mtu3_debug.h:32:39: warning: ‘struct ssusb_mtk’ declared inside parameter list will not be visible outside of this definition or declaration
 32 | void ssusb_debugfs_remove_root(struct ssusb_mtk *ssusb);
 | ^~~~~~~~~

Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/mtu3/mtu3_debug.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_debug.h b/drivers/usb/mtu3/mtu3_debug.h
index fb6b28277c9b1..3084c46017c37 100644
--- a/drivers/usb/mtu3/mtu3_debug.h
+++ b/drivers/usb/mtu3/mtu3_debug.h
@@ -12,6 +12,8 @@
 
 #include <linux/debugfs.h>
 
+struct ssusb_mtk;
+
 #define MTU3_DEBUGFS_NAME_LEN 32
 
 struct mtu3_regset {
-- 
2.25.1

