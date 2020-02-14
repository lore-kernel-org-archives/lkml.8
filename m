Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FBFC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3120A20873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702259;
	bh=3mMW9xAzJDDMfYwE+KOeTghpU9ATN3hhSY+NwNKGAbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bLbPZUCZogRzvcrrllGqZBu0rwYyFZsjkDNWkWHRqzzv6sJ2doOZj91bshQc+9UEp
	 sHzHfwqQUfT1BAq0KYDj0sBV6YHVjspVIQ4uhMockNpqGMrAxrERcla2qD9ZNdjpLX
	 4ZuZDG8+7duDaNxVUOX/2GF51BTNXJMqGF491HxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389541AbgBNQDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:03:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389447AbgBNQCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:02:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF70124684;
        Fri, 14 Feb 2020 16:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696165;
        bh=3mMW9xAzJDDMfYwE+KOeTghpU9ATN3hhSY+NwNKGAbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1FlUYGt7UFejq/TNF2kLMo8TmyVUNcpf2ukc6NuxyXDG1EqpO5XJOmR6sSl4AHvPm
         fBg/YwkobGsjnWz6x2fAqNZZpZGE572/M7D3RHbbyniJ6DPoM4IXs5pA1e6AmoI5NZ
         MWzHKlscPH6Vj5PfV1yUDZF01wpb/yuDF2jRpUX4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eugen Hristev <eugen.hristev@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 041/459] clk: at91: sam9x60: fix programmable clock prescaler
Date:   Fri, 14 Feb 2020 10:54:51 -0500
Message-Id: <20200214160149.11681-41-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

[ Upstream commit 66d9f5214c9ba1c151478f99520b6817302d50dc ]

The prescaler works as parent rate divided by (PRES + 1) (is_pres_direct == 1)
It does not work in the way of parent rate shifted to the right by (PRES + 1),
which means division by 2^(PRES + 1) (is_pres_direct == 0)
Thus is_pres_direct must be enabled for this SoC, to make the right computation.
This field was added in
commit 45b06682113b ("clk: at91: fix programmable clock for sama5d2")
SAM9X60 has the same field as SAMA5D2 in the PCK

Fixes: 01e2113de9a5 ("clk: at91: add sam9x60 pmc driver")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Link: https://lkml.kernel.org/r/1575977088-16781-1-git-send-email-eugen.hristev@microchip.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/at91/sam9x60.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 86238d5ecb4da..77398aefeb6db 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -47,6 +47,7 @@ static const struct clk_programmable_layout sam9x60_programmable_layout = {
 	.pres_shift = 8,
 	.css_mask = 0x1f,
 	.have_slck_mck = 0,
+	.is_pres_direct = 1,
 };
 
 static const struct clk_pcr_layout sam9x60_pcr_layout = {
-- 
2.20.1

