Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308DBC3B1A6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F289324650
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701439;
	bh=kMUw6Js6eknNyxk3vBQwSZ6XBHAU+POFf0euwGKYmW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1ln3vZnSrgv/KDlsOLdiifhsT0MrCIB41I6nqhMzCcaxLxHvdk/n69hd3xDExJm/T
	 Zgm+ir/8QFd0SoR6ksjuNuQcZXTPvtV2rq8F2aI2KsXvcKcywgh4bSi1CEejIIbVSR
	 SVs/7BVvRAr5j3MXGV9DX293oeezouihHKbaOddM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390666AbgBNRai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:30:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:58720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390665AbgBNQHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:07:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DAE52067D;
        Fri, 14 Feb 2020 16:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696444;
        bh=kMUw6Js6eknNyxk3vBQwSZ6XBHAU+POFf0euwGKYmW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pGxiGkDfbjFuibu3JCz+k6Z6DjpmLXjXlO54HPMWsxBzMI3F8tN2SdQCPixT5endY
         fRzSM12doQTF87uTjF2pYlvRvFTxLdKvy1ClzKrHFJ17BNDRS0eE9icnQ3xruZX9NT
         R5Nfk7yCjGQX3eQzie9MiCRyQ3Mk0Gq6hmwkNSvw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 259/459] soc: qcom: rpmhpd: Set 'active_only' for active only power domains
Date:   Fri, 14 Feb 2020 10:58:29 -0500
Message-Id: <20200214160149.11681-259-sashal@kernel.org>
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

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 5d0d4d42bed0090d3139e7c5ca1587d76d48add6 ]

The 'active_only' attribute was accidentally never set to true for any
power domains meaning that all the code handling this attribute was
dead.

NOTE that the RPM power domain code (as opposed to the RPMh one) gets
this right.

Acked-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Fixes: 279b7e8a62cc ("soc: qcom: rpmhpd: Add RPMh power domain driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20190214173633.211000-1-dianders@chromium.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/rpmhpd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 5741ec3fa814c..51850cc68b701 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -93,6 +93,7 @@ static struct rpmhpd sdm845_mx = {
 
 static struct rpmhpd sdm845_mx_ao = {
 	.pd = { .name = "mx_ao", },
+	.active_only = true,
 	.peer = &sdm845_mx,
 	.res_name = "mx.lvl",
 };
@@ -107,6 +108,7 @@ static struct rpmhpd sdm845_cx = {
 
 static struct rpmhpd sdm845_cx_ao = {
 	.pd = { .name = "cx_ao", },
+	.active_only = true,
 	.peer = &sdm845_cx,
 	.parent = &sdm845_mx_ao.pd,
 	.res_name = "cx.lvl",
-- 
2.20.1

