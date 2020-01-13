Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF2DC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31975206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578936150;
	bh=9WHbh29wBhdUptqcUQAudp/k0/ZH8JBbCqlAlqjeNMg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=UkqtH2sGyt31vXC9Bs3SNMHVnsIjSbXZjq6XX1MvMN9xHsAAIJ+5SkNwFEGP/uSlK
	 8pvHbSm0kfH4lJNuM5nyZniAl8b3YMmKW2VTqBluujKulAqlOtFlKjdHPSmQoruPMk
	 hlPCFH7gC97uve7tILLm9sDSl9jg3nA0lUg4hN9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgAMRW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 12:22:29 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41056 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgAMRW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 12:22:29 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so7447583lfp.8;
        Mon, 13 Jan 2020 09:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5zVt0sRFRdUX8z6vKZQ0/vfkRSe85i7P2h2dcN4rYpE=;
        b=EV4aS1Q8dRF0j7DibbCEL0gw9HNtAKvE9WFZ4nsPOmMJsUqWMnZ6BEicjUP/ImW451
         N++8Cxq/mg7x8hCZVCeDsYobpxCXTp3mHFPl7lX2O9uPAdJ3/OzdXtECn3M9I/S+8Awl
         05TTFfvarChOgP4KGaArnnZEZxs71glH58hTHvUu5FSbo8Hp96Q5ObzmY3582MU6sfX5
         H5GzoxHpQJ3+24c2gccnD/czMNDCivYp8UbiKPibBCZ8WwyiTbnFXSixgro4cdatIyjt
         3j9vJhalGd2nU/+pnxp8382FXRv2xH/C2SGIv2Qxh7eaGdCzkZd8lFEHsprBoyhQSmo/
         20gg==
X-Gm-Message-State: APjAAAX1zaTmaf0qfcG3zGA+ziDvdVK/I3PeeXmvKIMc81vXE2wYDP4e
        1x9F48zoiE6r2JpFngMsgpQ=
X-Google-Smtp-Source: APXvYqzk5Ev0WmtdV66O19LVc+hQg/udQ4dagQdxMNaWaUXOHFci9mTchJqUzGcwZylCMVN8e4BjnA==
X-Received: by 2002:a19:cc49:: with SMTP id c70mr10453747lfg.73.1578936146650;
        Mon, 13 Jan 2020 09:22:26 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id n1sm5936296lfq.16.2020.01.13.09.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 09:22:26 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1ir3Q2-00082e-3j; Mon, 13 Jan 2020 18:22:26 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>,
        Martin Jansen <martin.jansen@opticon.com>
Subject: [PATCH] USB: serial: opticon: fix control-message timeouts
Date:   Mon, 13 Jan 2020 18:22:13 +0100
Message-Id: <20200113172213.30869-1-johan@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was issuing synchronous uninterruptible control requests
without using a timeout. This could lead to the driver hanging
on open() or tiocmset() due to a malfunctioning (or malicious) device
until the device is physically disconnected.

The USB upper limit of five seconds per request should be more than
enough.

Fixes: 309a057932ab ("USB: opticon: add rts and cts support")
Cc: stable <stable@vger.kernel.org>     # 2.6.39
Cc: Martin Jansen <martin.jansen@opticon.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

This was reported to me off-list to be an issue with some opticon
devices. Let's address the obvious bug while waiting for a bug report
to be sent to the list.

Johan


 drivers/usb/serial/opticon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/opticon.c b/drivers/usb/serial/opticon.c
index cb7aac9cd9e7..ed2b4e6dca38 100644
--- a/drivers/usb/serial/opticon.c
+++ b/drivers/usb/serial/opticon.c
@@ -113,7 +113,7 @@ static int send_control_msg(struct usb_serial_port *port, u8 requesttype,
 	retval = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
 				requesttype,
 				USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
-				0, 0, buffer, 1, 0);
+				0, 0, buffer, 1, USB_CTRL_SET_TIMEOUT);
 	kfree(buffer);
 
 	if (retval < 0)
-- 
2.24.1

