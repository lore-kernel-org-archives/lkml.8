Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8637CC10DAA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F56720DD4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyBVNcif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgIGDRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 23:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgIGDRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 23:17:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7030BC061573;
        Sun,  6 Sep 2020 20:17:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m15so2718034pls.8;
        Sun, 06 Sep 2020 20:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6tftrKTqmWLxNHZt3+NeQEcHMJr6D4n4ARgXA8+wv/E=;
        b=ZyBVNcifZE002BsaJprml4QYAJcgg2SO9drUX2/a5M0XugYSalGy6371RUIKeju2RZ
         fbZP+nJInHH2MgCdu5NuKJtBRYQfaEpM7NPajzYhln6iX2o5MDysbh+BFvk9P2OvzDhg
         TLqUjQkSmj64GLcbzamqeZnCRaidw5en5mAf9NlRfvBoiQnYjQdqbsFJ2pcjUEYtbwSo
         2T8QpbUFDJxqwTc+LyN3VW3wUl5yFoCJBoAEi1pLE6Od3+V8Xx6ZiWD2Hh61UNw5PiuL
         64XD30/PvrbZ5r1/65ETopIWTnuRTWY4oreOplQxGLgPX3aT+wiFIC+Kvdhj1svHebZJ
         G6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6tftrKTqmWLxNHZt3+NeQEcHMJr6D4n4ARgXA8+wv/E=;
        b=MbULplQmJv5Vx6tCG8XeGuhEv3rEIuU58jzQF4GBcVG0yjv0yHw63FChkwiY/32fMO
         iV1Kh+qCLHEadLusVhBmslu/CtwpY20shQ1gacbsolj9mJDAZMUjQymyfMF4Jd2HOKCm
         F84PEPNQQ5mJzC4P0izFqKSRmDVZyfX2E+bl8AACPR98KmGeymxEP3C35XN5UKBR4UNj
         4R0UFCr1yn+Qz5gT1hYYB76dX0DN5rznh37CSI7jsKQj7qWEiRUD+VvuTeFnf5Wy6Xh/
         cj/YG93iUozqumXjTs3EQ+U92aLpwVjUeOz3cv6Td8W2dnmy378sx7PybHGeCxKxw/y7
         b1KA==
X-Gm-Message-State: AOAM5328ELGREzkYMLVY52OvX35DErqHwKNVRVc9TUZA2aizmriQXVWr
        WwswCq2kkaKvPA/hjJnC5Rw=
X-Google-Smtp-Source: ABdhPJxQe3et3ED+1OcGhHf//ZjYdHLKQ5s6mORNKZ1TmECSZhpH/1dTgVE92LB7HefXjx9JMVA+aQ==
X-Received: by 2002:a17:902:b495:: with SMTP id y21mr7006583plr.19.1599448661995;
        Sun, 06 Sep 2020 20:17:41 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y13sm6608675pfr.141.2020.09.06.20.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 20:17:41 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] dt-bindings: bus: Document breakpoint interrupt for gisb-arb
Date:   Sun,  6 Sep 2020 20:17:23 -0700
Message-Id: <20200907031724.3512099-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907031724.3512099-1-f.fainelli@gmail.com>
References: <20200907031724.3512099-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GISB arbiter can have a third and optional interrupt to handle GISB
breakpoints.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
index 729def62f0c5..10f6d0a8159d 100644
--- a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
+++ b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
@@ -10,7 +10,8 @@ Required properties:
     "brcm,bcm7038-gisb-arb" for 130nm chips
 - reg: specifies the base physical address and size of the registers
 - interrupts: specifies the two interrupts (timeout and TEA) to be used from
-  the parent interrupt controller
+  the parent interrupt controller. A third optional interrupt may be specified
+  for breakpoints.
 
 Optional properties:
 
-- 
2.25.1

