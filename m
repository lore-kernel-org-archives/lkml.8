Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D439FC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD8F82076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Vww20jGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgDOWGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728606AbgDOWF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 18:05:59 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98910C061A0C;
        Wed, 15 Apr 2020 15:05:59 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id e26so1735376wmk.5;
        Wed, 15 Apr 2020 15:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TSH8Zz/0+b8V3ai1FRug8rbeA2NpMDawQ7Swr68gBQE=;
        b=Vww20jGh73nudzgVXWPkzHO1ftBq0ZQCF/ZP+oJYJ9pF8DrKmMd6GoCN/lVIAE1wpk
         v7JvSGO+4fxgRvBMDlf4ZlibwzTh36VuE+r2kqxHATwwOCNTARIwBkj7FRKqampszJ8Q
         SdorBSvdH6knY3L9C5C6YrcyP7z5LqrQsQLxmrdSxg+O1RFLzA3tTxRu5buI6L9mFtU6
         Z2jqaJ4rLg+Oyjc7xjuQVymUgmv1Drxt3V6/1n4uNMYOUxLVHGVPuay+7YpGK6drj0R/
         U3nrtJBeoeI8cibx8AvCDcbFNWrdjUvexuGHQ7UEBOMfZ9S7m/V2TnsehOR6dX3w5zAZ
         gryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TSH8Zz/0+b8V3ai1FRug8rbeA2NpMDawQ7Swr68gBQE=;
        b=PhtjDFIBKAh0lGjYgGcwl2ts+AyJ4DiHGqN12RJTrLany6INi6Qm7LOtheyD7+usAz
         hdQquFqUO6Qe/bU5eAxqdjPi0Km9ClYGzKZHbDyy8cRT6n8BMzemC8mOLy6lPaesme3F
         FpUjbQuFTEIn7x0KmSUbvYcsZUKFC7tngBbnK7GiV2nT0FHmWF75aQBFQRF9TfrwJn+t
         tRxp5OGHQNpNLOP3V+/xFhQur4sTpZqrs8o89y/u+3v8x3kZAdbnsmtEH8sF18Bhqhvc
         voUee+WtP0ahpU1Fj0uWUMLn++9nvUxmklO8lj+X6ASLYMRdFXSWAl+GgrQOT5+Jjw3g
         Xb1A==
X-Gm-Message-State: AGi0PubANrD1W3tnyZTuY5hyIqGbAF2Gap1OJQe4vfqreCyLOfQRHdF5
        BGvMr+L6PJObqTcxX5Xxi7s=
X-Google-Smtp-Source: APiQypJ+keUVSmlKkrPVJTacLNMuwb6cbVrGFBfXXLMRDpS5EHRHjFEdNrwFzqXVPgBuEqM+JFkkqA==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr1323555wmk.125.1586988358165;
        Wed, 15 Apr 2020 15:05:58 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id n4sm1045064wmi.20.2020.04.15.15.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 15:05:57 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     vadivel.muruganx.ramuthevar@linux.intel.com
Cc:     anders.roxell@linaro.org, andriy.shevchenko@intel.com,
        arnd@arndb.de, boris.brezillon@collabora.com,
        brendanhiggins@google.com, cheol.yong.kim@intel.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, masonccyang@mxic.com.tw,
        miquel.raynal@bootlin.com, piotrs@cadence.com,
        qi-ming.wu@intel.com, richard@nod.at, robh+dt@kernel.org,
        tglx@linutronix.de, vigneshr@ti.com
Subject: RE: [PATCH v1 2/2] mtd: rawnand: Add NAND controller support on Intel LGM SoC
Date:   Thu, 16 Apr 2020 00:05:33 +0200
Message-Id: <20200415220533.733834-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200414022433.36622-3-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200414022433.36622-3-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

first of all: thank you for working on upstreaming this.
Especially since you are going to use the new exec_op style in v2 as
Boris suggested.

> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> This patch adds the new IP of Nand Flash Controller(NFC) support
> on Intel's Lightning Mountain(LGM) SoC.
> 
> DMA is used for burst data transfer operation, also DMA HW supports
> aligned 32bit memory address and aligned data access by default.
> DMA burst of 8 supported. Data register used to support the read/write
> operation from/to device.
I am wondering how this new hardware is different from the Lantiq NAND
controller IP - for which there is already a driver in mainline (it's
in drivers/mtd/nand/raw/xway_nand.c).
The CON and WAIT registers look suspiciously similar.

As far as I understand the "old" SoCs (VRX200 and earlier) don't have
a built-in ECC engine. This seems to have changed with ARX300 though
(again, AFAIK).

A bit of lineage on these SoCs (initially these were developed by
Infineon. Lantiq then started as an Infineon spin-off in 2009 and
was then acquired by Intel in 2015):
- Danube
- ARX100 from 2008/2009
- VRX200 from 2009/2010
- ARX300 from 2014
- GRX350 from 2015/2016
- GRX550 from 2017
- and now finally: LGM from 2020 (est.)

The existing xway_nand driver supports the Danube, ARX100 and VRX200
SoCs.


Best regards,
Martin
