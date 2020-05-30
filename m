Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CB6C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 17:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF6B20721
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 17:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKd9T0hs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgE3RNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 13:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgE3RNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 13:13:31 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DFCC03E969;
        Sat, 30 May 2020 10:13:26 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b6so3114682ljj.1;
        Sat, 30 May 2020 10:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wTHHUoOK9LtynLNtMfwC1JSkdo0WV2HtB9sbt24MB0w=;
        b=MKd9T0hsLjcFzFJL3H00K5UpfhG0vuV9FzffgVfcDHnswZiZFPT1P3MndDuWNz8s3H
         CZ6FGCNJh5ebffTiGIKQBe1JIPfNYycY7wQ5mk4oXMGzvtjHoe4nyDhS231xmfhxvV0Y
         tLDvzs/escssZRXOB2PIzL7wcEvc+sm3cN+6+NF5xyuu6S1DDvdINsptn73yWTJHZ5Gv
         YYtdpTr5IUklbfeXEHtJIEut42UWhpDf7rSku0LHVSwTJe7oRapJcm4F03/6qiJ+A/h+
         aHjW7dU4W95HPYOkwzzZqOq6RFRh2HcmINJBFI46FBsuZHi9S++DKuur/fL+TJtnm4k+
         H22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wTHHUoOK9LtynLNtMfwC1JSkdo0WV2HtB9sbt24MB0w=;
        b=Wsv+xOB2n5RcRZatcBk4MvzZkOtER/V6xcW8bWy4P4MDeRVe8jm6BuR6Z0pMGJ9SqN
         xshcrxScr9V1HyPAndNHOtJQp5Gw3ppf1suRF3iaIlgE4c9Ivf1IZjW6g2WfnqIGVJWX
         YatHxDc6TAIhipG7WSTwAKwhH1+WFi/TQT0isU5Hs59hBe6hOBnkeOxgbsqSF0OqImGH
         8eTgWoLFU5pX8vekEqTUyU6Vkn+dIQEBFmnkhf2iEOVMAMEkLrjNhRTG7zJUIf7amWcP
         Ix6aMxPqPyhRg8GjgvGclNVoTsn7uSDV9bF+3tSCwizkD6OHHahJnlJ4C/MmoVxIXjwn
         GzsA==
X-Gm-Message-State: AOAM5301UkEZ02mesY9DgP2hWniZGoa/Qy61UtEdOTUJS150TsoMjsjS
        4k6ZMzfiwD8hEj7VFslBpiPHYotoiq68OQ==
X-Google-Smtp-Source: ABdhPJxyamokCEL/p9IltyFvDIH5FCNZsvvKjaHINHauYbTgSdiXMTtiqcL9y34U7NEax2P1gvL12Q==
X-Received: by 2002:a05:651c:508:: with SMTP id o8mr3968765ljp.112.1590858804997;
        Sat, 30 May 2020 10:13:24 -0700 (PDT)
Received: from localhost (95-31-124-98.broadband.corbina.ru. [95.31.124.98])
        by smtp.gmail.com with ESMTPSA id j5sm2732038ljg.78.2020.05.30.10.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2020 10:13:24 -0700 (PDT)
From:   Nickolai Kozachenko <daemongloom@gmail.com>
To:     Alex Hung <alex.hung@canonical.com>
Cc:     Nickolai Kozachenko <daemongloom@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] intel-hid: Expand DMI quirk to support HP Spectre X2 (2015)
Date:   Sat, 30 May 2020 22:07:20 +0500
Message-Id: <20200530170719.16923-1-daemongloom@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAHp75VdV4mAfAz5OZSW3FSzDwkvQiM7djBTH9rrAZYHJUp5jRA@mail.gmail.com>
References: <20200530170648.16845-1-daemongloom@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


HEBC method reports capabilities of 5 button array but HP Spectre X2 (2015)
does not have this control method (the same was for Wacom MobileStudio
Pro). Expand previous DMI quirk by Alex Hung to also enable 5 button array
for this system.

Signed-off-by: Nickolai Kozachenko <daemongloom@gmail.com>
---
Formatted patch with git

 drivers/platform/x86/intel-hid.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index cc7dd4d87cce..9ee79b74311c 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -79,6 +79,13 @@ static const struct dmi_system_id button_array_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Wacom MobileStudio Pro 16"),
 		},
 	},
+	{
+		.ident = "HP Spectre x2 (2015)",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Spectre x2 Detachable"),
+		},
+	},
 	{ }
 };
 
-- 
2.25.1

