Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631AAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B6A520702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ya78GGdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbgGAMsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbgGAMrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:47:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394C8C03E97B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 05:47:15 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so23636977wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4HmkZgMMnNokIcxpC5qsgSTpETcgy+guvTGIOYd3vjA=;
        b=ya78GGdRIDBQGK8B84BfpjUHk69NCx0tP8mmoMldCAn5FHcrT/VhqMAXQF6V/OVicR
         FMY6bg9H1UVELQAZDu4fCvqgDKIKWO4S9wzT4m3AteUDzvlZOK4/MtjhiCd+KXmKMb1L
         F1TtQ/2H7zYbSMx2RxkB8Qz1Gr21YJj+SLdsFpOqYnZSQUbS93IXbdEXgX9sf6HweKB0
         TNVjzis0NXV8fJMHzzSeFbiEixlXlbJBV2nY8NiHHWlwBss2KBdZAh0ig6sPaccKPpN9
         +cviagir9w82XUTR6EHMNr+NxvILSikRpvq1WwLaBLKCHbd8OhUghVvGmfhwHjUneWS0
         WzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4HmkZgMMnNokIcxpC5qsgSTpETcgy+guvTGIOYd3vjA=;
        b=YQue7iPrTknXvrA521ssWdyjrvh/2xmLi3oNgQk1z7DmQZxcCw/Sw6NlKsCwrrGVOY
         GIE/WGymRuSexMrOSeu25w1EacRYvGMb2JbwOPln8XrxtaDC3V+bE+yeQ4W465f072j2
         6imlskZ3CDNJD52ZbzoJjdkFVAFOhbQiDo75sI9TRIulTh/j4QouUXzCHr/utB+VhAVz
         RrBmR8bQ4JP/Wzf4A4O5xkLby3fZ52ZEaknmWDXyXIbulc3DamBgik0dGOMJI0JI7KXt
         JTxPuZT8C2ZJ8yi0wwZilpkcGUdYGS+8GSUcslHSB7ELAdX3oVzGcl200V4wNi5Y3NtE
         8luA==
X-Gm-Message-State: AOAM532bR7aJFp5CMrEBGkkRksmRsNjuse2UUiypjtVRO7O4/PSmdRqY
        uNymQQNNPVPCd8GFCuAXuneCeQ==
X-Google-Smtp-Source: ABdhPJx5sdyemoJCIEKPCxf8WbgcrVsCh6V9mQezCi/IiAds/ZoliLC+HT1ZY95I0UsHrI8WiYDixg==
X-Received: by 2002:adf:ecce:: with SMTP id s14mr26836949wro.154.1593607633908;
        Wed, 01 Jul 2020 05:47:13 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id o29sm7817862wra.5.2020.07.01.05.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:47:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 06/15] mmc: host: atmel-mci: Provide 2 new and correct 1 existing property description
Date:   Wed,  1 Jul 2020 13:46:53 +0100
Message-Id: <20200701124702.908713-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701124702.908713-1-lee.jones@linaro.org>
References: <20200701124702.908713-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'sg_len' and 'dma_conf' are missing correct kerneldoc documentation and
'buf_phys_addr' was misspelled.  Correcting these issues fixes the
following W=1 kernel build issues:

 mmc/host/atmel-mci.c:352: warning: Function parameter or member 'sg_len' not described in 'atmel_mci'
 mmc/host/atmel-mci.c:352: warning: Function parameter or member 'buf_phys_addr' not described in 'atmel_mci'
 mmc/host/atmel-mci.c:352: warning: Function parameter or member 'dma_conf' not described in 'atmel_mci'

Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mmc/host/atmel-mci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 5cb6926876981..300901415aa20 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -225,12 +225,13 @@ struct atmel_mci_dma {
  * @lock: Spinlock protecting the queue and associated data.
  * @regs: Pointer to MMIO registers.
  * @sg: Scatterlist entry currently being processed by PIO or PDC code.
+ * @sg_len: Size of the scatterlist
  * @pio_offset: Offset into the current scatterlist entry.
  * @buffer: Buffer used if we don't have the r/w proof capability. We
  *      don't have the time to switch pdc buffers so we have to use only
  *      one buffer for the full transaction.
  * @buf_size: size of the buffer.
- * @phys_buf_addr: buffer address needed for pdc.
+ * @buf_phys_addr: buffer address needed for pdc.
  * @cur_slot: The slot which is currently using the controller.
  * @mrq: The request currently being processed on @cur_slot,
  *	or NULL if the controller is idle.
@@ -240,6 +241,7 @@ struct atmel_mci_dma {
  * @data_size: just data->blocks * data->blksz.
  * @dma: DMA client state.
  * @data_chan: DMA channel being used for the current data transfer.
+ * @dma_conf: Configuration for the DMA slave
  * @cmd_status: Snapshot of SR taken upon completion of the current
  *	command. Only valid when EVENT_CMD_COMPLETE is pending.
  * @data_status: Snapshot of SR taken upon completion of the current
-- 
2.25.1

