Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2DCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9902120842
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="UONJUWqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgG3NCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG3NCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:02:33 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982B2C0619D2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 06:02:32 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d1so14044009plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 06:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fr7btDklxJ+wqORQ0drPfvC+MVq8o7T7llSZAP0YnxM=;
        b=UONJUWqFJJF/32nk1xjITTWvaaIc4XGh0HUHB450gMoWlZxhrNAlNScPWG3j2wZjFG
         Kn02HBhUtMGKhIaQ2Xo4Tl1pbG+4EEqCfus8DskdV0ZTcvjYXCTepC1QiMP5h9iG8t0M
         C+aCB3oN/qGI1dVUTzJm2f1UQkikEKzlha8rU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fr7btDklxJ+wqORQ0drPfvC+MVq8o7T7llSZAP0YnxM=;
        b=a/yOXH85+QhoxvsdGRNG+gC22dlQI3fmFhK0YTgVyQBwwhn+r47VJKjWFWuPF4ebbI
         Jl7JA2rtsVX+XzoEgRc5L8J1iil4IieQBcHpeuDWiGaOSmBP32PWW7xhGsBmrdh6fsOV
         svrcsS7qIlyWn2D4J0Gat/xvJLEbdP5eiMlc0QTjwFzIENuhSlFtW58eDAs6fQN5QTAE
         43K3HWyIhUSoIegRzk4AlbmMakRyayO07ne6kdJWylgv0/5rjl5AojBT0D0+lG9zWZa5
         AosHzh930IurCHmc3gKgEG8jbowcs2pIZJ7JfBxE9Bbspux5lS0eLaGvFScWsnWdW+ve
         z2qA==
X-Gm-Message-State: AOAM5300MdAtX5nD8BX4MB5KzrVV+2uqFlTQKxafKg7gB0i70FqgMijC
        8DlhhszGfrewS6eBLsyzcEf/wA==
X-Google-Smtp-Source: ABdhPJyl+XPEBp3lsaPYkKSu4oC8Ccqn/pDQcNPkQquOMxwIOVedrKk52WN8G7MjICPSSA+FwIoaTw==
X-Received: by 2002:a17:90b:297:: with SMTP id az23mr3150256pjb.135.1596114151676;
        Thu, 30 Jul 2020 06:02:31 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id b13sm6758704pgd.36.2020.07.30.06.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 06:02:30 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux@armlinux.org.uk, w@1wt.eu, Daniel Palmer <daniel@0x0f.com>
Subject: [RFC PATCH 0/3] ARM: mstar: msc313 intc driver
Date:   Thu, 30 Jul 2020 22:00:41 +0900
Message-Id: <20200730130044.2037509-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first driver for the MStar/SigmaStar chips.

All of the chips so far have two instances of this
controller.

One instance controls what are called "IRQ" interrupts
by the vendor code I have seen.

The other instance controls what are called "FIQ" interrupts
by the vendor code. Presumably because they can be FIQ
interrupts. Right now the FIQ bypass is disabled in the
GIC so they operate just the same as the IRQ interrupts.

The register layouts are the same for both. The FIQ one
needs to have the status bit cleared on EOI.

RFC because this is my first interrupt controller driver
and I expect to have made a bunch of mistakes.

Daniel Palmer (3):
  dt: bindings: interrupt-controller: Add binding description for
    msc313-intc
  ARM: mstar: msc313-intc interrupt controller driver
  ARM: mstar: Add interrupt controller to base dtsi

 .../mstar,msc313-intc.yaml                    |  79 +++++++
 MAINTAINERS                                   |   2 +
 arch/arm/boot/dts/mstar-v7.dtsi               |  20 ++
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-msc313-intc.c             | 222 ++++++++++++++++++
 5 files changed, 324 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mstar,msc313-intc.yaml
 create mode 100644 drivers/irqchip/irq-msc313-intc.c

-- 
2.27.0

