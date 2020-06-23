Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AB7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B502082F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592942667;
	bh=HPm53k8FD/4n/cpDgK8Tp6aZZf85ELf3u1yD4iOjm+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wfof63Y+bG9q4kj9BXcHUZp7zOcxzSsFu4Hdh8MrADqW9TqZhlBad8ZlfabWSrJ1P
	 iuHbJ4ZtvEEWVDlgTkZhOWqoW6uPmAYAGZfdhwDeVaef0Zb5UPj6kQcWG8xvR+kivr
	 uieq0gCoVxasP+2ZEON2h9OZs7D7fO59el6QdwQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388206AbgFWUE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:04:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388150AbgFWUEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:04:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEF1220FC3;
        Tue, 23 Jun 2020 20:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942660;
        bh=HPm53k8FD/4n/cpDgK8Tp6aZZf85ELf3u1yD4iOjm+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O29LtnL5VpAeOmTO3w2sRFb3e0c/lx0wskCmmWniq8Vad7bKTfHi670wU8KfRt0eD
         k+Oj4I8sRg0Sx2UelmX8toUMEOse+18PAotUFcbx5R6AFy8iQciEf1LysZ8XCu78Ql
         4G5Nturi0G6uZfPHcx/Xlg24Gm8OWfFQe+Bp253g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 068/477] usb: cdns3: Fix runtime PM imbalance on error
Date:   Tue, 23 Jun 2020 21:51:05 +0200
Message-Id: <20200623195410.836686698@linuxfoundation.org>
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

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit e5b913496099527abe46e175e5e2c844367bded0 ]

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code. Thus a pairing decrement is needed on
the error handling path to keep the counter balanced.

Reviewed-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/cdns3/cdns3-ti.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index 5685ba11480bd..e701ab56b0a76 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -138,7 +138,7 @@ static int cdns_ti_probe(struct platform_device *pdev)
 	error = pm_runtime_get_sync(dev);
 	if (error < 0) {
 		dev_err(dev, "pm_runtime_get_sync failed: %d\n", error);
-		goto err_get;
+		goto err;
 	}
 
 	/* assert RESET */
@@ -185,7 +185,6 @@ static int cdns_ti_probe(struct platform_device *pdev)
 
 err:
 	pm_runtime_put_sync(data->dev);
-err_get:
 	pm_runtime_disable(data->dev);
 
 	return error;
-- 
2.25.1



