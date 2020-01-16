Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D390FC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12702468C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196192;
	bh=4SRJb8qcVjP2QHL9Zdeu2yEEZmxwQyxCQJ9qOUOh2i0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sBby5yx7eu5r47L9sHwbM2Vmbzl7Gt0FIyR+o6OZkqZ1Y7BuPUQAnAPCDwNXbSRft
	 5hD37eN5ckiTrgA3MmhwuTfqnBEc5Pa7H9MtF/VIGI6dsBS3vDbo/MPrCHtOXMNhlw
	 NtHHN+Pc/re0dpp6mEQTy9WoqUqPKWJOIAID+iBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405066AbgAPRgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:36:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:49346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393076AbgAPRfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:35:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67A34246A9;
        Thu, 16 Jan 2020 17:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196109;
        bh=4SRJb8qcVjP2QHL9Zdeu2yEEZmxwQyxCQJ9qOUOh2i0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nmvqJbGs4q8fSDMfN64MGx8yTG3oOZiP45NEimjPar4QoiyyP9Kxf6emsgT2TrInQ
         NYwr8U4XXTAU2VnzmmLJSIoRw6tSmyh5ssmnrDxlu1oZntbESojCqIIBVJJUY2BB+t
         qEwH1N0FMgFiJp5L6tJFFuaC1OBPCeG/FZODLt8I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 018/251] pinctrl: sh-pfc: sh73a0: Add missing TO pin to tpu4_to3 group
Date:   Thu, 16 Jan 2020 12:30:52 -0500
Message-Id: <20200116173445.21385-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173445.21385-1-sashal@kernel.org>
References: <20200116173445.21385-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 124cde98f856b6206b804acbdec3b7c80f8c3427 ]

The tpu4_to3_mux[] array contains the TPU4TO3 pin mark, but the
tpu4_to3_pins[] array lacks the corresponding pin number.

Add the missing pin number, for non-GPIO pin F26.

Fixes: 5da4eb049de803c7 ("sh-pfc: sh73a0: Add TPU pin groups and functions")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index d25e6f674d0a..f8fbedb46585 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -3086,6 +3086,7 @@ static const unsigned int tpu4_to2_mux[] = {
 };
 static const unsigned int tpu4_to3_pins[] = {
 	/* TO */
+	PIN_NUMBER(6, 26),
 };
 static const unsigned int tpu4_to3_mux[] = {
 	TPU4TO3_MARK,
-- 
2.20.1

