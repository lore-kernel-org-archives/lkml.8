Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5078BC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F0C20774
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586857916;
	bh=UjAhtjsT9rMrkz4Nk/bCMqZ4k1bEVfRcJ4ozupVxmNU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=uzxTFvoOSFBmn66gg4Ur7fQ+q98P6F2opjxRxLshqsFgqTAYfIvcM3fBPSq5jQNAK
	 qtHfFY7JiSYvT/2kgJd7NxkbfJrBQ7xQfkqOHRFy70CzOvrHkBmzr8yeUT+gWqJOlq
	 +7pSIps+YOJVNCC21BeBw18FdjpSdvsF1pTNkB6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438002AbgDNJvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:51:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437931AbgDNJuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:50:20 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C3272072D;
        Tue, 14 Apr 2020 09:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586857819;
        bh=UjAhtjsT9rMrkz4Nk/bCMqZ4k1bEVfRcJ4ozupVxmNU=;
        h=From:To:Cc:Subject:Date:From;
        b=FkdEBg58ZembEkKLyFNmOM6x5hbkt0evo5m40h9TeX5R33VL9j0/g0IQ8EM5cioJ5
         AZ40YFxPIDPWN0GKPHoPSmd2E+QhjHEBo2DVyxFvoF6fWpxWxuH335dWnk8K+TV7ri
         23z0WKJ5ZGWC3egja4Yvnk5aN9SnPdWk8dGY9gA0=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jOICv-0036Cw-P9; Tue, 14 Apr 2020 10:50:17 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Zenghui Yu <yuzenghui@huawei.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/2] GICv4.1 fixes for 5.7
Date:   Tue, 14 Apr 2020 10:50:11 +0100
Message-Id: <20200414095013.2821418-1-maz@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, yuzenghui@huawei.com, eric.auger@redhat.com, jason@lakedaemon.net, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a couple of GICv4.1 fixes for issues that have been found
during the 5.7 merge window.

The first one implements the "Dirty+Valid" feature, where the
hypervisor can wait for the GIC to have finish parsing the VPT before
entering the guest. The feature was optional in GICv4.0, but is now
mandatory in GICv4.1, so let's take advantage of it.

The second patch fixes an issue where the kernel shouts about the
effective affinity of VSGIs not being updated, which is the absolute
truth. Let's fix it.

I plan to send these fixes as part of a bigger pull request for -rc2.

Thanks,

	M.

Marc Zyngier (2):
  irqchip/gic-v4.1: Add support for VPENDBASER's Dirty+Valid signaling
  irqchip/gic-v4.1: Update effective affinity of virtual SGIs

 drivers/irqchip/irq-gic-v3-its.c   | 20 ++++++++++++++++++++
 drivers/irqchip/irq-gic-v3.c       | 11 +++++++----
 include/linux/irqchip/arm-gic-v3.h |  2 ++
 3 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.25.1

