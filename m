Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6D5C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C47B2087E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747524;
	bh=GgwK2xKL5rzWEjTGTjQrmNbNFmz6oL1dId/NMqfwA/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yJOHTmhthNqB1KfGUNp1GXsAuZlHBb72uREuk1pkyX77J1hU17K00S+THz1MwK3Zc
	 B7fkV4r0jTSF5NOH/GCnJ5ssx+DQ3WVe+UGteyH5UbAQaH6llEUiVQFZTQP1si7M5K
	 eTNYYHwAEVB4PyA0GhkRPpqJrgtvLYo3gdeI9POo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbgBCQcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:32:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730345AbgBCQcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:32:01 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58A1A2051A;
        Mon,  3 Feb 2020 16:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747520;
        bh=GgwK2xKL5rzWEjTGTjQrmNbNFmz6oL1dId/NMqfwA/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7kDAsgfUoS1unXzyYH+tb64CM61mKP0OFeRmQhsCRb8sWarsnaFERyhlKzTkxamZ
         +FDxyOxSB6wyNLq1w9zVoCzhbjicEFtk40njtjGyPObf7IsMp1WT1/bg4tqcjIOP3P
         ySn7TOO7NWEfW2JuTLItazip4rbzaUcjOjkDgbHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 28/70] soc: ti: wkup_m3_ipc: Fix race condition with rproc_boot
Date:   Mon,  3 Feb 2020 16:19:40 +0000
Message-Id: <20200203161916.612889239@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161912.158976871@linuxfoundation.org>
References: <20200203161912.158976871@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

[ Upstream commit 03729cfa0d543bc996bf959e762ec999afc8f3d2 ]

Any user of wkup_m3_ipc calls wkup_m3_ipc_get to get a handle and this
checks the value of the static variable m3_ipc_state to see if the
wkup_m3 is ready. Currently this is populated during probe before
rproc_boot has been called, meaning there is a window of time that
wkup_m3_ipc_get can return a valid handle but the wkup_m3 itself is not
ready, leading to invalid IPC calls to the wkup_m3 and system
instability.

To avoid this, move the population of the m3_ipc_state variable until
after rproc_boot has succeeded to guarantee a valid and usable handle
is always returned.

Reported-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/ti/wkup_m3_ipc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index f5cb8c0af09f3..c1fda6acb670a 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -426,6 +426,8 @@ static void wkup_m3_rproc_boot_thread(struct wkup_m3_ipc *m3_ipc)
 	ret = rproc_boot(m3_ipc->rproc);
 	if (ret)
 		dev_err(dev, "rproc_boot failed\n");
+	else
+		m3_ipc_state = m3_ipc;
 
 	do_exit(0);
 }
@@ -512,8 +514,6 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 		goto err_put_rproc;
 	}
 
-	m3_ipc_state = m3_ipc;
-
 	return 0;
 
 err_put_rproc:
-- 
2.20.1



