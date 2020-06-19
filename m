Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8326C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A926220890
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="P80z4dP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbgFSJGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731487AbgFSJGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:06:49 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517F2C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:06:49 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id f7so9403294ejq.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HvGH7Pv4foao4L50irRdHfsqjrsvjQfU69J0IADDQqk=;
        b=P80z4dP158kR74roWZEYDQTGhtpYz6jZRYW/KrObAPurFivXZAr0jRWDh4vGLGQlVP
         BGoJN72IF1ztehvJlOH7VQ5lRuSEsczEAAdkVSTrMtvhFteZ6dncfBdUxz4pjtc/Dbp4
         iwRulvaJGMhtYWLXNNhVhPYbglLZLC4oprRohBrrGqWAzNXkCUIl9bbmlCCP/gUukUEf
         To9rjqcP1jeXGrI6Q2X7VrMWbWIOU2IMo68c3V/JrFPGLyUzP+vZJlFuc64eARetUsZk
         FoQdlw3xxGAfH8nUlwlcD1xshgLsWakRySyu9qVdkyXg224zO3HRfHoI8KsTp0iDEVoB
         Fh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HvGH7Pv4foao4L50irRdHfsqjrsvjQfU69J0IADDQqk=;
        b=SsHEfYnpOILJPCHRhFJAspt87B3ADX5xXNElmpZVf4+Bm9NJmehBLedGZ1jdLaiV9S
         gQgxr/ShNwlEjtQPLvN2mKFmJpt+oUTArG1S0lz22u2mDCX8cmkfAACNSWyDAtdpYlU+
         NR7OPSz70R+owCoq81x2g5HeupIo0HKtSxI688s3+Jo8JlVMFK0Kh+m7SywkpZR8igWE
         uhJN/9qA0DKImUgJwGCJY/AhVD8vd7iLoJ7I7J7pMcudm6DxlmefLSssvnEqyNCMagTy
         0QuSTdiyfp0t6Rutnks8MywkzUSsfsAbAT3QJAfxBF/GMgQikkkbB9YeQDXos785bQZp
         NMvg==
X-Gm-Message-State: AOAM532XAtlkfOXJ2O9JVPVmc3EoIrAM46IB3MyF8t9Nn830kb8aaC9N
        T3FWPgRyjmU/Y7pTQ7adpGZa/g==
X-Google-Smtp-Source: ABdhPJzYJAW/a3AmTwbnULTmzoFTpukWQQAUa1C0VYxyzK6eiXdwk67c0W3bjz/BfvoRWLinvzdfAQ==
X-Received: by 2002:a17:906:fc06:: with SMTP id ov6mr2795189ejb.184.1592557608029;
        Fri, 19 Jun 2020 02:06:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:16b8:5c68:7901:5c06:6064:338b:4004])
        by smtp.gmail.com with ESMTPSA id dm1sm4653650ejc.99.2020.06.19.02.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 02:06:46 -0700 (PDT)
From:   Drew Fustini <drew@beagleboard.org>
To:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>
Cc:     Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v2 0/3] pinctrl: single: support #pinctrl-cells = 2
Date:   Fri, 19 Jun 2020 11:06:05 +0200
Message-Id: <20200619090608.94948-1-drew@beagleboard.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, pinctrl-single only allows #pinctrl-cells = 1.

This series will allow pinctrl-single to also support #pinctrl-cells = 2

If "pinctrl-single,pins" has 3 arguments (offset, conf, mux) then
pcs_parse_one_pinctrl_entry() does an OR operation on to get the
value to store in the register.
    
To take advantage of #pinctrl-cells = 2, the AM33XX_PADCONF macro in
omap.h is modified to keep pin conf and pin mux values separate.

v2 changes:
- remove outer parentheses from AM33XX_PADCONF macro as it causes a
  compile error in dtc.  I had added it per suggestion from checkpatch
  about having parentheses around complex values.

Drew Fustini (3):
  ARM: dts: change AM33XX_PADCONF macro separate conf and mux
  ARM: dts: am33xx-l4: change #pinctrl-cells from 1 to 2
  pinctrl: single: parse #pinctrl-cells = 2

 arch/arm/boot/dts/am33xx-l4.dtsi   |  2 +-
 drivers/pinctrl/pinctrl-single.c   | 11 +++++++++--
 include/dt-bindings/pinctrl/omap.h |  2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.25.1

