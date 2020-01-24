Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73576C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C71B2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579876687;
	bh=wvibL/N1DiVGTjKauXYmvr6WaMH6WexNX705Ykpmzik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VuPwRa6XVUJjlAkAlE3c5us8rc0o6MSBnQKSmRC5BqRziupss9yoALtmlo9ZKW3/H
	 VQF5P8U4nEVflqKdg3Cpx3H+6eieCVHBknKafIKtyvnqhhyAgOIJcFUhTaudifC9JW
	 ukOwGRcpKqL5IxzUKYA2wPswqhRZE4o/c7tpCk0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388391AbgAXOiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:38:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391130AbgAXOSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:18:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB2502465B;
        Fri, 24 Jan 2020 14:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875530;
        bh=wvibL/N1DiVGTjKauXYmvr6WaMH6WexNX705Ykpmzik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V/A7tYjSkiUdNYXjFZUBHg2WfBPSqRkWG5s28YwmqcTjt/TQaqWlz2WbGzWU5fZ7d
         08f1D8SSnJOwd2MYfgB3JQkUOT2TulsNaag5i/yM6pjNn2Y0x5kCGZ5XsTGLoZQz9y
         wJ5Q3TTI37iMh5HJWyMRwQVtwI/pxqVLfM4+33dM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Stephen Boyd <sboyd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 028/107] clk: mmp2: Fix the order of timer mux parents
Date:   Fri, 24 Jan 2020 09:16:58 -0500
Message-Id: <20200124141817.28793-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124141817.28793-1-sashal@kernel.org>
References: <20200124141817.28793-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>

[ Upstream commit 8bea5ac0fbc5b2103f8779ddff216122e3c2e1ad ]

Determined empirically, no documentation is available.

The OLPC XO-1.75 laptop used parent 1, that one being VCTCXO/4 (65MHz), but
thought it's a VCTCXO/2 (130MHz). The mmp2 timer driver, not knowing
what is going on, ended up just dividing the rate as of
commit f36797ee4380 ("ARM: mmp/mmp2: dt: enable the clock")'

Link: https://lore.kernel.org/r/20191218190454.420358-3-lkundrak@v3.sk
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mmp/clk-of-mmp2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
index a60a1be937ad6..b4a95cbbda989 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -134,7 +134,7 @@ static DEFINE_SPINLOCK(ssp3_lock);
 static const char *ssp_parent_names[] = {"vctcxo_4", "vctcxo_2", "vctcxo", "pll1_16"};
 
 static DEFINE_SPINLOCK(timer_lock);
-static const char *timer_parent_names[] = {"clk32", "vctcxo_2", "vctcxo_4", "vctcxo"};
+static const char *timer_parent_names[] = {"clk32", "vctcxo_4", "vctcxo_2", "vctcxo"};
 
 static DEFINE_SPINLOCK(reset_lock);
 
-- 
2.20.1

