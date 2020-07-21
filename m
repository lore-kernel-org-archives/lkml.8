Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B777DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9714A20717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXYF5NtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgGUOnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGUOnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:43:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15D6C061794;
        Tue, 21 Jul 2020 07:43:48 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so3104338wmi.3;
        Tue, 21 Jul 2020 07:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tjB/ByhRKWu5CLBPrkRuS8Bem+I9tOuvC/RU2qeH018=;
        b=oXYF5NtGivVek7lFp8Eo0TgHIXMqoJu7zvs+8p7482oq5HRFfYMR53w7BAYLmdQUJu
         r+hzxITrpQgLOIWD6/uNmaQuWBysw+a/Y/k0btFLdyElSqF28JwUbMqM92FJhQCiC9Fa
         0OGoFQ1S4xXRLHjalW8JP/zyWIjpyjQCiQ5q1ZYn0h97cCj1jjgBHmxYUTuhbOXNOXBG
         UktiTHMrWcT7RXegmw8XcRy6GmuzEWR6LDxEo5VlT+B54AHqxqZ2YFd0U4AiJ3kPg/vV
         rLJYlbnh7/VHKk/jQXonKL1jhOTm18qX2IG8HVCQX3qgevpr/GFlbARfL36ZhBC5rl34
         LJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tjB/ByhRKWu5CLBPrkRuS8Bem+I9tOuvC/RU2qeH018=;
        b=mX3K4n5JnxKuSiBdnj1K/7H8xopLYG/lNF2E/uiDYeOJzqfVL34b7fI4XThjGA/aFV
         5EYFV/y0bMAQqWir/6h0AWROEUuTF+2LEuIrj1Gs+KCGWfD7xsCBXBrJTCbhPOVf1qEG
         oSs32hX42XNlNGBL2GCOdBdpiqe6mmdj/xGdDuNjm96t4nec7hRHDTO1GCzroDW/epnT
         +N9tSs9ibVFhsodploiEF5xtX18OPI3avXAvyIB24Z8rblzydcymPuC1YKyBFEzsGWtc
         toQGsD+vU2zW9U9bVkQqJQxU9LDhBxIwYwsmgNs9uNdLDhl3u0PU9EnfOf3zpPZUTv3W
         z/Tg==
X-Gm-Message-State: AOAM530MmooWehJDmyiKSI+s+WubvNMKYcrxPFlhnqqB55icFU3/H5/l
        QHYjEROZRKT+fBkNgq31RPv4GfDt
X-Google-Smtp-Source: ABdhPJzEQa8EDcoyxxaLnf2nFJbX8nLJGPm8NmGeTJw7u/xHntqluR+p+Xf9epMLJpZ9y8Rwk2Q6/g==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr4592584wmi.66.1595342627268;
        Tue, 21 Jul 2020 07:43:47 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y6sm38043116wrr.74.2020.07.21.07.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:43:46 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Subject: [PATCH v2 0/7] usb: bdc: Updates and fixes to the USB BDC driver
Date:   Tue, 21 Jul 2020 10:43:19 -0400
Message-Id: <20200721144326.7976-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 - Fix Signed-off-by issues, remove internal bug reference.
     Fix binding document to match driver.

Updates and fixes to the Broadcom USB BDC driver.

Al Cooper (4):
  dt-bindings: usb: bdc: Update compatible strings
  usb: bdc: Add compatible string for new style USB DT nodes
  usb: bdc: Adb shows offline after resuming from S2
  usb: bdc: driver runs out of buffer descriptors on large ADB transfers

Danesh Petigara (1):
  usb: bdc: Halt controller on suspend

Florian Fainelli (1):
  usb: bdc: Use devm_clk_get_optional()

Sasi Kumar (1):
  bdc: Fix bug causing crash after multiple disconnects

 .../devicetree/bindings/usb/brcm,bdc.txt      |  4 +--
 drivers/usb/gadget/udc/bdc/bdc.h              |  2 +-
 drivers/usb/gadget/udc/bdc/bdc_core.c         | 27 +++++++++++++------
 drivers/usb/gadget/udc/bdc/bdc_ep.c           | 16 ++++++-----
 4 files changed, 32 insertions(+), 17 deletions(-)

-- 
2.17.1

