Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A153C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C0B2467E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699083;
	bh=Tv5VPWmDajiGPiRyV5i0B5GdSfT+JFgoH0S4oLjldbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BNyFWh5ngFLM804Wj16UOahlrm/PmGtWSOeM1dOH51Rp+C5kivaHVOP4V0uo8HqnS
	 /0kyVztCpLgK6kt8/oF0wCk74Gy7xpNrUToWFUxzDxkbmdR9q0OHZa7ZrKuENvxmZa
	 9lfHoAPAVpsG3DCydT/Sh5Hj3iIe5h75tl/eUeQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgAVNSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:18:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgAVNSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:18:01 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BEA020678;
        Wed, 22 Jan 2020 13:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699080;
        bh=Tv5VPWmDajiGPiRyV5i0B5GdSfT+JFgoH0S4oLjldbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GT6OJ7K2FKqzjD4WFfwo1bLj0VG0MjVQcs9BJQhNp0sxn0aRCH27cRUAIx4fsWMWf
         voib7P6zCO7GK9aKDPUvAkWu4vG7A3iVFEhAdILhnKSSYM4N0BJCthowBYaB3XfYUb
         63w1nX0A90Ns0or8MrTO3em81wPwarDR6ahReD5I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yinbo Zhu <yinbo.zhu@nxp.com>,
        Yangbo Lu <yangbo.lu@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.4 007/222] arm64: dts: ls1028a: fix endian setting for dcfg
Date:   Wed, 22 Jan 2020 10:26:33 +0100
Message-Id: <20200122092833.889112687@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yinbo Zhu <yinbo.zhu@nxp.com>

commit 33eae7fb2e593fdbaac15d843e2558379c6d1149 upstream.

DCFG block uses little endian.  Fix it so that register access becomes
correct.

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
Acked-by: Yangbo Lu <yangbo.lu@nxp.com>
Fixes: 8897f3255c9c ("arm64: dts: Add support for NXP LS1028A SoC")
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -158,7 +158,7 @@
 		dcfg: syscon@1e00000 {
 			compatible = "fsl,ls1028a-dcfg", "syscon";
 			reg = <0x0 0x1e00000 0x0 0x10000>;
-			big-endian;
+			little-endian;
 		};
 
 		rst: syscon@1e60000 {


