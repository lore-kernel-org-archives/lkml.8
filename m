Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1679C433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB1AC2065F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYcQNfPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbgGVRII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgGVRIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:08:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321ABC0619E0;
        Wed, 22 Jul 2020 10:08:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f7so2639130wrw.1;
        Wed, 22 Jul 2020 10:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SM+ijn28RuEDD74oyOW/2/H9Sdykkw8SfTcfavc4Cok=;
        b=vYcQNfPY2mksJQVYme6rLpHSHIlGgYE9lq8MRKdDUPOh9y3hoPtOMH0HBmgZA8ytoO
         DT0u0M0nJtqfgDpsr2CqRh8vAobCadMdrkOWKFNNJFna+Gtt8wEca9b8xwtdH+lz205t
         FWrYXqWbQYF1981Dev2lEJSpBfmcquaAvxhiiRA3fnH3Ve+Mp932JlvA12L5nMnzkpkQ
         sxWxUKsppOtPxsDwDRG3LzAhQs7ig8jrGVv9yoj0rNNNUjMKhAOnyqDMyoBgzXtk4Zez
         wfj8uHal3eGYCQxhtcC8AXW5aG8rG48tmPPXQkjxFAFpVP5OhOTheaqFlNrMapeibY5R
         CCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SM+ijn28RuEDD74oyOW/2/H9Sdykkw8SfTcfavc4Cok=;
        b=R7bIdjtNIn9OWP2HnLOH3ATLqwj6ZuHF1v7pcqHNR8f7XFe41ZNC82kKfCVhucTFlH
         Rvn/JB80kZ/7PGTnHIOfmkFJ+HzMi1SNXTvl4D9mNTgJnw8qt7LZ7n5HrRD80yY5dJho
         zFkM/LnkewvNA7qPoWRparM1Tm6gOi/ztClR/L/bZfJpCSqpWKxlTeRpmZOurMrXk372
         67cBhGS5gTJ1KS4m1Da9whLO8uVF7gu4ViuSpejnGdEZiVV970pDDMRQU+p3aB7L7nTg
         bwfk340eUZuz5/Hcbk8QrAnCN2LXRX9Srlfbf0Gm3RPcqbJ9f1QVLXNqxqLF8dHfN3OZ
         +jgA==
X-Gm-Message-State: AOAM532jTBNLgBdgPcTiFXNPnmkfVQpM1RE1U2F3fCcLtTf3CUuzt49T
        CKiLtNXgVrtGX8ln3lgO/UdHtCCp
X-Google-Smtp-Source: ABdhPJzqP4gquP5sCjLbg8UuFYqW+hAQiPseNDJ+ZCquHVehhRFhaPUeDzFbD9nXqMwnTi04DRIBDw==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr452778wro.317.1595437683445;
        Wed, 22 Jul 2020 10:08:03 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 133sm392960wme.5.2020.07.22.10.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 10:08:03 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Subject: [PATCH v3 2/7] usb: bdc: Add compatible string for new style USB DT nodes
Date:   Wed, 22 Jul 2020 13:07:41 -0400
Message-Id: <20200722170746.5222-3-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722170746.5222-1-alcooperx@gmail.com>
References: <20200722170746.5222-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for some newer boards that only have this
as their match sting. Remove unused compatible string "brcm,bdc-v0.16".

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/usb/gadget/udc/bdc/bdc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 02a3a774670b..18d510fc02fb 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -629,7 +629,7 @@ static SIMPLE_DEV_PM_OPS(bdc_pm_ops, bdc_suspend,
 		bdc_resume);
 
 static const struct of_device_id bdc_of_match[] = {
-	{ .compatible = "brcm,bdc-v0.16" },
+	{ .compatible = "brcm,bdc-udc-v2" },
 	{ .compatible = "brcm,bdc" },
 	{ /* sentinel */ }
 };
-- 
2.17.1

