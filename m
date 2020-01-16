Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB404C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826C62072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217207;
	bh=A6436PZoUeMYCaPwbbuffN8Sf6L/qwVP+r2XQSU7Uwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TykUeW5fn5fIgz2Y3VwXnyK0/yAsjtSvKOAfxYIc9aRtihGIm+2Gdt/cEisASl5k3
	 u1QHzRxp9TW2rDS5CbMLCql6qinvUICnPWBISOOHewAfqS2zvqG/fWOiwD1CkDP9k8
	 f3CfNL97ufdcQnsXRvVYiXd9Dbi6/zj7rRnsdTOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388396AbgAPX0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:26:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388801AbgAPX0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:26:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D67F820684;
        Thu, 16 Jan 2020 23:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217178;
        bh=A6436PZoUeMYCaPwbbuffN8Sf6L/qwVP+r2XQSU7Uwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C4BZmuHvgubTJEIK05NTPiB41uRpzBqeKR/LqvDV8uzKDFhR86RI/M55Ygn1Of2v/
         54btpxESy2WfITZ1JBkFoK5Ykq6zLT0sWyS4gTjcbXp7AVViwaRRaQ+EtiUykQc/M5
         +p5aKVX2W8Q7N85p6SirLRUV/iB8l5lR8F0dVWyY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5.4 179/203] rtc: brcmstb-waketimer: add missed clk_disable_unprepare
Date:   Fri, 17 Jan 2020 00:18:16 +0100
Message-Id: <20200116231800.071360519@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

commit 94303f8930ed78aea0f189b703c9d79fff9555d7 upstream.

This driver forgets to disable and unprepare clock when remove.
Add a call to clk_disable_unprepare to fix it.

Fixes: c4f07ecee22e ("rtc: brcmstb-waketimer: Add Broadcom STB wake-timer")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Link: https://lore.kernel.org/r/20191105160043.20018-1-hslester96@gmail.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rtc/rtc-brcmstb-waketimer.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/rtc/rtc-brcmstb-waketimer.c
+++ b/drivers/rtc/rtc-brcmstb-waketimer.c
@@ -277,6 +277,7 @@ static int brcmstb_waketmr_remove(struct
 	struct brcmstb_waketmr *timer = dev_get_drvdata(&pdev->dev);
 
 	unregister_reboot_notifier(&timer->reboot_notifier);
+	clk_disable_unprepare(timer->clk);
 
 	return 0;
 }


