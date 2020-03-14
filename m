Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50F6C1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E3320578
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584239071;
	bh=kNjWWFHcWwZVWCXm90WyCgrVQq1EsdBwg9y6RA30dQA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XxeF1OW+RjEIUGnAWzQ9DjL7jIItBiQ5DOgwFRm6QnsL+5akDw5tYMeTZVZp1YH7s
	 TgXDV/vDETO2NS28iypVwMMsWLFZVOFEbEX7do5Y02OnmDSna67le9XkYcP6Y2y38o
	 ucn5o38aqUjWIkMWVa2uNwt5mNCP/ebC8jf4PrRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgCOCYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:24:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbgCOCYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:24:12 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C2B320768;
        Sat, 14 Mar 2020 10:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584181806;
        bh=kNjWWFHcWwZVWCXm90WyCgrVQq1EsdBwg9y6RA30dQA=;
        h=From:To:Cc:Subject:Date:From;
        b=CDiWb53zp6W/g7Xhr+SfRFbEkL5S0tGtmAFhC4f942Vc+mWxa9E1KxEOBMOAgbh9W
         e89Y62H36O28yx1jbAnhC09MOSsQjRgUs2ck5lFVJPn1WwzYADidQqudwHesqqJN0r
         1KYSDB7p920e0uZk3H9csIs6sKbQUE2xQ/u7pkug=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jD43Q-00CgAB-Bo; Sat, 14 Mar 2020 10:30:04 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Salter <msalter@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip fixes for 5.6, take #2
Date:   Sat, 14 Mar 2020 10:30:00 +0000
Message-Id: <20200314103000.2413-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, catalin.marinas@arm.com, msalter@redhat.com, rrichter@marvell.com, tharvey@gateworks.com, jason@lakedaemon.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

This is hopefully the last irqchip update for 5.6. This time, a single
patch working around a hardware issue on the Cavium ThunderX and its
derivatives.

Please pull.

	M.

The following changes since commit 5186a6cc3ef5a3fa327c258924ef098b0de77006:

  irqchip/gic-v3-its: Rename VPENDBASER/VPROPBASER accessors (2020-02-08 10:01:33 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.6-2

for you to fetch changes up to d01fd161e85904064290435f67f4ed59af5daf74:

  irqchip/gic-v3: Workaround Cavium erratum 38539 when reading GICD_TYPER2 (2020-03-14 10:15:19 +0000)

----------------------------------------------------------------
irqchip fixes for 5.6, take #2

- Add workaround for Cavium/Marvell ThunderX unimplemented GIC registers

----------------------------------------------------------------
Marc Zyngier (1):
      irqchip/gic-v3: Workaround Cavium erratum 38539 when reading GICD_TYPER2

 Documentation/arm64/silicon-errata.rst |  2 ++
 drivers/irqchip/irq-gic-v3.c           | 30 +++++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)
