Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD0DC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E25E246B4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2o99Rb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgCBJ2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:28:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36758 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgCBJ2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:28:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id j16so11614441wrt.3;
        Mon, 02 Mar 2020 01:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fknAu4Mi7mPoGch0tjoJSjMYmeswX/bt/k6r2YfuwWE=;
        b=c2o99Rb+A9AQ9FPzgwZKoZcoZNdvDOZLXgkynZGdcgs4YGzUyqDjKIWyEG3bWlDMl8
         zqlSN01fxUWAMKdv5y+D9ZaY2FwedSsk55BG+hO21RkNYE2i5nNzhjpIyRb3rvRUi5oh
         NH6Ovi8MuLjskr4lmwTCwdamwzQEBWXDxwbVBYK8CNWr7jAsS1/GzgLDGZ28rZCeox1/
         JC82bd1OmxriXshLCDJGdMjAi7Iib+roOE7yrXex3Hcj3kwL8dOIz4CCu0YsHfqFl/Vr
         y6xbuiR12kNOqonU2RWoBhx7w3oXcjY6S5JqzK/FtTXwBBSFF/I8lLu5eVsIzxNzPvLQ
         hoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fknAu4Mi7mPoGch0tjoJSjMYmeswX/bt/k6r2YfuwWE=;
        b=GxKIN8aagJW/HHVjY/Qg4JkJVgI+zsYzS6Lrzrnr5GmZB2cJPakFJiMUPxElTJAoE3
         JKADCEksLgMbT5StQYTEDpX2AxesaqvHnQ7+bKnMCQWvzu1VkXnswFwTGHc5fVxXEtj/
         rdn/O3iSbGbd3zZiJMIab4P5uq1dDnY/l6Ij7d46u+ZzsfdIM5oa7CRyNX0VETUPUYve
         uvGDVyaaDWPyoFx1aJoZqri6u0ndVpR3Penov3VaZC2eQFotsZ2yFTIjVk5PZtPHfNRx
         /lyoEnBeFrilNWAH5J5bK6PLlhyRjmwiSCfhkRWPLNmvmgfe/TEhWn1RaXx6rahoPoSA
         88EQ==
X-Gm-Message-State: APjAAAVE5xnXxo7Ffmg0SWKq39XlyN6s2nuiZjkhrX9jXbWHc2ZXipke
        qiKp26Zpdv5hp5kLgKlywH8=
X-Google-Smtp-Source: APXvYqxXlaMIucYPo55iWHhBI6sB1zHQmuSaeo2TekBQf3XjDtq0te5TlDq0lzQBCK4NO256i+X+eQ==
X-Received: by 2002:a5d:4d48:: with SMTP id a8mr21138127wru.35.1583141288142;
        Mon, 02 Mar 2020 01:28:08 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id m3sm6409586wrx.9.2020.03.02.01.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 01:28:07 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: arm: add Rockchip rk3036-evb board
Date:   Mon,  2 Mar 2020 10:27:58 +0100
Message-Id: <20200302092759.3291-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200302092759.3291-1-jbx6244@gmail.com>
References: <20200302092759.3291-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives this error:

arch/arm/boot/dts/rk3036-evb.dt.yaml: /: compatible:
['rockchip,rk3036-evb', 'rockchip,rk3036']
is not valid under any of the given schemas

This board was somehow never added to the documentation.
Fix this error by adding the rk3036-evb board to rockchip.yaml.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/rockchip.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 203158038..d303790f5 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -468,6 +468,11 @@ properties:
           - const: rockchip,r88
           - const: rockchip,rk3368
 
+      - description: Rockchip RK3036 Evaluation board
+        items:
+          - const: rockchip,rk3036-evb
+          - const: rockchip,rk3036
+
       - description: Rockchip RK3228 Evaluation board
         items:
           - const: rockchip,rk3228-evb
-- 
2.11.0

