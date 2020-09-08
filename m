Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D51FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D6C2080C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599589337;
	bh=FylbTEiD/DWhvOUoe0WCFuShSIlax8Y8+fievbYrx4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L4VI6P5NNMZ3EsWZ9zqdJW2eP+2BObbpUvJqVtJLHIoGMxlCd+wb629K7ad/tRHsC
	 yPMvYXb6gAPWB2aNG5GuY+wxOWQ4SwDRIf1q6A8EF3LwmnKU4zlI7X71653h2Te0EV
	 AZcStVqV53oqGldYvVtsUufxz8pQFaxZHKNxwQLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbgIHSWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:22:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731455AbgIHQLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:11:11 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E68024740;
        Tue,  8 Sep 2020 15:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579673;
        bh=FylbTEiD/DWhvOUoe0WCFuShSIlax8Y8+fievbYrx4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PUR2Zo8f+LNjtOAuUzZ72jRVnkonmwrXthCThYJaH8SKjDHx58DgguGqkg5TwKzZF
         tneh3+kVIsynF9b3TFF7ZcUP3a8Mygi5CJZVB0ND7nqNNsoFk92gGgliY6J3amg047
         oKtVatKwDiBCLxXxsA1h5BnmvNVeqJdT3Ij/zTTk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenbin Mei <wenbin.mei@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.8 145/186] arm64: dts: mt7622: add reset node for mmc device
Date:   Tue,  8 Sep 2020 17:24:47 +0200
Message-Id: <20200908152248.692679781@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenbin Mei <wenbin.mei@mediatek.com>

commit d6f6cbeee4e5ee6976792851e0461c19f1ede864 upstream.

This commit adds reset node for mmc device.

Cc: <stable@vger.kernel.org> # v5.4+
Fixes: 966580ad236e ("mmc: mediatek: add support for MT7622 SoC")
Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
Tested-by: Frank Wunderlich <frank-w@public-files.de>
Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
Link: https://lore.kernel.org/r/20200814014346.6496-3-wenbin.mei@mediatek.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -686,6 +686,8 @@
 		clocks = <&pericfg CLK_PERI_MSDC30_0_PD>,
 			 <&topckgen CLK_TOP_MSDC50_0_SEL>;
 		clock-names = "source", "hclk";
+		resets = <&pericfg MT7622_PERI_MSDC0_SW_RST>;
+		reset-names = "hrst";
 		status = "disabled";
 	};
 


