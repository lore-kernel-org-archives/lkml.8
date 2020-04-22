Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F97C5518C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1CEB2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587549562;
	bh=Ah1phaatKWQi3TK8AmYCuGygrGtfYztTNYjAIJTHsNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZRmQ/LLA6oMR0EezDZIlln03fKtcrL1CtBvmj5E36oxWXqNPYAg4MFGyarv8kUM5n
	 hIytYeErMO3JBwtEPcWcS2/yh50jM9WIifM8Rn+E/ovvxECwkgvIW4ehuDXTXmlSZj
	 spkuv1OssQnP1+hs6NS5ycrNkXnHnrMmWezzzdcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgDVJ7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 05:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgDVJ7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 05:59:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABA082076E;
        Wed, 22 Apr 2020 09:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549557;
        bh=Ah1phaatKWQi3TK8AmYCuGygrGtfYztTNYjAIJTHsNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nVriN0PPgK8tas6k4z1msAuQhcuoQfxuxp/MFkmy5hJk/Poz9Xko1nJTdXrJL/4L7
         webD0/+XCPMHOdio6SytQH2Q5DEuPUAFa3c8kSSSfwFf7wVZP1Y809sVkTz90LHzOb
         TzNBOnKUQXCQA/edFtznHDsjVr3Ctp7sVsMl1pKk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 013/100] misc: rtsx: set correct pcr_ops for rts522A
Date:   Wed, 22 Apr 2020 11:55:43 +0200
Message-Id: <20200422095025.302564921@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095022.476101261@linuxfoundation.org>
References: <20200422095022.476101261@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 10cea23b6aae15e8324f4101d785687f2c514fe5 ]

rts522a should use rts522a_pcr_ops, which is
diffrent with rts5227 in phy/hw init setting.

Fixes: ce6a5acc9387 ("mfd: rtsx: Add support for rts522A")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200326032618.20472-1-yuehaibing@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/rts5227.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/rts5227.c b/drivers/mfd/rts5227.c
index ff296a4bf3d23..dc6a9432a4b65 100644
--- a/drivers/mfd/rts5227.c
+++ b/drivers/mfd/rts5227.c
@@ -369,6 +369,7 @@ static const struct pcr_ops rts522a_pcr_ops = {
 void rts522a_init_params(struct rtsx_pcr *pcr)
 {
 	rts5227_init_params(pcr);
+	pcr->ops = &rts522a_pcr_ops;
 
 	pcr->reg_pm_ctrl3 = RTS522A_PM_CTRL3;
 }
-- 
2.20.1



