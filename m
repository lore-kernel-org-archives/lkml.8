Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BC3C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B8DC20731
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ubMoQe/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387556AbgDMSBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 14:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387542AbgDMSBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 14:01:42 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59421C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 11:01:41 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x18so6774303wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 11:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oFzTWhcRCR5eyAjpAIHdWF4cXdPQYj4ClKz3tMRVpzg=;
        b=ubMoQe/5WSJeHwx3UpJa1Mtt81fxLIXsxRkMHb8dBbGrt/rR4TfvT4oTPYOXc51Drx
         RkyYS//7/mexHk+rA3Tzpw3w5SJpH3wLxkPJP2TGuOtlLnmmHKIiykPiCDaZY7IffzNM
         j+NKAS3DVil6UgjAWVb3I38iXqsomo39z4HOk0VOTx7MsrEIu0hCUBFH7Ot2ugN0eHRV
         ZbGZH5PFMX8UVeW7KbIiOtpeh0KCobADfgB1zQ3WYNrhPF5FOS50fj04ocg+bGtkPiof
         YbnLb5Msqix7IKHFxWuiY6clvLfkEficis4v0shkoK2eSrvj1wBHIPZqcWE8R6tPpIAh
         O8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFzTWhcRCR5eyAjpAIHdWF4cXdPQYj4ClKz3tMRVpzg=;
        b=HfSeyBnLqlFisHyTixjBCqlY5fS/JLKg0AhqH/jiEtDYU4KtK3+k1r5UCtWXd7ufHp
         96U1RTOW/F79TVaExGb0hBk+601fmLhP3wNLwT2h0VC18flaj+fcX3FFfBDQQSOy5TBY
         /Ej9m5bxtTFMsie+owokZcPCkdcBs77gE/Q2scuaWah6YvqN/2a4rARG+na7pLFmU6Eo
         g0KmMjfwTA1emsnITDeLDNyoSQrJCz1gqGeOvHiiTiBVkBHrXHsGi+SnEJolo1roSA2I
         6i7ks/CBsQUpjG7EXdVSL+Iumza4hd2ASALGj0orMyot6TIkr1kHs5Q/0+MaKEp+c8ai
         Q0OQ==
X-Gm-Message-State: AGi0PuZ41cSkttwhe9cpE7L5k4JGR0xgDOdsbMrQTbNnsk06k5pHut3I
        18HuA0LNp1H0Sq2F1F6BWdw=
X-Google-Smtp-Source: APiQypJFUfq9aZ17IeqNWqfsZUzSUieOZY1CTUKO7tYEePEY+8fTp0B1QWN0CbLQ/2XrrAhP7rcn9A==
X-Received: by 2002:adf:cd12:: with SMTP id w18mr19420215wrm.311.1586800900161;
        Mon, 13 Apr 2020 11:01:40 -0700 (PDT)
Received: from localhost.localdomain (dslb-092-073-054-241.092.073.pools.vodafone-ip.de. [92.73.54.241])
        by smtp.gmail.com with ESMTPSA id u3sm6476181wrt.93.2020.04.13.11.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 11:01:39 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: rtl8188eu: cleanup long line in fw.c
Date:   Mon, 13 Apr 2020 19:59:56 +0200
Message-Id: <20200413175957.30165-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200413175957.30165-1-straube.linux@gmail.com>
References: <20200413175957.30165-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add line break to avoid line length over 80 characters.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/fw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/fw.c b/drivers/staging/rtl8188eu/hal/fw.c
index dbf7883f9ed7..432e6bea5ea1 100644
--- a/drivers/staging/rtl8188eu/hal/fw.c
+++ b/drivers/staging/rtl8188eu/hal/fw.c
@@ -192,7 +192,8 @@ int rtl88eu_download_fw(struct adapter *adapt)
 		rtl88e_firmware_selfreset(adapt);
 	}
 	_rtl88e_enable_fw_download(adapt, true);
-	usb_write8(adapt, REG_MCUFWDL, usb_read8(adapt, REG_MCUFWDL) | FWDL_CHKSUM_RPT);
+	usb_write8(adapt, REG_MCUFWDL,
+		   usb_read8(adapt, REG_MCUFWDL) | FWDL_CHKSUM_RPT);
 	_rtl88e_write_fw(adapt, download_data, download_size);
 	_rtl88e_enable_fw_download(adapt, false);
 
-- 
2.26.0

