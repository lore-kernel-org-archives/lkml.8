Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4042BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B90820706
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="R6RIM/sa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgHRMsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgHRMsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:48:39 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF2EC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 05:48:39 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f5so9152393plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 05:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S3wwF18SJPRWddTddR//I693SzjVDLp8OcZwkDYMGWI=;
        b=R6RIM/saupqW+Zak80S0VU4kXW2JBALllnGUhl6RxKT14mI+DsjwExJqSmMJtOB0k2
         Ou0LS437EsXWtWdPWd36a72DFs/M+PbxaUehN2I4S3969kM7GGqZk4b2LkIQzZwgyMHH
         cgb+VkKRMGAN9S4/31V5XBz34W1ou1dUgwAvrJh3ZZ4bun7YbkPDkO4R4D0HwsZHsuQE
         8eBfaFPfsAMq8UM/miaIXxrd/jII1NKozI/mCUGTh+HgKMZXaDpqjM0u6v9YfwR06ZCM
         FjKeWDlLO0hHM7EP8fcUmTg/3p5hRJ6kKUnmigAb2t71Yyq7APEcSbFMjyiteb02Yd6D
         06Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S3wwF18SJPRWddTddR//I693SzjVDLp8OcZwkDYMGWI=;
        b=YIZEzTAc7DIFeAWIlZ8hHoSBsb0ljJ9n3NgS+yUKTt6GN4J2q3+wuUBCVuWXy4TJFg
         SGHe4iLE9JKwk7ju/rhyJYDqVN9PKbHjcnZ4yHTJBefCyZSVX3umhufzdcj2nxAFqvWw
         J7M694ujtwjs6PbJ1KWn8zQHWzFV8aov5sdVZmNcqpJjwb9tEFCur6Y7YC+JtfVwvGzM
         wV53Z8tSfvXMX0NH2SquEbBv5PP/2PlbeWYYrkqPCfAdLA06MVQIzsQwq+QNh2wdryff
         NXTScomrswhk/VW/x0rrcNBlDkLkT0pGo5AaqEEQT5AlWqVUgePnyq6FTYZA+WiUFiX3
         gsUQ==
X-Gm-Message-State: AOAM532Ca9A1rQcYFk8SDw64JBIMeSrTx6BJ+mXl1TPT1nTixJDLQ/jW
        ZmTw3XYnGRCjdEAtHOnegoTr8RtwTjhzAJo=
X-Google-Smtp-Source: ABdhPJy018uHUmfKkM+8cajlBoJS6Y0FPrdtdoa8BE5MPQohtbpOf99zowCPtXJYGDFHdnm6EgSmWw==
X-Received: by 2002:a17:902:d345:: with SMTP id l5mr14325736plk.276.1597754918562;
        Tue, 18 Aug 2020 05:48:38 -0700 (PDT)
Received: from localhost.localdomain ([116.68.79.111])
        by smtp.gmail.com with ESMTPSA id e4sm24264221pfd.204.2020.08.18.05.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 05:48:38 -0700 (PDT)
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, johan@kernel.org,
        elder@kernel.org
Cc:     Vaishnav M A <vaishnav@beagleboard.org>, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com,
        chrisfriedt@gmail.com, zoran.stojsavljevic@gmail.com
Subject: [RFC PATCH v2 0/3] mikroBUS driver for add-on boards
Date:   Tue, 18 Aug 2020 18:18:12 +0530
Message-Id: <20200818124815.11029-1-vaishnav@beagleboard.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This Patch series is an update to the mikroBUS driver
RFC v1 Patch : https://lkml.org/lkml/2020/7/24/518 .
The mikrobus driver is updated to add mikrobus ports from device-tree
overlays, the debug interfaces for adding mikrobus ports through sysFS
is removed, and the driver considers the extended usage of mikrobus
port pins from their standard purposes.

change log:
        v2: support for adding mikroBUS ports from DT overlays,
        remove debug sysFS interface for adding mikrobus ports,
        consider extended pin usage/deviations from mikrobus standard
        specifications,
        use greybus CPort protocol enum instead of new protcol enums
        Fix cases of wrong indendation, ignoring return values, freeing
        allocated resources in case of errors and other style suggestions
        in v1 review.

Vaishnav M A (3):
  add mikrobus descriptors to greybus_manifest
  mikroBUS driver for add-on boards on mikrobus ports
  Add Device Tree Bindings for mikroBUS port

 .../bindings/misc/linux,mikrobus.txt          |  81 ++
 MAINTAINERS                                   |   6 +
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/mikrobus/Kconfig                 |  16 +
 drivers/misc/mikrobus/Makefile                |   7 +
 drivers/misc/mikrobus/mikrobus_core.c         | 692 ++++++++++++++++++
 drivers/misc/mikrobus/mikrobus_core.h         | 191 +++++
 drivers/misc/mikrobus/mikrobus_manifest.c     | 444 +++++++++++
 drivers/misc/mikrobus/mikrobus_manifest.h     |  21 +
 drivers/misc/mikrobus/mikrobus_port.c         | 171 +++++
 include/linux/greybus/greybus_manifest.h      |  47 ++
 12 files changed, 1678 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/linux,mikrobus.txt
 create mode 100644 drivers/misc/mikrobus/Kconfig
 create mode 100644 drivers/misc/mikrobus/Makefile
 create mode 100644 drivers/misc/mikrobus/mikrobus_core.c
 create mode 100644 drivers/misc/mikrobus/mikrobus_core.h
 create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.c
 create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.h
 create mode 100644 drivers/misc/mikrobus/mikrobus_port.c

-- 
2.25.1

