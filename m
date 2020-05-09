Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C5CC47257
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 04:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9171B2495A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 04:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588998968;
	bh=UpZGwnSM8yCWwClaXT07mQ86DC2ABKivl/qFQL50cyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tj5Q7RQotUO0Gt/knA/VQ8UxCDCXK29kAJwAbi/W3yO6z6TJnDlVizOaHobWl031U
	 4WwTRp8TMaBBN0wPJvSiMOJj2nq0rg8xYcq8/JV0GoOo9ynxvrodRPSEsQco7qFUrH
	 7GnO4cAs6PriEsAKw4XU8de1kbt8FmYrGiH5zYZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgEIEgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 00:36:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32789 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgEIEgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 00:36:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id t7so1642694plr.0;
        Fri, 08 May 2020 21:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VkP6GWOio7qtVGJiV0OeaEyHuFiaIWKPQxya3i5GDSA=;
        b=l82iai2dqocs6iEfllINJe0nVEKcCUXwdS5lX4Pjfx0k+/tUN1vHDaBoNrCYxWa2un
         94Ph1y67DrIxZDdfUDpHbIqhkWC0yuJ4gpRFGUQl7bFjmHviAh0MB3BPxPTWn+jLUXmg
         v9W/gZd9Bcy4v7jQUjhQgQRw/KAyx9qYUthUMMmsSB8Vh/ghiACFRPKopHRtbiP8ByHQ
         PQML9RjuEViYNSrHEv1zl7QXZNwpTQ5z7no6baNrndLk2vEz/3nv/xSqE282n9+UmWcG
         rcXwxK5TfpKL9ayLxMG25cKRIJmdssADrz3N94OMmrQ9vmic9Hyw7US7d2J/AVG2OwEG
         Kdfw==
X-Gm-Message-State: AGi0Pub8O12eCz0m5xeyuajFUw33pAntvzncej+WQzEJF6toWCq1DVR+
        iXFUgOOGU1Q4gcDqxk0oh6s=
X-Google-Smtp-Source: APiQypIXyBqaBXyxzVqzZQbND5CCRopwmyiq2AWa34I4lmbuikMQ9/1Jk5F5GGDOQHUv7bOBuauRqA==
X-Received: by 2002:a17:90a:3b42:: with SMTP id t2mr9742401pjf.11.1588998964576;
        Fri, 08 May 2020 21:36:04 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 138sm3331874pfz.31.2020.05.08.21.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 21:36:01 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C70A841405; Sat,  9 May 2020 04:36:00 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     jeyu@kernel.org
Cc:     akpm@linux-foundation.org, arnd@arndb.de, rostedt@goodmis.org,
        mingo@redhat.com, aquini@redhat.com, cai@lca.pw, dyoung@redhat.com,
        bhe@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        gpiccoli@canonical.com, pmladek@suse.com, tiwai@suse.de,
        schlad@suse.de, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, daniel.vetter@ffwll.ch, will@kernel.org,
        mchehab+samsung@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Shannon Nelson <snelson@pensando.io>,
        Jakub Kicinski <kuba@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 02/15] ethernet/839: use new module_firmware_crashed()
Date:   Sat,  9 May 2020 04:35:39 +0000
Message-Id: <20200509043552.8745-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200509043552.8745-1-mcgrof@kernel.org>
References: <20200509043552.8745-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes use of the new module_firmware_crashed() to help
annotate when firmware for device drivers crash. When firmware
crashes devices can sometimes become unresponsive, and recovery
sometimes requires a driver unload / reload and in the worst cases
a reboot.

Using a taint flag allows us to annotate when this happens clearly.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Shannon Nelson <snelson@pensando.io>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/net/ethernet/8390/axnet_cs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/8390/axnet_cs.c b/drivers/net/ethernet/8390/axnet_cs.c
index aeae7966a082..8ad0200db8e9 100644
--- a/drivers/net/ethernet/8390/axnet_cs.c
+++ b/drivers/net/ethernet/8390/axnet_cs.c
@@ -1358,9 +1358,11 @@ static void ei_receive(struct net_device *dev)
 		 */
 		if ((netif_msg_rx_err(ei_local)) &&
 		    this_frame != ei_local->current_page &&
-		    (this_frame != 0x0 || rxing_page != 0xFF))
+		    (this_frame != 0x0 || rxing_page != 0xFF)) {
+			module_firmware_crashed();
 			netdev_err(dev, "mismatched read page pointers %2x vs %2x\n",
 				   this_frame, ei_local->current_page);
+		}
 		
 		if (this_frame == rxing_page)	/* Read all the frames? */
 			break;				/* Done for now */
-- 
2.25.1

