Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFFBC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA11C20708
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599717656;
	bh=f4336PWe4WG+RgFNW3zEird+7qZY2uqwhkCQYVRYHFA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DaOf4t8UZrUMLbYE65m1tzIw6b2WA6QC+ftHSTBKpBS5iOhJSx7PLU2Ip7c7mRG1K
	 2QuUvGUNE8vckliDQK/fe1vOoxDu+U3MmOLGxoOeUidftXn4r07VHHmIpfbYpimhZv
	 f6NwHfMGKdxlbXs5JoMH8b2cg//DNevCP53lyyWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgIJGAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 02:00:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgIJGAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:00:21 -0400
Received: from mail.kernel.org (ip5f5ad5ac.dynamic.kabel-deutschland.de [95.90.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE5D2207FB;
        Thu, 10 Sep 2020 06:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599717621;
        bh=f4336PWe4WG+RgFNW3zEird+7qZY2uqwhkCQYVRYHFA=;
        h=From:To:Cc:Subject:Date:From;
        b=FfthQ8EaBV2OAUjOiSg3TekfvtRhCcLOrZK2QUgfUHEpxcIIkyJMwGj5kE0/sHszi
         49Rufqnw0SPEDUM6UBs1XuQt5Ip3YUnYcPxBxx5g56quQxe7zpP0qjv/PkyTsgA9JH
         LVN8GfKzFl6e7eh1xFTe9mWxLWD8PGz1ipPz0Ltc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kGFd4-00E1uY-Ru; Thu, 10 Sep 2020 08:00:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add support for onboard GPIO USB hub for Hikey 960/970
Date:   Thu, 10 Sep 2020 08:00:11 +0200
Message-Id: <cover.1599717402.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both Hikey 960 and 970 comes with an onboard USB hub. On those devices, 
the USB connectors are connected via the hub. 

This patch series adds support for it.

Mauro Carvalho Chehab (2):
  misc: hisi_hikey_usb: add support for Hikey 970
  dts: hisilicon: add support for USB3 on Hikey 970

Yu Chen (1):
  misc: hisi_hikey_usb: Driver to support onboard USB gpio hub on
    Hikey960

 MAINTAINERS                                   |   7 +
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 102 +++++++
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  58 ++++
 drivers/misc/Kconfig                          |   9 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/hisi_hikey_usb.c                 | 274 ++++++++++++++++++
 6 files changed, 451 insertions(+)
 create mode 100644 drivers/misc/hisi_hikey_usb.c

-- 
2.26.2


