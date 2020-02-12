Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD33C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BE420873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="Rd9ZsYVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgBLIkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:40:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35104 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgBLIkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:40:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id w12so1136513wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sh9edya09m3ampotYP3rKXxFWAQAZ1sl203zZxDnubY=;
        b=Rd9ZsYVqBQpLNRN1NUoCJwtgrHIvxjFXbiYEbesFFL+EtggZeSkMBsmX6aQN4sRPqk
         BFm7ziMyioakOHPenVv+pazCq1xMgITET4yi3liedrfDOAYUiIlLzo7E7XNEIvegXUBX
         VVryKZVBrlSDZxSLbfYqPEDFJgSbi3oy3nDXlTZs8GcWdZZwU3frgCCR/swJU89rUorq
         q2MuolQSmMWjjazZ+JadmnTMhsRcwMVWiPPvoHqIzEPRmpPdhSyYd0CI+AdR0i+Jc/rO
         DdIo+gr5eG0/N7R7ER0Wvm5aB55R/zxAvE9YDjWfOqt+5/iPXeOQxA4BGm1SPsdQctNB
         PeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=sh9edya09m3ampotYP3rKXxFWAQAZ1sl203zZxDnubY=;
        b=rqz6kIP1WPT82MZtn5i7hAacp85dacj9XUMhKDiJVeS/hb7WtdYRIDNfmf3pSzbxJ0
         kTqYT7D559RtXnZG43cnuFBVrfma7CXwtIkbf/eXftN2X1t045lbCGfu5S4FnRQRA7B8
         hLMnscVOIo/4l/qGZPrg/17PUoMR2jklTGsyNFHWHWlFm9aJBpTFL/2kAs9y41Y63t3j
         rSmB7V1qT08VoI214F7/naTRrUs/cMQokNaLpcmiaHFNHmtsQAWzrfAZ6Ui3P+eIC33Z
         4s+GV/oIgcyYDb0xKFVXrSeDh821KNeb6KuROnjOX9not2+v60wjGvVNvwZYyXNSHPdy
         SeyQ==
X-Gm-Message-State: APjAAAXzAhAFMXUJLb6sRI9zDMSVfwkVJj98BrGf4jLO+SUfaEOA8oxe
        nMECb/+LUOUJqHu4YMhIFA9cdCNT/cOoyA==
X-Google-Smtp-Source: APXvYqwuS7+TqsdETIEjYnS5F+Hk3WQXvU5tJoIGMYYgCfRi7CqmSIQCIAeJ5eLjixqHvrdhZP54DA==
X-Received: by 2002:a5d:42c6:: with SMTP id t6mr13871376wrr.151.1581496800421;
        Wed, 12 Feb 2020 00:40:00 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id x17sm8482201wrt.74.2020.02.12.00.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:39:59 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>,
        Mubin Sayyed <mubinusm@xilinx.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] irqchip: xilinx: Switch to generic domain handler
Date:   Wed, 12 Feb 2020 09:39:55 +0100
Message-Id: <cover.1581496793.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series is based on cascade mode patch sent by Mubin
(https://lkml.org/lkml/2020/2/11/888 - v3 series).

The first patch is just fixing error patch. The second and the third are
converting microblaze do_IRQ() to generic IRQ handler with appropriate
changes in xilinx intc driver. I have done it in two steps to be visible
how it was done.

The last patch removes concurrent_irq global variable which wasn't wired
anywhere but it stores number of concurrent IRQs handled by one call. There
is option to get it back if needed but I haven't seen it in other archs
that's why I have removed it too.

Thanks,
Michal


Michal Simek (3):
  irqchip: xilinx: Fill error code when irq domain registration fails
  irqchip: xilinx: Enable generic irq multi handler
  irqchip: xilinx: Use handle_domain_irq()

 arch/microblaze/Kconfig           |  2 ++
 arch/microblaze/include/asm/irq.h |  3 ---
 arch/microblaze/kernel/irq.c      | 21 +------------------
 drivers/irqchip/irq-xilinx-intc.c | 35 ++++++++++++++++++-------------
 4 files changed, 24 insertions(+), 37 deletions(-)

-- 
2.25.0

