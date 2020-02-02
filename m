Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E81C3524C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 16:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F5C20658
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 16:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u340iptu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgBBQjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 11:39:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45686 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgBBQjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 11:39:43 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22so4837202pls.12;
        Sun, 02 Feb 2020 08:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Gk+4kc7bcxmwm9qBtI8zt+2lMveHew9wDQSMTXKODNs=;
        b=u340iptusySS+Qerd7xdlTZcG85z+DOqIyNwWblPk+wKd/mjQdeyRPNZ7tBZILZJIU
         nLV87YzIrIaRUKOelw3zWhxGoxtSvfreF1prYR5Pq62u0z8YNovPC9zt6nh2cwbjH/xU
         CghTk52t3ZfZA8TdMu+FpUYi0PWJGQ4TMEGJ7kX3M0Daqaj/hkxY+FE65VS8OoZyUCut
         j1ag2/RLZSbf270ZAbGE1fAavbl4+qN/li3DtKCKBYrz47bzgIM1fQN9UTVdjA/2sG6K
         wExtbreSjQ/f6DMKTK6vwlgBuwBWv2F+yMOdtPnvi/bNPyBoJmFKblFcDAxiEpA3ndUt
         sAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Gk+4kc7bcxmwm9qBtI8zt+2lMveHew9wDQSMTXKODNs=;
        b=oWRWHds7fyRe5w/IBtkH3YnihC0EIjywPq3dkE3wO3xNjEnFyt+cFMVHPCO3265wQG
         xeqiJ1Xe83wij5t2h1LprX1g2tJPXgr3jfI9Shgj/ezHb3s4/riQAz/h+wC0vBZizNR6
         Z+Wo4itHr+e7oPKDu/36dwluJsvg2s5HrWgq482oU6edL7crrwuhivAB7lUEMPnwTEY0
         slbPVHIyiD8e0a/72iWvt+m/Dtb5h1GxB5hK7jza0MAppvs74FgGfHTxH7e84VN9LUbV
         CvO4EGK3dIFN7rbJ8FMFbkL8DmKMOmYOG0aPZ2Mx8uNI43wTWOrWecWGe6DrqyDsL64d
         He0Q==
X-Gm-Message-State: APjAAAX0K+e324fBiMa9ef68ZHBkgSN5RhR7lUJ4q+QW0Eq7nyTI/a39
        n3fGDAnd3WwqXrj1/xs0n1Cp/Gr9
X-Google-Smtp-Source: APXvYqwHyC+cFz9eR+nX72AmYJ9CsrQ2dTwB0OTb/PsM1rItR9jKyRyX+djyVfGzuApXhbffE2IlLA==
X-Received: by 2002:a17:902:ab81:: with SMTP id f1mr15266267plr.5.1580661582239;
        Sun, 02 Feb 2020 08:39:42 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k1sm18045122pfg.66.2020.02.02.08.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Feb 2020 08:39:41 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH] ARM: dts: aspeed: tacoma: Enable eMMC controller
Date:   Sun,  2 Feb 2020 08:39:39 -0800
Message-Id: <20200202163939.13326-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling emmc without enabling its controller doesn't do any good.
Enable its controller as well to make it work.

Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Joel Stanley <joel@jms.id.au>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
index ff49ec76fa7c..47293a5e0c59 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
@@ -132,6 +132,10 @@
 	use-ncsi;
 };
 
+&emmc_controller {
+	status = "okay";
+};
+
 &emmc {
 	status = "okay";
 };
-- 
2.17.1

