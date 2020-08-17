Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA89BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D9462065C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKcokAzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgHQXvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 19:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgHQXvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 19:51:09 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A12C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:51:08 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y2so10392487ljc.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SPW2LJTAlWqhtQcTdPRilBhn2+hGuuzRK5hGsS5a3Jc=;
        b=OKcokAzCr/ZNeiCuxO21SZILLIMu2s5cJiQzCY6at0CrIXZIz9ODJq/iL+SIgSaiGn
         fviQM/QhH9/2a57xpfXytVA4dwYKCyT5d4ADpys6V26EQ8uCOMDmmm9QcyFaH+uSBT0w
         XiAO8qu1iiSaINDZdX0QT5ne0tzOzSsoS4WOf+fI0HKzq0CaYnpKU6LtdK1WFeSKbKn2
         nctsLgmsE9HTP19tH1DTrZutcWIdSNF2hFJ31AWX108Ooeo4fHooi+ayhnowjyGdRvGo
         IJjKfLmaMJPe780xcpTmjezu73FZMx6DBqJes1ZUcGnacKBoefmUDOXKFXjGNFc2J5nG
         8AJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SPW2LJTAlWqhtQcTdPRilBhn2+hGuuzRK5hGsS5a3Jc=;
        b=FXPZWEF7rMRx19OD0GpnpGwyZ3TPNiFE96TMB3VYaMnnCQHXpBs6SRNoKYsCRpk052
         ASl+L9kNTzcxIylsdMzx/d4suZe+psV79BmnolbBtNU3d5ZS94TI7hlJvpKnihieiM9a
         7io5llz4Kr7+ZY4cZ5+/djX5kG90rOn4i9pEIeq0WnJnfQ188+yJ6WCNrIgViPHAFG/M
         xfPmBSr4alUKL/mF4UA1gJoXqoUpDv8S1W5mFpt+ppeQ7ZZ9h1y/2UP8R9IcP4LWlJKo
         qdmZ+W4FQgyl6WosKpo8g4sEJ9RnNlwsQPxkp4fxj0d8Y5AYLDopD89a+tbmzepuMaIj
         osGw==
X-Gm-Message-State: AOAM532ZTVGXAq0ROIv9Bo2VZmQxNK+693Mp+GKNWUwwHAH6dupuZSlR
        t7rQLo4C6dnEO+zqfdlUpUJS+/oVmF8=
X-Google-Smtp-Source: ABdhPJwM/OYmtmEDcj6/hnzgLs2BKgcJYxJvZxSLo83fZtiWA8Qa1ezbICIyomdn2AydMJ/rL5pPAA==
X-Received: by 2002:a2e:b009:: with SMTP id y9mr7842316ljk.119.1597708267275;
        Mon, 17 Aug 2020 16:51:07 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id h6sm5368826ljg.86.2020.08.17.16.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 16:51:06 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v1] mfd: core: Fix double-free in mfd_remove_devices_fn()
Date:   Tue, 18 Aug 2020 02:50:48 +0300
Message-Id: <20200817235048.24577-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pdev.mfd_cell is released by platform_device_release(), which is
invoked by platform_device_unregister(). Hence mfd_remove_devices_fn()
shouldn't release the cell variable. The double-free bug is reported KASAN
during of MFD driver module removal.

Fixes: 466a62d7642f ("mfd: core: Make a best effort attempt to match devices with the correct of_nodes")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mfd/mfd-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index c3651f06684f..c50718e3db58 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -370,8 +370,6 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 	regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
 					       cell->num_parent_supplies);
 
-	kfree(cell);
-
 	platform_device_unregister(pdev);
 	return 0;
 }
-- 
2.27.0

