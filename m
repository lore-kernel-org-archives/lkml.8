Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D351C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588D92071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3WKXcxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgCLJiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:38:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34787 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLJiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:38:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id z15so6507903wrl.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 02:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FNf46Ec3CGDhnh1BuF3u+Qyby4M6Nu5elgafH8NKV8g=;
        b=f3WKXcxJo/wGVRvm9GX2aaNkRmWHQwjwtZSW7CeW5WesDiLBvCOHVW1itHGIhADdHR
         eM8YnJ6GWCmI5TwVPsm3LnjhHtFILX0WWLlkbJqT4hGv2EQ08iH/D9ST1T9i41gDSqrl
         ghsjYoyk18uGo6QoWQTAqysFfPDzIdgZZ2eMbNmAkh+3pHIWtH591AsqHFymXE4CBVHQ
         Gx4y7Ko3z/QdK4LrJdlp2heN3bXBFjyt/CodeTjqMbyxRkqYXVj3mb0NQLKe8NAN1GMG
         uX42hcIq8ih2k5sJdNsaboUnKyEINVuxhPK46p8O9nRQLmhGOwELRKKXwJmEIu1r1Pc7
         gb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FNf46Ec3CGDhnh1BuF3u+Qyby4M6Nu5elgafH8NKV8g=;
        b=QKVKvQSaLZn7PxvYKBZlDISi7UoykrB1zfgFEBSfh6T3Umkm+HXFwadahaM75ZOcA/
         yfWVg/YyMZVuDRQGQIW89xe0rYClUpNoV6ofZFSkS2FlVgJPstoo2BcBF+Q3WrIFUFq4
         18njw9vF9L8+p0ofaUyR6FnCSr4K4UTafvgGqwKwgl1yIvWCwFVPpNp8VycLYmBqESC+
         5HgcXCMpiQYIvXYe01B2D4usHuRJuFo6JvV3w7hdWtz/rKISitFS+qwo8rWVE6Kys2st
         AW0KSr/Y3G4I6hjerXb0XXhBmg8/kHj5wi1sJBLYu7bnc0JtfDiNXP5BWR1G3GULG7N9
         amoQ==
X-Gm-Message-State: ANhLgQ3eHZMW3lDkheHbGaOrLQNhjX4klhDFpzTGQfyukRKEEgi1UUP3
        xn/xUVQw5WSgb8QEExmvxeUDFGLN
X-Google-Smtp-Source: ADFU+vsJ0GbL9PBJ20GqoLCmqR5b3y/HtGxsx+wtqTrK3uQv+nfPVq6W8Rvs6rqcVzmrAcYoLTC6CA==
X-Received: by 2002:adf:b3d6:: with SMTP id x22mr9798658wrd.242.1584005897585;
        Thu, 12 Mar 2020 02:38:17 -0700 (PDT)
Received: from localhost.localdomain (dslb-178-006-252-224.178.006.pools.vodafone-ip.de. [178.6.252.224])
        by smtp.gmail.com with ESMTPSA id x16sm8670126wrg.44.2020.03.12.02.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 02:38:17 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: Add device id for MERCUSYS MW150US v2
Date:   Thu, 12 Mar 2020 10:36:52 +0100
Message-Id: <20200312093652.13918-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device was added to the stand-alone driver on github.
Add it to the staging driver as well.

Link: https://github.com/lwfinger/rtl8188eu/commit/2141f244c3e7
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/usb_intf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_intf.c b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
index b5d42f411dd8..845c8817281c 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
@@ -38,6 +38,7 @@ static const struct usb_device_id rtw_usb_id_tbl[] = {
 	{USB_DEVICE(0x2001, 0x331B)}, /* D-Link DWA-121 rev B1 */
 	{USB_DEVICE(0x2357, 0x010c)}, /* TP-Link TL-WN722N v2 */
 	{USB_DEVICE(0x2357, 0x0111)}, /* TP-Link TL-WN727N v5.21 */
+	{USB_DEVICE(0x2C4E, 0x0102)}, /* MERCUSYS MW150US v2 */
 	{USB_DEVICE(0x0df6, 0x0076)}, /* Sitecom N150 v2 */
 	{USB_DEVICE(USB_VENDER_ID_REALTEK, 0xffef)}, /* Rosewill RNX-N150NUB */
 	{}	/* Terminating entry */
-- 
2.25.1

