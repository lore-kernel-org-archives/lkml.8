Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCCDC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3A620735
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSuWybSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgHUSRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgHUSQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:16:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FFBC061573;
        Fri, 21 Aug 2020 11:16:43 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kr4so1176505pjb.2;
        Fri, 21 Aug 2020 11:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a2vqkZxfOh+KOvHb/YS3OmfJIe+mxzH/jxJhC3snMUg=;
        b=TSuWybSbjuAJC4eOTR/wqj2USx1dIVQ/8Bw71iutCMI9O8SDvoXQ7kjmPBTntSjNvA
         v2KomnVccZ+NJeLC6G9Z4JWPvWo2DCfS0hmLVvW3TMSnADyRpBYufAIl6EEmHtgflaBo
         /ulca1MPZXQyi3wM8RkGA2LkmqOR2Ax4w7THXXaSaElIUdoUzvWeZW06GCQ8N1m803TO
         MyBSi9v0j+gU1LVUG9epywOzT1+ew2mNotbF6JKI5Si+QaqRJ4DXcyCYGpxqOSn8EOOy
         UA6kZaS6RLL+fFbz2t7Uz/IM4Qr4qYv0eaohHwMMsANmTeyWP3GUMz9p/Fk+3sqBIcwP
         mJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a2vqkZxfOh+KOvHb/YS3OmfJIe+mxzH/jxJhC3snMUg=;
        b=J6rHS2/APzWzd+RGNyiL4JYs/LNRoyiASJxvmRg2IR58t0O1mNtzzTMtPWVSxis/qN
         /EuPXbPteaa2xIbojPZ3nTiETQ1FIobAOIPdfop7IZpZfHAHFeYmF/44J/pwvTVV1Ux1
         +QDn58ppYzozgxdUQSI66lMPrmT2f+Id5CbW6x7vn+PpnM/Xz/CZqxAtOhQBRI6Pe7No
         nTu1xRiKVS/6byJ/GOFOeTjctKlDt0vwFokjiTrkqqMolZ2V1Joaik6lrhsTItoqMI2t
         yoTyvwt2C0JjKdx631Ll4UvBRigI2tQgTM+IIChzes4Ib+YlUF6r34VwoJfQ1Uv+f4fe
         nVWg==
X-Gm-Message-State: AOAM533/SshN1IoWmuzoE60lruvvayU2wnRP3tkRgbYtXQ0bsJ1V6P1v
        /tszjAt7dfeGmmpTJIkCaVKe+pv6Wth49A==
X-Google-Smtp-Source: ABdhPJzRevWugGeYRMihOgPCjayehkX1o4qEQKhA0c18pdqxbSkDvktpEg6TsfT08KQe/JrWdBMhxw==
X-Received: by 2002:a17:90b:128e:: with SMTP id fw14mr3552684pjb.66.1598033802731;
        Fri, 21 Aug 2020 11:16:42 -0700 (PDT)
Received: from jaguar.thds.mooo.com (061239037006.ctinets.com. [61.239.37.6])
        by smtp.gmail.com with ESMTPSA id a13sm3158152pfo.49.2020.08.21.11.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:16:42 -0700 (PDT)
From:   Kenneth Chan <kenneth.t.chan@gmail.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     laforge@gnumonks.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject: [PATCH 7/9] resolve hotkey double trigger bug
Date:   Sat, 22 Aug 2020 02:14:31 +0800
Message-Id: <20200821181433.17653-8-kenneth.t.chan@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821181433.17653-1-kenneth.t.chan@gmail.com>
References: <20200821181433.17653-1-kenneth.t.chan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes double ACPI events are triggered for brightness, vol and mute hotkeys. This
patch fixes it.


Signed-off-by: Kenneth Chan <kenneth.t.chan@gmail.com>
---
 drivers/platform/x86/panasonic-laptop.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 3b0294ee9d3e..6779099a3ec9 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -13,6 +13,7 @@
  *
  * ChangeLog:
  *	Aug.18, 2020	Kenneth Chan <kenneth.t.chan@gmail.com>
+ *			resolve hotkey double trigger
  *			add write support to mute
  *			fix sticky_key init bug
  *			fix naming of platform files for consistency with other
@@ -597,9 +598,11 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 					result & 0xf, 0x80, false);
 	}
 
-	if (!sparse_keymap_report_event(hotk_input_dev,
-					result & 0xf, result & 0x80, false))
-		pr_err("Unknown hotkey event: 0x%04llx\n", result);
+	if ((result & 0xf) == 0x7 || (result & 0xf) == 0x9 || (result & 0xf) == 0xa) {
+		if (!sparse_keymap_report_event(hotk_input_dev,
+						result & 0xf, result & 0x80, false))
+			pr_err("Unknown hotkey event: 0x%04llx\n", result);
+	}
 }
 
 static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event)
-- 
2.17.5

