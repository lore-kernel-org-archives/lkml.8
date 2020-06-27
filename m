Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C7DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 14:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9758F208B6
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 14:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrJykvv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgF0O7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 10:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgF0O7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 10:59:17 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E209BC061794;
        Sat, 27 Jun 2020 07:59:16 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d10so5391591pls.5;
        Sat, 27 Jun 2020 07:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=chesPouUZaMid4bYSr3ZV53BHmtt8IXHr4Z/luYFot0=;
        b=nrJykvv5dQCy9VkIa3fSoyXmFptDPtXHEVFo7qRNA2v0EaMSOE2GnZtMUP2/hvKPbm
         KMQDOH2M4s4UX74jf2MeEQFfUQ/JeS2VUU5EtdZM0glgrnp64DjWIxX958eIlnCBnncB
         luqZ4dvQaMK1fsp6GbjGmrOEGtNs02e8HGmNxnOxzX4g3Twh9ttEVn5YVxN2k3wST+XW
         2J5kVRCMv0AzuyLwZ/BksnrfPGto3hs9odnviFnHpmIJE6PEpcbXBLZPziu14ti3tmmm
         xtnwbbEw9L3F2RzLlqgUvtEj3mIA/51BJr1grE9agmkzdyBVEe/EJJX0EXDeyhgAb9u5
         Eiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=chesPouUZaMid4bYSr3ZV53BHmtt8IXHr4Z/luYFot0=;
        b=aYd/Cfh0lE/PKd0MT19v+xwBH9nF+9rp4DfgvICh1vN3gyCxSSIY+Z8n+4I/VZZF46
         nY6GOd1ZqGA5deAyuFpIExxcH7gLurhSeCXfJK2oxCUreiZWubByKMsdhgIhKtgd0lZR
         FrvmFw8CAyNYjfsurCavd3AXh8Rx+or9yZEZ/oj3iB46GTEzUOHlvpKaOLaUxmlS1mYT
         ArQWolrpSqt6+bjWFTpJuOlUH3j0D5Wyv9iRAKjbYNTTBG0+cYHaQw7JNJBvzrYk73Wv
         VPCHhbBHcBAj5ACnzq9fQsrYDbsE2FajB44CC3x+s+f1YWCxysJIPqFfGxojnT/OnHLe
         pmtg==
X-Gm-Message-State: AOAM5314142AkuUvxhx/hxdavXYf1Offx5JS3aNlw3pgtPqhO8I9LcGL
        6c5j2DpCV02VILxWeLptX0M=
X-Google-Smtp-Source: ABdhPJwR75dTLHgeGYWcFmTUSTdNqrjXkJOQFaFvHKZuNS4t0epDw8LKWj8+wSNK9lFPtzbJeWmvrg==
X-Received: by 2002:a17:902:8546:: with SMTP id d6mr6942743plo.220.1593269956440;
        Sat, 27 Jun 2020 07:59:16 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
        by smtp.gmail.com with ESMTPSA id i125sm25063375pgd.21.2020.06.27.07.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 07:59:16 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        gregkh@linuxfoundation.org, Manish Chopra <manishc@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com (supporter:QLOGIC QLGE 10Gb ETHERNET
        DRIVER),
        netdev@vger.kernel.org (open list:QLOGIC QLGE 10Gb ETHERNET DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/4] staging: qlge: fix else after return or break
Date:   Sat, 27 Jun 2020 22:58:55 +0800
Message-Id: <20200627145857.15926-3-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200627145857.15926-1-coiby.xu@gmail.com>
References: <20200627145857.15926-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary elses after return or break.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 drivers/staging/qlge/qlge_dbg.c  | 23 ++++++++++-------------
 drivers/staging/qlge/qlge_main.c |  8 ++++----
 drivers/staging/qlge/qlge_mpi.c  |  4 ++--
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
index 058889687907..87433510a224 100644
--- a/drivers/staging/qlge/qlge_dbg.c
+++ b/drivers/staging/qlge/qlge_dbg.c
@@ -1391,12 +1391,11 @@ static void ql_dump_cam_entries(struct ql_adapter *qdev)
 			pr_err("%s: Failed read of mac index register\n",
 			       __func__);
 			return;
-		} else {
-			if (value[0])
-				pr_err("%s: CAM index %d CAM Lookup Lower = 0x%.08x:%.08x, Output = 0x%.08x\n",
-				       qdev->ndev->name, i, value[1], value[0],
-				       value[2]);
 		}
+		if (value[0])
+			pr_err("%s: CAM index %d CAM Lookup Lower = 0x%.08x:%.08x, Output = 0x%.08x\n",
+			       qdev->ndev->name, i, value[1], value[0],
+			       value[2]);
 	}
 	for (i = 0; i < 32; i++) {
 		if (ql_get_mac_addr_reg
@@ -1404,11 +1403,10 @@ static void ql_dump_cam_entries(struct ql_adapter *qdev)
 			pr_err("%s: Failed read of mac index register\n",
 			       __func__);
 			return;
-		} else {
-			if (value[0])
-				pr_err("%s: MCAST index %d CAM Lookup Lower = 0x%.08x:%.08x\n",
-				       qdev->ndev->name, i, value[1], value[0]);
 		}
+		if (value[0])
+			pr_err("%s: MCAST index %d CAM Lookup Lower = 0x%.08x:%.08x\n",
+			       qdev->ndev->name, i, value[1], value[0]);
 	}
 	ql_sem_unlock(qdev, SEM_MAC_ADDR_MASK);
 }
@@ -1427,11 +1425,10 @@ void ql_dump_routing_entries(struct ql_adapter *qdev)
 			pr_err("%s: Failed read of routing index register\n",
 			       __func__);
 			return;
-		} else {
-			if (value)
-				pr_err("%s: Routing Mask %d = 0x%.08x\n",
-				       qdev->ndev->name, i, value);
 		}
+		if (value)
+			pr_err("%s: Routing Mask %d = 0x%.08x\n",
+			       qdev->ndev->name, i, value);
 	}
 	ql_sem_unlock(qdev, SEM_RT_IDX_MASK);
 }
diff --git a/drivers/staging/qlge/qlge_main.c b/drivers/staging/qlge/qlge_main.c
index aaecf2b0f9a1..0054c454506b 100644
--- a/drivers/staging/qlge/qlge_main.c
+++ b/drivers/staging/qlge/qlge_main.c
@@ -3778,10 +3778,10 @@ static int ql_wol(struct ql_adapter *qdev)
 				  "Failed to set magic packet on %s.\n",
 				  qdev->ndev->name);
 			return status;
-		} else
-			netif_info(qdev, drv, qdev->ndev,
-				   "Enabled magic packet successfully on %s.\n",
-				   qdev->ndev->name);
+		}
+		netif_info(qdev, drv, qdev->ndev,
+			   "Enabled magic packet successfully on %s.\n",
+			   qdev->ndev->name);

 		wol |= MB_WOL_MAGIC_PKT;
 	}
diff --git a/drivers/staging/qlge/qlge_mpi.c b/drivers/staging/qlge/qlge_mpi.c
index 3bb08d290525..fa178fc642a6 100644
--- a/drivers/staging/qlge/qlge_mpi.c
+++ b/drivers/staging/qlge/qlge_mpi.c
@@ -276,8 +276,8 @@ static void ql_link_up(struct ql_adapter *qdev, struct mbox_params *mbcp)
 			netif_err(qdev, ifup, qdev->ndev,
 				  "Failed to init CAM/Routing tables.\n");
 			return;
-		} else
-			clear_bit(QL_CAM_RT_SET, &qdev->flags);
+		}
+		clear_bit(QL_CAM_RT_SET, &qdev->flags);
 	}

 	/* Queue up a worker to check the frame
--
2.27.0

