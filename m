Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AA3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD9E20FC3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592942793;
	bh=MbzOSjRoiqdb69w84rbBC2eBhnaS0icBGMkKwY3XLKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y2jPRN/JOlPJVoiFZ7IWsWyvaosGis6GuANOORGjBu3TuNJmVuSnYoJtt6e1+SjkH
	 k90cRt0qvvwwC7z9QlhH6YsxDDyj1DivWLFu5a4Lx2P9+o9buAM4TJBYqkHT7S8Heu
	 BC48amIEC8EA1m4Lc5l6G1RUbpGY6Bzv4Zb53Ejo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388054AbgFWUGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388462AbgFWUGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:06:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D15AF206C3;
        Tue, 23 Jun 2020 20:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942783;
        bh=MbzOSjRoiqdb69w84rbBC2eBhnaS0icBGMkKwY3XLKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFCtdR3m9UF9gGxy5lnr742f8QqvgrQSWL3SV43OCPumPmUsv2JgAEEeuS1A6RB47
         CJQtCkymff8G+axYCxLhA6OUq9yFK5+3K4kTrCe5WAqzup5nvFi8AzegF6FWM8YGgE
         U86rUNJw5bfup3ADQ4KuinA5nZMOgCVhg1CdgF0s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 132/477] arm64: dts: qcom: sm8250: Fix PDC compatible and reg
Date:   Tue, 23 Jun 2020 21:52:09 +0200
Message-Id: <20200623195413.845355949@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

[ Upstream commit 240031967ac4c63713c6e0c3249d734e23c913aa ]

The pdc node suffers from both too narrow compatible and insufficient
cells in the reg, fix these.

Fixes: 60378f1a171e ("arm64: dts: qcom: sm8250: Add sm8250 dts file")
Tested-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Link: https://lore.kernel.org/r/20200415054703.739507-1-bjorn.andersson@linaro.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 891d83b2afea5..2a7eaefd221dd 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -314,8 +314,8 @@
 		};
 
 		pdc: interrupt-controller@b220000 {
-			compatible = "qcom,sm8250-pdc";
-			reg = <0x0b220000 0x30000>, <0x17c000f0 0x60>;
+			compatible = "qcom,sm8250-pdc", "qcom,pdc";
+			reg = <0 0x0b220000 0 0x30000>, <0 0x17c000f0 0 0x60>;
 			qcom,pdc-ranges = <0 480 94>, <94 609 31>,
 					  <125 63 1>, <126 716 12>;
 			#interrupt-cells = <2>;
-- 
2.25.1



