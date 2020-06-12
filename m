Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4A4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 20:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBBE206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 20:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="R3pCRUqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgFLU2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 16:28:03 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:51994 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLU2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 16:28:02 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49kC361SYMz9vpNQ
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 20:28:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1XlsPzMKRKNS for <linux-kernel@vger.kernel.org>;
        Fri, 12 Jun 2020 15:28:02 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49kC356vFhz9vpNR
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 15:28:01 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 49kC356vFhz9vpNR
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 49kC356vFhz9vpNR
Received: by mail-io1-f70.google.com with SMTP id p8so6858745ios.19
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 13:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=15g7t7Uei6AmpLN3ekbAqZ45/3DFCsrsD7nCEei6vOg=;
        b=R3pCRUqHU9BitaWWtCt5Z2/yajAtRzxQgM0OvAPYqThro6GY8jb5QI3sfLmf0JHjG1
         2i1TuFSnZ7utZNNYoQ1e/ttJ5lNDz+Y1RfsBFueSj57DghPX0XxhFvGmvrtBSqsI5XBC
         g/jlLtaLjh34bTcS0P54PfMVDHa1SNU4eiuXYaVk1cwGQUmF109ois/t/BhzRlAS9atI
         nV49jCWjqSw0i+KPPiBV4dMhCO8WyXlJq3V0selPPMqWGNkZcnVgMRhJXrPwDebXt6FR
         zKR4Js63iOuGRMsJDXakKew2cezTXYOJM1khIwJJaaLklO9NUYOka3rjSmqrsk12EJAg
         YHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=15g7t7Uei6AmpLN3ekbAqZ45/3DFCsrsD7nCEei6vOg=;
        b=oUA4iCYzEUbdSCTkbvAA64LL2PBNuRDr1AlZ7ZnrVThr1+0nGcq/bx3KJAweGVb3ly
         aGgYo9G8WhNxzl9pIeX2alL3IV2DKhYcP4F+TUKPYq0opAV7wOY7ea10zWYFZ8vLSZMi
         skC7CRFOHPK1uSbpVv3Wv2gujclxxUsyG8ucPcs4BaJTW5yZ0jxs8j1DKygp+y0Hl5lz
         5KTn6TzsQqLq3mBMYqS70GYbFIQFTc7Lhh5E9uLxG0LTitvLOIajNm2IE8Cv+uvhzjo2
         Zw6HKSdJ4eEcA5oiWxsSoHho2zcTXBvlbx5MR3+bMQ557dukOnAa2cqPNdLJRC13lzQM
         Rhdw==
X-Gm-Message-State: AOAM533QjFXLqRiq0tmeg33YnoRjm5RrXzVd2runE05LN+SOY6cuKE29
        FP5m6fhlNIA2wUc7YhINaaIqs7kWGqRdJGECTti58/Q02LZ9CafEeH0tNmbPIyZGzyGTqvNx1k1
        Z2QtgIxFa7S88phcYCLu0r/AfS89Y
X-Received: by 2002:a05:6e02:8ea:: with SMTP id n10mr14152592ilt.58.1591993681604;
        Fri, 12 Jun 2020 13:28:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrCxyRcnu/uj9UMguP3lKGMvs3vnk4/rXTUtjzr6ELOw0xUTbZ5xJTp7kURkky+wDW/4Kaww==
X-Received: by 2002:a05:6e02:8ea:: with SMTP id n10mr14152574ilt.58.1591993681403;
        Fri, 12 Jun 2020 13:28:01 -0700 (PDT)
Received: from piston-t1.hsd1.mn.comcast.net ([2601:445:4380:5b90:79cf:2597:a8f1:4c97])
        by smtp.googlemail.com with ESMTPSA id r1sm3565653iln.77.2020.06.12.13.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 13:28:00 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, wu000273@umn.edu, Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rocker: fix incorrect error handling in dma_rings_init
Date:   Fri, 12 Jun 2020 15:27:55 -0500
Message-Id: <20200612202755.57418-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rocker_dma_rings_init, the goto blocks in case of errors
caused by the functions rocker_dma_cmd_ring_waits_alloc() and
rocker_dma_ring_create() are incorrect. The patch fixes the
order consistent with cleanup in rocker_dma_rings_fini().

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/net/ethernet/rocker/rocker_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 7585cd2270ba..fc99e7118e49 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -647,10 +647,10 @@ static int rocker_dma_rings_init(struct rocker *rocker)
 err_dma_event_ring_bufs_alloc:
 	rocker_dma_ring_destroy(rocker, &rocker->event_ring);
 err_dma_event_ring_create:
+	rocker_dma_cmd_ring_waits_free(rocker);
+err_dma_cmd_ring_waits_alloc:
 	rocker_dma_ring_bufs_free(rocker, &rocker->cmd_ring,
 				  PCI_DMA_BIDIRECTIONAL);
-err_dma_cmd_ring_waits_alloc:
-	rocker_dma_cmd_ring_waits_free(rocker);
 err_dma_cmd_ring_bufs_alloc:
 	rocker_dma_ring_destroy(rocker, &rocker->cmd_ring);
 	return err;
-- 
2.25.1

