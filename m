Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF8CC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CFB32076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAKFo9wW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgGQPXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgGQPXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:23:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D3CC0619D2;
        Fri, 17 Jul 2020 08:23:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f18so11619942wrs.0;
        Fri, 17 Jul 2020 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eDUInn53PGUx0+AivLJa/ERiqsHCKn0OmcMLZZkWr94=;
        b=iAKFo9wWY23qfH4cIb3HsqnAp7+7HOUipi0jN7nDImzSfSiNZkFl9IDdvZ7E1EDpvB
         v1mg3R+e6SOP7coSLNIKsr/cLI/5zfMm+DAUq6blu/kxPy64ZFicqV/a67QH3EAaR1ZN
         gm5JEywZfCyL+th4u5w8aFgxVyXmfXWhIcxNZDdnhV1swjNz+R3HQ1ewHf2zELS9asNz
         +vheSiUb5rw2MMjaQ5zuOx1M56rOLDlX0oN9/rOFXXvrKh5PG++SFNZizb9Vo6DSF1eW
         ng3bStxj4BNbVpS6hK/Lo6E5la6rHu9swrQbPaJA7HBCziX2l/lyz3Z0SoTGnvrEsRVm
         fxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eDUInn53PGUx0+AivLJa/ERiqsHCKn0OmcMLZZkWr94=;
        b=auPdYKj5YDrbOLH6sOxZZiUuIZGuESLE+pxr7A5Gqu+RFXb+UOBHQIb6z4+EYhZo4M
         8pbdq02ZNzcB1b0Qe0oUWD/pUHX7rWz7wTqzXdtvve6cy/TGn7m2ZeIGrbWmBskF39pb
         uf4RKiD5Kf7Hq0jrBfpI3LkRfZEL0MzGOl8wILPfsqguKikV+t6X/F+qbEJK2B5Aeiva
         xQrrR2S1iXYA6sKzfjS7Rpwzc6/Um0oUkM/hFmRDQEoqGeADVa8k//Cj7zQExVWYj27P
         8SgHv6+ZNRxViSvDHy/cZHuqw0Y4ngyxdfgw6hgGdN7ANyuPcU1biBsdm6DxFwvM4RFs
         qvvA==
X-Gm-Message-State: AOAM530yVV3EyWm7ebBvbSPeY208QcFDrFp7ycL7A2/eVoaEhY9NAhRL
        LyxWVVeSKh8pnC0fOdpsfp6S4/Eh
X-Google-Smtp-Source: ABdhPJwIJwBRgUX4sCFwxhKTnxbnMU4Vfpyi/0Jd5ghS3qrniODyaNYrPiZo5G+XPGaUhcV9xklpFQ==
X-Received: by 2002:a5d:56d0:: with SMTP id m16mr10478813wrw.194.1594999424545;
        Fri, 17 Jul 2020 08:23:44 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id a22sm13431051wmb.4.2020.07.17.08.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 08:23:44 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Subject: [PATCH 2/7] usb: bdc: Add compatible string for new style USB DT nodes
Date:   Fri, 17 Jul 2020 11:23:02 -0400
Message-Id: <20200717152307.36705-3-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717152307.36705-1-alcooperx@gmail.com>
References: <20200717152307.36705-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for some newer boards that only have this
as there match sting.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/gadget/udc/bdc/bdc_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 02a3a774670b..436a734ea0bc 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -629,6 +629,7 @@ static SIMPLE_DEV_PM_OPS(bdc_pm_ops, bdc_suspend,
 		bdc_resume);
 
 static const struct of_device_id bdc_of_match[] = {
+	{ .compatible = "brcm,bdc-udc-v2" },
 	{ .compatible = "brcm,bdc-v0.16" },
 	{ .compatible = "brcm,bdc" },
 	{ /* sentinel */ }
-- 
2.17.1

