Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71723C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 424772065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260285;
	bh=mc4hgWFiyS5cm0An1H3bX+ZTsInr0ZMhIEiUCiIdrVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VdfkHw0Tirx02vaqEiS5vcQTcWss0Rn4d9Ma7ovg9hrXdZySmaQvyng8HlV31BuiZ
	 Jf+BW5gDfPMwMdUyztpbxSexnTXRDO7uqC1MV3uPV5AEtPlGKEgMPeuOqcVLrE2p0Y
	 Ut92I4xezI5P7js7ghFb2ixn0R6cpx0V3xFDo9KI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbgGTPvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730070AbgGTPvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:51:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBAE72064B;
        Mon, 20 Jul 2020 15:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260280;
        bh=mc4hgWFiyS5cm0An1H3bX+ZTsInr0ZMhIEiUCiIdrVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KIJptgaQDTjOrCnc6XPlAyw3Q8f0GL6BkcGZZjf/gxP856325xx6obn/HGaGyUjDJ
         tIDCLqv9dp7+K3q6r7eunYY/p+KmfSb5PYtUBTNf0z/15dkF8Y8o2lFSALr+T2vHwT
         in6d+P3QzyoTBv0BHpDa8j8chjsQMoKeuoiyReBg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 046/133] HID: quirks: Remove ITE 8595 entry from hid_have_special_driver
Date:   Mon, 20 Jul 2020 17:36:33 +0200
Message-Id: <20200720152805.940091930@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 3045696d0ce663d67c95dcb8206d3de57f6841ec ]

The ITE 8595 chip used in various 2-in-1 keyboard docks works fine with
the hid-generic driver (minus the RF_KILL key) and also keeps working fine
when swapping drivers, so there is no need to have it in the
hid_have_special_driver list.

Note the other 2 USB ids in hid-ite.c were never added to
hid_have_special_driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-quirks.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index f4bab7004aff7..7216285659566 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -400,9 +400,6 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A081) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A0C2) },
 #endif
-#if IS_ENABLED(CONFIG_HID_ITE)
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ITE, USB_DEVICE_ID_ITE8595) },
-#endif
 #if IS_ENABLED(CONFIG_HID_ICADE)
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ION, USB_DEVICE_ID_ICADE) },
 #endif
-- 
2.25.1



