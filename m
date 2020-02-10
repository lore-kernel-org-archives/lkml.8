Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB84CC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A765D2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l+T5X3Wh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgBJRSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:18:30 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54175 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgBJRS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:18:29 -0500
Received: by mail-pj1-f67.google.com with SMTP id n96so20526pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 09:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=29xLBkG6ZsGvvZoV6NquOYgL0DhsT5ED6pKhcVtl/rI=;
        b=l+T5X3Wha8PqXHaprTLj3dBFJ8ltPC3PyxWqpmP216h0uk6KKDfRXq2kQ1VTiuNYJ9
         AnVlBbEKS1U45FgVnY9ruwuW8eY1HVyD+JQwE2xy7hORgQ+p14ehknBMwSDtvfoyh7Pp
         Y4hxaQ7T4iC3dDN9MXG+fOkE1jPmW4L0gQDz94dYd8wvkt0TkDCQddDmpbOWp3VpMCuV
         l6UJGFWaBxiFdv6/FSTTW14aL/hbgNvntg7ucPrQQi/rBj351apxJKTBd66Bwsiw2fqA
         GefCUSFiSPWZYndOjdIrMTwDMcNo4ill1gYqPB1sZJLUGZjDP0COBXQmja/dDU78csrE
         FKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=29xLBkG6ZsGvvZoV6NquOYgL0DhsT5ED6pKhcVtl/rI=;
        b=FDPMc6idTJaZ74HtzGNpqxjwAG9kR67iibf5LMNfQas7DeITD12egJRE2/kisDmGJ2
         r1upjjw8AJNdHiGRvzwE0qBRwBiFmeUk3IpwbHK43Mb3BEhFsS+9QLQifP8cEu80T97Z
         t1bg4HY1ooEk1q52obP4D68DkmRg5ms2jYRq5PXkR4iyureazLPQgfFvuqJKccIOulAe
         6G49no+EtWmtKkopOWHgB4p2J4kBx0o7kzu5jDsrffBX5tEAHC9uteS8T8UIE/e936WM
         24EfIoIbb7XLkQHafVtzSEqFK12FHf4yOBoLKAaqBadq4iGW/C8wx2QHGa1Nha8IV2Sy
         UTZA==
X-Gm-Message-State: APjAAAVc0rV37CPUMvXcjCO5gsVh532ESLdWfnyAy/YLB6Qnac39Moj2
        uGWxbrFXcsD5ZI48af7WxreQU9BpBAE=
X-Google-Smtp-Source: APXvYqyNmiA1Sf8vj3Zf3miE+vqfT90qjkUFTIkGqrjiiF01+UeKO5rOY7tmO4+P5cQ/hEnrAGnm7A==
X-Received: by 2002:a17:902:b587:: with SMTP id a7mr14047693pls.82.1581355109073;
        Mon, 10 Feb 2020 09:18:29 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id u12sm927912pfm.165.2020.02.10.09.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 09:18:28 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [stable 4.19][PATCH 0/3] stable: Candidates for 4.19.y
Date:   Mon, 10 Feb 2020 10:18:24 -0700
Message-Id: <20200210171827.29693-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please consider for 4.19.y - applies cleanly on 4.19.102.

All three patches are already in 5.4.y so no need to apply them there as well.

Thanks,
Mathieu

Boris Brezillon (1):
  spi: spi-mem: Add extra sanity checks on the op param

Brandon Maier (1):
  gpio: zynq: Report gpio direction at boot

Shubhrajyoti Datta (1):
  serial: uartps: Add a timeout to the tx empty wait

 drivers/gpio/gpio-zynq.c           | 23 +++++++++++++
 drivers/spi/spi-mem.c              | 54 ++++++++++++++++++++++++++----
 drivers/tty/serial/xilinx_uartps.c | 14 +++++---
 3 files changed, 81 insertions(+), 10 deletions(-)

-- 
2.20.1

