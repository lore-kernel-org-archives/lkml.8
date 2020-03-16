Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D17C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E3820679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="trk/L3v+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbgCPQzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:55:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37036 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731665AbgCPQzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:55:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id 6so22142334wre.4;
        Mon, 16 Mar 2020 09:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AQf2iKCEsB/GA9ZIoAYJPyIaIBV5OxWUOZmM58+bafY=;
        b=trk/L3v++ANqrIUVITso6ThLzoP1KahOPQyG7f8RK5X5q2u/wheKNMpf80UEm7iu5p
         YM/EYZSgLlPVf3nZ/cVs67W9ZdFUUkSMnASQkzH5pE4ED+HmN8NehI4U6sKayo9dGb7d
         zIBRSuqUnxQJu9mC5j98ddHovxCBddjWuvkzv9LarLbnWbeMnxRFxli8WIadqM+P2Zmv
         3HvLdKmgkN4foVGlIhjfyjledLRYqhQtOya+ywYKYBgl9hodD1aE1UQteJSqHl1YNkVm
         qak9hC1IS0zag0Aw5T00naucmeaCjTOanLhKv/mDlE3dD8SPLYPUCXxvehtXd9EUrr7Y
         IGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AQf2iKCEsB/GA9ZIoAYJPyIaIBV5OxWUOZmM58+bafY=;
        b=a2XGwRKwU2cn80lxJB+xR91gc4kNhGAbhlKvWHmr9lmt8S014m9/9EX8nlUOwxF8y9
         Ql+moKX+oCw4fnnABcX9RyvyH5xLrF/06Omme/KavQ8YRVnt0EdC+FCqUNffKbSiwr6X
         8bgO20oOUeNx/hEPs8kCeYAMxwDZ79si5ZiYcgxc7t5ulnj/ipmnw9t7Y3HqBYb4cIQL
         Aq2JOMMbkXAwOk6wqhXcWUbbHl9XhQm7M+G8Yce2/wpLPa+flw2oyu74PJbb2M8lthk8
         aG8EIROFYZxn9E8+Cw9fFW2pgrFUw/qoHxBcRXPt+3PVnPvA67eKZzfjAfcIEQIwDoG3
         LgFQ==
X-Gm-Message-State: ANhLgQ32FxXeftGDSQfR1IkUanA6rvrAK/TxNw05wRpPD3wt+nZzt2Zd
        aezAzT736h0X3znxNC90Xys=
X-Google-Smtp-Source: ADFU+vvHWm61UIugggtzM8uXyDIcDZdkvbs/hkRGyfkWWy7W9YjHvfNGqeh/+hEgajI/lmViYUCLzg==
X-Received: by 2002:adf:e68d:: with SMTP id r13mr328647wrm.170.1584377700423;
        Mon, 16 Mar 2020 09:55:00 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id x17sm359381wmi.28.2020.03.16.09.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2020 09:54:59 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: rk3xxx: fix L2 cache-controller nodename
Date:   Mon, 16 Mar 2020 17:54:53 +0100
Message-Id: <20200316165453.3022-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:

arch/arm/boot/dts/rk3066a-bqcurie2.dt.yaml:
l2-cache-controller@10138000: $nodename:0:
'l2-cache-controller@10138000'
does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'

Fix error by changing nodename to 'cache-controller'.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/l2c2x0.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3xxx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 9438332b8..f9fcb7e96 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -91,7 +91,7 @@
 		status = "disabled";
 	};
 
-	L2: l2-cache-controller@10138000 {
+	L2: cache-controller@10138000 {
 		compatible = "arm,pl310-cache";
 		reg = <0x10138000 0x1000>;
 		cache-unified;
-- 
2.11.0

