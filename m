Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF15C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 23:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A410520715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 23:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0yWasi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgBJW77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:59:59 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39600 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgBJW77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 17:59:59 -0500
Received: by mail-oi1-f193.google.com with SMTP id z2so10935846oih.6;
        Mon, 10 Feb 2020 14:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h2g0oTCV98K2k6Xzoh29zE55ImVHkBdtE4+mSxUulQQ=;
        b=P0yWasi5AD3Wkz/vo7yXo6yPuziD6iH6KVE8Q4bimB6WtQzDEGVCzAezGZWb5k1W/w
         Z3VnF48KO1MFvUq/PYlKG96U0XCWBkZi4BEoZOfhJRetQloceUj4EboyQMfGIfdiWwMQ
         5frXSdglP2M9xnE8DbEyl5GOqlKRymcz8n0OOw5y/drqhSgXwypJcoE7C6KVLYBhhUma
         YhK//vHGZi4wWwJJO5iplJ8thpu4ffDHGFEt4IaJY+HDlOiSMPxLpW1vGmhH/t5mGWmP
         7Z9PGLdLzUOHoG+WVQ6mZVShDxTkw+cAbUsA7kYE2YV/Yni7Hfb3flIETXftd93ndXRq
         JGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h2g0oTCV98K2k6Xzoh29zE55ImVHkBdtE4+mSxUulQQ=;
        b=e9iWkoPSgtNgdxbDdk5p4GWROUq/HjF24j9eh0oqFF2XhCUHeWrPHrtyDAh1YeyUOI
         aZ40nQ1JgBpnOewmFdVNb+Mf1C2tfHQgmb//qaX+PwDJtvd7W9cuVOhtO/Nimg4gdCD8
         lLhQGg0so8lp6nO5VwI45TYy2K1hAZuLlO5V8p2ZdMkWaRY+juGvvUU4wDbz/vV0UZf7
         j2TqXZFNJs/7E4nK5nmbaDCe7NQ4ROTPtOyDJnVRjRUtov6rr5QNnP5xycUEAYqYRbd3
         x8ERyb72T3AmYClvBLgJIU0Knjwi8PDHWy165CjrwyNoUufAGAo4iEekNDoJMXQjlble
         DXHQ==
X-Gm-Message-State: APjAAAVb/iNquQtEUQfFFEdAMDpvou441Dp4zKzrTpnR4B6NfplXVf87
        HttG/fnEmKQa4GVvENCzsBE=
X-Google-Smtp-Source: APXvYqwDbrcIeb7Xbibh7qCosUJ25r6zAICrriHVO5CceM7+UyW/5dwZqBATLkJk71AmXk2eQKqTWQ==
X-Received: by 2002:aca:458:: with SMTP id 85mr1030996oie.56.1581375598184;
        Mon, 10 Feb 2020 14:59:58 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id r17sm546985otq.70.2020.02.10.14.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 14:59:57 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] usb: dwc3: meson-g12a: Don't use ret uninitialized in dwc3_meson_g12a_otg_init
Date:   Mon, 10 Feb 2020 15:58:17 -0700
Message-Id: <20200210225816.36598-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

../drivers/usb/dwc3/dwc3-meson-g12a.c:421:6: warning: variable 'ret' is
used uninitialized whenever 'if' condition is false
[-Wsometimes-uninitialized]
        if (priv->otg_mode == USB_DR_MODE_OTG) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/usb/dwc3/dwc3-meson-g12a.c:455:9: note: uninitialized use
occurs here
        return ret;
               ^~~
../drivers/usb/dwc3/dwc3-meson-g12a.c:421:2: note: remove the 'if' if
its condition is always true
        if (priv->otg_mode == USB_DR_MODE_OTG) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/usb/dwc3/dwc3-meson-g12a.c:415:9: note: initialize the
variable 'ret' to silence this warning
        int ret, irq;
               ^
                = 0
1 warning generated.

It is not wrong, ret is only used when that if statement is true. Just
directly return 0 at the end to avoid this.

Fixes: 729149c53f04 ("usb: dwc3: Add Amlogic A1 DWC3 glue")
Reported-by: kbuild test robot <lkp@intel.com>
Link: https://groups.google.com/d/msg/clang-built-linux/w5iBENco_m4/PPuXreAxBQAJ
Link: https://github.com/ClangBuiltLinux/linux/issues/869
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Note: This patch is against Felipe's testing/next branch.

 drivers/usb/dwc3/dwc3-meson-g12a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 70d24b98fcad..902553f39889 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -452,7 +452,7 @@ static int dwc3_meson_g12a_otg_init(struct platform_device *pdev,
 	if (IS_ERR(priv->role_switch))
 		dev_warn(dev, "Unable to register Role Switch\n");
 
-	return ret;
+	return 0;
 }
 
 static int dwc3_meson_g12a_probe(struct platform_device *pdev)
-- 
2.25.0

