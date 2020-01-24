Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F30EC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5231420838
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV6ntgB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389699AbgAXQa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:30:28 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36533 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389927AbgAXQa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:30:26 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so67313wma.1;
        Fri, 24 Jan 2020 08:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ma8EEHyJQOUo40MQ8HAnhmncQWACdEusOuKxQidJjKI=;
        b=kV6ntgB+pNXteyIG5sQDdsiztdm3UBUUCJyBoyHiHmxkclFVPND0S3W3Vk6VtIjf5J
         XmoZK93FpxIBE+t16nwoSXdf8iEj5II8LtZLoFrtJBk/poXhgEfUVt06lYqC4g5zT4DC
         dGO9DdbcAxTDQYOQb3gv9WroclH0OUq6kFhDNj/m7L03ZIU30FXeAiem8DceUgivY2NV
         JMRgC7XDzZKwOXHZTFkZFcRlhgjFLQfCpzHh2sHkpCYUQsdm4KWzsS89k5J0249uJT8J
         kPP1QgcGvxH9NjtTV0QMpJoIUX62vqavosjYUaEzOHX2HGAzNx4vxcjDaQlaaDv1VHLI
         DfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ma8EEHyJQOUo40MQ8HAnhmncQWACdEusOuKxQidJjKI=;
        b=NVTdDNHjmyJnczZGre7PtpzKUE4V1LoN0IIp2cP3KjdeNw3YEX21VJfD4RIiYny8Tw
         IA/nFmXN/2hpoHog2eTtr/kuNPj3m2SHMnBMFzezm6yaiKClt4tZFo9c3mCA/XVAptvw
         Sx1JNqnAZWpm1pVnNAx+qm0/dih2CQibHCF+7sT3dOSMDYAN2CfzVuJ76dPZg+Knc2GC
         sxHcxUyLRkndgEQmli49BctWOKLPIJNn5/mE5iz8LiFQ9WyJF/JSQ4usUzoR619ChNFx
         sCGFOHcJwZk75znYL2jK69ZK20p/Rd3JNEb0MkG7m7Mr/4cewmQaXBm32IrOslzDIf/u
         9Nag==
X-Gm-Message-State: APjAAAX30fvlQNRacoVXO5Eyej6Dpy4Gnt9SoisM9zQQNth47zmo80kL
        pKpGZ8T7no5cres5TmbeMtQ=
X-Google-Smtp-Source: APXvYqxRFPMGGtg+KpLSBpXUNcXTEuVXdOJ58XYB81RM8BMMGfpOR7Z3BO/sFZG6zDyKioVd3UJFjQ==
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr30871wmf.113.1579883422270;
        Fri, 24 Jan 2020 08:30:22 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 205sm1977304wmd.42.2020.01.24.08.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2020 08:30:21 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, yifeng.zhao@rock-chips.com
Subject: [RFC PATCH v2 10/10] ARM: dts: rockchip: rk3066a-mk808: enable nandc node
Date:   Fri, 24 Jan 2020 17:30:01 +0100
Message-Id: <20200124163001.28910-11-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200124163001.28910-1-jbx6244@gmail.com>
References: <20200124163001.28910-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the nandc node for a MK808 with rk3066 processor.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a-mk808.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-mk808.dts b/arch/arm/boot/dts/rk3066a-mk808.dts
index 365eff621..e33c85699 100644
--- a/arch/arm/boot/dts/rk3066a-mk808.dts
+++ b/arch/arm/boot/dts/rk3066a-mk808.dts
@@ -133,6 +133,17 @@
 	status = "okay";
 };
 
+&nandc {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+		nand-is-boot-medium;
+	};
+};
+
 &pinctrl {
 	usb-host {
 		host_drv: host-drv {
-- 
2.11.0

