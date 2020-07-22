Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16427C433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4EEC2065F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPbgCIom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgGVRIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGVRIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:08:01 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3159FC0619DC;
        Wed, 22 Jul 2020 10:08:01 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 9so2565163wmj.5;
        Wed, 22 Jul 2020 10:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=N0ZPzN8DV4plHFoK836X092XqX/974xvGzph7Wc1J9o=;
        b=mPbgCIomQVQ70hDwbn+dBvoDgfzjcoSFqWbaVj09zbOGXNqBlwFBIIUrKa16ReBPSx
         RW59ZRsAFwO0D88mIqHOW5ChhpKJxcGYQiE699Tb4LD1bG5phLlc41OLKld1E0OTSKcV
         cgBkSiVBA6YQnc2xIrRzgTmI15RqBnYy1qVAhHtFIT3cnsa9Ho09Mh/uVKZKyzfOb7zg
         JI5gJfpSYqBzu3qcWyLKX2DXHhfHiM2RKz9Oy3WtWKvAUxcGn1ADtMtOKUY2MoIfcm6C
         lDHkyo92nSZaoXCxXOadyFL3EOpQtPeZ4zZC2YHx11SSfmSmaBvMS/6Zo349UNtT2nex
         N+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N0ZPzN8DV4plHFoK836X092XqX/974xvGzph7Wc1J9o=;
        b=bvCJ22BJxg5z9dwdOPu0GToM+RLmEFV4gDQd/W82B7X5J3pwHUpB/eMy645wf1OEQ8
         xBC4aEhyrBeRNwoxWX7gaGO1q0EJZxo+92xjb71Vdz3UCLjpp+tIpiVUzJ+WN3XcGWGf
         cQXKQMi5cOFaaiKy/Ra8250qheH4KA4pwT7VjBESP71Q5GZSTiD1bUsY7AqNnrzCjkPi
         4+5VW03n9HVfOiegBeuCz/VJEmcHwkjfSfdAkiyfZ1/N1A4kdAwU89z1Oh2oViwFAgQm
         l1UKBTfxqM3TsqY0OsE/naRAESHoHY8hpy2/Jx/jukYIrRrxY9SUqS1qSB2dWkOV+hg3
         Bb0g==
X-Gm-Message-State: AOAM533+05ZDjjZAW8AaPPwl7wg9ccsgA95Ejj56VEBvHgob0kJHE3kM
        DCHZhvFVxTpwWRuHIq3OoEwoF6Nh
X-Google-Smtp-Source: ABdhPJxxLzfIwYfks3+mUKbqfuvvt3kKdrc2SXcdfApmEmxURr7Q/3myDwXFyel6kBwrWb9RyXq1oQ==
X-Received: by 2002:a1c:1bc6:: with SMTP id b189mr531548wmb.166.1595437679626;
        Wed, 22 Jul 2020 10:07:59 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 133sm392960wme.5.2020.07.22.10.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 10:07:59 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Subject: [PATCH v3 0/7] usb: bdc: Updates and fixes to the USB BDC driver
Date:   Wed, 22 Jul 2020 13:07:39 -0400
Message-Id: <20200722170746.5222-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 - s/there/their/ in commit message in patch 2/7 as suggested
     by Sergei Shtylyov.
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

