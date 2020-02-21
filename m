Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA57C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513D4206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582274919;
	bh=t+HGHp5WXwS0C0Tt94knmpE+cBtGP+NH5K22SJzMyk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=liDdDlPdmkYu+tuDOQs8M+jO6QhKYkQ9dgbOPjKFgbMD+WH75Fv9ai/U+veMCXp75
	 qhvqSFIOsyYP9tuLwrS4P8j933f/8Qcu7XYtQDpT+AaTULT9vZ6tLRUmH5Y61w5KOH
	 zaIR5aMhw15AGOKaMU3BZdCXiqIJFEGkNA2ICZ8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387804AbgBUIsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:48:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728259AbgBUHqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:46:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A88124656;
        Fri, 21 Feb 2020 07:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271199;
        bh=t+HGHp5WXwS0C0Tt94knmpE+cBtGP+NH5K22SJzMyk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jgb9oTYQ2Yw7f265m5QzMYnNQg9m0HBLli1n7S/TWxH5Lmoo2hh/ZaS4sN416A8Gt
         3wjIHQA2YAT0+0p62FL5NnslGHmoORcxct6XWWYGngapHpPBLBS1FjD1fXlcywK0PV
         lCOxjWCR6T1QwLOk4Q+cyKdhrn+0wjDutDpKOznA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 039/399] media: ov5640: Fix check for PLL1 exceeding max allowed rate
Date:   Fri, 21 Feb 2020 08:36:04 +0100
Message-Id: <20200221072406.165679359@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Ford <aford173@gmail.com>

[ Upstream commit 2e3df204f9af42a47823ee955c08950373417420 ]

The variable _rate is by ov5640_compute_sys_clk() which returns
zero if the PLL exceeds 1GHz.  Unfortunately, the check to see
if the max PLL1 output is checking 'rate' and not '_rate' and
'rate' does not ever appear to be 0.

This patch changes the check against the returned value of
'_rate' to determine if the PLL1 output exceeds 1GHz.

Fixes: aa2882481cad ("media: ov5640: Adjust the clock based on the expected rate")
Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov5640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 5e495c833d329..bb968e764f318 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -874,7 +874,7 @@ static unsigned long ov5640_calc_sys_clk(struct ov5640_dev *sensor,
 			 * We have reached the maximum allowed PLL1 output,
 			 * increase sysdiv.
 			 */
-			if (!rate)
+			if (!_rate)
 				break;
 
 			/*
-- 
2.20.1



