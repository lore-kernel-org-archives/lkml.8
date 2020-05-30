Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487F2C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 12:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27367207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 12:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="eW2X1W2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgE3MMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 08:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgE3MMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 08:12:38 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FCAC03E969;
        Sat, 30 May 2020 05:12:38 -0700 (PDT)
Received: from localhost.localdomain (unknown [142.147.94.151])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 59D582049D;
        Sat, 30 May 2020 12:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1590840755; bh=R7e/lLuhIwTLBmpeCCmWO3wYYEAI25FSKZglWnBA+ng=;
        h=From:To:Cc:Subject:Date:From;
        b=eW2X1W2V4ZHKfXp9K/Mi6uoXL8RdKo73klpTzerFopEXxrbdn/BykYbQu7B75Bxkx
         TZ4+k+j5rsvoAGOAx92FYIvSjpTHhgxhDlN1xDrypE3ZGwjZ5YvYH/LSvNmWo5AwbG
         pImFHn+/kjltEq1JfQBbts3ltuInqx+tb3jmS476HXjrJCkarTn2gb9aDbVTmGXa+4
         dzulu5+fcV0j/nctwLr4BNQ8WWiXNJOtMTe7RHHU/kuryIvaxVg4VQyNn9ptQqg0+u
         T1COkdhXjcQBWcBScWwmkU8JdY2MA6ORUT5GGhlPM/htBRux+0k6QlLMTuZ0vKhrrz
         8mN0VccYvIWIQ==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     maz@kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Huacai Chen <chenhc@lemote.com>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH 0/2] irqchip: loongson-*: Two small fixes
Date:   Sat, 30 May 2020 20:11:11 +0800
Message-Id: <20200530121113.1797678-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.27.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jiaxun Yang (2):
  irqchip: loongson-pci-msi: Fix a typo in Kconfig
  irqchip: loongson-*: Fix COMPILE_TEST

 drivers/irqchip/Kconfig                | 2 +-
 drivers/irqchip/irq-loongson-htpic.c   | 4 ++++
 drivers/irqchip/irq-loongson-htvec.c   | 4 ++++
 drivers/irqchip/irq-loongson-liointc.c | 4 ++++
 4 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.27.0.rc0

