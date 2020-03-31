Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AA3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC2020786
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AgqKOg0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgCaSiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:38:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44884 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCaSiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:38:50 -0400
Received: by mail-lf1-f65.google.com with SMTP id j188so18216051lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 11:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A1iR82JLy2QBCOT69varWy2T5A5xF9bW9JJAjBNZYtw=;
        b=AgqKOg0Xlsg+qGXoQ+t9zCBNScJcIVnuGn7QUcnP5aj8K6e742Rcu/EaX9dFEgNWBB
         vLt6fu6VOygerOifBdA6nnhB4ysDtUoC0P1DJFSqfuuPpywvC25BwJBpffeJCIkJh8dG
         tLUkc/jZQ3hFDfS/dw7P10lHqjs5yx7744a4h8kR+4682zw7JntAP1hQJza4+5Ku02jb
         dNvog8Zyo5wsM5AASjRnI3cy5WnI9Gu7ncfLGtjv7HYWKTm2pQkdxBZaLHwLhXV4Ye05
         5DmXFtwrhnbuUCpWEJdx7hpJvwEYTEu/5k+jNUlVf3VrzgCLx9kpqwanVLH5BWTzIS1P
         mdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A1iR82JLy2QBCOT69varWy2T5A5xF9bW9JJAjBNZYtw=;
        b=NBWWmu8XaTI6DDdemscOuShL2kR8p0GkBeokIORildsi0xWO2Fk1jzquW/7l8xqOT/
         yMPI+IWiiGCtzcLkVbzWk0M4M9SOK9qgAA6kWUkhP334rSGlseYCxE/rk7LjEQ57yP+p
         w8487VTE4CzgyGWUkcu6XsnMcTbv7rmPILK3z0up4O8C4Kv7rci+q1o6LFMMrv5NtWoV
         jGSfIfhpqEJZDXEunfUv9h18iW9GIe8zCW0dBdCyR6oBeTRyG+Xch28mM33Lct9xMr/g
         7RvxRcK+7703ecAkRUMKG93oa3zTh2Ng6ybZtNxiBQSCx1QYtvW4RcTXCP4tDAeRieNS
         Cr1A==
X-Gm-Message-State: AGi0PuZOo8okFkNZbZzPTY1graJkjqReNruq/YaVF8MFUBQBKQXywVQ2
        +zZt+SIlOjkhn0qZN+1oLB6zMQ==
X-Google-Smtp-Source: APiQypKRx83jRA3vthxlvydh1YZb4WXvAun13NnHXa386ryuuWqw8NWW/Vu8GQtNCFg8UW/MxqPqog==
X-Received: by 2002:a19:a409:: with SMTP id q9mr12183993lfc.71.1585679928748;
        Tue, 31 Mar 2020 11:38:48 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b28sm10331849ljp.90.2020.03.31.11.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 11:38:47 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Vinod Koul <vkoul@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 0/2] amba/platform: Initialize dma_parms at the bus level
Date:   Tue, 31 Mar 2020 20:38:42 +0200
Message-Id: <20200331183844.30488-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's currently the amba/platform driver's responsibility to initialize the
pointer, dma_parms, for its corresponding struct device. The benefit with this
approach allows us to avoid the initialization and to not waste memory for the
struct device_dma_parameters, as this can be decided on a case by case basis.
    
However, it has turned out that this approach is not very practical. Not only
does it lead to open coding, but also to real errors. In principle callers of
dma_set_max_seg_size() doesn't check the error code, but just assumes it
succeeds.
    
For these reasons, this series initializes the dma_parms from the amba/platform
bus at the device registration point. This also follows the way the PCI devices
are being managed, see pci_device_add().

If it turns out that this is an acceptable solution, we probably also want the
changes for stable, but I am not sure if it applies without conflicts.

The series is based on v5.6.

Kind regards
Ulf Hansson


Ulf Hansson (2):
  driver core: platform: Initialize dma_parms for platform devices
  amba: Initialize dma_parms for amba devices

 drivers/amba/bus.c              | 1 +
 drivers/base/platform.c         | 2 ++
 include/linux/amba/bus.h        | 1 +
 include/linux/platform_device.h | 1 +
 4 files changed, 5 insertions(+)

-- 
2.20.1

