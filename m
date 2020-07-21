Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46CCC433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD26720714
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQJbyvrx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbgGUOoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGUOn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:43:58 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C4BC061794;
        Tue, 21 Jul 2020 07:43:58 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 184so3169062wmb.0;
        Tue, 21 Jul 2020 07:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2WK/JeeE/+nRyXwG8HQaNc35vq7rZhxdQ0xZiZF9ajQ=;
        b=rQJbyvrxOrncommrgjtatOvhPg1Pabu6o5TRfMOy6W8MXP8C8/41aMQ+D8mjxFW+hs
         fXUk4ITuVYErOeItwMicvNy+8Br+NB6mLndemGip1uHkfxomODt/phx3lJwmGUfNuTxL
         4Gt2jJwvmUxMknUooZaBvo3PqbbSOC9pfeFpM56CcI2NX9S+GbCOr62MxPITmiEeRsr3
         CJYLQYSp0G9x6Gu0Q9WHUUldZcT+t+FI1ooZlo3VI84oJ7EwZbOE5S8l+GAcCmd1L6A4
         Ag3oYlLAXJsaT817tzzXuQgUYi0f2Toyuu1vTvG1B3Fzj18W4cwSbAEbygANrY/Ln1Qy
         d/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2WK/JeeE/+nRyXwG8HQaNc35vq7rZhxdQ0xZiZF9ajQ=;
        b=WDG/6g3NPoXeMzhQAMq6yZMnHz+wP+SvMkJAQDyiqCnZ9841uO9JErOduM5GViyLAb
         J8NrARA6GT0k2OzEKuqCd63sewQlAiMFR5ntnA3wlmfP+P/IK49ppnez+QM9VTihMq4E
         o1BkLMKFeh+ALSElu6VbfY/QVcRyjPR27viBeQr7l4R3ZXhjrvpht2aq/qmQsTwhp0jN
         B6S2XPj+0dkeqPpif6/P5jC4JpvpCEzGmHKMfsJlnF5FxYFcZX1GRVW/eS1EOKVbgTmJ
         R5l7ZxQc/cEKhq31egj78AKN3iGdSDZzNJfpZZtjm7AUttBt3q2A/OUZZWUPJ1XYLYbu
         tv2g==
X-Gm-Message-State: AOAM531i4OA/tj/pU7vt4vF9yPLU+dMA9caO4YSqmTMWmQfhZKtDl9xS
        NzSDpQGx79vv/tdaYqAl0A6uLVxp
X-Google-Smtp-Source: ABdhPJx08iO+KKiyBNH+T/5yivtegAn8wOfRjAOQvbXnO77p0A8Npt0iH3cHXkhnHyEM/l/GGzjnmw==
X-Received: by 2002:a1c:1d46:: with SMTP id d67mr4719153wmd.152.1595342636720;
        Tue, 21 Jul 2020 07:43:56 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y6sm38043116wrr.74.2020.07.21.07.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:43:56 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Subject: [PATCH v2 4/7] usb: bdc: Adb shows offline after resuming from S2
Date:   Tue, 21 Jul 2020 10:43:23 -0400
Message-Id: <20200721144326.7976-5-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721144326.7976-1-alcooperx@gmail.com>
References: <20200721144326.7976-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Android systems, After temporarily putting device to S2 by
short pressing the power button on the remote, the display turns
off. Then press the power button to turn the display back up. Adb
devices would show the devices is offline. It needs a physical
disconnect of the usb cable or power cycle to bring the device
back online. The device is operational otherwise.

The problem is that during S2 resume, the ADB gadget driver could
not link back with the BDC driver because the endpoint flags were
cleared. The fix is to clear the endpoint flags for the disconnect
case only and not for S2 exit.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/gadget/udc/bdc/bdc_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index b70b438efff4..2c2f7aef7ba7 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -292,9 +292,13 @@ static void bdc_mem_init(struct bdc *bdc, bool reinit)
 		/* Initialize SRR to 0 */
 		memset(bdc->srr.sr_bds, 0,
 					NUM_SR_ENTRIES * sizeof(struct bdc_bd));
-		/* clear ep flags to avoid post disconnect stops/deconfigs */
-		for (i = 1; i < bdc->num_eps; ++i)
-			bdc->bdc_ep_array[i]->flags = 0;
+		/*
+		 * clear ep flags to avoid post disconnect stops/deconfigs but
+		 * not during S2 exit
+		 */
+		if (!bdc->gadget.speed)
+			for (i = 1; i < bdc->num_eps; ++i)
+				bdc->bdc_ep_array[i]->flags = 0;
 	} else {
 		/* One time initiaization only */
 		/* Enable status report function pointers */
-- 
2.17.1

