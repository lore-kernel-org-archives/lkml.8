Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1DEC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1099B24677
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IZRJrLu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgCBXNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 18:13:52 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:21108 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgCBXNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 18:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583190831; x=1614726831;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AGqPkTKe6UEXeLLRbH5vhOJ55qI3COFWkFGnJ1Hvl2A=;
  b=IZRJrLu6Qx2qiqH93EvjvS4g7N2dYCazcw7uCyLv2smRqy136r8FMVH0
   gksEfJwjLTLg+TQ8pSlvSMtftFPIzS5MAZn3xEEKWXV5sgK2cuCL1i1cS
   mY2jlu2lnzvH7klyMjPV1oPaTwYuw6B1vd2sqzpzyw1ZbxB77/jAxkqBO
   3i6Ko7eybuC+pmeocjgTAKtNiZVqnEbY/vm/65Bhj4sZ3/IcHCt0WlWkM
   g83Q6p8Jo/02eY+CPboQc1Pq946JvFmKkttus4ZQW92d0WtBgIMBJ40yb
   LLB09N7cbK3KEkJtAVXDiLbcD8wEghWE8209HX0ifNpts6pxHN/Hu99QE
   A==;
IronPort-SDR: Yny6UzCsnE6h1MVKxLbhRe3keIcYm+bNAEL2+qI3UhSQFTnAVQiMu9xHXmdCZL1Cr7mqnZMKyM
 9PcQzeMMyG3UxZDyWKuAPlSCXmYwGVseqULIi/N/DZfQPWm6e5yiZzBjCS7ySbsX5kH/IoZyoX
 iXkNhOIDppBy832NCGwjvrUpbKcofNOb5Iv57z9y10gbOJ++H5QadwYaCaIVc1hOXV5qRSbIor
 BY+NLtzMNUNp1ksR6rMFf2v3Bepepa/1wZcQC4wfUYN1C70aG+/AnHMaM+fKmm8hME3cQFI4CS
 RS8=
X-IronPort-AV: E=Sophos;i="5.70,508,1574092800"; 
   d="scan'208";a="131708407"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2020 07:13:51 +0800
IronPort-SDR: FVvFnga86vJNAg52eJOm3LTAnn5MUOzMeNRjDodCZI4doFRajTKZxSbfKfZ5Iy7zUw6pjeQ/S+
 ShFOhIafI8Pk+ng8q6uGeni7YSwZqi9ig1HhYvZOb/SNGg4KtSKn4i3DbLD86YW+7E0+KW7MHI
 HQNwG+3EVfstYiz6VSYEwbhwp/jo4aEDIXmmSLJLifYfsovYrPyEf7/pf/+AjFxrXnB+dGNZ7w
 Hb10XlAcaxKHgmiXV8KRNxhFC54mnHeOOhidNFGhJCqRAIZ30/qLa2jP0VV3GaOSetukOM4WtT
 EvpvVNfoBtb2IFmJRVHe7DtD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 15:06:07 -0800
IronPort-SDR: mqEq2MevqO9o2882QUhs/dzrhYoOweLKrDEouviGDeX58NS0lglPclveQfXS8xGa6YXGvbVHUZ
 zxP+yo1cwYQ+nPhMAV6yFGR0XyfQpIj6w5qDvOlEO1D0LX/SDgbD82HVbbtuaMOa53kloIOXJX
 6ogck5Fykqyf3IcDZnOwewDaHdh7BzumvbmJMf0J6Jh2xnyBBnP8I8maHNnG5hw5QNdDGiX5oi
 T0ACYnWkjRfufF5RfRuz0DMK4/Z1skuqR403z8YKDQHLEIkWXonZ0RViKQMSLdgolxfg1WC+31
 Tp0=
WDCIronportException: Internal
Received: from usa002267.ad.shared (HELO yoda.hgst.com) ([10.86.54.35])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Mar 2020 15:13:50 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Anup Patel <anup.patel@wdc.com>, Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-riscv@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Steven Price <steven.price@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v3 0/2] Improve PLIC functionality
Date:   Mon,  2 Mar 2020 15:11:44 -0800
Message-Id: <20200302231146.15530-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds following PLIC functionalities

1. Enable/disable interrupts only on cpu online/offline events.
2. Support multiple PLIC nodes in the device tree. This is required
for multi-socket platforms such as OmniXtend.

The 1st patch was originally part of the CPU hotplug series[1]. It is added to
this series now to keep all the PLIC related changes together.

Rebased on top of 5.6-rc4.
 
[1] https://patchwork.kernel.org/patch/11407379/

Atish Patra (2):
irqchip/sifive-plic: Enable/Disable external interrupts upon cpu
online/offline
irqchip/sifive-plic: Add support for multiple PLICs

arch/riscv/kernel/traps.c         |   2 +-
drivers/irqchip/irq-sifive-plic.c | 119 +++++++++++++++++++++---------
include/linux/cpuhotplug.h        |   1 +
3 files changed, 87 insertions(+), 35 deletions(-)

--
2.25.0

