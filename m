Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D18C433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0B332220C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QMwhtxDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgGNLS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgGNLQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:16:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8537AC08E6DC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:16:04 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j4so20883956wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NG9Wo5yoqPGjiyqodzKSv+oNiGoDZQc2LrtiOZLw/AM=;
        b=QMwhtxDa+JsIYLGkUIZnWg3AJTpgFH0ficDCJzPtKLoaZCg8YduENGKsRoTzfb0QTz
         Gyu3Cqsat4DTRiNwff9MhhGJxWAsooiZxVz2Yp/6x0RpBecs9ejTuRPUEpJUZG75fi3X
         +P6gjwJGwpRpgD6jnp7+9mxe0EtP29RHfFxLUFtSXHH/C+je3VQ7E40NHqdEoGoiuWAD
         bIbdmUhQEcsv+lomE5TNhgItLBYNn65TwW9BP3v2Bw4Ie4p4y+BC0M4QzjX5NB01jxyG
         VlD9mWRFwKCxJVSb/6HyXNPrS6UmSuXj9Ya3O8ddMBXpU5Ree0hlB8zVke5Id4lo3q6n
         u0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NG9Wo5yoqPGjiyqodzKSv+oNiGoDZQc2LrtiOZLw/AM=;
        b=RZ95E4IiSspYm3ZO57h6ib67huLwFQ/tZLXWByCrwrnKnb2jI9XaGtIVL5vePwHrgy
         P2PiPrOt4pbvXNgdY4CkSulFRpOKPMfSQZ94oQYT67ei/pCoM0qiu9oU7GFyZTyKrBXM
         S2rf2eQzhYoFliDBCR2CDDLfAGRqRfj0Hr0u8gc0sQBopI3UKQwXjhJ6qRYcFFSVEzEQ
         7kFiGu8VhGxGLNloTC322z7D7GPBquqb7XmlNfN7ubj20NxzIuPetDuhQ5uOcYv24Xj0
         DjbSfFAKNHFHcUTxpxD1htUDejHXhOrPDHYkhZr9ZstunG1W/DDi5hY0HZwS+zMWI7H8
         OFtQ==
X-Gm-Message-State: AOAM5334CTlg3i/wzo4ocQpiNzKzYf6Ip4MsQ+gLacKBydrTKefwhoa5
        7GK3bI0OMunf3P9QgcdUnPqN/A==
X-Google-Smtp-Source: ABdhPJzQhzUPxkgJqMX4nrpyi4zj2gxa+lDyykGrb8nrWKpjpsCsNGmOs+AiZhWEbBSh2KpnpmRSug==
X-Received: by 2002:adf:f388:: with SMTP id m8mr4801297wro.338.1594725363325;
        Tue, 14 Jul 2020 04:16:03 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:16:02 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 12/17] dma: iop-adma: Function parameter documentation must adhere to correct formatting
Date:   Tue, 14 Jul 2020 12:15:41 +0100
Message-Id: <20200714111546.1755231-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also remove superfluous entry.

Fixes the following W=1 kernel build warning(s):

 drivers/dma/iop-adma.c:418: warning: Function parameter or member 'chan' not described in 'iop_adma_alloc_chan_resources'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/iop-adma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index db0e274126fb7..3350bffb2e937 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -406,8 +406,7 @@ static void iop_chan_start_null_xor(struct iop_adma_chan *iop_chan);
 
 /**
  * iop_adma_alloc_chan_resources -  returns the number of allocated descriptors
- * @chan - allocate descriptor resources for this channel
- * @client - current client requesting the channel be ready for requests
+ * @chan: allocate descriptor resources for this channel
  *
  * Note: We keep the slots for 1 operation on iop_chan->chain at all times.  To
  * avoid deadlock, via async_xor, num_descs_in_pool must at a minimum be
-- 
2.25.1

