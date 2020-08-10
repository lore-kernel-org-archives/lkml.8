Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE22C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 04:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD0620756
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 04:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="eq43nKPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgHJEdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 00:33:44 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:15139 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgHJEde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 00:33:34 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BQ34W5brcz5m;
        Mon, 10 Aug 2020 06:33:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597034012; bh=rIF0nogV4x1mhyvkPCRrFXs5W4aZY5wkfcrNu+VP314=;
        h=Date:From:Subject:To:Cc:From;
        b=eq43nKPgCutWB+r1u1XJmT0LvHiGvRFcSpfLtHAMLj6wlkVOvHiA2PUW+UAj//LaJ
         oQUVlzCZmZAJ7LpmGe5SWq8i3kAB0wLz5Irho0u9jKzvlf+UzJ1Xyc3TRckiaDRMFI
         j7ItM676chrACTdF//nIxMyndlab/rJxgx2DT9ZcJfe+/P87bd5ASks1PunGYjt4cG
         8mdx/QVQqHau6XwEDCl88PIVE2D/anDmqUJzjEpkG7cMh+4G7NsGFE50EvdidWfIPZ
         izIwzQiNg5C4FGoWeW35eqAxYi5U+OwfoSAle3SJE2DF2MHVS26NNCLMplZf7oBbRQ
         TI/G1fswMGS0A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Mon, 10 Aug 2020 06:33:30 +0200
Message-Id: <cover.1597032945.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 0/3] regulator: unexport regulator_lock/unlock()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes regulator_lock/unlock() calls around
regulator_notifier_call_chain() as they are redundant - drivers
already have to guarantee regulator_dev's existence during the call.

This should make reasoing about the lock easier, as this was the only
use outside regulator core code.

The only client that needed recursive locking from the notifier chain
was drivers/usb/host/ohci-da8xx.c, which responds to over-current
notification by calling regulator_disable().

Michał Mirosław (3):
  regulator: don't require mutex for regulator_notifier_call_chain()
  regulator: remove locking around regulator_notifier_call_chain()
  regulator: unexport regulator_lock/unlock()

 drivers/regulator/core.c               | 11 +++--------
 drivers/regulator/da9055-regulator.c   |  2 --
 drivers/regulator/da9062-regulator.c   |  2 --
 drivers/regulator/da9063-regulator.c   |  2 --
 drivers/regulator/da9210-regulator.c   |  4 ----
 drivers/regulator/da9211-regulator.c   |  4 ----
 drivers/regulator/lp8755.c             |  6 ------
 drivers/regulator/ltc3589.c            | 10 ++--------
 drivers/regulator/ltc3676.c            | 10 ++--------
 drivers/regulator/pv88060-regulator.c  | 10 ++--------
 drivers/regulator/pv88080-regulator.c  | 10 ++--------
 drivers/regulator/pv88090-regulator.c  | 10 ++--------
 drivers/regulator/slg51000-regulator.c |  4 ----
 drivers/regulator/stpmic1_regulator.c  |  4 ----
 drivers/regulator/wm831x-dcdc.c        |  4 ----
 drivers/regulator/wm831x-isink.c       |  2 --
 drivers/regulator/wm831x-ldo.c         |  2 --
 drivers/regulator/wm8350-regulator.c   |  2 --
 include/linux/regulator/driver.h       |  3 ---
 19 files changed, 13 insertions(+), 89 deletions(-)

-- 
2.20.1

