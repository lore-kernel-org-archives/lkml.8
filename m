Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63123C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1382A20738
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbtetSh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgIGDRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 23:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgIGDRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 23:17:39 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82E9C061573;
        Sun,  6 Sep 2020 20:17:38 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s2so5773381pjr.4;
        Sun, 06 Sep 2020 20:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IKiXYes+fd9b8uPkxG0NZPJpkPZlWwEapAM6b4VhKkM=;
        b=rbtetSh6ATT+Il0cuPv+1iaPt+6O0OaICZkqINSan0JDc5lV2xrFVEBPxC6SF5XVsN
         IhVeeUcJjBzwHWhO5jvHiAG1bWmoeI1t2TVn2YRYXo8M1NrTP1wmBUXLvuYPqI1lCIBw
         FonkX+TcEGxN0Atd+LJmbQm3m4XnPyOosyOPN2lAvC0yV3xxJgZ1AkKib5Mp42lKrhj4
         Ik3qMkTBMEqUWdZktBU+wZpvqb46Wkq2UYBouWK1Q/5Nq++EGk53z8oHvaZRhb+199Xs
         5Y0lPmrlO/Bf2hPtrgTLiuUSkZjquzUs6rziRywSqzAToZaeoBIvs5p2gwt6PB+RHsKk
         J+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IKiXYes+fd9b8uPkxG0NZPJpkPZlWwEapAM6b4VhKkM=;
        b=eTxNwYPLg+UX8QsQJOhJ0KQauxAw/vcTBw0IvDvoXMv+wWro2tU8cEu0QkHQheq5yl
         aKezfhOedhoWW9hkn7INan0IV4NYMEspyUgv378grJckzA/tSIfO+LmAWNi/pg7yBddc
         KoMTB73eMeaNs2OtwfqpE6hPvC92iHnkVhHodxRU1J5ATqdqNDfbUq7/zW4x4P/Sru1y
         oCESZsZU35kFNL5RHV+cvrnm3L7k6ldYqp4PcCJkjXz8zCnLgq3hiOZx5NawapRzOp2p
         2jOhbbfpNgL/N3dHvwx47n4kuovQyyuWo/57I4N57BSlygT3y9XMAhKO0pamm77gKpWL
         aXrQ==
X-Gm-Message-State: AOAM530evMpV7eSGmLRepOyXRO4G5tdD5S3CTJtQ9yBIsXb7Ys9sgqgE
        9mSNPz+U4UIIZC+p3+BcM9o=
X-Google-Smtp-Source: ABdhPJwt5Cn30TfGzIbnA275YoFgftKaww9m721H7eGQirmKQxJ3prOLuR5caZALv5MAD7jxLvYFkg==
X-Received: by 2002:a17:902:a9c2:: with SMTP id b2mr17830363plr.56.1599448658007;
        Sun, 06 Sep 2020 20:17:38 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y13sm6608675pfr.141.2020.09.06.20.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 20:17:37 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/2] bus: brcmstb_gisb: Add support for breakpoint interrupts
Date:   Sun,  6 Sep 2020 20:17:22 -0700
Message-Id: <20200907031724.3512099-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series adds support for GISB break point interrupts which can
happen when a specific GISB range has been locked out by a security
processor. Being able to get a debug message when such an access occurs
greatly helps with debugging production software on Broadcom STB SoCs.

Florian Fainelli (2):
  dt-bindings: bus: Document breakpoint interrupt for gisb-arb
  bus: brcmstb_gisb: Add support for breakpoint interrupts

 .../devicetree/bindings/bus/brcm,gisb-arb.txt |  3 +-
 drivers/bus/brcmstb_gisb.c                    | 96 ++++++++++++++++++-
 2 files changed, 97 insertions(+), 2 deletions(-)

-- 
2.25.1

