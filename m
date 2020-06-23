Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C44C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96DDA2078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592942929;
	bh=/CPyaLLZRU4Fh2P4fIpFjAZgAOMq5TubLnUNK5hB58U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p93nZ2r2JhyeDeJyryAXj5/7ftj9wsbx5MqDrEOwvew9OKtkrav7jRrF+/rJkCom/
	 Zwki8881kkbHGVI/nKWp4BpX0T9Hap67njkEj3cRdpwCTJYWOWy6bwD0OEC5LD0JCf
	 r7VM/IRDW6Ki4nfSVMoYA83ApZhdA8RGQbTxKKyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387816AbgFWUIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:08:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387878AbgFWUIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:08:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1836B20E65;
        Tue, 23 Jun 2020 20:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942889;
        bh=/CPyaLLZRU4Fh2P4fIpFjAZgAOMq5TubLnUNK5hB58U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MtrV1Mf5FfummDYTrM7EmhqBQ2xcetaUmE9u2/X6G7qHE2xMTwnUlg+2s/m1Z5BCq
         cL5tFnz6e2+f5k7fc+Htm0JvZcdfilL8abdppgjYPnsI7C4KTFXroc25HFJbhdFgpy
         8tDOru7TaXWGDhaX9R9AFzl7ZWbg5q7k9+g78fxw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matej Dujava <mdujava@kocurkovo.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 168/477] staging: sm750fb: add missing case while setting FB_VISUAL
Date:   Tue, 23 Jun 2020 21:52:45 +0200
Message-Id: <20200623195415.526484292@linuxfoundation.org>
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

From: Matej Dujava <mdujava@kocurkovo.cz>

[ Upstream commit fa90133377f4a7f15a937df6ad55133bb57c5665 ]

Switch statement does not contain all cases: 8, 16, 24, 32.
This patch will add missing one (24)

Fixes: 81dee67e215b ("staging: sm750fb: add sm750 to staging")
Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
Link: https://lore.kernel.org/r/1588277366-19354-2-git-send-email-mdujava@kocurkovo.cz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/sm750fb/sm750.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 59568d18ce230..5b72aa81d94c1 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -898,6 +898,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		fix->visual = FB_VISUAL_PSEUDOCOLOR;
 		break;
 	case 16:
+	case 24:
 	case 32:
 		fix->visual = FB_VISUAL_TRUECOLOR;
 		break;
-- 
2.25.1



