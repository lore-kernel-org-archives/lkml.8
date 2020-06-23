Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C46C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF7FD2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943504;
	bh=7q4axiA0Tm1nEfJFiUKPJX5zM5O2lmPDAXdKfaPrOZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0EIX9Q1ThYEcqkX83scnRGFAXX67Nb4AwwDvLQhkkFdRzU4whydg0ln89STAMT2ez
	 upncQnLiw5RmAhEvlY6MSEcqKhMM9n7mjZMb1JajUVc6Qg/lUBSyHeg0q5FgxfdRQe
	 X3gfK15rZ1Bd+QuRUL99qoArIPfTLcTwJ+JnyGEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389392AbgFWUSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:18:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389643AbgFWUSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:18:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78FAE2080C;
        Tue, 23 Jun 2020 20:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943493;
        bh=7q4axiA0Tm1nEfJFiUKPJX5zM5O2lmPDAXdKfaPrOZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UCO2XEl+AzSIuofBirZH0fCbkmCRTHN+3dlWDrbjnVTPkZTJ+8BHQZFYUtIYB009L
         1lC7E28Yhie+qPXa6URJpjU8V7nANbK/96fAe9TR5F+OhXc9gCoZkmRPW15bI370aC
         qEmvMFm2OqWQxx9L+cbsqmUm3TMwsmB4iMgReW3I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 414/477] pinctrl: qcom: ipq6018 Add missing pins in qpic pin group
Date:   Tue, 23 Jun 2020 21:56:51 +0200
Message-Id: <20200623195427.098323373@linuxfoundation.org>
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

From: Sivaprakash Murugesan <sivaprak@codeaurora.org>

[ Upstream commit 7f5f4de83ca30a4922bb178b80144e2778faad01 ]

The patch adds missing qpic data pins to qpic pingroup. These pins are
necessary for the qpic nand to work.

Fixes: ef1ea54eab0e ("pinctrl: qcom: Add ipq6018 pinctrl driver")
Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
Link: https://lore.kernel.org/r/1592541089-17700-1-git-send-email-sivaprak@codeaurora.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/qcom/pinctrl-ipq6018.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-ipq6018.c b/drivers/pinctrl/qcom/pinctrl-ipq6018.c
index 38c33a778cb8d..ec50a3b4bd161 100644
--- a/drivers/pinctrl/qcom/pinctrl-ipq6018.c
+++ b/drivers/pinctrl/qcom/pinctrl-ipq6018.c
@@ -367,7 +367,8 @@ static const char * const wci20_groups[] = {
 
 static const char * const qpic_pad_groups[] = {
 	"gpio0", "gpio1", "gpio2", "gpio3", "gpio4", "gpio9", "gpio10",
-	"gpio11", "gpio17",
+	"gpio11", "gpio17", "gpio15", "gpio12", "gpio13", "gpio14", "gpio5",
+	"gpio6", "gpio7", "gpio8",
 };
 
 static const char * const burn0_groups[] = {
-- 
2.25.1



