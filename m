Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284C1C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE9E20674
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586647663;
	bh=Oz8l4a2+DuHtBPXpl9y0K8v+0yx9MzbKD4iUyuOn2i4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xcXZyNU9NYF9qYmSTI1pUIC9stt5BY8kg+KkhVwH0hBmQ7Ju+sRNKfadk2Jsrf3mN
	 GIuNSMaUrI3uIPE4OxuXSJlAwKpvg+7F+WT3e9PEnFfu0Vnc8Sz+BD1nJ980DoDO58
	 Kr3iI6mY76vTi3ImAAA/zpqW10X+qVzKfDAlVQgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgDKX1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:27:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728366AbgDKXLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:11:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F6342173E;
        Sat, 11 Apr 2020 23:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646704;
        bh=Oz8l4a2+DuHtBPXpl9y0K8v+0yx9MzbKD4iUyuOn2i4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZbnHuQrP9PA23Et/z1q6vFvBDR0x9/JLUc9xuDbCkZT+hucK5D1rBb3nSUmFiGDFq
         Xt6X285SUYNKnz+lpLmvtVvFQTnIz/E3cb0c/9WOgDcV1Su0fLFJ135Gzwl+xsn0AT
         8C+7mubO2dkvUssLZqprqSl1x1TSXKhDZ3fA616o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Michael Srba <Michael.Srba@seznam.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 096/108] arm64: dts: qcom: msm8916-samsung-a2015: Reserve Samsung firmware memory
Date:   Sat, 11 Apr 2020 19:09:31 -0400
Message-Id: <20200411230943.24951-96-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230943.24951-1-sashal@kernel.org>
References: <20200411230943.24951-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

[ Upstream commit 8f4a7a00c1019df72cda3002643fb5823ef39183 ]

At the moment, writing large amounts of data to the eMMC causes the device
to freeze. The symptoms vary, sometimes the device reboots immediately,
but usually it will just get stuck.

It turns out that the issue is not actually related to the eMMC:
Apparently, Samsung has made some modifications to the TrustZone firmware.
These require additional memory which is reserved at 0x85500000-0x86000000.
The downstream kernel describes this memory reservation as:

/* Additionally Reserved 6MB for TIMA and Increased the TZ app size
 * by 2MB [total 8 MB ]
 */

This suggests that it is used for additional TZ apps, although the extra
memory is actually 11 MB instead of the 8 MB mentioned in the comment.

Writing to the protected memory causes the kernel to crash or freeze.
In our case, writing to the eMMC causes the disk cache to fill
the available RAM, until the kernel eventually crashes
when attempting to use the reserved memory.

Add the additional memory as reserved-memory to fix this problem.

Fixes: 1329c1ab0730 ("arm64: dts: qcom: Add device tree for Samsung Galaxy A3U/A5U")
Reported-by: Michael Srba <Michael.Srba@seznam.cz>
Tested-by: Michael Srba <Michael.Srba@seznam.cz> # a3u
Tested-by: Stephan Gerhold <stephan@gerhold.net> # a5u
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Link: https://lore.kernel.org/r/20191231112511.83342-1-stephan@gerhold.net
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index e675ff48fdd24..0cc5c5be0c21e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -14,6 +14,14 @@
 		stdout-path = "serial0";
 	};
 
+	reserved-memory {
+		/* Additional memory used by Samsung firmware modifications */
+		tz-apps@85500000 {
+			reg = <0x0 0x85500000 0x0 0xb00000>;
+			no-map;
+		};
+	};
+
 	soc {
 		sdhci@7824000 {
 			status = "okay";
-- 
2.20.1

