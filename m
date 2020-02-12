Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05ECC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805C9206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dl9lpSma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgBLOWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:22:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40879 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgBLOWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:22:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so2684697wmi.5;
        Wed, 12 Feb 2020 06:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f3OlCupjVSpjjJAyiqIlXphKxGd2QdpKN8ivxs447PI=;
        b=Dl9lpSmatwVOC21E0mjSSB6JBbvrgHOhnt9TJQKurWmEXoJD/j6RCoaQpD0XXLBNPG
         s/aR2DqI/iJJmcA1mm2lC98j11nV1A63keqbKOERz/00nvFAHQYaKJm9roD/8w9OJbCh
         stipo5s68ycgLPwKYp9FQin8Uec53elM3Dq3OcJnI4HkI8WvpQW86fAW9gaKiYNMzXkH
         8jjXjyW/MgKwM8JNe0VwCHunEB7ULx+BmCZlC/J0fyrLci4PdE2Ztq1tDR+GyVl3PrMy
         DCMBtn/WzSW9wRb8xrb8O4WXsXeh71t2AFZ2apstctwXCbZdky6khu44kw7S6QM+Gt1g
         CiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f3OlCupjVSpjjJAyiqIlXphKxGd2QdpKN8ivxs447PI=;
        b=XeBX/zISSg5hwOwxkvyp0BcoKw2o7TNb2Kswd21U1P6GYlJS2rmwyaObGPerV6eOMy
         P0LYGK+D5n/8gIKacqS5Loj4NetNZp/UlBdvls3P1uWRyOmyVU59ZZIdqfLQ05sD3Tqm
         /WuoOr8j+76lHCanvEaaXwGidNkYfRowrBv3egSZ6uJ22lPJ4vbQLc73UHSLpuwaFR6I
         qwztTzOK1jNYbmknevhJf7+vixIlAMiN3qTqH5CzFFY4xI0k421frhuB5TtghP3NFPzm
         nfUOBTbkZmiHrXPs+sIgZaUMoqBxZlV4sjXk9Kjxg7ZP1gnYHqbKH5vlcX7aY1ze8gSm
         9zQQ==
X-Gm-Message-State: APjAAAWU6DrNVtxW11Fs2sTEQlgPpowZwtYr+fioUL5H+mt9UUhjmWVo
        rfrtaNqw63I4iWcG21AI7vFkpRS5k9w=
X-Google-Smtp-Source: APXvYqzrf6YE5hkFqUnWc+nBttuk6honbPrzWg+QT57DKimAG4x961PYYPZNWxLWLqxj0+Q5N9SB4Q==
X-Received: by 2002:a1c:a78b:: with SMTP id q133mr12733112wme.28.1581517355791;
        Wed, 12 Feb 2020 06:22:35 -0800 (PST)
Received: from rdodd-desktop.home (host5-81-121-228.range5-81.btcentralplus.com. [5.81.121.228])
        by smtp.gmail.com with ESMTPSA id g7sm851625wrq.21.2020.02.12.06.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 06:22:34 -0800 (PST)
From:   richard.o.dodd@gmail.com
Cc:     gregkh@linuxfoundation.org, oneukum@suse.com,
        linux-usb@vger.kernel.org, Richard Dodd <richard.o.dodd@gmail.com>,
        Marco Zatta <marco@zatta.me>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] USB: Fix novation SourceControl XL after suspend
Date:   Wed, 12 Feb 2020 14:22:18 +0000
Message-Id: <20200212142220.36892-1-richard.o.dodd@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200131214036.GA2280058@kroah.com>
References: <20200131214036.GA2280058@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Dodd <richard.o.dodd@gmail.com>

Currently, the SourceControl will stay in power-down mode after resuming
from suspend. This patch resets the device after suspend to power it up.

Signed-off-by: Richard Dodd <richard.o.dodd@gmail.com>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 6b6413073584..3db6c05aaa4b 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -445,6 +445,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* INTEL VALUE SSD */
 	{ USB_DEVICE(0x8086, 0xf1a5), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* novation SoundControl XL */
+	{ USB_DEVICE(0x1235, 0x0061), .driver_info = USB_QUIRK_RESET_RESUME },
+
 	{ }  /* terminating entry must be last */
 };
 
-- 
2.25.0

