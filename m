Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03F2C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 15:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735A824699
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 15:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVoOoG6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgB2Pru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 10:47:50 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41726 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgB2Pru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 10:47:50 -0500
Received: by mail-lj1-f196.google.com with SMTP id u26so6583963ljd.8;
        Sat, 29 Feb 2020 07:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tog/pAf06KNFgFu4FcTsoNuZ3R7bNzFtAnXDa+lS9fg=;
        b=LVoOoG6uWTa9YlH/w4GM/bE5Kjz2b8mLGUPHYceGJv3sM0etpnkzqD0lONdWxzEnxt
         T2dCzb4sWBEOXYJ3fGcT/P5QXViZBWiIAxiNAs/0a2pxRbinIvd/V+crPtE9+n9hAOTT
         StOj+YPzEBovfKhbHFh+v8k3ygDwzkmbCs2vEpNv0pTeJoqiMzpKy5AS7QZYTOqF5T5Y
         8YCS02/3WMUOAy8nmMNF0UXBLiCwGxTUCZM4necc1oKvjtqLhneF4MDGodpoj+9VKIjb
         QdJwFBIcWJKfPFw5y6czjEq5agbB+myxnHqlcBHdS8HF+1hi5Oyqn0N20Gs9Zxtl4Mvp
         Cl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tog/pAf06KNFgFu4FcTsoNuZ3R7bNzFtAnXDa+lS9fg=;
        b=WyRPSKmwtsoozQfmNS3l5Ieh63rA+tmVsEZGbjZm3haplNZ0chROKxET4JGTRpdoCK
         t2kyw7Ew1NZvmGAYAiI5ekTP5rmtMhRSI/r3JPb3P4mPHeU5MZk9ZvSZToAmXyUN+0R9
         x6y2wKP0WSIuMbfgUPQEVyc0sJR/31YUNEt6Job7dL6mA4r8T3IaoR4JKsBRHmQhS/eD
         +4kSiceQndgJu3/zKE+HZf6CkafmtY03wgb5WNLdgiRMMOx4SRYEmNT47PRN+3cdh+bQ
         cxJIBUbgFvfNdkbxuQeNSmruDr9PK1U+Ea1rsOUc9sXs/5hqZjI2ELzX8B8h2nZyWtfJ
         UdoQ==
X-Gm-Message-State: ANhLgQ0bkETlH+PbtrL5jiVaSWIEOVXY0tj5+IKinhQao93HgxyDJEut
        R73B3gpKQS8Z6AYaHe08Sfc=
X-Google-Smtp-Source: ADFU+vsSMc/FZvJlefaWuLD76s3Qnh3X+NY/DbOsLYF4tZ6d+m9sR0EafudhEaum6TLLYqQbv8SSyQ==
X-Received: by 2002:a2e:3504:: with SMTP id z4mr6292186ljz.273.1582991267806;
        Sat, 29 Feb 2020 07:47:47 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id g20sm7294786lfb.33.2020.02.29.07.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Feb 2020 07:47:47 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm: amlogic: add support for the Tanix TX5 Max
Date:   Sat, 29 Feb 2020 19:46:53 +0400
Message-Id: <1582991214-85209-2-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582991214-85209-1-git-send-email-christianshewitt@gmail.com>
References: <1582991214-85209-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Oranth (Tanix) TX5 Max is based on the Amlogic U200 reference
board with an S905X2 chip.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index f74aba4..4003206 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -136,6 +136,7 @@ properties:
               - amediatech,x96-max
               - amlogic,u200
               - seirobotics,sei510
+              - oranth,tx5-max
           - const: amlogic,g12a
 
       - description: Boards with the Amlogic Meson G12B A311D SoC
-- 
2.7.4

