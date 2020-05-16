Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F1FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 361CE20657
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edJhXqRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgEPMEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 08:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726202AbgEPMEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:04:49 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30512C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 05:04:49 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h188so4041540lfd.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 05:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SztMmK0s5SW44x0nkgziD1lEEd1yF36ak6n7wePJY/k=;
        b=edJhXqRrdAvT1LckGt4P939ulELjxXdG16RX32eIvjoiB8CmizN1wYB8yhYjKs06VR
         tbOXH20ZMCrG5tdUSfR/MKeEKEDTsL/GWyPE+Fq044V8keJwnDA+mIK0Ipx+KKv7G27n
         RKUhYbvx74utCZJAQu6vg8bgzDH9uPjN/Ug3o/3RA89jBVWB90bY7JgyN0atwkusbDmI
         4WDkd6r6qHaIDdlBPNOXHs2fkjL0NSF5Hy1oR759SZX8JZiIf7Md6nnknWWSl818XuND
         +GYe0qdVof8Sn2Ng24QYtVvXvmTZRjgr7/Rm4HmVzIdgcI+xTT6mJ+/E50U8qSgP59mo
         4gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SztMmK0s5SW44x0nkgziD1lEEd1yF36ak6n7wePJY/k=;
        b=XRLRXBCvZuBEpecOoE8ZG+zBH4w/IEgG7/fX9+UdsY80Klm8i0I0Ur/lraXOXLkZK4
         Qip4BxeZgqYx96o9UaqERfFgUtyDc4tpGRL9xXWF9wRA3YLk54ZDWjUmPyYU79evEyC/
         kGiRy3JyE1dCnhkUgPbweQ9PwOptYCe1HzzBJTX0aXXrpZZc+OKsXq2lkOowuPoDoRID
         OVHrHlMI7IgLBHUD2Mj4pV/Evwyo1Tieg18hmdKm1gfz8dL0Yn1UeggDd59CrojTdv9S
         ErjS8iTVUMlb/E71kbDpVsY5n+y5hThTCEWGx3etG9Hp4xD/ByBHdaidYzVkscdpCs/9
         c4fA==
X-Gm-Message-State: AOAM531MIjLFNrFDNPxCl63StCo9oCKthtuMcPzkE0kNmLmdurZzUiJ/
        Iz1igyxjY0K9Y2u/sozY/4I=
X-Google-Smtp-Source: ABdhPJy5MeX/pHrkLRTz20V7fBXMwENdaOSoSNpf94IBDfGTQOLdm+wrNHhCMZpmtiQrM93nQdqQ2Q==
X-Received: by 2002:a19:c150:: with SMTP id r77mr5667915lff.12.1589630687572;
        Sat, 16 May 2020 05:04:47 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id r20sm2581538ljj.44.2020.05.16.05.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 05:04:46 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     kishon@ti.com, vkoul@kernel.org, alcooperx@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 0/3] phy: broadcom: Constify structs
Date:   Sat, 16 May 2020 14:04:38 +0200
Message-Id: <20200516120441.7627-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A small series adding const to a few static structs. Each patch can be
applied separately.

Rikard Falkeborn (3):
  phy: phy-bcm-ns2-usbdrd: Constify phy_ops
  phy: sr-usb: Constify phy_ops
  phy: phy-brcm-usb: Constify static structs

 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c |  2 +-
 drivers/phy/broadcom/phy-bcm-sr-usb.c     |  2 +-
 drivers/phy/broadcom/phy-brcm-usb.c       | 16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.26.2

