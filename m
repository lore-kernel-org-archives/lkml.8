Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416F3C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE792080C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580746940;
	bh=WrquJt1Q/cm6mKQRk/i8DpXbOAVsBq22nXml15sHB38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kr4FuH/DN2uHh5AcRzAD7mkqk8CNbvxxcxtm0666h+M7Wad9ueUX7nZ+bPflP6Hbj
	 tMs4AyPmKU4dHZF73SyQCXenX7sLtrZyZPbSXIvkWoEAqlvqC+EdcwvkB7rt8v3Sbt
	 +T/ppZXVlwPH+k/Jo4To3FkPkLhM21sZfaTdQtNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgBCQWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:22:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728634AbgBCQVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:21:42 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F06652082E;
        Mon,  3 Feb 2020 16:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580746902;
        bh=WrquJt1Q/cm6mKQRk/i8DpXbOAVsBq22nXml15sHB38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HCHOavvhlggO7mvjxsvqi1jGKaX+9ojfnri67v/Xi5WDXENOIi4JrqwQttpmIm6oU
         kW+1R5Pa2oNa0oCkWZQWG2X5LxEAzycuEA1cMFoClSSiXRnF2ND7jF03MNqA/i7Nlz
         tc5YNSXm4sFVM6o1krhLXMtwD6UpS1YJxhk4cmmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Vladis Dronov <vdronov@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 38/53] Input: aiptek - use descriptors of current altsetting
Date:   Mon,  3 Feb 2020 16:19:30 +0000
Message-Id: <20200203161909.760107807@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161902.714326084@linuxfoundation.org>
References: <20200203161902.714326084@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit cfa4f6a99fb183742cace65ec551b444852b8ef6 ]

Make sure to always use the descriptors of the current alternate setting
to avoid future issues when accessing fields that may differ between
settings.

Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Vladis Dronov <vdronov@redhat.com>
Link: https://lore.kernel.org/r/20191210113737.4016-4-johan@kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/tablet/aiptek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index 40a166773c1b4..142f34a0a3cb6 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -1731,7 +1731,7 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	aiptek->inputdev = inputdev;
 	aiptek->usbdev = usbdev;
 	aiptek->intf = intf;
-	aiptek->ifnum = intf->altsetting[0].desc.bInterfaceNumber;
+	aiptek->ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
 	aiptek->inDelay = 0;
 	aiptek->endDelay = 0;
 	aiptek->previousJitterable = 0;
-- 
2.20.1



