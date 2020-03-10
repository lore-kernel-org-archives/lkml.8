Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8FEC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFE3222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QyQ5OuAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgCJNXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:23:32 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:39712 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgCJNXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:23:31 -0400
Received: by mail-wr1-f52.google.com with SMTP id r15so10800715wrx.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FRdcUkChFP73CYf+Z4biQyn+H2NRrY9pLjMDRNYo9tg=;
        b=QyQ5OuAwtnFtO+rzxR9TwzIq3V4BxejuzULD5FX2U7mPjWYVDKzoOha/TPpoqCdWjV
         3m2p79yqiNcO4tW1EFP9AL7hBG7DZEBoQ1g8aBaGaHcCa+vVkBAiF3LQ7YeAGcwykSfG
         SJQLjO4wrL+Zz4/IF/eYXyLV84zkZVyTAh2X9BZiXd6wNns1LgsPOcQU6jWJY4UrKZdV
         gWOSjCxHX46mUs7VQ2w83JsDC3oKbE4nNQkLG8eqcVuisCqHBIH4jsJhK9eWmtNPsy9L
         N6Fcf2z0DhtMg0iPY10PNNvWuQa/kBMjqp1mUJTK/mGu/Y/zNN4E0X1wMyxUotGzwpxW
         eFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FRdcUkChFP73CYf+Z4biQyn+H2NRrY9pLjMDRNYo9tg=;
        b=VgVIyBI8NHOYGCLCDYMIS91X4oVOGRu0Rz+EJxLHhAT803GzI+MGHb+GN8UjpUrg+i
         REbsESif0lFt9vJq87eMVJ9hl/44hAX4XITYmS+rMuiR56YzW7QUidF2jpZE0HUMkD4h
         pgaTe5p7k3wOBnVWMPwC3PkcOO1b2ioI1nbWgBK9mMCaSlcAmjTsszKyad57j1yuyzP1
         Qn3t7JYrLzjZ440iq/FenWJIAHN5inHiwJCsiY9F54Gp2UfCu55gRlPNAzIE7+NV9yBx
         Px++4E4J4zeHiBP/1sH6gfS/ay+pFjkzsna9z9LU8DDqLcADZK2dRkwM8eMwzQV53rtw
         CrwA==
X-Gm-Message-State: ANhLgQ0JEuZCdIpgglHjTqCaM1c5dykQjz0s8hilQmEB1/40kvVI1JF5
        BXOnW+KNkOCoozVoMqXsF/ICwg==
X-Google-Smtp-Source: ADFU+vvYNTEkfMjbpKNQHbWYLz1vKiv/kKkC1gxI0zsBl1Z7EB1nAWwRqDzMwDnWZIARR9zyQCYNgw==
X-Received: by 2002:adf:df8f:: with SMTP id z15mr27121143wrl.184.1583846608939;
        Tue, 10 Mar 2020 06:23:28 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id s22sm3761199wmc.16.2020.03.10.06.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:23:27 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/14] nvmem: patches for 5.7
Date:   Tue, 10 Mar 2020 13:22:43 +0000
Message-Id: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some nvmem patches for 5.7 which includes
- few general cleanups and checks
- gpio descriptor release fixes
- new JZ4780 nvmem provider
- compatible string for i.MX8MP
- add new nvmem_cell_read_u64()

Can you please queue them up for 5.7.

thanks,
srini

Anson Huang (1):
  nvmem: imx-ocotp: Drop unnecessary initializations

Bartosz Golaszewski (3):
  nvmem: remove a stray newline in nvmem_register()
  nvmem: add a newline for readability
  nvmem: fix memory leak in error path

H. Nikolaus Schaller (1):
  nvmem: jz4780-efuse: fix build warnings on ARCH=x86_64 or riscv

Khouloud Touil (1):
  nvmem: release the write-protect pin

Nicholas Johnson (1):
  nvmem: check for NULL reg_read and reg_write before dereferencing

Peng Fan (1):
  nvmem: imx: ocotp: add i.MX8MP support

PrasannaKumar Muralidharan (3):
  Bindings: nvmem: add bindings for JZ4780 efuse
  nvmem: add driver for JZ4780 efuse
  Documentation: ABI: nvmem: add documentation for JZ4780 efuse ABI

Srinivas Kandagatla (1):
  nvmem: core: validate nvmem config before parsing

Yangtao Li (2):
  nvmem: core: add nvmem_cell_read_common
  nvmem: core: add nvmem_cell_read_u64

 .../ABI/testing/sysfs-driver-jz4780-efuse     |  16 ++
 .../bindings/nvmem/ingenic,jz4780-efuse.yaml  |  45 ++++
 drivers/nvmem/Kconfig                         |  12 +
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/core.c                          |  83 +++---
 drivers/nvmem/imx-ocotp.c                     |  29 ++-
 drivers/nvmem/jz4780-efuse.c                  | 239 ++++++++++++++++++
 drivers/nvmem/nvmem-sysfs.c                   |   6 +
 include/linux/nvmem-consumer.h                |   7 +
 9 files changed, 397 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-jz4780-efuse
 create mode 100644 Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml
 create mode 100644 drivers/nvmem/jz4780-efuse.c

-- 
2.21.0

