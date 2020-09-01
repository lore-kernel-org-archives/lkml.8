Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F35C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 101C22067C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598978766;
	bh=d7DHFf7zjW6Mm0rL9KHHhH3jU/jLuPmb92KRdWfAIks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v6RbdRfvrD2BlWIqq2ewTKABCvQie3NziSTpm3TYmVKsr9yvNIqTWPx8WzorvHiCU
	 4C2kPBUgaHZr8F7aCClwTNzpAegXySQkYd4yiAAF5+gA/YCcSbEsXcKrxtRa5SBTVk
	 6P79YwDC0JB0PGCAj9wBgKHJ3h7mSupFVLc9MZ+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbgIAQqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:46:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730008AbgIAP1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:27:23 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4C8F207D3;
        Tue,  1 Sep 2020 15:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974042;
        bh=d7DHFf7zjW6Mm0rL9KHHhH3jU/jLuPmb92KRdWfAIks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R33SZ9ZDUCVYcBeeRkJrMW1hX1TRg2XISM8jDHMT374t+0m/Rq0+j3Vf7fV2bczxh
         90Hf5AsklojMYvi4pax3rfubydJrXV+mrrNF1vTqjnx6WOH8hjHYqh/VQcu8mcsOjW
         V38IouiMr+UAAmRXhIc4tACOAsb9mbAwWUqTPspk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 021/214] arm64: dts: qcom: msm8916: Pull down PDM GPIOs during sleep
Date:   Tue,  1 Sep 2020 17:08:21 +0200
Message-Id: <20200901150953.984062242@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

[ Upstream commit e2ee9edc282961783d519c760bbaa20fed4dec38 ]

The original qcom kernel changed the PDM GPIOs to be pull-down
during sleep at some point. Reportedly this was done because
there was some "leakage at PDM outputs during sleep":

  https://source.codeaurora.org/quic/la/kernel/msm-3.10/commit/?id=0f87e08c1cd3e6484a6f7fb3e74e37340bdcdee0

I cannot say how effective this is, but everything seems to work
fine with this change so let's apply the same to mainline just
to be sure.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Link: https://lore.kernel.org/r/20200605185916.318494-3-stephan@gerhold.net
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index 1235830ffd0b7..38c0d74767e3f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -521,7 +521,7 @@
 				pins = "gpio63", "gpio64", "gpio65", "gpio66",
 				       "gpio67", "gpio68";
 				drive-strength = <2>;
-				bias-disable;
+				bias-pull-down;
 			};
 		};
 	};
-- 
2.25.1



