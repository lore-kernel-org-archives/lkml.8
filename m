Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBC8C433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB9922B4E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753422;
	bh=kcbW/+42tbYkeYEzHPoKqQt2cffnqTQdX15gHcEcuBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oesLKtbxC3O5YEJ5J7aYz4gNDjE3gcr1uVu5NAGuUE486Ceig7Ape2nRIEyGlSdGB
	 FUes9DD+E0EYPD8rdg5uWXdHodawBA9NopHHBItpVcviaOF8hn1jaL2Vo/0kNJOA1F
	 Up7XISvFxtZqyCABWIWHDVQLGGXu2vEcb4aEfW+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbgGNTDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:03:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730678AbgGNS5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:57:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C368229CA;
        Tue, 14 Jul 2020 18:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753031;
        bh=kcbW/+42tbYkeYEzHPoKqQt2cffnqTQdX15gHcEcuBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MtvJYiYFkXpugTUpLBFuhyx3mJGyEm3c7btP2Fsg1SjvA9BR9oL2TWe1lFPS4OIem
         yn/cywKtzW8k6FcMnTL3Fe8ZJOcdXbDtmL/x8I0rltxQvYL57yOBf8Ojw9DX5dwt8p
         fLoJmUmPFqjq4m9FCUALD+iz7obnQJKkavjv5P8g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Elder <elder@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 063/166] net: ipa: no checksum offload for SDM845 LAN RX
Date:   Tue, 14 Jul 2020 20:43:48 +0200
Message-Id: <20200714184118.882833458@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Elder <elder@linaro.org>

[ Upstream commit 41af5436e857ec64f302fcc9b6e4a8c526b6b402 ]

The AP LAN RX endpoint should not have download checksum offload
enabled.

The receive handler does properly accommodate the trailer that's
added by the hardware, but we ignore it.

Fixes: 1ed7d0c0fdba ("soc: qcom: ipa: configuration data")
Signed-off-by: Alex Elder <elder@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ipa/ipa_data-sdm845.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_data-sdm845.c b/drivers/net/ipa/ipa_data-sdm845.c
index 0d9c36e1e806c..0917c5b028f67 100644
--- a/drivers/net/ipa/ipa_data-sdm845.c
+++ b/drivers/net/ipa/ipa_data-sdm845.c
@@ -44,7 +44,6 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		.endpoint = {
 			.seq_type	= IPA_SEQ_INVALID,
 			.config = {
-				.checksum	= true,
 				.aggregation	= true,
 				.status_enable	= true,
 				.rx = {
-- 
2.25.1



