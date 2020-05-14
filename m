Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B62C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4594220727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="l/fwL98F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgENKyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 06:54:44 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:38039 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726101AbgENKym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:54:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589453682; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=4pj2pSGmKEolcDAZl5r+t+wxWGg/AYuXOejKTDbWUcE=; b=l/fwL98FvpDqkgnChZtNiy1BpGNxCjbtpI0GFfiulFS/eFkUuqZf1cu5IrjDyPsSYlw8I3zV
 loDa1ZIyAYyT/ekqs89JzdMoGXuPsnmYOeD4hOJt2E+4ruhiAdwQiK6YUi81fZLCCydnb5Z5
 JnezejBffQGyqUwmD0I/KfMPghE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebd2369.7f72daae1688-smtp-out-n03;
 Thu, 14 May 2020 10:54:33 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D34CDC433BA; Thu, 14 May 2020 10:54:33 +0000 (UTC)
Received: from hyd-lnxbld559.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: smasetty)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5464EC4478C;
        Thu, 14 May 2020 10:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5464EC4478C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=smasetty@codeaurora.org
From:   Sharat Masetty <smasetty@codeaurora.org>
To:     freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jcrouse@codeaurora.org,
        georgi.djakov@linaro.org, mka@chromium.org,
        Sharat Masetty <smasetty@codeaurora.org>
Subject: [PATCH 1/6] arm64: dts: qcom: sc7180: Add interconnect bindings for GPU
Date:   Thu, 14 May 2020 16:24:14 +0530
Message-Id: <1589453659-27581-2-git-send-email-smasetty@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589453659-27581-1-git-send-email-smasetty@codeaurora.org>
References: <1589453659-27581-1-git-send-email-smasetty@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the interconnect bindings to the GPU node. This enables
the GPU->DDR path bandwidth voting.

Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index b46ee78..0ce9921 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1384,6 +1384,8 @@
 			operating-points-v2 = <&gpu_opp_table>;
 			qcom,gmu = <&gmu>;

+			interconnects = <&gem_noc MASTER_GFX3D &mc_virt SLAVE_EBI1>;
+
 			gpu_opp_table: opp-table {
 				compatible = "operating-points-v2";

--
2.7.4
