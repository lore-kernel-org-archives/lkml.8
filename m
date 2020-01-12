Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9052C32771
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 13:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF6021556
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 13:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJtyigPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732888AbgALNIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 08:08:20 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44696 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732692AbgALNIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 08:08:19 -0500
Received: by mail-qk1-f193.google.com with SMTP id w127so6198589qkb.11;
        Sun, 12 Jan 2020 05:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CVIIqXyHzDbdN22XmAnBH1b4dJjW09R/BAehXl5oxdg=;
        b=tJtyigPR9V5FfCtMMuuwuyZEQm9bnzwJ1gmALthebBV2640gw/02BvhqqdjzmORJtA
         JY0JrhIsDLG1p095AMK4PuXdb7CArZLROGMH5tx0pwJWRaTjCVEjK70dbHz1vCinSD6S
         VSNUF8zKUmrXNspU1jdFjoA7xDD3bkpc1aGXYCE6v+PHQDSDZaOF0pmJ1MXxh9E9qbVh
         CdBqcF5cqWC6a0cXluLVcyAani8Z3jv4Uwbmw0kR5Rdn/bhxHTG+7D5Rpf7MNVT1zZ+Q
         z0jrT+412vulnJTUvRrMLtB9QJtKwMjOLpw62btGfDAwZohj5N4LBKWl8/rLIyh9CPEw
         Qhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CVIIqXyHzDbdN22XmAnBH1b4dJjW09R/BAehXl5oxdg=;
        b=BP6aq8zilJXlZiI4f9BfWtjo1IgVo4YKspT1/LUit21jG17GNfBnsWNXhKaV3sUEAB
         zsVC6fuFdhtPQ6U89vLa4mrQau5OmgbUq+f1QYLG3jByNyZDRd1m9vhJAs5sElG2FFxk
         RX+dysDM/1Jb8QFmScyb95lTPlESx6aSORmPajIkgJLsPHFPXzuPREDEGbMwAuziGuB5
         NqHu92c3AKkQnB899Up4MSwmJ0iVHXLWcTrEoVl9+IHfTqrmoPly1Wax5c0yp20j39xy
         pqsn9dLtHH2auynQliVtzvWrJtilujDizbXd/ZeYaPCH580o1KeWQgUBMtnpqnf8inA2
         OAxg==
X-Gm-Message-State: APjAAAX4NgXnWSBHqvkE90kOr1Tyk9/bv+gN0O87ejZFN3zOAGr3WQOb
        4pZ+hg+U1VxCPZ51BndiXaU=
X-Google-Smtp-Source: APXvYqw8nC4byAvgpfkdgD4CIi+KnFtAkrjPcHHHSGlDGZF3b8ftUq0Oh1fGiD41cHlaatclK1xNZw==
X-Received: by 2002:ae9:f502:: with SMTP id o2mr6868598qkg.89.1578834498844;
        Sun, 12 Jan 2020 05:08:18 -0800 (PST)
Received: from theprophet.pesuec.pes.edu (111.ip-149-56-108.net. [149.56.108.111])
        by smtp.gmail.com with ESMTPSA id x8sm3577450qki.60.2020.01.12.05.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 05:08:18 -0800 (PST)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] uvcvideo: On load display message
Date:   Sun, 12 Jan 2020 18:38:02 +0530
Message-Id: <20200112130802.2874-1-naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/media/usb/uvc/uvc_driver.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 428235ca2635..e0797f62e100 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2098,6 +2098,9 @@ static int uvc_probe(struct usb_interface *intf,
 	int function;
 	int ret;
 
+	pr_info("I changed uncvideo driver in the Linux Kernel\n");
+
+
 	if (id->idVendor && id->idProduct)
 		uvc_trace(UVC_TRACE_PROBE, "Probing known UVC device %s "
 				"(%04x:%04x)\n", udev->devpath, id->idVendor,
-- 
2.17.1

