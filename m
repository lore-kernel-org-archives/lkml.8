Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BD3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9FE82065C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZX89HUHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgGHMEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbgGHMCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:02:35 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485B3C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:02:35 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so2727423wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DmqYn8cL7eqDFwNGfmdwoQHTEQPwopRMh0yPN6WNGOc=;
        b=ZX89HUHjMyHzb2heKm0iH8q120RxpXZ4NY/Lixv0Rryknk//WXNKNL878jlcUlwD49
         lChMvRvyp2d4ylLHijtfBzHUSke+nLv3JvqjaILPjmI2/osr42fXXhHvW1otnkJ//5RA
         PsmBBT+QTvIFVvrk6MZ/OMKKCDmePDjOMzzRIEM2w2nSM5MDwDhq587PwePzFNlLq90y
         pr72HLxGR9a4GcvhyFNTSlEoiEbzmLNGJiR8kUBognvguyqVNiUwe1IGf5sIePxRdAmb
         zLsoOx2hSbEay1tc3FINUEu1HVft+fIYuN3V3iskbFPP4x79ZLD63clZdzhZP0IR3wMt
         MPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DmqYn8cL7eqDFwNGfmdwoQHTEQPwopRMh0yPN6WNGOc=;
        b=TnV/jOnLuDtEjSubsqXOKeAyH3fmo3liwQj/VYggeensd+k2gB9G8BnA4esQJFExpR
         u8gtCPcfZkglmklMIkpjAHfrHo5/Fwq70+lF9WmZo+JbDCWvzwHS1uqmkx85VaWx2qIG
         YuOn9S3yHVr/SwVoYbLd5ngB+XWjMNX8rB1aU/8u8Iboy+wgUI1F3bT4cDDMkPYLR32r
         9bCFpln7o5ASXCbotuxa5c4Bs9DmoZDq0ujGdCzoCIAdxmkuowImCzs5Eoopdr3qKloY
         1anpPpWzdliWpqj9LiFEWm9rlru70BxEoRzq28+t+oVq5PRr4Em+dasH+4PZ6x2DpvxA
         zoRw==
X-Gm-Message-State: AOAM531LsEFcIaZvD9JduzbMykZZUdbuo/hBa0RBPDpcnjTQOlAaIu1C
        4Fekh9HmPF1POYcnt7CPokVRGA==
X-Google-Smtp-Source: ABdhPJyyzSZPiPJuG3p9zylereXCy8YSx2u92+RYTlb+uZ2h3JczIOOmqkwgrRMO7xGWj6DDJaWMXg==
X-Received: by 2002:a1c:6788:: with SMTP id b130mr9412333wmc.100.1594209753955;
        Wed, 08 Jul 2020 05:02:33 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id m62sm3964997wmm.42.2020.07.08.05.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:02:33 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 06/30] scsi: fcoe: fcoe_transport: Correct some kernel-doc issues
Date:   Wed,  8 Jul 2020 13:01:57 +0100
Message-Id: <20200708120221.3386672-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708120221.3386672-1-lee.jones@linaro.org>
References: <20200708120221.3386672-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mainly due to misdocumentation or bitrotted descriptions.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/fcoe/fcoe_transport.c:396: warning: Function parameter or member 'skb' not described in 'fcoe_check_wait_queue'
 drivers/scsi/fcoe/fcoe_transport.c:447: warning: Function parameter or member 't' not described in 'fcoe_queue_timer'
 drivers/scsi/fcoe/fcoe_transport.c:447: warning: Excess function parameter 'lport' description in 'fcoe_queue_timer'
 drivers/scsi/fcoe/fcoe_transport.c:682: warning: Function parameter or member 'netdev' not described in 'fcoe_netdev_map_lookup'

Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/fcoe/fcoe_transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/fcoe/fcoe_transport.c b/drivers/scsi/fcoe/fcoe_transport.c
index a20ddc301c89e..6e187d0e71fd2 100644
--- a/drivers/scsi/fcoe/fcoe_transport.c
+++ b/drivers/scsi/fcoe/fcoe_transport.c
@@ -382,6 +382,7 @@ EXPORT_SYMBOL_GPL(fcoe_clean_pending_queue);
 /**
  * fcoe_check_wait_queue() - Attempt to clear the transmit backlog
  * @lport: The local port whose backlog is to be cleared
+ * @skb: The received FIP packet
  *
  * This empties the wait_queue, dequeues the head of the wait_queue queue
  * and calls fcoe_start_io() for each packet. If all skb have been
@@ -439,7 +440,7 @@ EXPORT_SYMBOL_GPL(fcoe_check_wait_queue);
 
 /**
  * fcoe_queue_timer() - The fcoe queue timer
- * @lport: The local port
+ * @t: Timer context use to obtain the FCoE port
  *
  * Calls fcoe_check_wait_queue on timeout
  */
@@ -672,6 +673,7 @@ static void fcoe_del_netdev_mapping(struct net_device *netdev)
 /**
  * fcoe_netdev_map_lookup - find the fcoe transport that matches the netdev on which
  * it was created
+ * @netdev: The net device that the FCoE interface is on
  *
  * Returns : ptr to the fcoe transport that supports this netdev or NULL
  * if not found.
-- 
2.25.1

