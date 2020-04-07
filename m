Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0FFC2BA1B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A3C20719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="B+xIf7Lr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgDGIaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 04:30:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33474 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgDGIaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 04:30:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so2872691wrd.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 01:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bjnqIOw/64UQcMVXxP2HD9T2UIEtrKARcLY/HHXuepw=;
        b=B+xIf7LrFVj/ug5XH1E/s6FhhIXn71JDZDAtx7pUHGPzZ285a1FcD58Mq98o3Zhhb3
         2dcf+apBwPnaTla0J+J+W3uP3bHomuQMPzdqkHMj1A5T/DjrGlvBgd8MVa0+UDNv73mR
         J0iXUHGAizCSurnz6QFQHPYnfFq+JqHN1sWH8gCntQXXthgv+orE435eRnkAyous8NoK
         pvOX0X1Ole1qobSOudaRsdYsfXT/evwkaKN2y207fivB1lfKZbOo0tb/Rzo56fVsmaFd
         2vfNCX5OwcJvYSQAiwE8IJCojx7VS8Novt6RRc3GpDvtRgivGmbzf6WsCUC8JUpERADr
         33kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bjnqIOw/64UQcMVXxP2HD9T2UIEtrKARcLY/HHXuepw=;
        b=ae+leR+5v/VTNhP1GE4HSxFxSVfyPteL5bffjtx4NvUpK1oO0JNc6a5w6orC9mwSna
         /ZSZbxCuashfxCdJo63fPO2veSWnsMVQXGSy8Dz5K3QsDjSiY91TwdxBVV2UaE3yZ5xt
         iBhn0ti3/28FoqUZR3LyJYbcMJeEgFhiOk6H9AxPkSx3MT9gOiuMuEviELnXI98h4MM+
         ol06R9OA7GNiukxms00bK73kirHmobUQzoQ1lFavhWPV1S/GrPYvnSVcdxIh9cKUTxK3
         ydFJ3bM+P1Ov0a2c9LVkiI42BQ6EAQFnI/6MnQkHOoXothZUNSIgM97Na88l4plrPj7r
         NcLg==
X-Gm-Message-State: AGi0PuYR4pOVxFSX75rjVPM5B7Pj8BDpwaf+yKapgAzuYfISEn5aVjK7
        +5hoYuk5RCaDng14Vmk+rdRWvOhdJoE0culA
X-Google-Smtp-Source: APiQypJ93wNSP368wCVt3Ckg5cs2DoYF36j4Rpl82GUvt99HweZnWg7ZOEqe853jNO0v/H8JAAZqNQ==
X-Received: by 2002:adf:a343:: with SMTP id d3mr1426273wrb.163.1586248214691;
        Tue, 07 Apr 2020 01:30:14 -0700 (PDT)
Received: from localhost.localdomain (ip-94-114-101-228.unity-media.net. [94.114.101.228])
        by smtp.gmail.com with ESMTPSA id t16sm31190743wra.17.2020.04.07.01.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 01:30:13 -0700 (PDT)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     coreboot@coreboot.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v4 0/2] firmware: google: Expose coreboot tables and CBMEM
Date:   Tue,  7 Apr 2020 10:29:05 +0200
Message-Id: <20200407082923.2001556-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

As user land tools currently use /dev/mem to access coreboot tables and
CBMEM, provide a better way by using read-only sysfs attributes.

Unconditionally expose all tables and buffers making future changes in
coreboot possible without modifying a kernel driver.

Changes in v2:
 - Add ABI documentation
 - Add 0x prefix on hex values
 - Remove wrong ioremap hint as found by CI

Changes in v3:
 - Use BIN_ATTR_RO

Changes in v4:
 - Use temporary memremap instead of persistent ioremap
 - Constify a struct
 - Get rid of unused headers
 - Use dev_{get|set}_drvdata
 - Use dev_groups to automatically handle attributes
 - Updated file description
 - Updated ABI documentation

Patrick Rudolph (2):
  firmware: google: Expose CBMEM over sysfs
  firmware: google: Expose coreboot tables over sysfs

 Documentation/ABI/stable/sysfs-bus-coreboot |  74 +++++++++++
 drivers/firmware/google/Kconfig             |   9 ++
 drivers/firmware/google/Makefile            |   1 +
 drivers/firmware/google/cbmem-coreboot.c    | 128 ++++++++++++++++++++
 drivers/firmware/google/coreboot_table.c    |  58 +++++++++
 drivers/firmware/google/coreboot_table.h    |  14 +++
 6 files changed, 284 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-bus-coreboot
 create mode 100644 drivers/firmware/google/cbmem-coreboot.c

-- 
2.24.1

