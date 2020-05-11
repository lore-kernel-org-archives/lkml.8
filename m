Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7DAC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ECCA20736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FmXOD1Bn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbgEKOu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 10:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729688AbgEKOu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 10:50:56 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AFCC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 07:50:56 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so11347938wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 07:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9GOPX57g2MztmXU+yX5lewA2PGYreWeDlYTtgbj/IiQ=;
        b=FmXOD1BnYa8PAsLd0mpXvQmrZAU1Lh65cIwUkcvvZVYWFwSqN9rCejWftfQIX0YEBk
         d81GvAvxyE0uxTSdST4sKjINWAPNAOg8x1PIgrJj8GbQT113ReSPpWuxi0F2EcelBeTK
         rbtalc8jFiJe/0wWOOAPqeoVm7JOS6AMV4XFh2t5lrIEZ4Cww+VAtWvL157RMcoZ1ccc
         SqR+5EJj17PvDvw9Srwyx1oXdCcycySY2VYiFH01CsCIIfig1pPJWJz27mgHR41UOml8
         hS8lYD5yFODUm/XbqsfY/6Ebc8to6tW+Pl+4lOe1jqPgrrMN05w0TztBukCWUTD9JHdv
         fCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9GOPX57g2MztmXU+yX5lewA2PGYreWeDlYTtgbj/IiQ=;
        b=Pwoqo42OPJXHYG9gq6KGq00Nqn3Qw63ZbEJdzt3npWpIsOwiGx63vkhXiMQwoLCmUh
         /FjM5UeH+j1G5lEFC0yvN0X2Od4E07nUwQeVo7LRxm6/ajA9+s0QPZELJujiQHpYh2v6
         jeB3UI81NhvufpNhHKCPB74lQBUOX/RL6voI9xONhCXskTyKPdw+SFe4oOlXIxuRXi4V
         q6YZFXJXYqarPLCUphgTH8moXj+Ep4YLOojK9jsHybtdZGKlmQPzDbV2sEr9S5H8sP7p
         RYFkKYAkO504x0Vvo72+x+8A/r1MXfC35MiVNpOwmQ7p2eO/c2Kd05XX/wOeUOMxrK12
         A0mA==
X-Gm-Message-State: AGi0PuYg4HPoKyA0xlNXMZkS0CEPe+UL1x0jpFp4SbZ2EUyL+UGv13+a
        FiOcXuxe/dbe+B50i2jgGGl+klPeqGM=
X-Google-Smtp-Source: APiQypJMIZWOVHsMwLzn0+moQJlqujZ/GQ2rrv823pV+QWdAIIoWkF4MLw+TFF2tZQuAQvAPaHO3aA==
X-Received: by 2002:adf:8b45:: with SMTP id v5mr20850667wra.175.1589208655284;
        Mon, 11 May 2020 07:50:55 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id 33sm18512983wrk.61.2020.05.11.07.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 07:50:54 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3] nvmem: patches for 5.8
Date:   Mon, 11 May 2020 15:50:39 +0100
Message-Id: <20200511145042.31223-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some nvmem patches for 5.8 which includes two trivial
code cleanups and one fix to drive write-protect pin for all usecases.

Can you please queue them up for 5.8.

Thanks,
srini

Anson Huang (1):
  nvmem: imx-ocotp: Improve logic to save many code lines

Michael Auchter (1):
  nvmem: ensure sysfs writes handle write-protect pin

Samuel Zou (1):
  nvmem: jz4780-efuse: Use PTR_ERR_OR_ZERO() to simplify code

 drivers/nvmem/core.c         | 52 ++++++++++++++++++------------------
 drivers/nvmem/imx-ocotp.c    |  9 ++-----
 drivers/nvmem/jz4780-efuse.c |  4 +--
 3 files changed, 29 insertions(+), 36 deletions(-)

-- 
2.21.0

