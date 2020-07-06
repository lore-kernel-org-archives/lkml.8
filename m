Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419C7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16EF520702
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uusCAAiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgGFNek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729382AbgGFNeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:34:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7653EC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:34:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so40975665wrv.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wUFrKyBE/rqHQUVcokgEiKeaeYpvOr+KJ0Q9vYwpje8=;
        b=uusCAAiMYRyZu2CfIvDS4HCRjCXdZtQhAdbkpOMuxK8zvkQgvAiWP7osHCg5j0Lxi5
         16z2up3T4hzLGYGUj30PuZuH/B1ZOaCs7UsgLTYfLAopJ+wzvauVq5wsuRkhS9mODBVO
         xu3HpYfIRTGCABdG6OuYwyuSubTIL9fv8KfITH2PVNH6p+KU2u/VSZ88VFCHVaBSnUEE
         qCSCG4xa+6MOhyRfi5aRon2mI3zyyZNLPzHx0yYiSZHLP1iZQY77tCT0GZB2yW+6Np0Z
         oepj3m1na2bZFY8S7xZRfDmdzIbt82vIVRQ30dBiAEz2EguVEQm+DlN2OGXrSjBKXDOb
         Soig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wUFrKyBE/rqHQUVcokgEiKeaeYpvOr+KJ0Q9vYwpje8=;
        b=ljZ//B4sFqGmmdhyVX0u1KXod0k5Sri0wAD4YwbRCbDr0kORsFUub2qmL1UAZimpXV
         AEsX1M/1HJo03UumXT58R0vtoTqKgEacMiGcWrGqV4Il2sDH0T/MxV0hVVGzKYd1gnV7
         LqD4IMF22jYUvmFZ/9A329sNHsQ6SedvdsalvsrS6C7OWWrwlF5cOjAW12XeNzDzKa79
         /Z3I/F3/uEbGJGC04n/K/ZdZJADDT6dN/sHiNnNy5a3rSC6bbdj2n3ThOcH/UuUVcTu3
         iIdiAnA4umW1rPtv9gOp9A7g20nJ1CeAcKQcjTQRmBtqz/nfwO+zK8DNla/v3FyL94dD
         gOhA==
X-Gm-Message-State: AOAM5336hM7rjWkFV78+F78Q6mXQ4CPspIBIUrEmoERL51TEbmaW+W2D
        1R/wgB0o0xaZpgNEegW9dm4ejT7rakE=
X-Google-Smtp-Source: ABdhPJyyqkr63bgakviOF8q+Q3TQCXiWUrHVNA65wDA49vqE6L9e5OtXIB/BD5KAE97IICp4FfjQqQ==
X-Received: by 2002:a5d:470b:: with SMTP id y11mr50993618wrq.101.1594042461212;
        Mon, 06 Jul 2020 06:34:21 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:34:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Shlomi Gridish <gridish@freescale.com>,
        Jerry Huang <Chang-Ming.Huang@freescale.com>,
        Peter Barada <peterb@logicpd.com>,
        Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH 30/32] usb: host: fhci-tds: Remove unused variables 'buf' and 'extra_data'
Date:   Mon,  6 Jul 2020 14:33:39 +0100
Message-Id: <20200706133341.476881-31-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706133341.476881-1-lee.jones@linaro.org>
References: <20200706133341.476881-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither have been used since the driver's inception in 2009.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/host/fhci-tds.c: In function ‘fhci_flush_bds’:
 drivers/usb/host/fhci-tds.c:472:6: warning: variable ‘buf’ set but not used [-Wunused-but-set-variable]
 472 | u32 buf;
 | ^~~
 drivers/usb/host/fhci-tds.c:470:6: warning: variable ‘extra_data’ set but not used [-Wunused-but-set-variable]
 470 | u16 extra_data;
 | ^~~~~~~~~~
 drivers/usb/host/fhci-tds.c: In function ‘fhci_flush_actual_frame’:
 drivers/usb/host/fhci-tds.c:527:6: warning: variable ‘extra_data’ set but not used [-Wunused-but-set-variable]
 527 | u16 extra_data;
 | ^~~~~~~~~~

Cc: Shlomi Gridish <gridish@freescale.com>
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>
Cc: Peter Barada <peterb@logicpd.com>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/host/fhci-tds.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/fhci-tds.c b/drivers/usb/host/fhci-tds.c
index f3308ce250438..d98fd9e1af0bc 100644
--- a/drivers/usb/host/fhci-tds.c
+++ b/drivers/usb/host/fhci-tds.c
@@ -467,17 +467,15 @@ u32 fhci_host_transaction(struct fhci_usb *usb,
 /* Reset the Tx BD ring */
 void fhci_flush_bds(struct fhci_usb *usb)
 {
-	u16 extra_data;
 	u16 td_status;
-	u32 buf;
 	struct usb_td __iomem *td;
 	struct endpoint *ep = usb->ep0;
 
 	td = ep->td_base;
 	while (1) {
 		td_status = in_be16(&td->status);
-		buf = in_be32(&td->buf_ptr);
-		extra_data = in_be16(&td->extra);
+		in_be32(&td->buf_ptr);
+		in_be16(&td->extra);
 
 		/* if the TD is not empty - we'll confirm it as Timeout */
 		if (td_status & TD_R)
@@ -524,7 +522,6 @@ void fhci_flush_actual_frame(struct fhci_usb *usb)
 {
 	u8 mode;
 	u16 tb_ptr;
-	u16 extra_data;
 	u16 td_status;
 	u32 buf_ptr;
 	struct usb_td __iomem *td;
@@ -538,7 +535,7 @@ void fhci_flush_actual_frame(struct fhci_usb *usb)
 	td = cpm_muram_addr(tb_ptr);
 	td_status = in_be16(&td->status);
 	buf_ptr = in_be32(&td->buf_ptr);
-	extra_data = in_be16(&td->extra);
+	in_be16(&td->extra);
 	do {
 		if (td_status & TD_R) {
 			out_be16(&td->status, (td_status & ~TD_R) | TD_TO);
@@ -552,7 +549,7 @@ void fhci_flush_actual_frame(struct fhci_usb *usb)
 		td = next_bd(ep->td_base, td, td_status);
 		td_status = in_be16(&td->status);
 		buf_ptr = in_be32(&td->buf_ptr);
-		extra_data = in_be16(&td->extra);
+		in_be16(&td->extra);
 	} while ((td_status & TD_R) || buf_ptr);
 
 	fhci_td_transaction_confirm(usb);
-- 
2.25.1

