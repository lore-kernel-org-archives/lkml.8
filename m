Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B030C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED56217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jc0FOqid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgBEPzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:55:17 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38810 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgBEPzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:55:14 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so1417684pfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=JUnWYUYj9WgMqnGKXdAvUINkhyodp4ZrOWa+ysolFos=;
        b=Jc0FOqidGoKA7WGPDdKWEGrn8qI9pIynpbD98+YhltsUo/+1GpLwq6trZnTwiGYttO
         Piwq+MnVZEGurft6/qQLob2clQGJA8fr8UR992di1P64uQP+jT2w2zr5Iuz98dzO+b95
         PSX/5/SBSh5/JO9Jb/M/gjHcewPYSfJKOUwcEE8a79t6UoR2Irq6juuPj4cGhBApyuCu
         wDNTYa2T+RtNLhnM3v8x08B2jvAAQHsjf9DaeYl1psZ9OIyLkYpggwS2SrrWbi6ZfR2K
         71QeI1s9tO67e20rzSt3KnfP8cnw44DwYtrcMH5zCWrDS00S9L9CVVzf9eWq2cJBslVb
         bF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=JUnWYUYj9WgMqnGKXdAvUINkhyodp4ZrOWa+ysolFos=;
        b=Ofd1XRuawgUaeLkuZQHv80mfTK4TDcEATyF7TtC1hTEfzHGqMk3HiJCYVTODrQbJ01
         WPq/f8eYNEQds+lkSTNX82EaJoa8kd49ANtEscXLS5MHLNtm2htuvt6YXv2UKB7JIkQf
         x5QlCtb3FLss0QXkBRJUjojQpD615nIr4SX+II1MLPsBnlqKizDLtfpqoxnA7+J7m5MP
         +v3MaoE0dCxc0M3parYbgBf/32i7/aBt0jbikCymj3zrD0EkHbY8PHMJ/LNwigaUUwiZ
         9WEsfgvYYIZLGcF7iyPu9aiawYbq+sZ66+Zhd+q9BnKaJ7M3BhLk3S/N6vA+vCTI5HOm
         NPkA==
X-Gm-Message-State: APjAAAVRiY+xEhusS/DXkATAH6J6MRg5U/iQeRxBiFp2KoNV+zBnsbNb
        rNihynhLZV2Of+QexhWKv2F6c8N+jmOpBQ==
X-Google-Smtp-Source: APXvYqwfqYvt+v1r/Nyq/TRuk2rccc//oF6SVma9v0MhpoD7+L8qcng8wrumD6/uEV5ITp7pnEc/lQ==
X-Received: by 2002:a62:5547:: with SMTP id j68mr38413261pfb.6.1580918112263;
        Wed, 05 Feb 2020 07:55:12 -0800 (PST)
Received: from emb-wallaby.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id z10sm195678pgz.88.2020.02.05.07.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 07:55:11 -0800 (PST)
From:   Arindam Nath <arindam.nath@amd.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Jiasen Lin <linjiasen@hygon.cn>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 08/15] NTB: handle link down event correctly
Date:   Wed,  5 Feb 2020 21:24:25 +0530
Message-Id: <bff304461627e0d4b748973066b7f2d3c62b0b65.1580914232.git.arindam.nath@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link-Up and Link-Down are mutually exclusive events.
So when we receive a Link-Down event, we should also
clear the bitmask for Link-Up event in peer_sta.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index e964442ae2c3..d933a1dffdc6 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -551,8 +551,12 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 		dev_info(dev, "Flush is done.\n");
 		break;
 	case AMD_PEER_RESET_EVENT:
-		ndev->peer_sta |= AMD_PEER_RESET_EVENT;
-		amd_ack_smu(ndev, AMD_PEER_RESET_EVENT);
+	case AMD_LINK_DOWN_EVENT:
+		ndev->peer_sta |= status;
+		if (status == AMD_LINK_DOWN_EVENT)
+			ndev->peer_sta &= ~AMD_LINK_UP_EVENT;
+
+		amd_ack_smu(ndev, status);
 
 		/* link down first */
 		ntb_link_event(&ndev->ntb);
@@ -563,7 +567,6 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 	case AMD_PEER_D3_EVENT:
 	case AMD_PEER_PMETO_EVENT:
 	case AMD_LINK_UP_EVENT:
-	case AMD_LINK_DOWN_EVENT:
 		ndev->peer_sta |= status;
 		amd_ack_smu(ndev, status);
 
-- 
2.17.1

