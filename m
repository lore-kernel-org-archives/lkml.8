Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553DAC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A174246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWbwqJ5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgB1GOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:14:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53766 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgB1GOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:14:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id f15so1939099wml.3;
        Thu, 27 Feb 2020 22:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gnsdy3185ncPeDCu04aM13mod5LknXvQmY6PFV6k+Es=;
        b=sWbwqJ5FFtEag/dRIgtrIWnyWc+3s/A91H3JPqrpyB+iE6SQogJjDL1r+AI+DJ1EEw
         zWq2oGLU9ArISWq5LR+PH+fjBKVjSbZ5RhiLdJvxIih/TJMTzzvr2EYKbDddKTGxs6Zv
         SCSRivHvVGozcmJPj1za9jv4VireOKoEzQ7ZFnCQfZhGrg0hraklxJxjuMRUVTfqhJl/
         BZBPqNsqGvgx7sgSRJGQH2tFWSqtzozR4ckbUtxxAxXvGMvLachJ+JXRGvn+nMDPKZdC
         Onb6Ykx1imL8l98OALk5VZt9gTR9GRwY5YVUQpd84RXGUm0mzjd7otq3PudlpGQqerdF
         14cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gnsdy3185ncPeDCu04aM13mod5LknXvQmY6PFV6k+Es=;
        b=ES1kC23zHSgqg/cLjsDZy7oD/WujVtZPMC0sMJ21TWRvIJVc4/+V/CdHRtPO1fU3F2
         mVO3MtFVPpU1aIsHB8q+CfkBuJx9wl+1RcCEdR2d58UD82OtvxnnEUPFAHbnai7RSD9h
         WR+5J22juP3wpP8zJMyCshTrsdLAGlo3LZ0wLDqB0MP11sUuPi0/nAM2rFiqKPzR6Pxn
         SkX5HJRQKVx6xaiBCGQ0hwJ6sRi/dJcU99EdK/CtlxOrJgwdOfuoQ8ckAZuiz30Ln+FL
         0678txOjQruH70hrJ+eNZp++9SkCd7gGyjhD3f6K4n5vnwfA52ZNXi3aTb8K9/rNk2kV
         2aOA==
X-Gm-Message-State: APjAAAUmL52R+Ah+oJBSUaPG3y/Q9sFCBGoKK27OZauzu5ZXGmPI5MXo
        lLoj00GhuNFNk1XI2p7Y9eA=
X-Google-Smtp-Source: APXvYqxvicgbrGm82t+XVd96YBTlzhDK+AmuO43jDyiUn5cCb6UCtMVmCCw2P8kKev3sOpHQ65zqEA==
X-Received: by 2002:a1c:f707:: with SMTP id v7mr2964697wmh.121.1582870484899;
        Thu, 27 Feb 2020 22:14:44 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w7sm682554wmi.9.2020.02.27.22.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 22:14:44 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: arm: fix Rockchip rk3399-evb bindings
Date:   Fri, 28 Feb 2020 07:14:35 +0100
Message-Id: <20200228061436.13506-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200228061436.13506-1-jbx6244@gmail.com>
References: <20200228061436.13506-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives this error:

arch/arm64/boot/dts/rockchip/rk3399-evb.dt.yaml: /: compatible:
['rockchip,rk3399-evb', 'rockchip,rk3399', 'google,rk3399evb-rev2']
is not valid under any of the given schemas

Fix this error by adding 'google,rk3399evb-rev2' to the compatible
property in rockchip.yaml

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/rockchip.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index d303790f5..6c6e8273e 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -509,6 +509,7 @@ properties:
         items:
           - const: rockchip,rk3399-evb
           - const: rockchip,rk3399
+          - const: google,rk3399evb-rev2
 
       - description: Rockchip RK3399 Sapphire standalone
         items:
-- 
2.11.0

