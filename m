Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7D9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4A8A2177B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfVX7JRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgHDQdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbgHDQdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:33:10 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2D5C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 09:33:10 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h12so11178013pgf.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 09:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HB1DkkB09qWrt8yrL+0cExf6RI1ifp17/l8uSNxk2h8=;
        b=GfVX7JRFiyydVuUHwuRkSVoi9Dt0M5wctuGo85UGu0V2/Bj7Iw8ZwXXGeO4G4xDYUp
         np+vuVGQa5uJtQ5C31c4dZJiLgWfpIur8koDCTklGFO8cTy0AblmPIrtFv+x6zbUWlOT
         neQsgY/KR+u4llcwlXhihfz4YjLhQp/XBRiNHkyCviUJh4FS3bKQ85+LznC6fEfIuEQ/
         52IL5umBBsFcVVp+irJlf3fP1BZ6XHeSONtKK0VkFxNYwYw7ZtTT1HgL6z3nGzejUQT0
         unemmPAeku7yf65PcsNx6ewsfJ02kcUyFGBedcDqotM0QDLi8b2Zs/YUuV8LFCSLj/lj
         sKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HB1DkkB09qWrt8yrL+0cExf6RI1ifp17/l8uSNxk2h8=;
        b=T8pbQR2kywCasNaUd9bu7vj+vbZPsxtqALavvxZESNF0/fZ6FMt/FuUpngqHu/XuqG
         wP+98UsZXFdKRPfR5bjWDGTe315l/W56r2mXmU7a5XbSWR9ktnPBLKnwNkFDp7kn4FrW
         VmIxtJC1SeqCMw3EVwtdYfoBph0Geka+1M5TsIE4wK7EexZCDtFbesyiLnsOjVmrUsjG
         g3wEJZ6ugFqk1jXdAt3uaLYVQGOqJ8fH+7ICPA+Lkw/d7RsodKvyMqC4kt7LTZujsR1r
         +7JFIq4Wg419hDmn/dt1J5KsJg0aCABa/hlf1M4peeRzmxZwRkqF8lgsAPtx7smqKer3
         6H9g==
X-Gm-Message-State: AOAM531+6JQg0UwlAJQtww4NkaoCsRtPk28QNf6ITuSxtv5B18MRjQSn
        ZAnk4lTKg8clz/kuqTOqw+k=
X-Google-Smtp-Source: ABdhPJyuQ7eqMONZEolc8ZLYWfB5jUxqOVUQhl5ZrHz4/DSZc3qM9xhnweID1yjp3OR1tkJPH+s7BQ==
X-Received: by 2002:a62:7bc5:: with SMTP id w188mr12600475pfc.192.1596558790085;
        Tue, 04 Aug 2020 09:33:10 -0700 (PDT)
Received: from localhost.localdomain ([123.110.251.138])
        by smtp.gmail.com with ESMTPSA id m16sm657253pjz.47.2020.08.04.09.33.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 09:33:09 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com, rafael@kernel.org
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v3 0/9] mfd: mt6360: Merge different sub-devices I2C read/write
Date:   Wed,  5 Aug 2020 00:32:52 +0800
Message-Id: <1596558782-3415-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series merge different sub-device I2C read/write into one Regmap and
fix coding style for well-organized.

Gene Chen (9)
  mfd: mt6360: Rearrange include file
  mfd: mt6360: Remove redundant brackets around raw numbers
  mfd: mt6360: Indicate sub-dev compatible name by using
  mfd: mt6360: Combine mt6360 pmic/ldo resources into mt6360
  mfd: mt6360: Rename mt6360_pmu_data by mt6360_ddata
  mfd: mt6360: Rename mt6360_pmu by mt6360
  mfd: mt6360: Remove handle_post_irq callback function
  mfd: mt6360: Fix flow which is used to check ic exist
  mfd: mt6360: Merge different sub-devices I2C read/write

 drivers/base/regmap/Kconfig         |    3 
 drivers/base/regmap/Makefile        |    1 
 drivers/base/regmap/regmap-mt6360.c |  163 ++++++++++++++
 drivers/mfd/Kconfig                 |    2 
 drivers/mfd/mt6360-core.c           |  394 +++++++++++++++++++-----------------
 include/linux/mfd/mt6360.h          |  225 --------------------

changelogs between v2 & v3
- Replace mt6360_data to mt6360_ddata
- Split I2C read/write to regmap driver

