Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437C7C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A95A20784
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585730213;
	bh=1XYIZp3uXSzw6Rbv2PqKuepQw6ibS/RezQqfYs3N4GQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iOIoiw9lzJY6X9k5z2cpzq7RGTxYtx+qza8tSTTX+YSGwN/qjoOrXHGAI++5BiSTd
	 trRlZq1/1VyY8cvgeZJ+ws4X+jpjtDcJtYqxlyWg8xki1BZ1yku7kSIUA200Z6hrua
	 T7pkXdbtSYfnpRs3NvyufLTDFWW2dr6qQl3MzyHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgDAIgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:36:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgDAIgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:36:51 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE63C2073B;
        Wed,  1 Apr 2020 08:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585730211;
        bh=1XYIZp3uXSzw6Rbv2PqKuepQw6ibS/RezQqfYs3N4GQ=;
        h=From:To:Cc:Subject:Date:From;
        b=I7dLV/V5NycExHfqTXnYyGUtOngTPUHar9EcwbTG5NczZkh9DLgW1lgYs7UiUH/6h
         JrXNu5P7e/VwK1ixkRYMvF3bGr9hMuTUGVfIRbjEJ25wlCcVzIVbYwR1sAf2g10adK
         T1SQ0loNGYJjAvDz+1PVy6IDzPggrKT1rv4YqvQU=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jJYrg-00HRQl-N8; Wed, 01 Apr 2020 09:36:48 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Mubin Sayyed <mubin.usman.sayyed@xilinx.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip fixes for Linux 5.7, take #1
Date:   Wed,  1 Apr 2020 09:36:27 +0100
Message-Id: <20200401083627.432564-1-maz@kernel.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, michal.simek@xilinx.com, mubin.usman.sayyed@xilinx.com, sfr@canb.auug.org.au, jason@lakedaemon.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's a small additional pull request, reverting two patches
that break a number of old PPC platforms. Given that Linus'
tree is currently broken, I'd appreciate if you could send this
his way as soon as possible.

Thanks, and apologies for the breakage.

	M.

The following changes since commit 771df8cf0bc3a9a94bc16a58da136cad186cea27:

  Merge branch 'irq/gic-v4.1' into irq/irqchip-next (2020-03-24 12:43:47 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.7-1

for you to fetch changes up to 4cea749d56bec9409f3bd126d2b2f949dc6c66e2:

  Revert "irqchip/xilinx: Enable generic irq multi handler" (2020-04-01 09:12:24 +0100)

----------------------------------------------------------------
irqchip fixes for Linux 5.7, take #1

- Partially revert Xilinx changes that break PPC systems

----------------------------------------------------------------
Marc Zyngier (2):
      Revert "irqchip/xilinx: Do not call irq_set_default_host()"
      Revert "irqchip/xilinx: Enable generic irq multi handler"

 arch/microblaze/Kconfig           |  2 --
 arch/microblaze/include/asm/irq.h |  3 +++
 arch/microblaze/kernel/irq.c      | 21 ++++++++++++++++++++-
 drivers/irqchip/irq-xilinx-intc.c | 35 +++++++++++++++--------------------
 4 files changed, 38 insertions(+), 23 deletions(-)
