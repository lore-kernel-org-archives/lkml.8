Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32223C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 19:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 109E4206E9
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 19:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q67Y0Hwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHBTJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 15:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgHBTJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 15:09:30 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0BAC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 12:09:30 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o18so36413625eje.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 12:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2ZdTJGdfMkugWUUlFCnGJvt+G+wKnuQhA+92KpbVTOY=;
        b=Q67Y0HwgPZDjo/j7CtNy/dpI8cFR0nezF7HSoiAknIjLo4Vw0hmSEntR3koa0O/K0m
         jPqd72OuOzJKsm0mIdvYgRuivhbvzjeevkSr5jicp7wKp8Mu/g2Tq6tgALRFrI1HInz8
         FlERi6FsQMWBLk6ifVG+T4Rv0bGH7QvT5W/XIvZFs22w/OjzyQYrnHjPsddTLOfHoMVk
         YR32c8hC3e8YU4XAOH0LR3NnUYKT4FP6ibRLo6S1+By3YlSNrn7ATbQT1KvP1S+JXtML
         oqbMgptbMjxbXcfbbYwIghphfEPkyxvdexQ+EktV6+C02DVQuYfHiv3HrnBdxMTHDYjm
         PUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2ZdTJGdfMkugWUUlFCnGJvt+G+wKnuQhA+92KpbVTOY=;
        b=hUJ1CIuEDwMC9KuULwtblrqrdT4923+KFR1BGX+uXJ/Xx/vO2J35ouUfgSI/qBoYiH
         DyGGnMnMQDT+ZbS/FwvaDqgiGKTO9TbyqSU8HH7oiWX/jHXi1e1J8rtAE0MNGSkbWaz4
         JSg+uavpVLg6FSlP1Pa05mzcPZQSGoGDmOnDi4PLj1pthm03wRc7Mkz8ad6YVl3N9vR+
         zYEWYv6k36hyfzM4YRzaPN3ao44xb6Whk+1ASgVw8CuEEXZZTYCEqTIkBkYxfUBIDlh9
         fwavSdpG8x1GcwvidJykLLhho+6RvV7kmdIlanySiFeLZcH63EW/OF6y9NjbwpidaV9T
         lHhg==
X-Gm-Message-State: AOAM531Nflf6igYlfzmC+zb6N/cyelNzC1pmUPNwkt5mLngxmv+trjrH
        L94egprt0i5afNy6Q5I42oU=
X-Google-Smtp-Source: ABdhPJzdLlT35Uan3irAk0q96AMsAocSIt/5jV5mbOwFkAzbRZJi2BIOP7YqPxbqqFOoB3qQGaLf3Q==
X-Received: by 2002:a17:906:7a16:: with SMTP id d22mr13779348ejo.478.1596395369103;
        Sun, 02 Aug 2020 12:09:29 -0700 (PDT)
Received: from localhost.localdomain ([2001:8f8:1821:5abb:3429:e2f4:15c4:b960])
        by smtp.gmail.com with ESMTPSA id x16sm2724349edr.25.2020.08.02.12.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 12:09:28 -0700 (PDT)
From:   Mohammed Rushad <mohammedrushad@gmail.com>
To:     gregkh@linuxfoundation.org, vkor@vkten.in, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, john.oldman@polehill.co.uk,
        yanaijie@huawei.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: os_dep: fix brace coding style issue in sdio_intf.c
Date:   Mon,  3 Aug 2020 00:39:24 +0530
Message-Id: <20200802190924.19964-1-mohammedrushad@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch to the sdio_intf.c file that fixes up an incorrectly
placed brace found by the checkpatch.pl tool

Signed-off-by: Mohammed Rushad <mohammedrushad@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 5b1392deb0a7..f1e2829a19a7 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -15,8 +15,7 @@
 #define dev_to_sdio_func(d)     container_of(d, struct sdio_func, dev)
 #endif
 
-static const struct sdio_device_id sdio_ids[] =
-{
+static const struct sdio_device_id sdio_ids[] = {
 	{ SDIO_DEVICE(0x024c, 0x0523), },
 	{ SDIO_DEVICE(0x024c, 0x0525), },
 	{ SDIO_DEVICE(0x024c, 0x0623), },
-- 
2.17.1

