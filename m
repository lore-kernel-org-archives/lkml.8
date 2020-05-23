Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EAEC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 04:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD5A206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 04:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NckDMGHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387590AbgEWEMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 00:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgEWEMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 00:12:15 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1CDC05BD43
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 21:12:15 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k22so5198760pls.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 21:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gEbiXPOVzb6l609iXNKKkbZ9NpmGZQsueDMQ1EDDZ9s=;
        b=NckDMGHMskW1gWZnB4u4TCZi03QywErgjTEeoCcEP1lCZtUJXH1X6w/A58bfy6Wq1s
         VzCAscttd/0oSduppqZw4RtDIFJ5Dafn+F/gwezXE7mC+aM4GpsiCmTFbtHnc30FPOnC
         TQMqW6dkk7vWOVpC3NV2yJ4C5iZPloiDGyBOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gEbiXPOVzb6l609iXNKKkbZ9NpmGZQsueDMQ1EDDZ9s=;
        b=eUJ0O7JRsq5Vnc3xKg4hiO0wewm+trYDQ3EoS3z601/roD5XPR5A4mQDRwrFvAwT1P
         x2+7sy/4iHxqQtfgS14aMlkDWKQ29aDAd2RF1uI3y2jrBI7KN2myuNpmdIqbiLr4Z/P7
         uBNsXm5iZQK+lb2ErpKLuaQD0+8ii5If9Nc+FW3CGpeS/X5UNGoK1EjozycSCZfDLNY3
         xotR0AIfX13GmF0HgQRge7SCsJfAsl2bSQ1uy/dFMB2igt6Izl7fi1EVXUYZhoyHvMBz
         NkFKNU3tn0nzhFXRH7YSV8yzH4bfj2ueZl3DjI3zByFdbMWi5kt1wR/plO0z2pMO4QOS
         /hDw==
X-Gm-Message-State: AOAM5306Sl+j3Q8AFD/M+p/oIfXnafPfRRZHytRGKEWVDCyf3xPpzK6C
        MB1D4BoXBEAw4gfjlMGEpF5CoSHfW/c=
X-Google-Smtp-Source: ABdhPJyzSVHR+OuuJlxIZf66mUdu8x7cQ6x8OpG1RuDyYZsBABX4xWRimyeWBsQ3DY+83Pr7ASzQWA==
X-Received: by 2002:a17:902:6b09:: with SMTP id o9mr16542135plk.100.1590207134669;
        Fri, 22 May 2020 21:12:14 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id h7sm7075741pgn.60.2020.05.22.21.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 21:12:14 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:DESIGNWARE USB3 DRD IP DRIVER)
Subject: [RFC PATCH 0/1] usb: dwc3: Extcon hotplug support to of-simple
Date:   Fri, 22 May 2020 21:12:00 -0700
Message-Id: <20200523041201.75217-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms like rk3399 would like to power on the USB PHY layer only
when external devices are connected. This patch introduces optional
support for extcon USB_HOST events, so that child devices are
populated/depopulated when external devices are connected/disconnected,
respectively.

This is also useful since some PHY drivers like phy-rockchip-typec only
configure their Type C Phy on power on; if they are only powered on once
at boot by dwc3, these drivers will not be able to reconfigure their PHY
for peripherals plugged in later, like (Display Port) DP monitors.

I thought I’d send out an initial RFC patch, for comments and feedback
about the approach. Depending on feedback, we can refine this approach
and modify the bindings file.

Thanks,

Prashant Malani (1):
  usb: dwc3: of-simple: Add extcon support

 drivers/usb/dwc3/dwc3-of-simple.c | 149 +++++++++++++++++++++++++++++-
 1 file changed, 146 insertions(+), 3 deletions(-)

-- 
2.27.0.rc0.183.gde8f92d652-goog

