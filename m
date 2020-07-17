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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B3AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0117920775
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdcOdGCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgGQPXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgGQPXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:23:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD269C0619D2;
        Fri, 17 Jul 2020 08:23:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z13so11579033wrw.5;
        Fri, 17 Jul 2020 08:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Me2WHbUTpgnRM4D8kqx7FmbTflTfMafU7MOjlibIhCA=;
        b=mdcOdGCftCAR0C1l8D/cd1tWkMlYByjyNrxpQy2kCcTJqYGjZZHJY8Qi716jiVMX7a
         +PY3w5rcs+7M91IFVWLIqWtGAtxC5aRqAR+aDCmyuf6sXCwKTfaefjlTfeiv68KcMHkp
         pKOM99e6s7ECI8/wKhamNZYbAgmmRQFpBkRY9zdEPi7dLQpO8MXaXfZp95xqx6Iqu/IP
         +SM8pGIP33/1LJtPAsL52PyPJLvRm0XkAFup9IKL1rU7uSMg01QEokuTcSUlwZJtHrqn
         G2dk5kGaY/XT4aZhGvcq2VGprs4V+nSDuVYhUdv0o+2MYQTP8HKMWoDOyttJYyoZCrFv
         f3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Me2WHbUTpgnRM4D8kqx7FmbTflTfMafU7MOjlibIhCA=;
        b=UlCMELahOS0gkF6l6YBEwLeZ0bckZghX44LlNXeJuj1kc/D5t525AqYB/5RMmLi9or
         QEagpKui7OLSBkzDSP7YDy5ojwB4CBrR27wBWXHoJwQkYKviEnRfMxD3Eol2aMvvEVtk
         1ewySBou4HA5f5pI9G6yiOO8B1m8j7bhQy88/9nsMpkT/WEieSbxsEpy19HoqkMbbOrG
         1embYZhksOuLJzObl9f4zA11ncEYsSaWEFCRTuRYWS59NJqqGIPfwoGuuzayFGBkaYn6
         bZR2x/Bi3sfuL29x9Gfgi8retIpRTto2Ifuc5+kfLrk2GenkmQJ2ofMHbNpWa2j7PUCk
         wVhw==
X-Gm-Message-State: AOAM53248FuJHrYFS6JG1VJ/oG8LoanbAk9CtgUV48zBkgz6jvq+ruyp
        RXID8rt5gWF8aVPTo/3rgtXM9p8y
X-Google-Smtp-Source: ABdhPJwQwuHQ0dRfUDPFK85UD+bnKPMNyv73bwn7Ovu78ySabgeDS4V2QzqH3x5xjPBUKxcR1Q/+fA==
X-Received: by 2002:adf:dc90:: with SMTP id r16mr10921301wrj.264.1594999430177;
        Fri, 17 Jul 2020 08:23:50 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id a22sm13431051wmb.4.2020.07.17.08.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 08:23:49 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        devicetree@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Subject: [PATCH 5/7] usb: bdc: driver runs out of buffer descriptors on large ADB transfers
Date:   Fri, 17 Jul 2020 11:23:05 -0400
Message-Id: <20200717152307.36705-6-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717152307.36705-1-alcooperx@gmail.com>
References: <20200717152307.36705-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version v1.0.40 of the Android host ADB software increased maximum
transfer sizes from 256K to 1M. Since the STB ADB gadget driver
requests only 16K at a time, the BDC driver ran out of buffer
descriptors (BDs) if the queuing happens faster than the incoming
16K transfers. This issue is fixed by doubling the number of BDs
that can be queued so that the entire 1M request can be queued
without running out of buffers.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/usb/gadget/udc/bdc/bdc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc.h b/drivers/usb/gadget/udc/bdc/bdc.h
index 6e1e881dc51e..ac75e25c3b6a 100644
--- a/drivers/usb/gadget/udc/bdc/bdc.h
+++ b/drivers/usb/gadget/udc/bdc/bdc.h
@@ -44,7 +44,7 @@
 #define NUM_SR_ENTRIES	64
 
 /* Num of bds per table */
-#define NUM_BDS_PER_TABLE	32
+#define NUM_BDS_PER_TABLE	64
 
 /* Num of tables in bd list for control,bulk and Int ep */
 #define NUM_TABLES	2
-- 
2.17.1

