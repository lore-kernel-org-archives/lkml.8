Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2AAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C802074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9uv7DrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgFJWrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgFJWrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 18:47:25 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B38C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 15:47:24 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d7so2395895lfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 15:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VksGgFKIEXZczaCwsl1pQL0VbmA1hM56Tr8nj1ZMGGU=;
        b=t9uv7DrPWCUJPa/OykTy48St4eA8F2epkL3QWc+I70w5t2T0E/5LQ0ZGOk48gWg96m
         Cnp9UnM57CPlzpK5SmIiud8mSNj1veBmSZTWqWWkHdR0bbGxRa0s2ADdrPaWTf1pp3F3
         7Bprxx3kpGlAimgdtgmNr12D0nT6C39ZQ7wb0y/7eaPzb6VhdcmMLMVAoowBSy/E5XaU
         b9ZbM5QRv0fvzbV4LlxS+H+u2fE9+Cd+8DDFb5+g7Clb8aPECm/GREhdTk10qLEc6gDy
         Cayic5XOugw2E0A11QXc39ppOMGVGikRJy75sk+lObyHipE8krRxuyhJx+NmHTsNOP2+
         p2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VksGgFKIEXZczaCwsl1pQL0VbmA1hM56Tr8nj1ZMGGU=;
        b=eabuE12x3mSPhuhmNBwQPnLNnfrQdeqLIQiQLsKvnj6cGLnROxp+DiTz2yAkpbvYwg
         YcGc1ppQesEI3LCMAZOYIgH0hfpP5/3KgNgWb5N9o9mtlaLLT9hNlHhB7AKpxBmS3+JG
         B9fWwbNuaSQNgoxkd6F8fKBrJMvR/8rkNeBSZJ5JKSz7GipVLL7mRmSG47P89CFUwMOD
         fRf7S2AfxKpRhy1ptBwn3je4Q/GwvtNCmcI6c1I37OfOt6aWIfLutDU6YbOsHls6gfwN
         CakFvCE+hCraM+Cyk5ZZs1OcGYDejzHDaRUNdMVvgMJskd+CXiquh5FEbwYSp4M8Kev6
         LBUA==
X-Gm-Message-State: AOAM531ZWfiteGnYjLGCf4Z3mHjypyynHcaLRVmJiLP/NcD7HS7/mzkE
        HJeniE0I5PTFwaBHKDjKxHygrZekQwI=
X-Google-Smtp-Source: ABdhPJyHur2PUyzabi3GZeZIdQjXgA/kBPkxaQyw9Z4FIgiMWF/ZiHVVPW+1BKTJ0qQTsU0z3u20og==
X-Received: by 2002:ac2:54a8:: with SMTP id w8mr2756221lfk.53.1591829242217;
        Wed, 10 Jun 2020 15:47:22 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-136.NA.cust.bahnhof.se. [82.196.111.136])
        by smtp.gmail.com with ESMTPSA id s17sm262506ljd.51.2020.06.10.15.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 15:47:21 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 1/4] misc: rtsx_usb: Constify struct usb_device_id
Date:   Thu, 11 Jun 2020 00:47:01 +0200
Message-Id: <20200610224704.27082-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200610224704.27082-1-rikard.falkeborn@gmail.com>
References: <20200610224704.27082-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtsx_usb_usb_ids is never modified and can therefore be made const to
allow the compiler to put it in read-only memory.

Before:
   text    data     bss     dec     hex filename
  21513    4160     128   25801    64c9 drivers/misc/cardreader/rtsx_usb.o

After:
   text    data     bss     dec     hex filename
  21673    4000     128   25801    64c9 drivers/misc/cardreader/rtsx_usb.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/misc/cardreader/rtsx_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index a328cab11014..59eda55d92a3 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -759,7 +759,7 @@ static int rtsx_usb_post_reset(struct usb_interface *intf)
 	return 0;
 }
 
-static struct usb_device_id rtsx_usb_usb_ids[] = {
+static const struct usb_device_id rtsx_usb_usb_ids[] = {
 	{ USB_DEVICE(0x0BDA, 0x0129) },
 	{ USB_DEVICE(0x0BDA, 0x0139) },
 	{ USB_DEVICE(0x0BDA, 0x0140) },
-- 
2.27.0

