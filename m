Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BC0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6463A20719
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860622;
	bh=78btAS2b9p8DJC0sX4zuScTVsYWLaTYOwHo8pPXDDHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P6116nkcnO5crJ4oHef+jsNsO/P/vBpGOMD84uh6B2GUHK0FjNO/uvg90B+Tv+9NB
	 rVxf0MkmeNp5yQ1yNXUeWfkodkBNBEnm0Ejj7aBpawjsdXVs0SRnwBqZq4x67hJK0h
	 VjUSYCJJopOzm76huQws5w5qUAieYC0gwcbgEhEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732929AbgG0OhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:37:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730319AbgG0ONH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:13:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2462D21744;
        Mon, 27 Jul 2020 14:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859186;
        bh=78btAS2b9p8DJC0sX4zuScTVsYWLaTYOwHo8pPXDDHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mgQr2n7xMV7k9kSNNtZ2zLseZ1lwUeyNtYJWFl9kz5LY5wqE4Ckix2IBS7VCsFvwg
         d6I79StF+qILY09U7zbkyjyYdu4vaavGneYcTQwWlOvUuKm8W80JKLFoZgssM0PuFP
         uoMCLBaUmAdRnT/Tg8wdEC2A4cedJJ0kFDoVkNYc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacky Hu <hengqing.hu@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 004/138] pinctrl: amd: fix npins for uart0 in kerncz_groups
Date:   Mon, 27 Jul 2020 16:03:19 +0200
Message-Id: <20200727134925.460316521@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134925.228313570@linuxfoundation.org>
References: <20200727134925.228313570@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Hu <hengqing.hu@gmail.com>

[ Upstream commit 69339d083dfb7786b0e0b3fc19eaddcf11fabdfb ]

uart0_pins is defined as:
static const unsigned uart0_pins[] = {135, 136, 137, 138, 139};

which npins is wronly specified as 9 later
	{
		.name = "uart0",
		.pins = uart0_pins,
		.npins = 9,
	},

npins should be 5 instead of 9 according to the definition.

Signed-off-by: Jacky Hu <hengqing.hu@gmail.com>
Link: https://lore.kernel.org/r/20200616015024.287683-1-hengqing.hu@gmail.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-amd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-amd.h b/drivers/pinctrl/pinctrl-amd.h
index 3e5760f1a7153..d4a192df5fabd 100644
--- a/drivers/pinctrl/pinctrl-amd.h
+++ b/drivers/pinctrl/pinctrl-amd.h
@@ -252,7 +252,7 @@ static const struct amd_pingroup kerncz_groups[] = {
 	{
 		.name = "uart0",
 		.pins = uart0_pins,
-		.npins = 9,
+		.npins = 5,
 	},
 	{
 		.name = "uart1",
-- 
2.25.1



