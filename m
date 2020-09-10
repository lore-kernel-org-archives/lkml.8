Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73641C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25C462065E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d2ILA2RX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgIJVfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730943AbgIJNkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:40:18 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D71C061798
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:38:34 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k15so4627918pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JzQxGJ9JAZ+XJ6xMfeqjZSBi1JWeufBUfR8QvhxR6Ew=;
        b=d2ILA2RXwWfKf2hpjWEhVtzEUaCWKdcaSlhAKa/ZSavw/O6roLwxguJh8vFp66iJTA
         etQlP7MSuLrKmvOxSRQ8VuKq0p2XGDIK2ScvhLZdLwFr2vHS6sYjp/gM4OTwuSBFtmC6
         xJdwmY/Upik9w63L0ukrrXlljuKTSxjR41FIxXx6KIkLGE3djxdBwSrfliamzyj/6MjT
         cra674L/E8U19ZNXXs4UoDX8Ft5PGpE22IMGDN+1KHEeJsejdt7oRDprgGXNvEteijLK
         DqFLkzpzp+nCeRIyceatnuytxGDOxBUZEMbETI02lD4qjxsSWymA9vO3PTPumOqpXF74
         QPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JzQxGJ9JAZ+XJ6xMfeqjZSBi1JWeufBUfR8QvhxR6Ew=;
        b=um8sf8wSukGDOixpJFb91lUhVrLEWjQHY4mNb0pZTBVWWjy6O26T9otl7a+gsogFvW
         fe56w2wuPp5q2stTQ1JIdPUuOSzmMWbyReiQ3meRpL0V6swH2FBXvwoq/XTjBhPu+QjQ
         JtWIerJ44JiMG4yuiFLxmpUpqWbhBelYTQxwJRNB1NKch02LAeIC5tqWjtQl2UspLM6O
         RlM/R/v7TYpCdIOd63ERi1dIFMeIzL7ZcmtDo31DOSQogv5gAFK1C7zm3WLON2bh+0Tv
         XQPE2y+3WHKG/QuNRQYJQ6BDPpEmlICHC1OXXK42ylgQOR+vYVn6mAl5cGTLY94sTgJl
         etzg==
X-Gm-Message-State: AOAM532o/pt/Oyxk3lTdsURdJXBPly7rR9/K4/4s9nO9oPwq45yyvhYQ
        K5Wtgff+b5caIQa4GmnG3IyM
X-Google-Smtp-Source: ABdhPJzgg7lFbQmqKPmek/ijOouN0heqEiN0XoCY4AeOPaAnSc8Z0vIErszkKVMt9llJEbz0C6Ljhg==
X-Received: by 2002:a63:4a1a:: with SMTP id x26mr4409669pga.295.1599745098928;
        Thu, 10 Sep 2020 06:38:18 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id o30sm5603801pgc.45.2020.09.10.06.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:38:18 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org
Cc:     linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dev.kurt@vandijck-laurijssen.be,
        o.rempel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/6] Add support for MCP25XXFD SPI-CAN Network driver
Date:   Thu, 10 Sep 2020 19:08:00 +0530
Message-Id: <20200910133806.25077-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series is the continuation of the work done by Marc Kleine-Budde on
adding support for Microchip MCP25XXFD SPI-CAN driver [1]. I've taken the
patches from Marc's tree [2] and posted with an additional MAINTAINERS
patch on top since he seems to be very busy. This series has been tested
on RB5 board featuring MCP2518FD transceiver.

Marc: I'd like to co-maintain this driver in upstream hence added myself
as the co-maintainer. Shout at me if you do not want it! Also I've removed
the v4x tag since I don't think all the versions are posted to mailing
list.

I'll add my review on top of this posting.

Thanks,
Mani

[1] https://www.spinics.net/lists/linux-can/msg03712.html
[2] https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=mcp25xxfd-47

Kurt Van Dijck (1):
  can: mcp25xxfd: add listen-only mode

Manivannan Sadhasivam (1):
  MAINTAINERS: Add entry for Microchip MCP25XXFD SPI-CAN network driver

Marc Kleine-Budde (3):
  can: rx-offload: can_rx_offload_add_manual(): add new initialization
    function
  can: mcp25xxfd: add regmap infrastructure
  can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN

Oleksij Rempel (1):
  dt-bindings: can: mcp25xxfd: document device tree bindings

 .../bindings/net/can/microchip,mcp25xxfd.yaml |   79 +
 MAINTAINERS                                   |    8 +
 drivers/net/can/rx-offload.c                  |   11 +
 drivers/net/can/spi/Kconfig                   |    2 +
 drivers/net/can/spi/Makefile                  |    1 +
 drivers/net/can/spi/mcp25xxfd/Kconfig         |   17 +
 drivers/net/can/spi/mcp25xxfd/Makefile        |    8 +
 .../net/can/spi/mcp25xxfd/mcp25xxfd-core.c    | 2884 +++++++++++++++++
 .../net/can/spi/mcp25xxfd/mcp25xxfd-crc16.c   |   89 +
 .../net/can/spi/mcp25xxfd/mcp25xxfd-regmap.c  |  556 ++++
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h     |  828 +++++
 include/linux/can/rx-offload.h                |    3 +
 12 files changed, 4486 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
 create mode 100644 drivers/net/can/spi/mcp25xxfd/Kconfig
 create mode 100644 drivers/net/can/spi/mcp25xxfd/Makefile
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-crc16.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-regmap.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h

-- 
2.17.1

