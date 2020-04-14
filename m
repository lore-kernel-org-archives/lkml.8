Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925A7C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A3A6206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UUxL1PnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505249AbgDNTxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731039AbgDNTvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:51:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4431FC061A10;
        Tue, 14 Apr 2020 12:51:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d17so9030616wrg.11;
        Tue, 14 Apr 2020 12:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+N+iwx+s3b4ecaxzWwdiHxbedClo3dqSdoWLFQ6f1/U=;
        b=UUxL1PnKnUg8fIrCWtbyWVCvceOj6quFpI5/ZqIp5wWjHBQs2jj8vpenLiBMybtZMj
         eF9kGXUZn/M7fd8ZNyCtIQtIT5Z8fvBajTocjbk05VdH74TNqOKTbyek5eEC2qZK22yA
         EoXNTrjsZ/EeuJXkudxFEESAUBypRQ8CElySNf3Xu1ZtCao72FHYzsnewRgzCoolv7nd
         00a8xhEPPbDi3S0Pt3uyfHyxBizGsvzq1qJZteRoq9XQvErvnO+07byxwp65xHfuX4vK
         JuZYlUV/tubF5tUBLkSaUnWkCNht9HzMU0ycgoE1FPS9jPYFJUoGAT2bidaF+IJH/bdZ
         aGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+N+iwx+s3b4ecaxzWwdiHxbedClo3dqSdoWLFQ6f1/U=;
        b=r43UINVKh0KmxA2yktoL/Ebmkg1pvUNP2BjNgqgFs3I3SSnmKzSgjbEC1fNcb7BVmn
         0Vn5dW//8GQcrbZa+HWuvJzsuiU9/AJEoozWStb32lSeVqvScwLGT04wIue35FeOroJ1
         HXsIo5GcAaSY4dGfiSlm5u1IsbWDMC1RM2PzPaen8rIK8MjanqJ7keaC1a8Ny7hui25b
         nR71DO2YQXeyh9KFj0EOZ0QgvoBqGF6kiJ2AV/ZJ3vsLsciM1qDwNSNLgoteHIIbDCY0
         wU+kRu3NH28e90C2HGR1x56MKbnjcNs3E/TbifqnM7Ic6gpC4bx0ZSJnjHpWH1KG6vLr
         /SpQ==
X-Gm-Message-State: AGi0PuY3F5nSl3XA2JhgxNauwqLkPKr9qv/0IhWIEV0PZPI4nm01ddDb
        TwN8tuAjFRdCS66060Z54X0=
X-Google-Smtp-Source: APiQypJYWEsJw+LuFClfHTnB3e9fwDUHMevyZXeHtabNPFK+dyJsx6HpmKnwmmfYDvv65aGRQFpHbg==
X-Received: by 2002:a05:6000:8b:: with SMTP id m11mr11200017wrx.168.1586893876770;
        Tue, 14 Apr 2020 12:51:16 -0700 (PDT)
Received: from localhost.localdomain (p200300F13717DF00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3717:df00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id s14sm20886844wme.33.2020.04.14.12.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 12:51:16 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/2] clk: meson: prepare GX and G12 for GPU DVFS
Date:   Tue, 14 Apr 2020 21:50:29 +0200
Message-Id: <20200414195031.224021-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This contains only the clock driver updates from my other series titled
"GPU DVFS for Meson GXBB/GXL/GXM/G12A/G12B/SM1" from [0]


Changes since v1 at [0]:
- update the patch descriptions to indicate that we explicitly don't
  want CLK_SET_RATE_PARENT on the muxes
- split into clock driver (this series) and .dts changes (future
  series, waiting for testing feedback on v1 from [0])


[0] https://patchwork.kernel.org/cover/11466399/


Martin Blumenstingl (2):
  clk: meson: gxbb: Prepare the GPU clock tree to change at runtime
  clk: meson: g12a: Prepare the GPU clock tree to change at runtime

 drivers/clk/meson/g12a.c | 30 ++++++++++++++++++++++--------
 drivers/clk/meson/gxbb.c | 40 ++++++++++++++++++++++------------------
 2 files changed, 44 insertions(+), 26 deletions(-)

-- 
2.26.0

