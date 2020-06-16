Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431FFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B4CE2151B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592321895;
	bh=9p4Mo042Rqy4vJYBei02Cv/NT0DA2OR0anc2hVo4VZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y65YZNEK/iJZL00F94L0XXUIiO9gw9Fjt3K5mn56vQKz6UrI90TOBdkJYg+SVdM2S
	 FL99PIflzScHthxtewQ1m4zKzoHnBEDxbvp0R81vEwk0ZJi/aaZW/FtzZcVKLq1bv4
	 +Cy5Go6/Shp2p6bGLc0P3CPM615puhMTblCrbSVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgFPPiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:38:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730537AbgFPPiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:38:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A644220B1F;
        Tue, 16 Jun 2020 15:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592321886;
        bh=9p4Mo042Rqy4vJYBei02Cv/NT0DA2OR0anc2hVo4VZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BgFnwfZ3KznDvVT+xcBdLJgrQLmq5EKQ0x1OCqe7rFs1VejGfOEHEdIstYNeG82PE
         21imiJIh+Ji5WtyjJrNfLANaYIUnfXr4zDwjunF/m3YQd40KHMVq82uv0K0eKzcwCp
         fPd5/WlySpAxHmVUo6m2v6Ul5n5SFSrFOgpClK9o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Breno Lima <breno.lima@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: [PATCH 5.4 054/134] watchdog: imx_sc_wdt: Fix reboot on crash
Date:   Tue, 16 Jun 2020 17:33:58 +0200
Message-Id: <20200616153103.360499214@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153100.633279950@linuxfoundation.org>
References: <20200616153100.633279950@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

commit e56d48e92b1017b6a8dbe64923a889283733fd96 upstream.

Currently when running the samples/watchdog/watchdog-simple.c
application and forcing a kernel crash by doing:

# ./watchdog-simple &
# echo c > /proc/sysrq-trigger

The system does not reboot as expected.

Fix it by calling imx_sc_wdt_set_timeout() to configure the i.MX8QXP
watchdog with a proper timeout.

Cc: <stable@vger.kernel.org>
Fixes: 986857acbc9a ("watchdog: imx_sc: Add i.MX system controller watchdog support")
Reported-by: Breno Lima <breno.lima@nxp.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Breno Lima <breno.lima@nxp.com>
Link: https://lore.kernel.org/r/20200412230122.5601-1-festevam@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/watchdog/imx_sc_wdt.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/watchdog/imx_sc_wdt.c
+++ b/drivers/watchdog/imx_sc_wdt.c
@@ -177,6 +177,11 @@ static int imx_sc_wdt_probe(struct platf
 	wdog->timeout = DEFAULT_TIMEOUT;
 
 	watchdog_init_timeout(wdog, 0, dev);
+
+	ret = imx_sc_wdt_set_timeout(wdog, wdog->timeout);
+	if (ret)
+		return ret;
+
 	watchdog_stop_on_reboot(wdog);
 	watchdog_stop_on_unregister(wdog);
 


