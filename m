Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2400FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB10120724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948067;
	bh=U41vo2J41mKdG0sSmbL4LAJnwKc8Gnby07k97bRSZCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QhsIxEUi1my1l08YR0WxrZKdKeelx+y3Q2MRqQ8xSTHGmpcPH9SPcFbIHZ8Q2nbLG
	 tSej96n+M1Dp13aAamkDXlgMrU8Owuyzbq04u0ElWfYSCC6qnrRgylQzuXfNqtAH2C
	 1tpTEeVpq0kzbgMtfpEpUAMvBtHEZXE+oPDdicSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388863AbgFWULA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:11:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388805AbgFWUKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:10:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E17EC20707;
        Tue, 23 Jun 2020 20:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943031;
        bh=U41vo2J41mKdG0sSmbL4LAJnwKc8Gnby07k97bRSZCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sG/HDnBqf224kNiji3bfJgMY6nfcgJdGWQ/RrVjsBSb339Ud/8Qdo4PbbBCWnJBoF
         IX0DOjp0bdfg1yUzqCf4e9Rsq8P0kqln1oyDS87HIGe7SK9bIPLuOc/JchO6lpmkvx
         cUzuM1gh73B/gidiS+QYFiZlKH09aV4aHMomhBj8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 231/477] tty: n_gsm: Fix bogus i++ in gsm_data_kick
Date:   Tue, 23 Jun 2020 21:53:48 +0200
Message-Id: <20200623195418.500791401@linuxfoundation.org>
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

From: Gregory CLEMENT <gregory.clement@bootlin.com>

[ Upstream commit 4dd31f1ffec6c370c3c2e0c605628bf5e16d5c46 ]

When submitting the previous fix "tty: n_gsm: Fix waking up upper tty
layer when room available". It was suggested to switch from a while to
a for loop, but when doing it, there was a remaining bogus i++.

This patch removes this i++ and also reorganizes the code making it more
compact.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Link: https://lore.kernel.org/r/20200518084517.2173242-3-gregory.clement@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/n_gsm.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 0a8f241e537d9..f189579db7c4c 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -711,17 +711,9 @@ static void gsm_data_kick(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 		} else {
 			int i = 0;
 
-			for (i = 0; i < NUM_DLCI; i++) {
-				struct gsm_dlci *dlci;
-
-				dlci = gsm->dlci[i];
-				if (dlci == NULL) {
-					i++;
-					continue;
-				}
-
-				tty_port_tty_wakeup(&dlci->port);
-			}
+			for (i = 0; i < NUM_DLCI; i++)
+				if (gsm->dlci[i])
+					tty_port_tty_wakeup(&gsm->dlci[i]->port);
 		}
 	}
 }
-- 
2.25.1



