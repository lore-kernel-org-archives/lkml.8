Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15919C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19A8246A1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUwJLlVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgB1GOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:14:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33173 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgB1GOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:14:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id x7so1657925wrr.0;
        Thu, 27 Feb 2020 22:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fknAu4Mi7mPoGch0tjoJSjMYmeswX/bt/k6r2YfuwWE=;
        b=VUwJLlVXSKSgcaIhw50JvvmveSXLCDh1CGogCEz6lY1i29ZORjezua0aUrYDvKjrha
         MdGmcns+aYzVqlJMcmsJksgBCbZQraZJAfjKOOkhMhtpTUPP4TysyoaDqLZyuvTWhEEX
         vtcoKmzezrGBibu1JPmMDFYFHvnJq2o0NOnXIyd6MQBuYT6f4sr/WecMVe8CO+p7R9Nw
         wZtuIAcgL9gdrsGJECb68Cfmc/rthyi0qLTKIBq+gq7FT1YvEpsW6MBQ6IMkrBXjj2/n
         V/ti3NatCujPiuT54QMWuJztFIpJHEJ8PalUaEi98DrQQkaPeNOdRY4lqm4LE2P6sRJt
         xOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fknAu4Mi7mPoGch0tjoJSjMYmeswX/bt/k6r2YfuwWE=;
        b=tZyYwNM/0OZOEZ7n8QYQ9ukNjPPTXDVGiAbcP5XGnJae1Hb2Le2PHIMLKFqYcHq0by
         npEUbIZ5b1QKEzsl33TRS6bRd4QjNEhvDeJFJwnDnPlx35Oyn0WkG2uy/aFMCdI/vKEU
         TmDBRaHgyANvZfG/T2+XtyC9NtgMUB9zy9ne7oTXx4yx9AuGNJ0knuHbHTwIoVxUxo7N
         86xC3Str4EL8qbU8F9OBwTB3wM8KtYOylwz4uQ5mJUgVojt9qtqsLqESx+61op1wexCt
         /hlYZUHQJvrhbY18Lcylc+1ba1bPTOOhCQUQ409ALqyNu9aBBK8ygj7Dmrg2YPOZkwyV
         8FuQ==
X-Gm-Message-State: APjAAAVXhim08yCx9Mk0uL83YdPvIZ12/RYyCo/gT4sglJiuTjEcN7At
        V61vStwwTdD6C5eofSeqipo=
X-Google-Smtp-Source: APXvYqxErNBAtzXh8TNUphjZpmr4q6vyV2vjAJ24Bzh1e+oe8X1teN/nm2W6cUBiA2AP/eUn8fffcg==
X-Received: by 2002:adf:f892:: with SMTP id u18mr2954643wrp.328.1582870484010;
        Thu, 27 Feb 2020 22:14:44 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w7sm682554wmi.9.2020.02.27.22.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 22:14:43 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: arm: add Rockchip rk3036-evb board
Date:   Fri, 28 Feb 2020 07:14:34 +0100
Message-Id: <20200228061436.13506-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200228061436.13506-1-jbx6244@gmail.com>
References: <20200228061436.13506-1-jbx6244@gmail.com>
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

