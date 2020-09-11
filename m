Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244CEC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D481421D92
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599827334;
	bh=914AXHHF1pcwoNLbnq4/GwP/fsygqhgElNH78N/CrjI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ACKia5bq81sY359k8Tz/azAbtDkIALcf7h6+2GsCxhvwFVAKCcbIV4Ut5U1geUo2p
	 zd0SOboEGy7GYrTgUQRzdwJX+t8pFz75DEqtl6q5xbFPtBn6hyZbZoyU+BFnZxlkqA
	 IBtvhMF1Q39C1SW8RtUA8BscU1RgcwK2YcF6hca8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgIKM2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 08:28:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgIKMXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:23:36 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31C272078D;
        Fri, 11 Sep 2020 12:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599827015;
        bh=914AXHHF1pcwoNLbnq4/GwP/fsygqhgElNH78N/CrjI=;
        h=From:To:Cc:Subject:Date:From;
        b=CxBMczqxyAuwc3i1JJk5ihEI3HNS0IFmQJ7xdmRHnoYx56FQ4rrwGQf+NDNmBmj7/
         kK833qa3RV3xEJPSJOFm2f5h0bFxWfEPPYSvpLBqSupmDD2Yuyddj1lfXsSbta6Tu3
         r6IC5PtiE9/pLHKeoZckYOaNL7kW1FiKDPZc+AzE=
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.9-rc4
Date:   Fri, 11 Sep 2020 13:22:39 +0100
Message-Id: <20200911122335.31C272078D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8cb61d65b1c8d5bc5b37ebab498ca2f78d264ddb:

  Merge series "spi: stm32: various driver fixes" from Alain Volmat <alain.volmat@st.com>: (2020-08-10 19:55:35 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.9-rc4

for you to fetch changes up to c170a5a3b6944ad8e76547c4a1d9fe81c8f23ac8:

  spi: stm32: fix pm_runtime_get_sync() error checking (2020-09-09 15:11:44 +0100)

----------------------------------------------------------------
spi: Fixes for v5.9

There's some driver specific fixes here plus one core fix for memory
leaks that could be triggered by a potential race condition when
cleaning up after we have split transfers to fit into what the
controller can support.

----------------------------------------------------------------
Dan Carpenter (1):
      spi: stm32: fix pm_runtime_get_sync() error checking

Gustav Wiklander (1):
      spi: Fix memory leak on splited transfers

Marek Vasut (1):
      spi: stm32: Rate-limit the 'Communication suspended' message

Vignesh Raghavendra (2):
      spi: spi-cadence-quadspi: Populate get_name() interface
      spi: spi-cadence-quadspi: Fix mapping of buffers for DMA reads

Vincent Whitchurch (1):
      spi: spi-loopback-test: Fix out-of-bounds read

Vladimir Oltean (1):
      MAINTAINERS: add myself as maintainer for spi-fsl-dspi driver

 MAINTAINERS                       |  8 ++++++++
 drivers/spi/spi-cadence-quadspi.c | 17 ++++++++++++++---
 drivers/spi/spi-loopback-test.c   |  2 +-
 drivers/spi/spi-stm32.c           |  8 ++++++--
 drivers/spi/spi.c                 |  9 +++++++--
 5 files changed, 36 insertions(+), 8 deletions(-)
