Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B91BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46DA9207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RxSooEOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgFPGNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgFPGNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:13:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28663C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:13:43 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh7so7910306plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WpLd8LRsJ/8biRJMZx0Bnx3mOD9worHTt50kQ8XWP7E=;
        b=RxSooEOC/+yMUfI3gtNEWymtFFdmRe4Tkk2rBTpKJA3oVwp3ItlbonH5UnISC/UFSw
         xg7h20PlIep3H7ldLpXzMVsTTCtf/6qdsD2rtzER8gSccQuO5izUvI4/DVOJyuBr0uup
         P8aGCybW+GqHvl6l/YXJECQASVAnBVyQ/gMEygwAhcntyylCrDU5piUvOROASQrJULJ3
         xo1aXzo0HfZYEWVbNFb3YdWACmXm/8ZRtF59TQz1J9nEEG1zyL1wVX2++p/L/AMY9SsH
         hIm8Cg3VHPQyhCvqGwz5j4gSPvFKc8dSujV/RvR9zDWeHStJ0IPk46rRwp3VvwGDargX
         TGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WpLd8LRsJ/8biRJMZx0Bnx3mOD9worHTt50kQ8XWP7E=;
        b=AQkVokUT0ZZT45IZ+8n8trPc27TA10CiwNZzrdF8obd0R4NdA8mSTWjpwMIHNlj76N
         ehpeH/cfTaUYBfERhskZoie/UtF0/9lFMBUtnVNGei5jgJ3d3cugNMJRHI+kLqoJTBGL
         yfbqeXcpx2rJwoVDrujXjC7i1HbDEZaQBDp1/bZdbOxrdS9A03e6DWikn3LkqVHzeQU8
         r2MtogYxv+32ABi/RSnjLusYW3SWcGJtwTweVra2kFFuDkVVP+IN93mnGwoqBBDJ/PKI
         ZLYOtR0Fi5Neyt0jyw+TyJn0sdlTLLSlYqTXgt+y3fDWJ9yZTBk0cIO09oOlcZjBset7
         H8RA==
X-Gm-Message-State: AOAM530ZspIhA1HQ1ToELH7CJ0bAnx6bSSBB6iu+qc4xcEwj93LkWP1L
        FXwmddRRm/PQNADJ1GGgRsuE9zYax9g=
X-Google-Smtp-Source: ABdhPJxJYRDBUdC2n/hzHBEEXJUuOgq+LjZinVw+29cwU9skb8cP3yPF9qx0n2GXzlPlzYv9r0itoQ==
X-Received: by 2002:a17:90b:28d:: with SMTP id az13mr1345731pjb.67.1592288022378;
        Mon, 15 Jun 2020 23:13:42 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id i26sm15642032pfo.0.2020.06.15.23.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 23:13:41 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-gpio@vger.kernel.org
Subject: [RFC][PATCH 0/5] Allow for qcom-pdc, pinctrl-msm and qcom-scm drivers to be loadable as modules
Date:   Tue, 16 Jun 2020 06:13:33 +0000
Message-Id: <20200616061338.109499-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series provides exports and config tweaks to allow
the qcom-pdc, pinctrl-msm and qcom-scm drivers to be able to be
configured as permement modules (particularlly useful for the
Android Generic Kernel Image efforts).

Feedback would be appreciated!

thanks
-john

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: linux-gpio@vger.kernel.org

John Stultz (5):
  irq: irqdomain: Export irq_domain_update_bus_token
  irq: irqchip: Export irq_chip_retrigger_hierarchy and
    irq_chip_set_vcpu_affinity_parent
  irqchip: Allow QCOM_PDC to be loadable as a perment module
  pinctrl: qcom: Allow pinctrl-msm code to be loadable as a module
  firmware: QCOM_SCM: Allow qcom_scm driver to be loadable as a
    permenent module

 drivers/firmware/Kconfig           |  2 +-
 drivers/firmware/Makefile          |  3 ++-
 drivers/firmware/qcom_scm.c        |  4 ++++
 drivers/iommu/Kconfig              |  2 ++
 drivers/irqchip/Kconfig            |  2 +-
 drivers/irqchip/qcom-pdc.c         | 30 ++++++++++++++++++++++++++++++
 drivers/pinctrl/qcom/Kconfig       |  2 +-
 drivers/pinctrl/qcom/pinctrl-msm.c |  3 +++
 kernel/irq/chip.c                  |  3 ++-
 kernel/irq/irqdomain.c             |  1 +
 10 files changed, 47 insertions(+), 5 deletions(-)

-- 
2.17.1

