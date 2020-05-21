Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B50C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94CBC2078C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i/ZsB0BA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgEUAt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 20:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgEUAt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 20:49:56 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B02C05BD43
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 17:49:55 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f134so4155970wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 17:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Am2t2mnt7N49123WGfLB5801qjzz3v/XhEpUQAXEUsw=;
        b=i/ZsB0BAL3fzRozhXnvMrsn5pvn7S/V77xiEqAlliP41SzUds+7qr5pSbaYRKGQhH9
         oc5VKncux/1bbJ0LuCkLIN3F/n9K+RPU84LF3C9vGWSn+tnFYf4LPC4qT0bra0xc1ifF
         ZQ7nJQkEwh/KUlnOctGvo6RZrQN/P1Yj58io499Fb1mFJy/X8epccaRMX5G+1kJhv67P
         2kBlvExdBe0RDujXtlMhR1pP1VK0FLLvQcjldeqxXtQ1HU/lbOuaFVKbveRXiuJuYmiR
         pDcJfdqY0fF0iUeBlVca4mlgTFWLqt8vY0OfihFBsQflplKhMmILEE6xRY8ceN+NdKKE
         h/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Am2t2mnt7N49123WGfLB5801qjzz3v/XhEpUQAXEUsw=;
        b=Yy8bctMkHUhu1/cUgnbXkJSDuhYCc+wzyrefKJ3U2sSZA1f4d2HVuDKaITd4DeoZci
         mXnN5GrD19KIWksfK7hhebUzXA8vFLqsfIMEIsH/cFFlqyH9nJDHLq294GsoSR6jBY/b
         3ohBfLt+rwDjb77cmcgZ0eRAcKEGST8bweUobBm0nfA1JJB5V8II1utM2uqxlTxuTXQP
         HrBbWEtUP1tyfE6pHMmt0k3FHrcDfTmA04gSk9dncGE0z2PYgg76IGHEOqsfhYkVluSh
         T5wS5WzvjsVIPAAy+d7zma19uGgq7VzCcd8uE8lUCMVG23cvaECeWTBpc03sWyBcUDlu
         bHbw==
X-Gm-Message-State: AOAM531vUpysYVlp4582eadCjXZKUkAxs2otV0mFlNBvxES/jFWRyUqB
        tf5ahHmcbxU6qbRhHA/WbU45HXsdybE=
X-Google-Smtp-Source: ABdhPJy4aIHAEm8NTOBZRArUhB3Y0Eu/tolAtJ1efUCcys30IaqYQ/Hkk0ojFE0n07ctT7ptA0vmVA==
X-Received: by 2002:a7b:c951:: with SMTP id i17mr6274257wml.63.1590022194537;
        Wed, 20 May 2020 17:49:54 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id s15sm4536798wro.80.2020.05.20.17.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 17:49:53 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, bryan.odonoghue@linaro.org
Subject: [PATCH 0/2] phy: qcom-usb-hs: Add DT controlled VBUS pullup waggle
Date:   Thu, 21 May 2020 01:50:29 +0100
Message-Id: <20200521005031.747162-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On an MSM8939 we have a system behind both a type-c controller and a USB
Hub. VBUS is not connected to the PHY and no GPIO is available to signal
VBUS state to the USB controller and PHY.

In this case we've used USB role-switching to transition between
host and device mode.

The current code in qcom-usb-hs only touches the VBUS pullup control bits
if we have an extcon but, setting those bits is still required on the
example I gave of the MSM8939.

This series takes the downstream concept of a DT driven flag for the VBUS
pullup bits and applies it to upstream in the poweron/poweroff path of the
PHY.

I've opted to unset the bits on PHY poweroff though in downstream the bits
are only ever switched on if the flag is present, downstream never switches
the bits off again. I think though, setting the bits off on PHY power-off
is the right thing to do, so I've done it.

Bryan O'Donoghue (2):
  dt-bindings: phy-qcom-usb-hs-phy: Add qcom,enable-vbus-pullup
  phy: qcom-usb-hs: Add qcom,enable-vbus-pullup support

 .../bindings/phy/qcom,usb-hs-phy.txt          |  8 +++++
 drivers/phy/qualcomm/phy-qcom-usb-hs.c        | 36 +++++++++++++++++++
 2 files changed, 44 insertions(+)

-- 
2.25.1

