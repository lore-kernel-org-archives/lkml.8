Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA83C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D019207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UPuNhJ8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgHUOoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgHUOoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 10:44:22 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B169EC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 07:44:21 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 185so2116154ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 07:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AIG5aJvk4bOQSa/LqmM0nhcaHZI8vyVexmjeCfVeirU=;
        b=UPuNhJ8V2Q61eb74UpaLpxI1zgM5dDlClegTFZLT+Kn3ua31t8YT7RD4Jl0/lEXzSq
         5HGIX3aXa6i41RygZPryAX8QkUl8IAZs6ZBwUd8R6lofBZU38XV7k0iHAsAgrq7M0a1P
         zsifVaUYsnH7/Cwwe1lFeart2EiGDyw+7jChdNJUzaRkJSGBsubSok8sLyzZoACmcBOt
         RuC4ig/aGuzQBRPBFkXRlhvr7a8ts1YMumSLig2mpZQnSWZldE9aKPWEp4tDZm+ePZDo
         SQpkJiDwyv97GBOefvxcC6WUf9pyLnKEazu0JWDo5pn0wfwViX91MWN1uhBHfuLqm6qD
         0lzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AIG5aJvk4bOQSa/LqmM0nhcaHZI8vyVexmjeCfVeirU=;
        b=buU6Yhddm3pKronMUe1Bxy3FXg8zEeoXsFLNCyJd7owwaWHnkzNOhl2j7kJym4Q9pA
         pP+WAHz9F21wKYClGxZ1vGi4UqjZ3BMD5RO11/wi8NXUTvjM/sAZDApaPzkj9YUpn1gg
         PRGIU6+vDaWLV1PvNzRq1E6KSFqPsGC+hORw77ZasKRFePOzviO+lvlLPjuU2hYBH/uP
         cJbHyFQLJf74NUA83q4H4b1LGNAYpNEuicDqMlDhUJK0nMJHgXbHs7TBuf0M4W3fgx5k
         F49Q4sk3ZWZqSzx0nBv1677WbI3bQR3XdOuOijCM+XzvEoWU3MRQtGuAYPhOXX0zYqin
         IF0g==
X-Gm-Message-State: AOAM532vAY11PKlBuzR6od2sWfbBktqDxRyQJEV49K5MR4C4vr3DL5xe
        8qiozdrH6UT94GCDovpom/VMhQ==
X-Google-Smtp-Source: ABdhPJx46s8nwkObUzZieA+o4KdRW6bz8UYBJ7c/MvRLO2z7O2jYTUJj0VfzEUyGu92VciOkv6IvwA==
X-Received: by 2002:a2e:531c:: with SMTP id h28mr1825810ljb.322.1598021060145;
        Fri, 21 Aug 2020 07:44:20 -0700 (PDT)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id u10sm425301lfo.39.2020.08.21.07.44.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 07:44:19 -0700 (PDT)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     ssantosh@kernel.org, s-anna@ti.com
Cc:     grzegorz.jaszczyk@linaro.org, santosh.shilimkar@oracle.com,
        robh+dt@kernel.org, lee.jones@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        praneeth@ti.com, tony@atomide.com
Subject: [PATCH v2 0/7] Add TI PRUSS platform driver
Date:   Fri, 21 Aug 2020 16:42:37 +0200
Message-Id: <1598020964-29877-1-git-send-email-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The following is a v2 version of the series [1] that adds the platform driver
for the Programmable Real-Time Unit and Industrial Communication Subsystem
(PRU-ICSS), which is present on various TI SoCs. Please see the v1
cover-letter [1] for details about the features of this subsystem.

Please see the individual patches for exact changes in each patch, following are
the main changes from v1:
 - dt-bindings was updated regarding to Rob Herring comments;
 - support for K3 J721E SoCs ICSSG was enabled in patch #7.

[1] https://patchwork.kernel.org/cover/11690777/

Best regards,
Grzegorz

Grzegorz Jaszczyk (1):
  dt-bindings: soc: ti: Add TI PRUSS bindings

Suman Anna (6):
  soc: ti: pruss: Add a platform driver for PRUSS in TI SoCs
  soc: ti: pruss: Add support for PRU-ICSSs on AM437x SoCs
  soc: ti: pruss: Add support for PRU-ICSS subsystems on AM57xx SoCs
  soc: ti: pruss: Add support for PRU-ICSS subsystems on 66AK2G SoC
  soc: ti: pruss: Enable support for ICSSG subsystems on K3 AM65x SoCs
  soc: ti: pruss: Enable support for ICSSG subsystems on K3 J721E SoCs

 .../devicetree/bindings/soc/ti/ti,pruss.yaml       | 320 +++++++++++++++++++++
 drivers/soc/ti/Kconfig                             |  11 +
 drivers/soc/ti/Makefile                            |   1 +
 drivers/soc/ti/pruss.c                             | 184 ++++++++++++
 include/linux/pruss_driver.h                       |  48 ++++
 5 files changed, 564 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
 create mode 100644 drivers/soc/ti/pruss.c
 create mode 100644 include/linux/pruss_driver.h

-- 
2.7.4

