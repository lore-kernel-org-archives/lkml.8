Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B2BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 23:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8648C2250E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 23:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hM9DERAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgHEX1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 19:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgHEX1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 19:27:05 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832D9C061757
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 16:27:04 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 185so39407882ljj.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 16:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+O2DaDRZH6h9f7WMA09N1vTpbGM//lQdRVMqXRnCufc=;
        b=hM9DERALNg5R6Ha4jhrnYmLcn0MYi6h2qZV7pDm9aM92VheCRLW3OSvuql1XKxdNuM
         851IfSgmv7IFxSCtZQER6eUjZwn/z6gP27yfiv2fkseF97ILx4kVf17ERwgeEHXbO6AA
         SNrRtPZsZKYmhBEv8RcLucDmAS8XK9I+f/VbWLVwuL8f/o4xLhm6FIaqTXyc45Lq8p4Y
         qoLwfVdOrPUx6VQTzb0jqMyyWnQ8pI/2Qki0BdRpMUx9Ys4UTK+E2cEwWhxouQyxLhEP
         eJaPtzB0yk/BavPx1s5n0GGj7pJb4JlVfwaXin94hoQhtlz+P5+gmHL2OFKrTiHJsZD0
         csgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+O2DaDRZH6h9f7WMA09N1vTpbGM//lQdRVMqXRnCufc=;
        b=PhOTwaipp5EsdmCsSTD7J1ci5eRbQEcDwfa6EWWzN8oRy/NwuOL86CD3UMseuqTUAC
         xK2FNAoiozX8sb3C2fKlSfBEIHHk1wPLfFtGJvz4fIA5nhp/aKLFCV5SYqiVO097c2Kj
         0xPwLtON81fthaBEZMu03OO4ZRA1ZxfNImrEjmUrSOg8hNurhkyFbnW2TupX7PbdDAHP
         R6+RRtfj3EbN4BECvh7C3zCMG5gL9VXb5RZA6wCdSMmrcEuVHPLwym5rB3rwGPRcefpN
         UjSsnVjdDO0HwSChEsJ4WLBYHiifQZGoh0deykdWDTmGOl/BsQCxVulGfqHW6okTI5bf
         JY9g==
X-Gm-Message-State: AOAM532sm2gDU6hjN8aLA1Ph6f5zV5atoxEXlPjqiZ2tJC4LoLE16pwF
        iRGfEkDSTBZVcQvzyQtys/0=
X-Google-Smtp-Source: ABdhPJzCuPYHOqSjZ8Am6w8WQojGtw7DQkpMuftiQQ3InfSqgm5i7h91jXMsShkTW4vaZgUA3OTlmQ==
X-Received: by 2002:a05:651c:1024:: with SMTP id w4mr2419618ljm.244.1596670022934;
        Wed, 05 Aug 2020 16:27:02 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id r16sm1485603ljd.71.2020.08.05.16.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 16:27:02 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, eajames@linux.ibm.com,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 3/3] fsi: scom: Constify scom_ids
Date:   Thu,  6 Aug 2020 01:26:24 +0200
Message-Id: <20200805232624.6938-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200805232624.6938-1-rikard.falkeborn@gmail.com>
References: <20200805232624.6938-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of scom_ids is to assign its address to the id_table
field in the fsi_driver struct, which is a const pointer, so make it
const to allow the compiler to put it in read-only memory

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/fsi/fsi-scom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index 004dc03ccf09..b45bfab7b7f5 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -627,7 +627,7 @@ static int scom_remove(struct device *dev)
 	return 0;
 }
 
-static struct fsi_device_id scom_ids[] = {
+static const struct fsi_device_id scom_ids[] = {
 	{
 		.engine_type = FSI_ENGID_SCOM,
 		.version = FSI_VERSION_ANY,
-- 
2.28.0

