Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B33C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEE120772
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DRqp7xKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgCYLea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:34:30 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40697 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgCYLe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:34:29 -0400
Received: by mail-lf1-f68.google.com with SMTP id j17so1457550lfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 04:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GygzIdLieGBXLHn6ARjh7cxx6yFmsNHIRCvqZUoEcYs=;
        b=DRqp7xKN9hAEg0yzoACoL1sqSGt2zkuiC8T/kc3khyd5AU7yPm9TzjP9g64Lfnx0eV
         IhR3tdxeoYYwlcecjzbXSLbsGvsQ80B5x/pe2vK+cKy97E4y4MlXheTXRvDwOcTVpb54
         uPvIKuS2eopieWOxV6LYZthn3rlPGYobpYqAxc4g09nnk02DRFaiSasWr+QeggEGBirs
         uskLdv0pYvdYCYNvKmCAzzxGP5NKeNL/P+SD9dr8Ze/keCsGXnzPB2yDQDKTFcOcBkFA
         cGUbVY78QaEcXGchRKeR/OFkguB+lq1BvGOpXwl+7dwCxVD6mcOpV1IN5lopIzPW//94
         giOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GygzIdLieGBXLHn6ARjh7cxx6yFmsNHIRCvqZUoEcYs=;
        b=P1axsVsBd7dUrb3BbhAEcb3flWfF/VVeJ4v1EFHl33K/DAhkEvz6NTgqjquiqcjy+n
         3QiKrQDv6l36MS/j3iZbFxgyFBwsq1/SUS4xPlm9zgocxiwuerD+Y+6EqlGGE7SW3dyY
         iXJIvuiZ81yEY4AEY6C4VOFxMgQBcZ4m9XZni0XdSj/RzEADaPT6RX9UwnLILvKO6W+w
         s0msLu5TbO2w7l5Q3BHQ45OSw7S4I8z4WNE5XVJMXed9qfN6wy67bZRZHUvjpYwwFN/G
         IGj6/+C9hLvr5WbzXrR+5r3yf150R/rnLkXsrcanjJB6FqSO6YGivWjUMl9l0UBxYjr4
         xxIQ==
X-Gm-Message-State: ANhLgQ0Ke6ub4zoDA135jL3DgAbBnesnvMX3B/mFZ08bqHr9tCc5pWRw
        cYULso0xnDpy9cV/0nfYj7my7g==
X-Google-Smtp-Source: ADFU+vtnjU4L34iNseu0oH29xgbKLOULZjfBlZISdEH9KJSXiDUGagFRm4SrzXiL2Hzwl8XydqOIRg==
X-Received: by 2002:a19:ca12:: with SMTP id a18mr604115lfg.213.1585136067038;
        Wed, 25 Mar 2020 04:34:27 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id v22sm3920009ljc.79.2020.03.25.04.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 04:34:26 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/2] amba/platform: Initialize dma_parms at the bus level
Date:   Wed, 25 Mar 2020 12:34:05 +0100
Message-Id: <20200325113407.26996-1-ulf.hansson@linaro.org>
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

The series is based on v5.6-rc7.

Kind regards
Ulf Hansson

Ulf Hansson (2):
  driver core: platform: Initialize dma_parms for platform devices
  amba: Initialize dma_parms for amba devices

 drivers/amba/bus.c              | 2 ++
 drivers/base/platform.c         | 1 +
 include/linux/amba/bus.h        | 1 +
 include/linux/platform_device.h | 1 +
 4 files changed, 5 insertions(+)

-- 
2.20.1

