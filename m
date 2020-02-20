Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576F4C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6BA206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lWPdtbce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgBTN14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:27:56 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44412 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBTN1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 08:27:55 -0500
Received: by mail-pg1-f195.google.com with SMTP id g3so1939695pgs.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 05:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hF0MYOxyxn24x/ZYtlarhD9w/8tgL/0AbysCyIWUqB0=;
        b=lWPdtbceOs2cC0MFwqkm4JZMtIDewpsnrzs+5eIkhjoMV2SJvYChWk3tQPO3sjcpkM
         0JRFxORvBnqb715+jTuwsvbkljzaEdBcepRokDPscyhItPgPH+t4fPcI5jox0PwRS3BU
         gv11eSFh0I619wG7GnAGNs+xrvC5o5Bj5h+wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hF0MYOxyxn24x/ZYtlarhD9w/8tgL/0AbysCyIWUqB0=;
        b=ijnomhxC4SY/rAMYHJn27CY35qLx7qhQ1A1opz27MBEeiaErJ5v7G93rjsC2TDvcYX
         PkiWbMNwh7ugwrYFZIv2ybDknyBK7SbBPHw0foNoA1KSSa5QR3g5oOJ5rWBSqWE2C9Fo
         5dUUEb7zuDfT7QicjrxrdQRcViDB+vldR/QfPrUgizTZ8qn1qwlQZQsIij6BbnL6I3PH
         NGZkxsB7Hw+/wgjPB1HY1J3aGnp2ajJI2GMM0F7M8hehG72jGsc5y8tFqLNxl77xrCmT
         4hmeo9avTAzPJJa6w2xUohEFx70hZ6sHKqhr3iXuhind3pMtrTT0PiK3Snt7MyFWsvle
         9brQ==
X-Gm-Message-State: APjAAAURRkHBdaBMy52hRGo7P5oQze0/cVFTJ8QXUGPml8kPe5rdzRUC
        n4Ka52QlkqGSkGmpJr90gA2f0Q==
X-Google-Smtp-Source: APXvYqwLKJcZDrK2vGjpR2o1+UZVY6CiHiTRMZ76Tp2Fd8qa2KqcFHdMflOCt8bmXidsxemy6zDUHg==
X-Received: by 2002:a63:df02:: with SMTP id u2mr31473112pgg.403.1582205274678;
        Thu, 20 Feb 2020 05:27:54 -0800 (PST)
Received: from localhost.localdomain ([49.206.201.34])
        by smtp.gmail.com with ESMTPSA id 84sm3974646pgg.90.2020.02.20.05.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Feb 2020 05:27:53 -0800 (PST)
From:   sunil@amarulasolutions.com
To:     heiko@sntech.de, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Markus Reichl <m.reichl@fivetechno.de>
Subject: [PATCH] arm64: defconfig: Enable REGULATOR_MP8859
Date:   Thu, 20 Feb 2020 18:57:39 +0530
Message-Id: <1582205259-15274-1-git-send-email-sunil@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagan Teki <jagan@amarulasolutions.com>

RK3399 boards like ROC-RK3399-PC is using MP8859 DC/DC converter
for 12V supply.

roc-rk3399-pc initially used 12V fixed regulator for this supply,
but the below commit has switched to use MP8859.

commit <1fc61ed04d309b0b8b3562acf701ab988eee12de> "arm64: dts: rockchip:
Enable mp8859 regulator on rk3399-roc-pc"

So, enable bydefault on the defconfig.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Cc: Markus Reichl <m.reichl@fivetechno.de>
Tested-by: Suniel Mahesh <sunil@amarulasolutions.com>
---
Note:
This change set is applied on top of linux-rockchip, branch v5.7-armsoc/dts64.
(git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git -b v5.7-armsoc/dts64)
This change set was tested on ROC-RK3399-PC, an rk3399 based target.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0f21288..973a493 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -505,6 +505,7 @@ CONFIG_REGULATOR_QCOM_RPMH=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_REGULATOR_QCOM_SPMI=y
 CONFIG_REGULATOR_RK808=y
+CONFIG_REGULATOR_MP8859=y
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_VCTRL=m
 CONFIG_RC_CORE=m
-- 
2.7.4
