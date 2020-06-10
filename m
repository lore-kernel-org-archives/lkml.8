Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7F1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C2982064C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTBcIDFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgFJHrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgFJHr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:47:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3E9C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:47:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id m2so551381pjv.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gLuhd6tdN3osSGldQdu8FSvPjVUNRzIBfkIzjxRON30=;
        b=RTBcIDFSlsBO/gTklgX52us+4FVF4a/zA63Q1ngU5WKQK6MpsG2gfqgwd5VJgQtewz
         WxA+UcylbNeobEq03f4YdSVn/T/hZmmkyfUnfVZCDtNqdu/3+xhwnYGB367HC7qf6g/O
         Asd2Mm0ejDP2Y9cjdYslpGYQRL38ZxKlNBbGyXKfsf/lB9D/cidyrauysPut5YhRuZ1P
         63v69yE6Z070vSG3kL7hxarjy4zbs6gGOdrhb839GNaj+K1NUTJ4O7vD6RDrV2NsW+0E
         3INqHgANStyYT50my8gNFqpUkfBhnus8MpWOCx8PDTagPwTQeiy/tQksk1ZZWOpIc0wH
         i4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gLuhd6tdN3osSGldQdu8FSvPjVUNRzIBfkIzjxRON30=;
        b=Xi/FSg4zTBA+0QKcLU0rY379RwSuxNQe/0OwdN9XdqZn4CSl8bX9d27aP8rtDHM3wJ
         tzB42wWeN7+xQDXXq27RXRouwRxVagMqpBAXPXrvYJAq48qRMW3k0LquUVyLQIOOvQUb
         x7mpPfsWzkimSXdwBWjCUrIC/NsUsPV3iwKcHoiGWFrg1DRX+/DHVu1PxNGXH0ZbTqFu
         NGA4Atod/xUFOpf0AptyfRc5PvJanicXSlFfT+AzLtxVGTZOpQX+eHj9VvbgeDLDJbFT
         D8OsY65FxyThXokZcimqMlFldzSplrtyDFybbdx0y2fsgNXf/+sK104ZfQMEpDEkTcWy
         QI/w==
X-Gm-Message-State: AOAM53363HymeFzOON0NI+VQvKTHtRSl9U0WOmFNlOc+QwhcPUcWQnDV
        y0HNxoq7SRf6yAHzkyNYVJl4
X-Google-Smtp-Source: ABdhPJxYY6cmDXukFQtcpn41RRQIipDImlNiQc3P5dsyM4ucQHMpZ12HtNQhBpIMsqqWBWKC9mABHA==
X-Received: by 2002:a17:902:6ac1:: with SMTP id i1mr2007731plt.147.1591775245349;
        Wed, 10 Jun 2020 00:47:25 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:630f:1dba:c41:a14e:6586:388a])
        by smtp.gmail.com with ESMTPSA id u1sm10075040pgf.28.2020.06.10.00.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 00:47:24 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@martin.sperl.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 0/6] Add Microchip MCP25XXFD CAN driver
Date:   Wed, 10 Jun 2020 13:17:05 +0530
Message-Id: <20200610074711.10969-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds CAN network driver support for Microchip MCP25XXFD CAN
Controller with MCP2517FD as the target controller version. This series is
mostly inspired (or taken) from the previous iterations posted by Martin Sperl.
I've trimmed down the parts which are not necessary for the initial version
to ease review. Still the series is relatively huge but I hope to get some
reviews (post -rcX ofc!).

Link to the origial series posted by Martin:
https://www.spinics.net/lists/devicetree/msg284462.html

I've not changed the functionality much but done some considerable amount of
cleanups. This series has been tested on 96Boards RB3 platform by myself and
Martin has tested the previous version on Rpi3 with external MCP2517FD
controller.

Thanks,
Mani

Manivannan Sadhasivam (1):
  MAINTAINERS: Add entry for Microchip MCP25XXFD CAN network driver

Martin Sperl (5):
  dt-bindings: can: Document devicetree bindings for MCP25XXFD
  can: mcp25xxfd: Add Microchip MCP25XXFD CAN-FD driver infrastructure
  can: mcp25xxfd: Add support for CAN reception
  can: mcp25xxfd: Add CAN transmission support
  can: mcp25xxfd: Optimize TEF read by avoiding unnecessary SPI
    transfers

 .../bindings/net/can/microchip,mcp25xxfd.yaml |  82 +++
 MAINTAINERS                                   |   8 +
 drivers/net/can/spi/Kconfig                   |   2 +
 drivers/net/can/spi/Makefile                  |   2 +
 drivers/net/can/spi/mcp25xxfd/Kconfig         |   5 +
 drivers/net/can/spi/mcp25xxfd/Makefile        |  11 +
 .../net/can/spi/mcp25xxfd/mcp25xxfd_base.c    | 177 +++++
 .../net/can/spi/mcp25xxfd/mcp25xxfd_base.h    |  14 +
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.c | 538 ++++++++++++++
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.h |  52 ++
 .../can/spi/mcp25xxfd/mcp25xxfd_can_fifo.c    | 305 ++++++++
 .../can/spi/mcp25xxfd/mcp25xxfd_can_fifo.h    |  16 +
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_id.h  |  69 ++
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c | 674 ++++++++++++++++++
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_int.h |  18 +
 .../can/spi/mcp25xxfd/mcp25xxfd_can_priv.h    | 144 ++++
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_rx.c  | 233 ++++++
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_rx.h  |  18 +
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.c  | 653 +++++++++++++++++
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.h  |  86 +++
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_cmd.c | 226 ++++++
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_cmd.h |  84 +++
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_crc.c |  31 +
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_crc.h |  15 +
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_ecc.c |  74 ++
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_ecc.h |  16 +
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_int.c |  71 ++
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_int.h |  15 +
 .../net/can/spi/mcp25xxfd/mcp25xxfd_priv.h    |  50 ++
 .../net/can/spi/mcp25xxfd/mcp25xxfd_regs.h    | 661 +++++++++++++++++
 30 files changed, 4350 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
 create mode 100644 drivers/net/can/spi/mcp25xxfd/Kconfig
 create mode 100644 drivers/net/can/spi/mcp25xxfd/Makefile
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_base.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_base.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_fifo.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_fifo.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_id.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_priv.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_rx.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_rx.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_cmd.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_cmd.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_crc.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_crc.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_ecc.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_ecc.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_int.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_int.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_priv.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_regs.h

-- 
2.17.1

