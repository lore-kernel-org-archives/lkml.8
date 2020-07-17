Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B834C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CCED2076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7FbqHRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgGQPXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgGQPXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:23:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B602C0619D2;
        Fri, 17 Jul 2020 08:23:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so11593987wrw.1;
        Fri, 17 Jul 2020 08:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZQBY6n0XO5q0T2HKwgvRXJzUZ5cOaX1DHTrvKtmcRgQ=;
        b=O7FbqHRX208RD83qlfBMP1GinwaYuZEtsIXBCf4tqZut/g0O3MqIcstGWS7HVztJFj
         bVDuEBdLddWBnOIGxTVWebBfaW2K5S94Y6mGyWNgMn1Va1rhUpCuiisBTxL8rD86Jp8J
         31x5mmglYTwYWkBLkxWTi/dUhkD+B8Gtf97nkJz0eMEK7XCzER26W8QIcC7rzm6rNTIp
         MXubU+6CDog7LRKlawwuwRQPze2ltd/xFEb2oRWMjrqWC+zhMUQUWdvIU6YUQCmqXqWp
         1wb5l0VCU0kb+QiWo5VhrB099DiSnpb6nosyuwJq+FpewREc1XLw17lS055LIMUAB/Jp
         90SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZQBY6n0XO5q0T2HKwgvRXJzUZ5cOaX1DHTrvKtmcRgQ=;
        b=gneVltab2I5SvbxuO+TIuWNS1e88Ze6vxY5QEz6bJw/P0Rb4x9TtYIMGIVlaELv2TK
         XTmNS9vdkS56osTyK0U/uwZYu6OV2/vZsEXcU+tK97yEhsTaHNcHGlXVgKCO18b27Srm
         iNlzdk+uiYpokcN5ICEOGMMnj2d3aYifziAIgB8wlheyky4AHv0jObO7Tc76S6seRCcK
         b0BilU6yhKLZo1d0qcJcmREZjgbP6dqIJTzd5v8MeNoYk/ha+0J7fUXvQ1eAFP7HvXhf
         32YcHDdmGIcFJzf+qFSMfInU3BWyUomY/jdBYBKwfu1oi61faNUtA7PbsfN6s6K7R3er
         D94w==
X-Gm-Message-State: AOAM5328af2+yFPNx2fuIHKzsQJbSnQMKsAbRmoF7m8t7fs7SIHygUH2
        O1KDkB2GFDAtc5oVtwDMDq1YvemE
X-Google-Smtp-Source: ABdhPJxoZJNOFEnGBghehlIALG5iqBCkyyl9S/OuwiXTjIKFCuFmSZtAy9FV6sbNgw7PlNToNAqhXQ==
X-Received: by 2002:adf:c382:: with SMTP id p2mr10762081wrf.283.1594999420170;
        Fri, 17 Jul 2020 08:23:40 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id a22sm13431051wmb.4.2020.07.17.08.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 08:23:39 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Subject: [PATCH 0/7] usb: bdc: Updates and fixes to the USB BDC driver
Date:   Fri, 17 Jul 2020 11:23:00 -0400
Message-Id: <20200717152307.36705-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/usb/gadget/udc/bdc/bdc_core.c         | 26 ++++++++++++++-----
 drivers/usb/gadget/udc/bdc/bdc_ep.c           | 16 +++++++-----
 4 files changed, 32 insertions(+), 16 deletions(-)

-- 
2.17.1

