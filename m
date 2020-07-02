Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF522C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A748E2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MRCLlu77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbgGBOru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbgGBOrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:47:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53795C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:47:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o2so28288049wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pP5tNguPzonDyxhQNucE0D3MbWP90cYYUbxgRDFDsUc=;
        b=MRCLlu77vm2lwEuKfpgTjOHIiNbOSRTeYtgs5c+tcVQF2EOP3Y+PnwvY8yMjo/cJJ9
         TpF2T6O2DEjSh+q/g7J04eisB3ct2rVdiBCpsqSLJeVCjttHOc7mvJkWgxLpgTX1G7ih
         9zoqFAsZWRUg+4yjqPZtnjfXqRtNRxiUz9bgYGRiZMsU3zRp/oW2DAsNBN8kUjudGQt9
         2V6vEeJAtKSdSkRaouvKT1GaOXxATqsbk9o2Agt560AZqfMKPCHBpvFsq9QjR3OwQ2b/
         2wOOxYVGGAVrNGw3vGhZgQmcSwGG/WaDTMsIgDN0ckGLgqnUhN6oSdWcJu49hXBTt01a
         6Kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pP5tNguPzonDyxhQNucE0D3MbWP90cYYUbxgRDFDsUc=;
        b=DTV+e65p6UPdZmsPxsaky3XN96oPQnCuxx98lfZFgyoUoyInynJEKiR65vhwRXi+ze
         vt1AArRX7qn7qJBoYUQdycHwt3mzXEoliXluMuRRaMYcc0GnxWCt821DvGI2xyhPrbWE
         dCMaiQxa61DbsjJ33dW0lNIcrGwfVQa25Dyq7fHnPlSNof4gIhHhVoAEJKfZauM7sKRv
         14vZIGk1zs4ekjfrcCv9WyRodK7fe39Plotn8sOFSTmyaZI4mPYJUIsU8Lp8nijNENRA
         YHz17Y2iOFdwdKU+ashlBxM/yK+WB/QO0/7LEzw7YbEEbfd6drOvSQXAFyonjNsmiRhK
         Fnlw==
X-Gm-Message-State: AOAM531caD9C0hu8sRGHbn+KsOTubdOP4/AinQ3PcCxDeImtP0EShFM+
        dEnExT6y69U+02drGzdv1VTREg==
X-Google-Smtp-Source: ABdhPJyyBq6LXHLryVvWu+HFwT4JhZivbWn1QGWohZ3dXSZK0sYsC9OCCnVcIDtulXLnqPhVrsy2hQ==
X-Received: by 2002:a1c:49d7:: with SMTP id w206mr30883650wma.181.1593701220039;
        Thu, 02 Jul 2020 07:47:00 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g14sm7002737wrw.83.2020.07.02.07.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:46:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rodolfo Giometti <giometti@linux.it>,
        "Eurotech S.p.A" <info@eurtech.it>
Subject: [PATCH 23/30] usb: host: oxu210hp-hcd: Move declaration of 'qtd' into 'ifdef OXU_URB_TRACE'
Date:   Thu,  2 Jul 2020 15:46:18 +0100
Message-Id: <20200702144625.2533530-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702144625.2533530-1-lee.jones@linaro.org>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we assign 'epnum' during the declaration we can also avoid "ISO
C90 forbids mixed declarations" issues.  So it does looks like we
can have our cake and eat it in this scenario.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/host/oxu210hp-hcd.c: In function ‘submit_async’:
 drivers/usb/host/oxu210hp-hcd.c:2040:19: warning: variable ‘qtd’ set but not used [-Wunused-but-set-variable]
 2040 | struct ehci_qtd *qtd;
 | ^~~

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Rodolfo Giometti <giometti@linux.it>
Cc: "Eurotech S.p.A" <info@eurtech.it>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/host/oxu210hp-hcd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
index 120666a0d5901..b00673295c9fe 100644
--- a/drivers/usb/host/oxu210hp-hcd.c
+++ b/drivers/usb/host/oxu210hp-hcd.c
@@ -2037,16 +2037,15 @@ static struct ehci_qh *qh_append_tds(struct oxu_hcd *oxu,
 static int submit_async(struct oxu_hcd	*oxu, struct urb *urb,
 			struct list_head *qtd_list, gfp_t mem_flags)
 {
-	struct ehci_qtd	*qtd;
-	int epnum;
+	int epnum = urb->ep->desc.bEndpointAddress;
 	unsigned long flags;
 	struct ehci_qh *qh = NULL;
 	int rc = 0;
+#ifdef OXU_URB_TRACE
+	struct ehci_qtd	*qtd;
 
 	qtd = list_entry(qtd_list->next, struct ehci_qtd, qtd_list);
-	epnum = urb->ep->desc.bEndpointAddress;
 
-#ifdef OXU_URB_TRACE
 	oxu_dbg(oxu, "%s %s urb %p ep%d%s len %d, qtd %p [qh %p]\n",
 		__func__, urb->dev->devpath, urb,
 		epnum & 0x0f, (epnum & USB_DIR_IN) ? "in" : "out",
-- 
2.25.1

