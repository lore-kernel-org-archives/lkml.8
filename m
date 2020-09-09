Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0826AC10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8C4D20897
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="CeoXEIZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgIITsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgIITsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 15:48:25 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C32C061755
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 12:48:23 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id ay8so3892334edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 12:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jGoxTNHQetF7fWue/FsBwgBc5cdIuqMc5s44Uajfba8=;
        b=CeoXEIZBu6YhTVERAjUZGRjiPJZspQoOCh5rpLEodjsvPqEnEDRgWGpaELQrPeObQv
         CeKvNjw1eItFKS6YX84cs4eS8XJ8DxwjoZ7A8A3tfcvWCFna4X/Kkg6xM3EReyYhK9Sk
         OcnSfiljESAeHPf1QGN79OVLMCrGiOIU+apdTZ+0adyqnz1pccwwzkQFx0QryK2dENx9
         ItsPyFKrqsjB4CKKs1WIw0NRMIyHVHw7dFWLVCtSSfFcBut/3Mhg48lo7wh/QnFn+QOL
         meZzMneUjsW5SOObIlAH3TMIpACofHUvcczGb2IKw5bn4wYyqdNwRcfLJm70q4oinaH8
         FOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jGoxTNHQetF7fWue/FsBwgBc5cdIuqMc5s44Uajfba8=;
        b=q8O89u8ZksSuUbAov4A6gxfGQehTE2H3cCoLr4mIXcFP3jO190RAfuZ2BmBILgztnj
         Hij0Q1YUSH1oNVZdqgIj9F267dGXdED6JkP79GYAbsk6URgTwS1JjzOIJvm8coO9fjpr
         fkG9JwV38xd99lnRGm4o3M/6dyvDj5iJrIxEB1zSoz5wqJMJ2djXg3MPAbCcZ3KLYAiQ
         +hbMtBfF1wXH9zOWHyPXVhG8mLeY9kDYU+S9BpWY3gA1TMzVBKYrmiPaNCWz5KdfUnoM
         Ym4PhDsoYK+AYAEWCPpIjR2a+HbnX0UfZCyZWYIEvQlDS805Cgdm1IMOKLUTEhoFVwHx
         zu4g==
X-Gm-Message-State: AOAM532tzJIX8yDihZyVwmQM7Gdv9x/nQfCCUIWIsLO41tL7jPRDmQap
        ferh/VGd8zAJ652/SoxpJPwvrQ==
X-Google-Smtp-Source: ABdhPJy+AsLa/GrOqTK4l40JtalccZr5BVueT0w4yBYWM6KSdC/BeSG+/ge730Qph7akQNgiojK2tg==
X-Received: by 2002:a50:f1d1:: with SMTP id y17mr5521552edl.231.1599680902299;
        Wed, 09 Sep 2020 12:48:22 -0700 (PDT)
Received: from localhost.localdomain (dh207-97-133.xnet.hr. [88.207.97.133])
        by smtp.googlemail.com with ESMTPSA id hk14sm3461452ejb.88.2020.09.09.12.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 12:48:21 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH 0/4] arm: dts: qcom: ipq4019: add more boards
Date:   Wed,  9 Sep 2020 21:48:12 +0200
Message-Id: <20200909194816.3125213-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for some popular IPQ4019 based
boards.

This patch series depends on:
https://patchwork.kernel.org/patch/11765789/
https://patchwork.kernel.org/patch/11760437/

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>

Robert Marko (4):
  arm: dts: qcom: ipq4019: add more labels
  arm: dts: add 8devices Jalapeno
  arm: dts: add Alfa Network AP120C-AC
  arm: dts: add 8devices Habanero DVK

 arch/arm/boot/dts/Makefile                    |   4 +
 .../boot/dts/qcom-ipq4018-ap120c-ac-bit.dts   |  28 ++
 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts  |  27 ++
 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi | 255 +++++++++++++++
 arch/arm/boot/dts/qcom-ipq4018-jalapeno.dts   | 215 ++++++++++++
 .../boot/dts/qcom-ipq4019-habanero-dvk.dts    | 305 ++++++++++++++++++
 arch/arm/boot/dts/qcom-ipq4019.dtsi           |   6 +-
 7 files changed, 837 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-ipq4018-jalapeno.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-habanero-dvk.dts

-- 
2.26.2

