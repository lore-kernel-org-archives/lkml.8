Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CDAC3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6692051A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXiGF5EE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgBDLEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:04:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35055 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgBDLEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:04:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id b17so3086988wmb.0;
        Tue, 04 Feb 2020 03:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LH0FNJvIh7ah/abeeVlmbqU6/AZ1uZnmc0FpxP5KFE4=;
        b=iXiGF5EEa8dVjns+ecBX2Y5L6JJB5ARBlFf0QwqH3ttHJQSPgpNV8nJzTLSa0SKNXS
         g6shAerO8QRM7v/Sne7tkawaUdjMqhIkIfGFJgBBfOABTfR++Xv8+32JplsbeLrY/TYG
         MSqRj6ttof9ICP9ulzOt2fsfFaysMGl0uPPMwpvkFSXuSxrVcjByFjAJBNL/4iYU4geF
         iYu861agzKNeAxi++Z6wWQTPjEyYkX0bM5EUBJScnW8elZpI6NvsNd0+14cy4kyyfoNA
         KMk72DRnRnLl8IYrWehstt0qwwIs3QqotaBpnvFgJC/B38EeJg9o+ePmoj4mqJsWtrkH
         2K/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LH0FNJvIh7ah/abeeVlmbqU6/AZ1uZnmc0FpxP5KFE4=;
        b=c175VMjl3/M5MTEPt716ea4/64RRVsMtYoJdFQorjlikPXUGaZzxalCdKHC622uaED
         ec09sVW3qN44fXCN9buCjU1kJ70wZHzpgnHwllsTkLMEDdLtt4Zs/9/1DFiU2YbZB/O5
         UyQ81O0/vqLSN3428LrbACdGhtCk9s3GgWi9c7qB/jNviA7OFI6rNvADvo8Esnnyibo5
         kc2uS9hFA0D9z2LKeSQOMma35A930TzOojBga5S9zYSD/9LZGuBQpNE0xTXdGp1tPV6q
         CYD5vR27M3/JQYCQ5ZgX8AaPI+jzrcmnftcFVyoWU0KvQI2ADIYTRfZ4PA9sMRstY7Px
         1PMQ==
X-Gm-Message-State: APjAAAWC4TpLcNVbEUHbrXBwy94gTn9QaweKRlwRH2JqJ+85kVvmwjlj
        RCRbcVwSg7dZFSdo8XBhbvFm+bB+JoQ=
X-Google-Smtp-Source: APXvYqz6DCoGmD3pUv7die/yuXDbPH2zkZ5cqHTiVCVSW8SLRKfVJhYFUY2gIztfmzMFosfxR0zmkQ==
X-Received: by 2002:a7b:c190:: with SMTP id y16mr5352493wmi.107.1580814269526;
        Tue, 04 Feb 2020 03:04:29 -0800 (PST)
Received: from localhost.localdomain (p5B3F65E4.dip0.t-ipconnect.de. [91.63.101.228])
        by smtp.gmail.com with ESMTPSA id y185sm3476935wmg.2.2020.02.04.03.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 03:04:28 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add regulator support for mpq5416
Date:   Tue,  4 Feb 2020 12:04:16 +0100
Message-Id: <20200204110419.25933-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in V2:
  - fixed review comments for device tree bindings, removed $ref because
    regulator is a container for ldo & buck
  - modified MAINTAINERS common match "mps," bindings document

This patch series add support for PMIC regulator driver for Monolithic
Power System's MP5416 chipset. MP5416 provides support for 4-BUCK
converter, 4-LDO regualtor, accessed over I2C.

Thanks,
Saravanan

Saravanan Sekar (3):
  dt-bindings: regulator: add document bindings for mp5416
  regulator: mp5416: add mp5416 regulator driver
  MAINTAINERS: Add entry for mp5416 PMIC driver

 .../bindings/regulator/mps,mp5416.yaml        |  78 ++++++
 MAINTAINERS                                   |   3 +-
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mp5416.c                    | 245 ++++++++++++++++++
 5 files changed, 336 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
 create mode 100644 drivers/regulator/mp5416.c

-- 
2.17.1

