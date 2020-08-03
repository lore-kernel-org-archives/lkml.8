Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D310C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59FA22076C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+VjpceE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgHCLvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgHCLv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:51:28 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB0FC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 04:51:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q76so13932434wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 04:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=P7Q1lJHqVkqxaTMb6WTzWQvdXN5W9ErVGDG9hkuSZsA=;
        b=A+VjpceEPWo7QWRBeMZXJliBlAsTyax8Hb+X1BwjiugZIBxVp3lZMp6vxM6wH0PiHc
         6soefw5/1LaWmumJ+Zd05Z1XXxGpo5O68B/+ZvIimZPnbznjh9tgmj3nXz+yaFbhWOaF
         93/AEvcPpdjNAkq/mtGZG99VtuTPST0YnEIJl0P94BiI2sWtkzAEyjJTqL6cDvr+7ArC
         cbVfd/PvgHWt5hBKioFXNFgy/+lKIOlxVZTKw5p+RPUvQwgzhNe/NtMUEmi5yXhqLPJU
         FcYJ3Pm2owlbcdf8r3O2VtPHTRml3XMRo1/eQb51rM1x6uqzuxmdd5KQeRJmwENZJGNh
         sLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=P7Q1lJHqVkqxaTMb6WTzWQvdXN5W9ErVGDG9hkuSZsA=;
        b=Ub7NpKFERL7DNYyE+s8YJLSgGNxrS9tAibTAqkFHVn++9ljGmFMpxr7z1Sv4iYmRHK
         owsHiyz6A+tKVwc8n9N6JT8j3CpE33Rf5do+JEK+0pz12a7epakPaExgI4okojsT+ONj
         ncAM2bTdJpMhpzpwrygllBvA/A2nVP8myXb8tSGmfYzJVeBbTECWpj6CyEB7MPDHJuVT
         LU/5QGtp8b+oXhw3ZhnAEnnMCiv8P0+XeIdIdT5gaHIDNDn2jV29s6Nt62N3t0XulxfQ
         z3z6TSWkrd+/z+z0wcVOY+kntQtUrggvT19FSjicrVxs5d2Qo4KbEKozAEwwGcGWeJoD
         esvA==
X-Gm-Message-State: AOAM531JIzbZiJ2T2hzebzSrtajDpnN1P2u7iNqEoQqAp6H/lNOrf06R
        S5KtcTcrxwbP4+/SqFdb3zMgBHT5
X-Google-Smtp-Source: ABdhPJwef8MJ3cAwq3uYCx3+hMYQYkVf1rsumONdCkv3M2QV1qPZf/zRGeLd+HrALH3nK9etqn080g==
X-Received: by 2002:a1c:7e44:: with SMTP id z65mr16525047wmc.13.1596455482074;
        Mon, 03 Aug 2020 04:51:22 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id x11sm23885869wrl.28.2020.08.03.04.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 04:51:20 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: increase length of ASIC name
Date:   Mon,  3 Aug 2020 14:51:18 +0300
Message-Id: <20200803115118.31211-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Future ASIC names are longer than 15 chars so increase the variable length
to 32 chars.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/habanalabs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 942f7e52f1a2..8b5b4afe42c7 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1524,7 +1524,7 @@ struct hl_device {
 	struct device			*dev_ctrl;
 	struct delayed_work		work_freq;
 	struct delayed_work		work_heartbeat;
-	char				asic_name[16];
+	char				asic_name[32];
 	enum hl_asic_type		asic_type;
 	struct hl_cq			*completion_queue;
 	struct workqueue_struct		**cq_wq;
-- 
2.17.1

