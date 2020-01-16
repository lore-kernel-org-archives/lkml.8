Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0DEC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723272072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217535;
	bh=d7tnpAl5AppnZZy6il/7D+B7up9vWBV/emsgi/JzfOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=krnWAvgXoRYZmmu4bE+dRYrBeN1KZ7a9hCR/lm1kPyfxNZ5vfQjoA3WfjNFcqhkw+
	 4O85xd/8vl8oFo5+KL6rgrnYiXC6WXBdlFKCVda253KdUeBjQuZE6RehCCuL6Ti4AR
	 Ynb9Ze2bp4DhuPSETDmSGuUIT8CBW1ERZcc5O2EM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404027AbgAPXcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:32:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:41230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403994AbgAPXcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:32:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95957206D9;
        Thu, 16 Jan 2020 23:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217529;
        bh=d7tnpAl5AppnZZy6il/7D+B7up9vWBV/emsgi/JzfOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FcaCEMGpIGuGaxExoybmegQqBMNZeLcu2uF7hN+ZRNEZF9qer1dh9f6E42n8Ix0fZ
         tfXXnIK/7JoiDpRHnBRfOLoAupjFvV/7WRpgFLfz7kQ9zSxAFMtftYAm30xsGoXGPd
         64DCnwOgzqFznVeUKZmBPJ8uxtRylIEv6Zd1vxtc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.14 36/71] platform/x86: asus-wmi: Fix keyboard brightness cannot be set to 0
Date:   Fri, 17 Jan 2020 00:18:34 +0100
Message-Id: <20200116231714.822802644@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231709.377772748@linuxfoundation.org>
References: <20200116231709.377772748@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian-Hong Pan <jian-hong@endlessm.com>

commit 176a7fca81c5090a7240664e3002c106d296bf31 upstream.

Some of ASUS laptops like UX431FL keyboard backlight cannot be set to
brightness 0. According to ASUS' information, the brightness should be
0x80 ~ 0x83. This patch fixes it by following the logic.

Fixes: e9809c0b9670 ("asus-wmi: add keyboard backlight support")
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Reviewed-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/asus-wmi.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -457,13 +457,7 @@ static void kbd_led_update(struct work_s
 
 	asus = container_of(work, struct asus_wmi, kbd_led_work);
 
-	/*
-	 * bits 0-2: level
-	 * bit 7: light on/off
-	 */
-	if (asus->kbd_led_wk > 0)
-		ctrl_param = 0x80 | (asus->kbd_led_wk & 0x7F);
-
+	ctrl_param = 0x80 | (asus->kbd_led_wk & 0x7F);
 	asus_wmi_set_devstate(ASUS_WMI_DEVID_KBD_BACKLIGHT, ctrl_param, NULL);
 }
 


