Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AC0C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 13:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E932068E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 13:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkgRwto9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgECNXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 09:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbgECNXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 09:23:36 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121BAC061A0C
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 06:23:35 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k1so17653631wrx.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 06:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XO180w3Gyt92NXqJ8MWXDYCkhwcnEwcS3GLjFPvLeyQ=;
        b=TkgRwto9LeHwZqEescpLjbmPcNXR6ZqMQ6oFJd31QHctyxedVzzFpIfQfmEZwXtPCa
         e94RGi0uD2XG9dOfA4uEJgs6l/FepcxPDmRkUjX75OQWTspPGDXE4mDv1I/K6uR2gqj0
         1liKR0PXX6sewDORV2kOahqUjHh57XMhcin5PIt2atuXMH0+XmnECJ931j9ugUsH5OPE
         SI6XAvJOGb5HQESVUzFFEFR2kDguNqyWDKV05T3HhHB43t4IndcSnDD3wmvyMN1QOHzt
         115ek6T9kocsGGhX+R6YH89Bwm8Nl6zkJl+BnW6+j/cOBHXIrZKQFqSnXRAspJgYeEzh
         kknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XO180w3Gyt92NXqJ8MWXDYCkhwcnEwcS3GLjFPvLeyQ=;
        b=OPlCtWaxwSPWOp/CqNaXE7pZXh51RqmRalfn+oWgecgCry59MiuF/KyokgkIurU6yt
         zsPXHnDGlk/rm3WK/GR/K9xdpW9ZXvnBzJgYBBDV2/eMb0pbUgGJUUPZUbnZrdEREzTb
         AZW1IDdyTZ2obn8hWQs1w0wV0gI8+qFy2IQe6j7rCIJ5jMLtSlJH7m9bPXAYEmoseq3v
         azReNVsTHeAc/szZu7RTHujMR1cDnHj2RUzOiv/Qus2FvslywQGHG+Frnw8UR68D73E5
         QQRfxhxR1CmMytJ4iDWBnEY8hStk8WDxOE8hBK8eJ7EqranEfi50f+XYHhvq/9uwoLgx
         dgkQ==
X-Gm-Message-State: AGi0PuafgCEmb4BfKtZOY0mq73UcWzHVGvqpzeFnSyciR8QP8x9lNEk7
        X0QABrPo+8w2KZge7sMHw0yhCm/P
X-Google-Smtp-Source: APiQypIN5kEoyJRhf3LoJRNomYGnlSGdDowwfllqXDF38RWnmatQwgRoLZLCsUjJiSeJMd0TCIfDFA==
X-Received: by 2002:adf:ce0a:: with SMTP id p10mr13517816wrn.89.1588512213265;
        Sun, 03 May 2020 06:23:33 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id r23sm7627188wra.74.2020.05.03.06.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 06:23:32 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: add missing MODULE_DEVICE_TABLE
Date:   Sun,  3 May 2020 17:29:19 +0300
Message-Id: <20200503142919.14863-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI drivers should use this define to declare their PCI ID table.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index b670859c677a..5e73b456facd 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -47,6 +47,7 @@ static const struct pci_device_id ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HABANALABS, PCI_IDS_GAUDI), },
 	{ 0, }
 };
+MODULE_DEVICE_TABLE(pci, ids);
 
 /*
  * get_asic_type - translate device id to asic type
-- 
2.17.1

