Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280A3C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED9E20721
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3LBbVdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387408AbgDBCdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 22:33:22 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34218 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgDBCdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:33:21 -0400
Received: by mail-pj1-f68.google.com with SMTP id q16so2821166pje.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 19:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ATIn1oIMiOwI325i99rfncSx0LFzAXo2FxSFZi+2kaM=;
        b=n3LBbVdVMR9xztTWPZj9E4NAFROVpVuh4KUeELtpWMpWqKKx5lGsHyovhlSlocwRJf
         nN/pb2bi91NTXpSJ1uY00zkUiaPE1bGQ1OESWp5M3dZfU5PDgILsOCat+syRefKVKUQd
         NXAWZZRUUUWiZoDrpVBNkYiOUY3YwQbs4YN+1WLDGx4SIvMQHLOiGDrtnEZBewl7LeBk
         bV7tfeAbWFkoGaMruVpc4b5Cmt71VHuO8gVt3bKcqOtUZ3+4XYu4x4S6yOMwfntDxKEi
         Fn+YCM7DNZJ8NmjPzIxP8e2qLMH2U7SpRydjD4pitF5Y5D0juJOw5QqzRa2deSIgGTFi
         RmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ATIn1oIMiOwI325i99rfncSx0LFzAXo2FxSFZi+2kaM=;
        b=fgrjDIlmWn/e81hzNx1blwZJ4TubD+bSgF1IpbXYeKU8WLahdMM2zd6IN20j41e5JJ
         cjjx10a4TE3+zW81PiJa71x5jeULutz+gIydBYYCcnn6uXsTh1CDVzmf+DPBE6i2vVDH
         6hlFb0Sdw4ylhH6u8Wae239+RYlAzp9I1bSHaVvBKU2xGlEH+iUx3Gwy9TPYbbAdzc5x
         6Z4SFbdBGP4UK65AEavIxzQ3IQZdHkbAnPWQNGPgLBpV5dIllmyzXPTjvpdQwl6hvraD
         53F6t/TogpnpeTbVo8/aLsjBoFncT7FrdbaizMs+NmO4+v7EEVY+AsEIrYx5ev9wUJcp
         EL0Q==
X-Gm-Message-State: AGi0Pua7riLlOdSrrRLTJeRPRnWY7kuUnvXF6q6u5lWzqR74Lgypqe+d
        PULV0i4FWAnHV32rGtbzP4hgKGeU0b86cA==
X-Google-Smtp-Source: APiQypLRbDTF91VykRK3Z/pEgpBEwK+uBtcjCC4EZ+kNI3dgYXQkXJFmPIpDmGRKtu9XXqqhig71Fg==
X-Received: by 2002:a17:90a:24c5:: with SMTP id i63mr1182990pje.177.1585794800765;
        Wed, 01 Apr 2020 19:33:20 -0700 (PDT)
Received: from OptiPlexFedora.fios-router.home ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id b2sm2609402pjc.6.2020.04.01.19.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 19:33:20 -0700 (PDT)
From:   "John B. Wyatt IV" <jbwyatt4@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Cc:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Subject: [PATCH] staging: fsl-dpaa2: ethsw: Fix parenthesis alignment
Date:   Wed,  1 Apr 2020 19:33:10 -0700
Message-Id: <20200402023310.816245-1-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix 2 parenthesis alignment issues.

Reported by checkpatch.

Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 676d1ad1b50d..546ad376df99 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1094,7 +1094,8 @@ static int swdev_port_obj_del(struct net_device *netdev,
 
 static int
 ethsw_switchdev_port_attr_set_event(struct net_device *netdev,
-		struct switchdev_notifier_port_attr_info *port_attr_info)
+				    struct switchdev_notifier_port_attr_info
+				    *port_attr_info)
 {
 	int err;
 
@@ -1277,7 +1278,8 @@ static int port_switchdev_event(struct notifier_block *unused,
 
 static int
 ethsw_switchdev_port_obj_event(unsigned long event, struct net_device *netdev,
-			struct switchdev_notifier_port_obj_info *port_obj_info)
+			       struct switchdev_notifier_port_obj_info
+			       *port_obj_info)
 {
 	int err = -EOPNOTSUPP;
 
-- 
2.25.1

