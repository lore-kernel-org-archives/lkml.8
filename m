Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607FAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34F652074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLJhXVQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgFPGOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgFPGNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:13:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17C7C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:13:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x13so19398509wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pXcr8OVP5X871RYqTA04gII+1qhPuiQakZxe8lH3bVI=;
        b=hLJhXVQEM9udh+ljE+IHs7RDvOcS2K4wQxe4VgcSg3Ehdfk4suQm8QyJC2dJPmRIps
         DNB/mvwQTCAIMS6eJ/WpWqiYQvQicsMuzEnJLOflcUTGyMw21RD6jYL4BZit+FhmrrY4
         JcZSMQ+AvxVPloXL4xY19TiDC1b2cEfYos9JlymQR2pTfyQL4jlByKpnUtUNE5J9Jsjx
         T7dUqRKv2meY312B2kCmIPkrVq800HZM7RTIa408QE+O2xfXT3faZtrMN+EMYYR0juO1
         vPqZwh0YpD5TLCsRsWKLU34Oc2JUo1Rm+k9eOYrI9G2G4QrHS2OJ6IFu4PLPJNHV7tpM
         RlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pXcr8OVP5X871RYqTA04gII+1qhPuiQakZxe8lH3bVI=;
        b=W1d13LiXEtmPyITcalcJrUiyWuRjmrR1lgudehLMwZVZcEe4IMrHgy+1FE4ugQwaXA
         2Y7VKBwHjcXTYmB4gEkszds5P2pkCvROxw+CuiCA/BEjdHx6gMGks1uHSa2FVfGCKODz
         tgfD7a+vRLAUKkTwXMYP+cgYAsp3qvKtuqSWfBtp4CgCUsK+0vDnqp/LY8VULE/EqLoo
         RzsJkjNpG+gP2hXuHJnt4AG6gOhBjOhHnbrXiQizN4OO8SqtAsyr43W0PeCtnbqlDcJ1
         LvC5wJWzaBCuVaCx/WNAHzRA6wCeradi6sH0bwbFEyoAhnBT1Bjz6oAiQHHQ9jo5wo7D
         uy9w==
X-Gm-Message-State: AOAM531RZBr40Mp4y0H117mR5zg0tPJQwMfi7mFQ6VTc6TQxvgmx5y9F
        vBQV6239gciytKL/7nqAJH7nqldW4Ic=
X-Google-Smtp-Source: ABdhPJwd1Xh+Exq9A6lZlLJc1MjCnx1mj6gFV1W8vQvfcTGvhC+rKss6OCWDDFd7597s2ZcKx6faEQ==
X-Received: by 2002:adf:e3c1:: with SMTP id k1mr1156520wrm.33.1592288023241;
        Mon, 15 Jun 2020 23:13:43 -0700 (PDT)
Received: from ODED-MAIN.localdomain ([87.71.142.251])
        by smtp.gmail.com with ESMTPSA id s2sm2354963wmh.15.2020.06.15.23.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 23:13:42 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 6/7] habanalabs: align armcp_packet structure to 8 bytes
Date:   Tue, 16 Jun 2020 09:13:26 +0300
Message-Id: <20200616061327.12006-6-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616061327.12006-1-oded.gabbay@gmail.com>
References: <20200616061327.12006-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once there is a 64-bit field in a structure, GCC compiler for ARM aligns
the structure to 8 bytes. In order to avoid confusion when these
structures are being passed between CPUs from different architectures, we
explicitly align the structure to 8 bytes.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/include/armcp_if.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/habanalabs/include/armcp_if.h b/drivers/misc/habanalabs/include/armcp_if.h
index a34fc39ad87e..dea7c90faafa 100644
--- a/drivers/misc/habanalabs/include/armcp_if.h
+++ b/drivers/misc/habanalabs/include/armcp_if.h
@@ -276,6 +276,8 @@ struct armcp_packet {
 		/* For get Armcp info/EEPROM data */
 		__le32 data_max_size;
 	};
+
+	__le32 reserved;
 };
 
 struct armcp_unmask_irq_arr_packet {
-- 
2.17.1

