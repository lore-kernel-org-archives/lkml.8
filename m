Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DB0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4889E20702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946983;
	bh=TEKMVOR1p2eSDRp9ak6+WhSLEE9whw5E4A4wzwpAE9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ydKmw/a74mDt5MDnrdt82UZ0qCld2HqApAzWZz1+ikTFsPle6qqzFZCBCg4oT636V
	 bm4Qh5+wxm3AhUUkq4XX+EPsgCI1lJziXKEa4OWLyvMkj9JVYm16ZTr/CkkXKY3Y40
	 XmGpGWdiF3bR4SVzcfCsN3wxR6c996bJoX327vmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390793AbgFWU1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:27:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390790AbgFWU1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:27:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A15C4206EB;
        Tue, 23 Jun 2020 20:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944062;
        bh=TEKMVOR1p2eSDRp9ak6+WhSLEE9whw5E4A4wzwpAE9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vHajVJS7ldyLSTLqP0xqi57q/ZE9vqRzmcgRP6zjpKFJ+nJYPb+bRqQDnXTNMnxFU
         YoKCvv5zDWbcQa+ngXnHFUsLGDkxiXglIT7dErPlfXWMF/AkSvTsuFoi/Bz4AmGTJ1
         pnycu+20H80eT5IvmbNg/NWporiUMOIxr6rxj5pQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 157/314] tty: n_gsm: Fix bogus i++ in gsm_data_kick
Date:   Tue, 23 Jun 2020 21:55:52 +0200
Message-Id: <20200623195346.348815475@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
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
index 8a0d66a05af59..75408b9f232da 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -703,17 +703,9 @@ static void gsm_data_kick(struct gsm_mux *gsm, struct gsm_dlci *dlci)
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



