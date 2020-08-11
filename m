Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66BBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 753DA20748
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="AxIyVi7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgHKBHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 21:07:40 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:11787 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbgHKBHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 21:07:39 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BQZST3tp3zL3;
        Tue, 11 Aug 2020 03:07:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597108057; bh=9e3feEKulY/dNznrJIBuGuIp9LBvzdzl+EChhD0C2kw=;
        h=Date:From:Subject:To:Cc:From;
        b=AxIyVi7HtkOc4TumEdGJc61VbVulfdxMr4feWkRNP/AyASxPaktt1qcgNVDefzcx3
         R4PWA0h2ZLP+qmHyJT3LBLM6PCC22DLSg6XM8EsiPwdJAvceZ+o/VFsyml2Lmtd1Lg
         r7roQig0WT82jnFJBi4DBp2lQFWhzIh7eetTKj7XdyfMTBdLvUZaDLkq5ECs5n/IOu
         CQBKEXPhmcoye9GMzdCLs1opaINPLTOOr3hFaS8nF9irQXJE3zq4k9ti/N4z9dIMVG
         10X13MjPrOMeTM1F717pOBVuftg00gGzKqCjKWXrvEngqswo4OtSVRF7kwJisxXJx1
         0urYqXD6lr7Vg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Tue, 11 Aug 2020 03:07:34 +0200
Message-Id: <cover.1597107682.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 0/7] regulator: fix deadlock vs memory reclaim
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For systems that have eg. eMMC storage using voltage regulator, memory
reclaim path might call back into regulator subsystem. This means we
have to make sure no allocations happen with a regulator or regulator
list locked.

After this series I see no more lockdep complaints on my test system,
but please review and test further.

First four patches move allocations out of locked regions, next three
came as a drive-by cleanups.


Michał Mirosław (7):
  regulator: push allocation in regulator_init_coupling() outside of
    lock
  regulator: push allocation in regulator_ena_gpio_request() out of lock
  regulator: push allocations in create_regulator() outside of lock
  regulator: push allocation in set_consumer_device_supply() out of lock
  regulator: plug of_node leak in regulator_register()'s error path
  regulator: cleanup regulator_ena_gpio_free()
  regulator: remove superfluous lock in regulator_resolve_coupling()

 drivers/regulator/core.c | 162 +++++++++++++++++++++------------------
 1 file changed, 86 insertions(+), 76 deletions(-)

-- 
2.20.1

