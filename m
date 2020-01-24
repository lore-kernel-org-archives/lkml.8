Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E774CC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB61E20709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859974;
	bh=I0OFd4I/rlHALpCaadJbiimDLkOWBju1Gp3pF4klCIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w6NCdr03YvPCBDP41GFT9MQfUmSQIf0IO+O9XVmbbMCE+qmzivbsmmb4zPTz91lof
	 OYmH9/luSxJS2HpO3FceXBi11dOtMQbRryO7VOwxaJIGx+i5F8Unz8Oqp+AOyrQaNx
	 OHie7jlX/u5aqyOQqdQDmTDICHrO3J5TYn5c7szc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387830AbgAXJ7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:59:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733077AbgAXJ7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:59:33 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0440021556;
        Fri, 24 Jan 2020 09:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859972;
        bh=I0OFd4I/rlHALpCaadJbiimDLkOWBju1Gp3pF4klCIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TuMefyJQD+Ior6TXoQZPkANEMa3OtHvGQ+faAUk2Su1ziw3jijEvfhZn40iLff7KH
         0801dF//jDcSc1AvYAXxylfUoNY6AmUnexFTjDTOhupehEM6M1gE3dxV9+ol/cgOqt
         ZKDViAtFvulCrpEL0Icq1h6vcVIVSFsR3axT4feI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 213/343] arm64: dts: meson: libretech-cc: set eMMC as removable
Date:   Fri, 24 Jan 2020 10:30:31 +0100
Message-Id: <20200124092948.084390411@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 9f72e321d5506fe3e162a6308a4a295d7f10bb5d ]

The eMMC on this board is add-on module which is not mandatory. Removing
'non-removable' property should prevent some errors when booting a board
w/o an eMMC module present.

Fixes: 72fb2c852188 ("ARM64: dts: meson-gxl-s905x-libretech-cc: fixup board definition")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index e2c71753e3278..407d32f4fe734 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -226,7 +226,6 @@
 	cap-mmc-highspeed;
 	mmc-ddr-3_3v;
 	max-frequency = <50000000>;
-	non-removable;
 	disable-wp;
 
 	mmc-pwrseq = <&emmc_pwrseq>;
-- 
2.20.1



