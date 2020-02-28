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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C318C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E2B246AC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iR/lE70W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgB1PyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:54:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46470 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgB1PyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:54:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id j7so3428320wrp.13;
        Fri, 28 Feb 2020 07:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M9Kwu3SWVjUR0QlpKz+Qj4yHox2icU+uJW/FEvY6z9g=;
        b=iR/lE70WvXZfxCZGgNi3yNG8JV9JYIq9yGC/908jVx3v8HEpHbnf+VMxhIhHMQb2/w
         ANhVztbKYczLQwp7w0hh/ErfVlIgL/ZKFICmcz2E0rlrlglBDoQQfCk+EtOPtzLDlqCi
         +fRKmw4rAG5oBolmGB5kueTin2gVS5CSzpFyZ3lpeayC4P7vANVcq4oNnTiUxI92agC6
         XLisfb3so6N4ZA63WtInJZ0ZuxU9oK/H3BVWrJrzGVQbInwzSpBsntDajHpyQ3mw2XJi
         HlMcqXSoNbuPs9CuVJ7XhR4AjQKQPsl+sEJCv9wnQkqrUwvUs0ekXTtwl+wXopJq5Ug3
         nJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M9Kwu3SWVjUR0QlpKz+Qj4yHox2icU+uJW/FEvY6z9g=;
        b=AmoSeza7IIcJuTayiL0QflT5R2XcSGyM4Yacr0Ode/RfeDSy+BdSsaxi1SqAg8DY0n
         DKh2vDL9FoGqO5y5Sd9eGkQWD38TbsligmLAySKOW8p01ENe5f6vaGg1DaaEmodKC8Zy
         g5Y4+aERejKuPmyWEBMpchlAZ9aHOTZx3xt6t2xqMm2tM+CrowB2REWEvSvojZ6PH4PO
         E8/61Zyh7PLu672uif/1CJCXwAy0gwwYuXHzRUX+dMYTSZi7uksYggkQOotp5p2cyxqG
         gYrES1Tmv7IFcizHoPQ138VwMZUcGTep4Rb5SPIatEkhPCCrLcfZ+tiXqHASy2fcl/EW
         hhag==
X-Gm-Message-State: APjAAAX7tboG9q9O7jm0SD+FfC43tv+qCYZ9S/3EG8figvsLH5daHuZJ
        AMECx67+Lske/1BHY6keT8o=
X-Google-Smtp-Source: APXvYqwYXkK4g5VxFmULSk2KUCbUp0Rg3cowIjv95fjxucVHABt/NLUJdkgCdL+IWzIu/YSUAfbKuw==
X-Received: by 2002:adf:f846:: with SMTP id d6mr5288458wrq.125.1582905244576;
        Fri, 28 Feb 2020 07:54:04 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id m125sm2706605wmf.8.2020.02.28.07.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2020 07:54:04 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: rockchip: add sram to bus_intmem nodename for rk3288
Date:   Fri, 28 Feb 2020 16:53:54 +0100
Message-Id: <20200228155354.27206-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200228155354.27206-1-jbx6244@gmail.com>
References: <20200228155354.27206-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example these errors:

arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml:
bus_intmem@ff700000: $nodename:0: 'bus_intmem@ff700000'
does not match '^sram(@.*)?'
arch/arm/boot/dts/rk3288-evb-rk808.dt.yaml:
bus_intmem@ff700000: $nodename:0: 'bus_intmem@ff700000'
does not match '^sram(@.*)?'

'rockchip-pmu-sram.txt' inherit properties from 'sram.yaml'.
Fix this error by adding 'sram' to the bus_intmem nodename
in 'rk3288.dtsi'. But 'sram' is also a node name already in use.
To prevent confusion rename it to 'pmu_sram'.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/sram/sram.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 9beb66216..039e8aa70 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -718,7 +718,7 @@
 		status = "disabled";
 	};
 
-	bus_intmem@ff700000 {
+	bus_intmem: sram@ff700000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0xff700000 0x0 0x18000>;
 		#address-cells = <1>;
@@ -730,7 +730,7 @@
 		};
 	};
 
-	sram@ff720000 {
+	pmu_sram: sram@ff720000 {
 		compatible = "rockchip,rk3288-pmu-sram", "mmio-sram";
 		reg = <0x0 0xff720000 0x0 0x1000>;
 	};
-- 
2.11.0

