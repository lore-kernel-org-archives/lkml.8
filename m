Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C374CC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16222087D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wEtprO+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgHZJjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbgHZJe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:34:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE69C0617B1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:34:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k20so1065643wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7NPqtCpN+MJMO4A/dgMyA434mUf+bmEkPLCWrQ+c5YA=;
        b=wEtprO+kfdTRh0oBj+5B8Yy4ISBKhQwNoTK2RGOv3zTrbnF9ElfliFrU1265sy2Dlk
         X/Ql8tuDk3rwEZ/h46rhTJo/9PJUV7zVajAOJBku2X0uO34M80zXe45EDRxYuRqQleDC
         NAP9JiR0oSCosMNy+oDBMCmD/yLLjTIp8xiMSXLlVqiYG1K+qxxyGamKNF7mIOUuyrb5
         2VSYZ/iMRe2lF+4MMY6QZMN5DYTs+DH4vh/WXqjhBMVd/g37WzOUKzu3gn6NxpqqmLqK
         OxsVrOTqkJx4HfE7sGwpLwgjM/oHqbOrnto26nf/M69S3VNyhRFIPip5KiAAkOn5l5Qw
         D+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7NPqtCpN+MJMO4A/dgMyA434mUf+bmEkPLCWrQ+c5YA=;
        b=ZkgGR/M0rxX61iPnYvXbmqOIVh/INMxdKZ48ssriL3x7a+xmtbTMYVDhpKlMqC9OiX
         C1fi7HnY6LeLippUUJQn3gEOM6SVPYRB2PmLVRLDXiIILn1n9o7WK86v04S90ThD6MnT
         yIc8Z/vzFr/Glc+tqKu47fHvAx3+Yjko5xLFzPwR/6TuCFWBXUsuo5e427zsYL0OO/K1
         o2cZKEZR7dxCRrwBVJMOCU04SwYN7bjXBuhd+eJjJw3nBcPVgXpszv7TZToDw/Us9Y3d
         UEcsxHkPW6uvqJc8vRm29iTnM2EtzFQdlPfALekyyPj5X2hvylVHd96FtJKV1rf2oClz
         tSAA==
X-Gm-Message-State: AOAM530n9ADOQsiZMskJRQJ3O/h0sqLQIOcUGYJUHi/Lx3wjphano4OW
        3yRgozJ/UNgsgrHS/O9nU6oVmg==
X-Google-Smtp-Source: ABdhPJzqT0DyC5PnoSK/CEUmtrG0VP7Wqe/C2ORblcv2v2YKXnDCylYJ3YnwxTiMZT0M3+HT1whIRA==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184mr6449203wmf.26.1598434453548;
        Wed, 26 Aug 2020 02:34:13 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <greg@kroah.com>
Subject: [PATCH 07/30] wireless: intersil: orinoco_usb: Downgrade non-conforming kernel-doc headers
Date:   Wed, 26 Aug 2020 10:33:38 +0100
Message-Id: <20200826093401.1458456-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826093401.1458456-1-lee.jones@linaro.org>
References: <20200826093401.1458456-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intersil/orinoco/orinoco_usb.c:434: warning: Function parameter or member 'upriv' not described in 'ezusb_req_queue_run'
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c:716: warning: Function parameter or member 'req' not described in 'ezusb_fill_req'
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c:716: warning: Function parameter or member 'length' not described in 'ezusb_fill_req'
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c:716: warning: Function parameter or member 'rid' not described in 'ezusb_fill_req'
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c:716: warning: Function parameter or member 'data' not described in 'ezusb_fill_req'
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c:716: warning: Function parameter or member 'frame_type' not described in 'ezusb_fill_req'
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c:716: warning: Function parameter or member 'reply_count' not described in 'ezusb_fill_req'

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c b/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
index 11fa38fedd870..645856bc1796c 100644
--- a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
+++ b/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
@@ -423,13 +423,13 @@ static void ezusb_ctx_complete(struct request_context *ctx)
 	}
 }
 
-/**
+/*
  * ezusb_req_queue_run:
  * Description:
  *	Note: Only one active CTX at any one time, because there's no
  *	other (reliable) way to match the response URB to the correct
  *	CTX.
- **/
+ */
 static void ezusb_req_queue_run(struct ezusb_priv *upriv)
 {
 	unsigned long flags;
@@ -704,7 +704,7 @@ static inline u16 build_crc(struct ezusb_packet *data)
 	return crc;
 }
 
-/**
+/*
  * ezusb_fill_req:
  *
  * if data == NULL and length > 0 the data is assumed to be already in
-- 
2.25.1

