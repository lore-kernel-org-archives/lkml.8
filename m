Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DCAC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 23:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB6F2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 23:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gv89tcQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgDVXIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 19:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725846AbgDVXIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 19:08:09 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439A4C03C1AB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 16:08:08 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g2so1563003plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 16:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ArROpAk6/OFm/ez5Uo9l28XbbULD17tF98w60ra2Vi8=;
        b=gv89tcQPRXlNJNGrQiV+m2G9DKOjCc262kmlFxBszHuzeoiWhdWG4OCqmk/sedBKcg
         JTzVVOWZbOaY8bT/G6OnfXSvcLYKs5A3bSrZ/AdqRQVLB/LOnnBIMWr8lFLF4T6+Xtn8
         RxSEPKqBtxIHv8OLiqZ4JGP93yBKqwHslN7EUMUL9ee1a3ouosAeGCBYGi+t13BqJUaW
         Si7dSAssE4mf94jaXp1Pe30gfv3zqOYXQOOlRd3DwPdS41y6/FfEyEaJWMA2Mih253m8
         yR0JNTQN+r7PazhMj+GKXwXKXTrC5pG68j/Oqd7B4Ka2PxD5eDDoBDJ7MffPGVvK1nNf
         THug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ArROpAk6/OFm/ez5Uo9l28XbbULD17tF98w60ra2Vi8=;
        b=hxomXDYWDYIH6o07MEtg+5vfqRxHJkRBPavzzPOAhakPAgIJE5aOME5GJUIFWe7POi
         xYJX0mk5t0rNdaL1FK40o+cV3XKt7BMw8s/+iNl9uX+ZmkFuguit4MnMOAMWiW2aWlZA
         FDEdCdAEwTQGEt7ha1HyLfknrF75ngRN/wuhocYOjWuCLwEdrZBWstDrmkR1jkvGxuFw
         Xf3G4aa+I8ldhtgCAAQzclqotdXlzEw8OP/xvQRGcfPuGP3dpkktSc6U4lOPu4giIfsH
         5M6BnUqrVmXZJuUUTfKUk7UNf789a8PR+pJnfJeCt77Z5os0jmQ1G0JvKFL1WcbUYJ+y
         BBSw==
X-Gm-Message-State: AGi0PuYpKMV6Bfw/Z8P1vNMWjT8TdSHbRisVMZaFUo70DNnRDTKjFzqC
        xdxCayN3jFq6RzniJ7enQVmtJw==
X-Google-Smtp-Source: APiQypKdavy8VuGj9OPbA1SloQuWUfYm9s+txwLnuKWP2L4onHGFPWc6YXuPxnjY8GMYtNzb9G3Gqw==
X-Received: by 2002:a17:902:784c:: with SMTP id e12mr984699pln.191.1587596887624;
        Wed, 22 Apr 2020 16:08:07 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p62sm554472pfb.93.2020.04.22.16.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 16:08:06 -0700 (PDT)
Date:   Wed, 22 Apr 2020 16:08:33 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alex Elder <elder@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [GIT PULL] remoteproc fixes for v5.7
Message-ID: <20200422230833.GA2112870@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rproc-v5.7-fixes

for you to fetch changes up to c2781e4d9bc6d925dfc1ff833dfdaf12b69679de:

  remoteproc: mtk_scp: use dma_addr_t for DMA API (2020-04-16 15:53:15 -0700)

----------------------------------------------------------------
remoteproc fixes for v5.7

This fixes a regression in the probe error path of the Qualcomm modem
remoteproc driver and a mix up of phy_addr_t and dma_addr_t in the
Mediatek SCP control driver.

----------------------------------------------------------------
Alex Elder (2):
      remoteproc: qcom_q6v5_mss: fix a bug in q6v5_probe()
      remoteproc: qcom_q6v5_mss: fix q6v5_probe() error paths

Arnd Bergmann (1):
      remoteproc: mtk_scp: use dma_addr_t for DMA API

 drivers/remoteproc/mtk_common.h    |  2 +-
 drivers/remoteproc/mtk_scp.c       |  6 +++---
 drivers/remoteproc/qcom_q6v5_mss.c | 33 ++++++++++++++++++++-------------
 3 files changed, 24 insertions(+), 17 deletions(-)
