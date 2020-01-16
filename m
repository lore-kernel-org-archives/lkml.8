Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81811C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520002072E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218134;
	bh=++ih1uuZ0bYBKz46Wt4vma2E5KK7w5eA52Hcw2OUv70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TW7iG4dvc8iGxkalqWsBlBrrTb3SqNPto0Opqqsz9yi5URZZghb9HdkKPlD/avuOj
	 rE9oePp9dSsAs7auXhzh9kgENqriVgDWyIHWIVxAEfpuY+BsYQgKGSJ5cn06KDWTPG
	 HKywEF2ZZICPGl/jORAgR+znzIt2xTw4VLawIZzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388263AbgAPX0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:26:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:56772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389043AbgAPX0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:26:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4399220684;
        Thu, 16 Jan 2020 23:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217180;
        bh=++ih1uuZ0bYBKz46Wt4vma2E5KK7w5eA52Hcw2OUv70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SnPhcSdYWIhPLM/FHT4+kA4PCQ0GBzj12eTR9BFqTFaJPy/Rzd1nLAq2Gr4aAikGd
         XzyuZ3PQGe4apamQuB1NuY0ypCxsAwONK1BB5TkZDhwuyg5b8loEHBb23t2/VlyF1N
         tWM5i+5orOWXIPtP7ABThvejjqXk5pXFUH69VBJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5.4 180/203] rtc: bd70528: Add MODULE ALIAS to autoload module
Date:   Fri, 17 Jan 2020 00:18:17 +0100
Message-Id: <20200116231800.144113702@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

commit c3e12e66b14a043daac6b3d0559df80b9ed7679c upstream.

The bd70528 RTC driver is probed by MFD driver. Add MODULE_ALIAS
in order to allow udev to load the module when MFD sub-device cell
for RTC is added.

I'm not sure if this is a bugfix or feature addition but I guess
fixes tag won't harm in this case.

Fixes: 32a4a4ebf768 ("rtc: bd70528: Initial support for ROHM bd70528 RTC")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Link: https://lore.kernel.org/r/20191023114711.GA13954@localhost.localdomain
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rtc/rtc-bd70528.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/rtc/rtc-bd70528.c
+++ b/drivers/rtc/rtc-bd70528.c
@@ -491,3 +491,4 @@ module_platform_driver(bd70528_rtc);
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
 MODULE_DESCRIPTION("BD70528 RTC driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platofrm:bd70528-rtc");


