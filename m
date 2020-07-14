Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26600C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE45622BEB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752859;
	bh=WZm9NVwm/5hzx3Z8PKdERAEM9pbyT8kA/yFB5RQ6bAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uiLRcWUKC655vple0qLF7+PawShdFHaRx26FbNkal/1fTTSApUyI2b4D4HWM5poIN
	 L7jEh4xU7tvJmvSKhEITMO7kxXIbIzoc9v8qaMRrbTrgnL/O8wZkH/dO95jD1JubZ8
	 wJj9xAFWiWGDqOmcfEu0pYxN8fRV0OUclyQyentU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbgGNSyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:54:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730732AbgGNSyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:54:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65A2922BED;
        Tue, 14 Jul 2020 18:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752851;
        bh=WZm9NVwm/5hzx3Z8PKdERAEM9pbyT8kA/yFB5RQ6bAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QcbN8Q4rOYFXKUoSu1OMStUqeEK279AlGJxTUlFO/vci0+css9jOkp4b9kTYokDxm
         MGSemkPPI2Hx1z0+N4XjltcZQkbQUg6ThA5Z98N9+Nq3MK1Yb6Zdc5V2eXEBxsl0vg
         zUapohUiYHdmE1SkXlmj/ma4YbfGMwxmbssfVtlw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 010/166] gpu: host1x: Clean up debugfs in error handling path
Date:   Tue, 14 Jul 2020 20:42:55 +0200
Message-Id: <20200714184116.376338634@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 109be8b23fb2ec8e2d309325ee3b7a49eab63961 ]

host1x_debug_init() must be reverted in an error handling path.

This is already fixed in the remove function since commit 44156eee91ba
("gpu: host1x: Clean up debugfs on removal")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/host1x/dev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index d24344e919227..3c0f151847bae 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -468,11 +468,12 @@ static int host1x_probe(struct platform_device *pdev)
 
 	err = host1x_register(host);
 	if (err < 0)
-		goto deinit_intr;
+		goto deinit_debugfs;
 
 	return 0;
 
-deinit_intr:
+deinit_debugfs:
+	host1x_debug_deinit(host);
 	host1x_intr_deinit(host);
 deinit_syncpt:
 	host1x_syncpt_deinit(host);
-- 
2.25.1



