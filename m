Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C5DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AD952220C
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592444535;
	bh=rquLcWC4YtiKOb0ygjRmmWfIq8S43jtn/9IxyUHEXBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fV7Pa5bmMAuzKv33vZ9B80DYta6Zvw4/QYQK7dPF8MbpZ1SpAk+xSA8h/ELy9Yb9V
	 MIucDxPIsN29oQ7qbiUC7lbuFA4lJZjyXiOpD9DjHu7HSLRdGX0oTudY53FFgCbjj2
	 eQKMqCLmwwqYnsTzAgDIVJi/ZeqYg3s5x8MxS1aM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732532AbgFRBmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:42:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732303AbgFRB33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:29:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2199E221E6;
        Thu, 18 Jun 2020 01:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443768;
        bh=rquLcWC4YtiKOb0ygjRmmWfIq8S43jtn/9IxyUHEXBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OEKbw47jxJJkVA1FnavcAM+mpAGsWTkslKfEF3Zka8nzGxGZl+oo01X5ObyoOveIH
         Xjikd8ed69PaNQhBv4FC+3CyZ9HBcNXmHTAqc9b5WdCs3EVvJAyMEl/MbAXz9mnGFF
         6UVtlJ3hlGcFpytk0btnkvugplyS0iLQ+zqmI9hM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 53/80] tty: n_gsm: Fix bogus i++ in gsm_data_kick
Date:   Wed, 17 Jun 2020 21:27:52 -0400
Message-Id: <20200618012819.609778-53-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012819.609778-1-sashal@kernel.org>
References: <20200618012819.609778-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 56716f525030..1ab9bd433542 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -719,17 +719,9 @@ static void gsm_data_kick(struct gsm_mux *gsm, struct gsm_dlci *dlci)
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

