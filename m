Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1C7C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 15:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAAA02072E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 15:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=footclan-ninja.20150623.gappssmtp.com header.i=@footclan-ninja.20150623.gappssmtp.com header.b="mSaUCHoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgEBPFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 11:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgEBPFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 11:05:42 -0400
Received: from mail-ot1-x361.google.com (mail-ot1-x361.google.com [IPv6:2607:f8b0:4864:20::361])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E887BC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 08:05:40 -0700 (PDT)
Received: by mail-ot1-x361.google.com with SMTP id z17so5011992oto.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=footclan-ninja.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQORw5TEfimEXpNhMvXlHoOfqoU2wjV/uOY185Kq3UI=;
        b=mSaUCHoGYShDMb+Lf5CRxCzDzCJ+1zT+RtqmWGintrHCC4l8VxoUbiJhNkF0wz/3g1
         5wtd3TaFJNEUY/aq2+7Uh26oXxEHc67i5vnTQY8/BSZiBCFvLXH6jP+F5T5EzwJFxPEV
         aHEvqPsyltSRk5D9QZHpolAeCF+x4MqhlHHp8yFuWWfgzqOl62/Bu1pmmwLzF7sNPrIg
         VzpOIVobqS4E9CSFGcUOfThgdInTWUbSdJXUeQc8g1aLp5jIONinVceU0RH9hGTG9WZ3
         /PBOUaxLsruGed/zsYExgu4+wKhrBeNfMnl42LhBPNQODKJtgd2C8vlLvLA/tNEq5VxE
         mpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQORw5TEfimEXpNhMvXlHoOfqoU2wjV/uOY185Kq3UI=;
        b=ta/VeIBcVF1bi/8tYQftTl3UrihL0htQirOVxcEWksf7TqMQaUfHMAKP88MuXE8LgF
         U/4HhD4bh7G7lBvD8V6mPXtre5bWGeUkUhXbM9xRxEfZh0T/YmJ6YQm6b7Z7Nmmjk0wc
         7AUtumvEgH6/zYdVRrh/EOV3z28eFJ6GP87+xt+Kox5gcNDOnUXJh2M742wATKQ+i2Sl
         /9t/0P1cl96R0yseYGUsaLuuWI03P5vuMleqznb0vIhfMkosH9iYNWYxJu6phJbey0nk
         Eo5iLeyORu66WK8SYbZ+T4qTvq/lFE3XE369rtl51+DNNao7o4G5R8SgDAU0FD1/cdKh
         JsDA==
X-Gm-Message-State: AGi0PuZm4BDsMd40ttdvgHEr0WBZYEM3rezYohzDmqXcTk698En2Jcsa
        976gopA7WZr1J9FkArQrlep4QCQkmaAZey2sKFHObbJnQ8ShSg==
X-Google-Smtp-Source: APiQypImB47WNrzjBq8n0eBafDQwxnQVTWzVZCbQnY2dWgUYapbGZhsaNgKF0XU7ph4MzC6W100PR7r33Rnb
X-Received: by 2002:a05:6830:4db:: with SMTP id s27mr602241otd.301.1588431940365;
        Sat, 02 May 2020 08:05:40 -0700 (PDT)
Received: from localhost.localdomain (pa49-195-101-57.pa.nsw.optusnet.com.au. [49.195.101.57])
        by smtp-relay.gmail.com with ESMTPS id i6sm791456oos.16.2020.05.02.08.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 08:05:40 -0700 (PDT)
X-Relaying-Domain: footclan.ninja
From:   Matt Jolly <Kangie@footclan.ninja>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matt Jolly <Kangie@footclan.ninja>
Subject: [PATCH] USB: serial: qcserial: Add DW5816e support
Date:   Sun,  3 May 2020 01:03:47 +1000
Message-Id: <20200502150347.10186-1-Kangie@footclan.ninja>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Dell Wireless 5816e to drivers/usb/serial/qcserial.c

Signed-off-by: Matt Jolly <Kangie@footclan.ninja>
---
 drivers/usb/serial/qcserial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index 613f91add03d..ce0401d3137f 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -173,6 +173,7 @@ static const struct usb_device_id id_table[] = {
 	{DEVICE_SWI(0x413c, 0x81b3)},	/* Dell Wireless 5809e Gobi(TM) 4G LTE Mobile Broadband Card (rev3) */
 	{DEVICE_SWI(0x413c, 0x81b5)},	/* Dell Wireless 5811e QDL */
 	{DEVICE_SWI(0x413c, 0x81b6)},	/* Dell Wireless 5811e QDL */
+	{DEVICE_SWI(0x413c, 0x81cc)},	/* Dell Wireless 5816e */
 	{DEVICE_SWI(0x413c, 0x81cf)},   /* Dell Wireless 5819 */
 	{DEVICE_SWI(0x413c, 0x81d0)},   /* Dell Wireless 5819 */
 	{DEVICE_SWI(0x413c, 0x81d1)},   /* Dell Wireless 5818 */
-- 
2.26.2

