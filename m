Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE74C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9DC620772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sl2TTjzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgGBOTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbgGBOTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:19:10 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B720C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:19:09 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so32411852ljn.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0P63yETtCZy7cAGoDgafSeN36XD6Q/8y9SUCJsklzIU=;
        b=Sl2TTjzwSjlY2Q45XFnpjkZAYMSWda+yE40Vr4ZMzbf45WKugp/wqROPo3mVS70Qeh
         6rrSJ522hSEUbMfdvCCnRIApBpzMMNQ7zosW95YMpgW6FAUBex6eVjXU/6UM7J7xz7ZC
         vBvCn5BXRM86J8J4owX9S5qS8aHnWROah/VleW8+Y/YRVzQ41DDi68C4sIj8wTv9wtZg
         vroEPWaLTy2fLdsmJykqeGqv63UmoGLiFU5K1rjyYDmxOWxyeXk1oDy7HILMu4/+iH4t
         xh9BhxMVXq5jalPjRCbX0STd5QLJO1F/AnrsJSAbvoJj8Q1GZ0EmgsDBECPIrod/CTwt
         TdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0P63yETtCZy7cAGoDgafSeN36XD6Q/8y9SUCJsklzIU=;
        b=WNBQWAn4UEKjoOpszjbSGdVHLb0O5vU+yTDERdWf62UGttnQnCW2hPczL0DRQ3ZJQt
         cU8Q9ZFqCODFgw6pPrM2oNttuOSu+xkMfikOfBY2ZKioRWwUkPopXjR69Bxvcp33Qrum
         DiMkNZdCJnEBOYgH9SGz3JPbbQiCuSJ8PIg+HWw6y96M6OJktoLhlXWSglNqOgl373Ax
         6k8KmYPeN4Lf8XewfNUfXfwKeRMQsI5+gS0o5qObiLGv1PRAi5jV+UlhGBdbsESZrr+s
         ykNbFLIzgVWePCIGqL0ljFFfHmhOq8Slfk9b0wABLGaCYHdT/se7ARGYO4pwurVQt5Sx
         vxIA==
X-Gm-Message-State: AOAM532RdC3lG6witSpW+B1RoHPn8Jd/RfarhK8j1bOgdLzfWyFF1fkP
        df6T1N3X9TPlHkkI/7UU/V1zIJUU84tL9g==
X-Google-Smtp-Source: ABdhPJxNW8aUC7P/8FBnpgDN16lffoUsadSz8mCqHx5zKjKr2rET0nDVNBdEJxLtRZb50m5Lq78rnQ==
X-Received: by 2002:a2e:9744:: with SMTP id f4mr14295946ljj.367.1593699548019;
        Thu, 02 Jul 2020 07:19:08 -0700 (PDT)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id v10sm692581ljg.113.2020.07.02.07.19.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 07:19:07 -0700 (PDT)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        s-anna@ti.com
Cc:     grzegorz.jaszczyk@linaro.org, robh+dt@kernel.org,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, david@lechnology.com,
        wmills@ti.com
Subject: [PATCHv3 0/6] Add TI PRUSS Local Interrupt Controller IRQChip driver
Date:   Thu,  2 Jul 2020 16:17:53 +0200
Message-Id: <1593699479-1445-1-git-send-email-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The following is a v3 version of the series [1][2] that adds an IRQChip
driver for the local interrupt controller present within a Programmable
Real-Time Unit and Industrial Communication Subsystem (PRU-ICSS) present on a
number of TI SoCs including OMAP architecture based AM335x, AM437x, AM57xx SoCs,
Keystone 2 architecture based 66AK2G SoCs, Davinci architecture based
OMAP-L138/DA850 SoCs and the latest K3 architecture based AM65x and J721E SoCs.
Please see the v1 cover-letter [1] for details about the features of this
interrupt controller.  More details can be found in any of the supported SoC
TRMs.  Eg: Chapter 30.1.6 of AM5728 TRM [3]

Please see the individual patches for exact changes in each patch, following are
the main changes from v2:
 - Convert dt-binding to YAML (patch #1).
 - Address comments from Marc Zyngier regarding patch #2 and update following
   patches due to those changes.
 - Dropped the custom helper functions used for interrupt configuration outside
   of irq driver [4]. Introduce new patch (patch 6) which uses xlate and irq
   domain mapping functionality in order to map system event through 2 levels of
   many-to-one mapping i.e.  events to channel mapping and channels to host
   interrupts.

[1] https://patchwork.kernel.org/cover/11034561/
[2] https://patchwork.kernel.org/cover/11069749/
[3] http://www.ti.com/lit/pdf/spruhz6
[4] https://patchwork.kernel.org/patch/11069751/

Best regards
Grzegorz

David Lechner (1):
  irqchip/irq-pruss-intc: Implement irq_{get,set}_irqchip_state ops

Grzegorz Jaszczyk (1):
  irqchip/irq-pruss-intc: Add event mapping support

Suman Anna (4):
  dt-bindings: irqchip: Add PRU-ICSS interrupt controller bindings
  irqchip/irq-pruss-intc: Add a PRUSS irqchip driver for PRUSS
    interrupts
  irqchip/irq-pruss-intc: Add support for shared and invalid interrupts
  irqchip/irq-pruss-intc: Add support for ICSSG INTC on K3 SoCs

 .../interrupt-controller/ti,pruss-intc.yaml        | 135 ++++
 drivers/irqchip/Kconfig                            |  10 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-pruss-intc.c                   | 717 +++++++++++++++++++++
 4 files changed, 863 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml
 create mode 100644 drivers/irqchip/irq-pruss-intc.c

-- 
2.7.4

