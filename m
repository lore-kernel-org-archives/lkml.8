Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6085BC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 00:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B84420809
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 00:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nkLT+MDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgGRAGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 20:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgGRAGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 20:06:43 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E79C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 17:06:42 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id x6so7451261qtf.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 17:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rJVmt4ZwvRTHWXzLKcOClrGZS1hFJIY01F+5WZok3xc=;
        b=nkLT+MDkiiaXW4XaRtaceajqWSG1GinaUs7iUYNAPyVF3I16mAM60i0gGxIDbAsMQt
         fYL3Y4hkLQ4zrCRLIrRhLXNAFIUzqqbNLcna5BgT/oUTLTWlK2CVCP26dSTIHxdBJ9ha
         0ACj5SjZiHCYVw2sKDNWSf9UjvBfXMIAVREz2NDrkfitTNAXQDqByq4edHfoQysDKFnn
         XC4oT1Yu/8OuXz/+K6DazZZVmvoiE3s04R4QsiTeyT81Px5iQFL5NBAfHgZE3j/NJjdP
         d7FBIRkJbXCCOJ0U9kQsUWd45y3rWC+omYqme3AiSCb14sHnlJK5v/B+S1aTOcNzOgv3
         Q7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rJVmt4ZwvRTHWXzLKcOClrGZS1hFJIY01F+5WZok3xc=;
        b=HN+ercvHDFTSInwyJcM0DE0af+GiiHKG07LpVBldvvuFVD3emQLBcNQH7H/e9ROm6N
         86zuT2DsUHeFajd/2DU03EuPfN/ly41n+bGZrsXva2ehICq2lH/oRC1djZ3VUlx5fdYt
         ub0AhHikJu+XePkqA6mNdnPgwYNeZin56IELqnJMB9Uzr3n9eYEuFbKHM0dViXsCj3gK
         tM6yAYDb+qxgjciFKGYlpPGO+wmKd0+JyHgDIXAMowpcqkJVE1oIz+nCpBtnL7AUQkEP
         U/UKVik4/HX9+baXDxx5D+ml1041aJiGN9Zr1I5sNZVZLoIIte4OeMcZTEEBavEngDRa
         DeEg==
X-Gm-Message-State: AOAM531KKcCW03w7AZ6egIiTVlB3PQXxFKJAXe9hCsLUlvZExmJBGMl7
        MN5LIZLyKleHVbTrHb+uz6c6SbTphvfNAYI=
X-Google-Smtp-Source: ABdhPJz83yKT96CBvwXwQbOgr6og9PaNdHb27iy5PN2zqKCaFfX0K9leKlkCDg5IteBpKBZ/nYJFfwCY8C2fVsE=
X-Received: by 2002:a05:6214:3ec:: with SMTP id cf12mr11680570qvb.251.1595030800209;
 Fri, 17 Jul 2020 17:06:40 -0700 (PDT)
Date:   Fri, 17 Jul 2020 17:06:33 -0700
Message-Id: <20200718000637.3632841-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 0/4] irqchip: Add IRQCHIP_PLATFORM_DRIVER helper macros
From:   Saravana Kannan <saravanak@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Hanks Chen <hanks.chen@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Made a series out of the previous v2 patch + some example uses of the
macros.

Not sure if the MTK changes work (just compile tested), but saw that
Hanks was trying to make those drivers into tristate. So I assume
they'll work as platform drivers. Please wait for MTK Ack before picking
up patches 3 and 4.

v1-v2:
- Instead of redifining IRQCHIP_DECLARE, created new macros.
- Added more checks in the probe helper function to ensure topological
  probe ordering when fw_devlink is not "on".

v2->v3:
- Added comments
- Changed IRQCHIP_PLATFORM_DRIVER_BEGIN macro parameters

Saravana Kannan (4):
  irqchip: Add IRQCHIP_PLATFORM_DRIVER_BEGIN/END and IRQCHIP_MATCH
    helper macros
  irqchip/qcom-pdc: Switch to using IRQCHIP_PLATFORM_DRIVER helper
    macros
  irqchip/mtk-sysirq: Convert to a platform driver
  irqchip/mtk-cirq: Convert to a platform driver

 drivers/irqchip/irq-mtk-cirq.c   |  4 +++-
 drivers/irqchip/irq-mtk-sysirq.c |  4 +++-
 drivers/irqchip/irqchip.c        | 29 +++++++++++++++++++++++++++++
 drivers/irqchip/qcom-pdc.c       | 26 +++-----------------------
 include/linux/irqchip.h          | 23 +++++++++++++++++++++++
 5 files changed, 61 insertions(+), 25 deletions(-)

-- 
2.28.0.rc0.105.gf9edc3c819-goog

