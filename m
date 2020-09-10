Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AE2C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4164321D92
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="lvCWAmz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgIJV0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgIJVZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 17:25:28 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E178C061756
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 14:25:28 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 8C6AE891B0;
        Fri, 11 Sep 2020 09:25:26 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1599773126;
        bh=qqHU8t6MUhQ7iFPaaO3/oB5D4eqjg20+i952QRb+1fM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lvCWAmz3PLpRblqQoHVR1T6wswyx4Q9rXsLMKwXsg83nOrerMKec3ssfW/nSSr1zP
         nu4fYf7vlzz3RYsyeTfEzVVowMUbx5BZyP5/6MA2Bz9frbMbyRf6izWQh0w2E0oBLI
         dtUpV2tfeiyiXV4OUlauQ0+S2lgbe3zW5Bp2KZPAQ82XZoltvoFySRASONt4VGYErT
         seD2VDn7FMUGSniBA7uN358lO8T0JmokTqtOjhp604x4bByHqZzHmkKkiyQm0Fo3/O
         DuKbKPuzkcijTlpd4fwflXUjszhXZWcOu3baORvtjulxccNRTwyHi7BVRO8ZgCsl71
         kUX6PF2M3nUhQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f5a99c50000>; Fri, 11 Sep 2020 09:25:25 +1200
Received: from hamishm-dl.ws.atlnz.lc (hamishm-dl.ws.atlnz.lc [10.33.24.30])
        by smtp (Postfix) with ESMTP id 0A44013EEB7;
        Fri, 11 Sep 2020 09:25:25 +1200 (NZST)
Received: by hamishm-dl.ws.atlnz.lc (Postfix, from userid 1133)
        id 60FB02A2AB9; Fri, 11 Sep 2020 09:25:26 +1200 (NZST)
From:   Hamish Martin <hamish.martin@alliedtelesis.co.nz>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Subject: [PATCH v2 2/2] usb: ohci: Make distrust_firmware param default to false
Date:   Fri, 11 Sep 2020 09:25:12 +1200
Message-Id: <20200910212512.16670-2-hamish.martin@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910212512.16670-1-hamish.martin@alliedtelesis.co.nz>
References: <20200910212512.16670-1-hamish.martin@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'distrust_firmware' module parameter dates from 2004 and the USB
subsystem is a lot more mature and reliable now than it was then.
Alter the default to false now.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
---
 drivers/usb/host/ohci-hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 2845ea328a06..73e13e7c2b46 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -102,7 +102,7 @@ static void io_watchdog_func(struct timer_list *t);
=20
=20
 /* Some boards misreport power switching/overcurrent */
-static bool distrust_firmware =3D true;
+static bool distrust_firmware;
 module_param (distrust_firmware, bool, 0);
 MODULE_PARM_DESC (distrust_firmware,
 	"true to distrust firmware power/overcurrent setup");
--=20
2.28.0

