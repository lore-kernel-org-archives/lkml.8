Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90A3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84A2320FC3
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YI97RlPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbgFSLyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 07:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730957AbgFSLyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 07:54:23 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4C5C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 04:54:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d10so1946177pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 04:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zMo8MqpGrcojR1hu7gkCRGNTOG7j0ijRPmvlVewWUos=;
        b=YI97RlPMLGyRbSuJRbi+umDjfTca99+ghiQrmrlW0mKwUOsobIygCn551WZCkAsalv
         v1lkPth7EzHXSBb0Z2KmTkH91OxB+dGGX4pRSUrTkpBAFLDz66JD4Gt9njc6/1NkRlF9
         ccaX18Qf8k5ARWqVLucrT+8Asd/7gRrtvHCJGsu5Oeo2zF7NDCwHqgwz4iKPf3YOzxQZ
         NmNfEz95J7vlG1sbT+Y4uV7iUm+8KmMbTGSvj7dLJhx2hd3CI5NxGHOEamnTolvY03CC
         l+MXzFpco3S8vYKItM5dj4oH+9Y6La67ry66D/vHwQzUfhQ8bETL7tA4onToHMsH5EWk
         AIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zMo8MqpGrcojR1hu7gkCRGNTOG7j0ijRPmvlVewWUos=;
        b=rU1L5Ev0o/l7dai2g+dtlZothPiq5k1fud8jVmlldpCuHcmJeg4mPfnh2RfJPRrCmk
         zULiAqqDO7fWG4I64+z5nWG5OllHe5N+yrBwERtv+G8uuUckbOL3pthm7HFSUVh2gxiu
         4Gk8nV4g1en+8LPhvWd1aDJXpDy07bJfUlRv0VImx0nyziRyHtHpdnUveVvdTHNYABNN
         HUBNMo43TGgCXsEfPie64ZoO5yVhyU9to9aVD81CPDBAAnMNlobnu8XAofceqXSP2BUW
         5RszZZR26pbqdLlVbij7pyv9zSgVFS5gSTqDAAJogpq7Q7HzxKlQ4FoVuYOIN9a5ycSr
         e1mQ==
X-Gm-Message-State: AOAM531D6Qku4SYnjWxUWl1EygVi5gv0vxxy9o4WA5I1pPhp8HyWvOFO
        o6+lJEYBc6vORBFdjC0Vx60=
X-Google-Smtp-Source: ABdhPJxVCcy/FmlsDxTpc0oGXo8VISLG/G70q11V1vZLt9e6ze3um1Q+NKeMPmkO2NaRFcgW2erl4Q==
X-Received: by 2002:a17:90a:b903:: with SMTP id p3mr3348490pjr.4.1592567661891;
        Fri, 19 Jun 2020 04:54:21 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46c:79b7:a5d3:5b37:1d99:175a])
        by smtp.gmail.com with ESMTPSA id n64sm5026712pga.38.2020.06.19.04.54.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 04:54:20 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, jic23@kernel.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, matthias.bgg@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmurphy@ti.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Subject: [PATCH v2 0/4] dt-bindings: mfd: Add bindings for the Mediatek MT6360
Date:   Fri, 19 Jun 2020 19:53:47 +0800
Message-Id: <1592567631-20363-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch series add mt6360 sub-device adc/regulator and
fix mfd architecture and add dt-binding document

changelogs between v1 & v2
- adjust binding document schema include mfd/adc/regulator
- adc: use IIO_CHAN_INFO_PROCESSED only
- adc: use devm_iio_triggered_buffer_setup
- adc: use use s64 to record timestamp
- regulator: merge regmap to mfd driver for r/w with crc

Gene Chen (4)
  dt-bindings: mfd: Add bindings for the Mediatek MT6360
  mfd: mt6360: implement i2c R/W with CRC
  iio: adc: mt6360: Add ADC driver for MT6360
  regulator: mt6360: Add support for MT6360 regulator

 Documentation/devicetree/bindings/mfd/mt6360.txt |  122 +++++
 drivers/iio/adc/Kconfig                          |   11 
 drivers/iio/adc/Makefile                         |    1 
 drivers/iio/adc/mt6360-adc.c                     |  388 ++++++++++++++++
 drivers/mfd/Kconfig                              |    1 
 drivers/mfd/mt6360-core.c                        |  541 +++++++++++++++--------
 drivers/regulator/Kconfig                        |    9 
 drivers/regulator/Makefile                       |    1 
 drivers/regulator/mt6360-regulator.c             |  485 ++++++++++++++++++++
 include/dt-bindings/mfd/mt6360.h                 |   15 
 include/linux/mfd/mt6360.h                       |  240 ----------
 11 files changed, 1389 insertions(+), 425 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/mt6360.txt
 create mode 100644 include/dt-bindings/mfd/mt6360.h
 delete mode 100644 include/linux/mfd/mt6360.h
 create mode 100644 drivers/iio/adc/mt6360-adc.c
 create mode 100644 drivers/regulator/mt6360-regulator.c
