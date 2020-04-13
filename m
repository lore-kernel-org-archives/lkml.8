Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303CCC2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DEA420644
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCUthXOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389327AbgDMVxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389316AbgDMVxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:53:02 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3109CC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:53:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a81so11655719wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bBfsyF1VnA0cKxAcKLlCIJxhfaA+R7OwaF4oqvEAYA=;
        b=eCUthXOwxMffnOIqflw2IQSqLcsHKwp4Pltp5HYZXQ4zho5w5FHmZql3uCivXzUWdf
         oBpJaG+DaG5QxCpqzlIKoBrGqvFOd38Juny1eqUEN6816sou6WEyLteZufCt5z+TJ/AO
         X4poODJfVMql0zn/+nuOIhS4/9cafu0N75GCAEKMbCNa+675oIJOZM0eZCFBsmbWNL+S
         Ae26hqpsKq6AnhgfQ97ro+Z6DNUVgJu1LWSfHsBwrpUbDDw53GA/ITiNDU/6y2nqINfI
         NyJDlH7uhe9bue+bXHHmr13OOYm885KbeKn9zb5rYXFuPmHsvXDjwhxT2sz3xz5mHxpt
         4IPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bBfsyF1VnA0cKxAcKLlCIJxhfaA+R7OwaF4oqvEAYA=;
        b=NYD0UkAxU2GiiVGDiThZq3oRAAW3oKHtIbzGsBoZHjHq5R+5RgUcjf6SR445zemgpU
         DgnTkpdr7wiS7BGcRgf9DJlHIrj2EGo2Iqo4kT/f2av9T2vxkea1fTiOGdWjv3xwj5Gb
         4yVqo/hGtCiBS3rr4dDczAhlw4AwFRr537Upjk1ZC14BHjgqFHG/KWLivTuOOhiw1Mbq
         ZwqXiA0qqpH2Zu9SeQ0iWtQXUTtexVLvWYyRsAvv0irHpxTp6iIMtHAw9LLbrqCJYASi
         Y8QD5u/ZZ2oWPEOqQvpSI/XufQFsan58bh0X+bAqDC5DF8I3YpgbbqyMKQtShsRHK+7/
         SD1Q==
X-Gm-Message-State: AGi0PuYA8i+YONbrCB3XQFg2xGsYh6jorbMKJAUErdu1uLehkas21K+t
        sjAAm3JKoEpL/rlQOhRVzoY=
X-Google-Smtp-Source: APiQypIGXAB/N+85j0VAxukuJmGY9h8Tv8exBNIABHZmUjSCM7xKGKHtWcvx4oB58soriuP4rhj/aw==
X-Received: by 2002:a7b:cc06:: with SMTP id f6mr20303735wmh.65.1586814779881;
        Mon, 13 Apr 2020 14:52:59 -0700 (PDT)
Received: from localhost.localdomain (dslb-092-073-054-241.092.073.pools.vodafone-ip.de. [92.73.54.241])
        by smtp.gmail.com with ESMTPSA id q18sm9732790wmj.11.2020.04.13.14.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 14:52:59 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8712: correct spelling mistake in comment
Date:   Mon, 13 Apr 2020 23:51:09 +0200
Message-Id: <20200413215109.15749-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct a spelling mistake discovered by checkpatch.
attatch -> attach

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8712/usb_halinit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/usb_halinit.c b/drivers/staging/rtl8712/usb_halinit.c
index 6cc4a704c3a0..313c569748e9 100644
--- a/drivers/staging/rtl8712/usb_halinit.c
+++ b/drivers/staging/rtl8712/usb_halinit.c
@@ -58,7 +58,7 @@ u8 r8712_usb_hal_bus_init(struct _adapter *adapter)
 		r8712_write8(adapter, SYS_ISO_CTRL + 1, val8);
 		val8 = r8712_read8(adapter, SYS_ISO_CTRL + 1);
 		val8 = val8 & 0xEF;
-		/* attatch AFE PLL to MACTOP/BB/PCIe Digital */
+		/* attach AFE PLL to MACTOP/BB/PCIe Digital */
 		r8712_write8(adapter, SYS_ISO_CTRL + 1, val8);
 		val8 = r8712_read8(adapter, AFE_XTAL_CTRL + 1);
 		val8 = val8 & 0xFB;
-- 
2.26.0

