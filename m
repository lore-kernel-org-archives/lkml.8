Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2428C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791A620702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZFXdztB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgBEPzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:55:19 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45058 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbgBEPzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:55:17 -0500
Received: by mail-pg1-f194.google.com with SMTP id b9so1149105pgk.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=2uclY266m3vl3O6CK5JaBmW5CVIO6lWzMDS9vhDGfZU=;
        b=iZFXdztBj8ZRhOEgxAz0aFdE6IVn8NZ2fE0sQAxwXQaf6m8OFZo1TwzvyHpjxu5ntr
         FY0Fs4K8sVhh+hF40khH6blRydEPqpc/aV86rEx4E2sUoNcy1ZO/lNP9SblakXDqqFaK
         A+ei4lthsYJkSXWu8PbjaShL7Mie3NHLjhtlGOrubLVLdT6oOuGA/d6RLB0OsZel8Gc+
         yaBjHQcecIsiK+5W2JA3EjnKuuQiaq33PrPScvk5B+WMUWHEfYln+7lgsJTugRLlwqjT
         O+dinAV++vFPyq1Kaa/xtWGJNbHh1r+0L5fzr54vq7lR8dKrm7ERB8aybw8nEak94+wD
         jHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=2uclY266m3vl3O6CK5JaBmW5CVIO6lWzMDS9vhDGfZU=;
        b=CBssClxg/Uez6A2wP4XlrZD//YMX6OdOSjtaCcmfHscCH0Gw7fz65mxCHyenDqkCwn
         Fy67TovapobLYUgN4YDgc5znRVYW8ZCtapTB7S9K73B6NM0qmAEhoPxcQy395sdC+7Qp
         ZvECXM8NGTXfBY9KyXegInmFLgthuWdRcKWe8dDSs2Hrez+/5vODFoUqp8VLOZfWe/A8
         y3nKOtb4qenyh4Ua8cRGVPEWf5n8R9rR9ADqkThklZt1abGt+KiIrVaN88ld47RVD6Ty
         5KN8WnjoUZn/OVRgCiYxRqOv+GeJByzteBWeTMmvdLaHktoDUivKqlJq7qE0jBUoiQ6F
         GwUw==
X-Gm-Message-State: APjAAAVHyVSNWR92pmvXM1A632OUnp8WDOuu2Wx+h5hTNY3zXxQj06o2
        GUBVwxtATKZA5FJMDjQ3D1E=
X-Google-Smtp-Source: APXvYqy8s6oGH7CmDuWchtUaitAfsmYQJUdne35Pf0ZJY1u7l1/iybe260xYa8XxnrM356El/S97ZQ==
X-Received: by 2002:a63:dc0d:: with SMTP id s13mr35858064pgg.129.1580918115197;
        Wed, 05 Feb 2020 07:55:15 -0800 (PST)
Received: from emb-wallaby.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id z10sm195678pgz.88.2020.02.05.07.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 07:55:14 -0800 (PST)
From:   Arindam Nath <arindam.nath@amd.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Jiasen Lin <linjiasen@hygon.cn>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 09/15] NTB: handle link up, D0 and D3 events correctly
Date:   Wed,  5 Feb 2020 21:24:26 +0530
Message-Id: <4c07c3e337fe2343d9fa0ff234c2d85543198274.1580914232.git.arindam.nath@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like for Link-Down event, Link-Up and D3 events
are also mutually exclusive to Link-Down and D0 events
respectively. So we clear the bitmasks in peer_sta
depending on event type.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index d933a1dffdc6..a1c4a21c58c3 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -568,6 +568,11 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 	case AMD_PEER_PMETO_EVENT:
 	case AMD_LINK_UP_EVENT:
 		ndev->peer_sta |= status;
+		if (status == AMD_LINK_UP_EVENT)
+			ndev->peer_sta &= ~AMD_LINK_DOWN_EVENT;
+		else if (status == AMD_PEER_D3_EVENT)
+			ndev->peer_sta &= ~AMD_PEER_D0_EVENT;
+
 		amd_ack_smu(ndev, status);
 
 		/* link down */
@@ -582,6 +587,7 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 			dev_info(dev, "Wakeup is done.\n");
 
 		ndev->peer_sta |= AMD_PEER_D0_EVENT;
+		ndev->peer_sta &= ~AMD_PEER_D3_EVENT;
 		amd_ack_smu(ndev, AMD_PEER_D0_EVENT);
 
 		/* start a timer to poll link status */
-- 
2.17.1

