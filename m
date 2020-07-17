Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42423C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13789207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595000588;
	bh=1YCbDeYacEe/f/OP4BR3Y6rKkZXeo/f2bFT0SQfnj64=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ScyCoxMIIe8+t80K3TVSnxIh5MWCMoGm/22hpRaHE57hgliJKSx7jsBa5Dyvl8SHp
	 hdSjsZdeXhguWwu+ULzneAhjB32Z5cg9crRjKL2ApopG5wPOm3DuZ+QeXJxPdymSLW
	 87t8pToxh5FAwtonDXAeHgAlqf6p6FYRxpz/nrLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgGQPnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:43:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgGQPnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:43:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA4DF207DD;
        Fri, 17 Jul 2020 15:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595000586;
        bh=1YCbDeYacEe/f/OP4BR3Y6rKkZXeo/f2bFT0SQfnj64=;
        h=From:To:Cc:Subject:Date:From;
        b=n+c/PVr/Mmrkb57zloyD23y7cOLZlzoT0N/zwSomO0VGrNnfSCc6VWeGgxidmDTue
         xcqLfuWJfkg0JmCVRLmysSjptQ6O63754CeEvDCZXMSGW5YUjkU36UJIPAsHpn/Ngk
         towbe80i1ZXsu1TthbcTrDYZ+NZo0/2F0v+IYmL0=
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.8-rc5
Date:   Fri, 17 Jul 2020 16:42:54 +0100
Message-Id: <20200717154305.AA4DF207DD@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1b3bcca2085865c1facfbea9baf2f5cde5dc15e4:

  regulator: mt6358: Remove BROKEN dependency (2020-06-17 13:01:19 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.8-rc5

for you to fetch changes up to 412847fb47336c58885ac6231a5f34ac7ac862a0:

  MAINTAINERS: remove obsolete entry after file renaming (2020-06-29 18:14:20 +0100)

----------------------------------------------------------------
regulator: Fixes for v5.8

The more substantial fix here is the rename of the da903x driver which
fixes a collision with the parent MFD driver name which caused issues
when things were built as modules.  There's also a fix for a mislableled
regulator on the pmi8994 which is quite important for systems with that
device.

----------------------------------------------------------------
Konrad Dybcio (1):
      regulator: qcom_smd: Fix pmi8994 label

Lukas Bulwahn (1):
      MAINTAINERS: remove obsolete entry after file renaming

Seth Forshee (1):
      regulator: rename da903x to da903x-regulator

 MAINTAINERS                                        | 1 -
 drivers/regulator/Makefile                         | 2 +-
 drivers/regulator/{da903x.c => da903x-regulator.c} | 0
 drivers/regulator/qcom_smd-regulator.c             | 2 +-
 4 files changed, 2 insertions(+), 3 deletions(-)
 rename drivers/regulator/{da903x.c => da903x-regulator.c} (100%)
