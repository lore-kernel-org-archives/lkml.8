Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CE6C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 18:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9212B206E6
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 18:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Qygw9emn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgHASN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 14:13:56 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:26982 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726477AbgHASN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 14:13:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596305635; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=cJyeRZPN9m3WfcT3UaEZE4Gf1yPYYNx/SsDF1xhJnSc=; b=Qygw9emnwGzvTi3WCsx4xyORxPMabOsmc5xANcLIvA7hHz72X2tx+uhg3Q4ORL0xg+kS396f
 EAWblP3HB+rBjzdsok76uXstLmjBYTFU41dyYeslaaHJ2D/qqYFBmFoUJVEnI5pnWaD4ViUS
 G0FhkC1uHDY5wUrtV4Xt0cHsG+Y=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-east-1.postgun.com with SMTP id
 5f25b0debcdc2fe47193e77f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 01 Aug 2020 18:13:50
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DEC6BC43391; Sat,  1 Aug 2020 18:13:49 +0000 (UTC)
Received: from tdas-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C85ECC433C6;
        Sat,  1 Aug 2020 18:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C85ECC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2] Add LPASS clock controller Node for SC7180
Date:   Sat,  1 Aug 2020 23:43:34 +0530
Message-Id: <1596305615-5894-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[v2]
 - Update the node in sorted order.
 - Depends on the patch
  https://lore.kernel.org/r/20200731133006.1.Iee81b115f5be50d6d69500fe1bda11bba6e16143@changeid

[v1]
 - Clock controller LPASS device Node.

Taniya Das (1):
  arm64: dts: qcom: sc7180: Add LPASS clock controller nodes

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

