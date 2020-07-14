Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B93C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C694F22203
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fqu+JGaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgGNLUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgGNLSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:18:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17EEC08E876
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:16:06 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l2so5010523wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 04:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tHvsPtXMawqhgTlXf8i2jhQs/B2cBsj2Ks/fZJOcmHY=;
        b=Fqu+JGaFSRh7vRRPgR/HabR8IBZaeLvvr2EcwSrSv7QCI/6fOnODRUdqwt90J3g5C8
         0s7/ZkCY/MC07cLGz5P6eZPk8H0sOh7MIQCT3wT/fmUP0dZZvRlB6+ROihSuNTcRcnrn
         3f/KQJT0rXlJvq27p2T59AjfgIz20tp6gxCQwiRj2g3DFceT0HNj5P5tLxs2F3WUfGUr
         BCztbiua/SQvCo0rqC98vsPQJ6hLsJvnB5rS2qxatc4pm34FHMoA/X6H2H78RvRzapwC
         7c22y4tqYny0qVqhSNYiSLAngITlsOr2bNM3rVNtPcNOiSxaFmQjsg/AEf1VCrEiPz2W
         p5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tHvsPtXMawqhgTlXf8i2jhQs/B2cBsj2Ks/fZJOcmHY=;
        b=ShEF3DacY3iIejks6uD9xP05l45Dwu+u8KDsnUmJ6GXLnGXIy9qlIod6gaoIqHEqZ2
         jvBneX/bvn4BU6PIuvEfI3BTy4ez2LG46eOMykwVQleUWmlznubHZ3GVslr2fE5RbZlC
         lUuTVXfWUr5knBJZ3TlMVgeprt9f7cgdtoOjM9+sE82EjSevoonDxd4IcTqxcOwIEvoh
         vvEWZGK4im/gRj0IWk0SxtVdUTj7uN/QPcxSAj/Q7S4Zt6h57Bpfu5bNpv8I1BkRsCOn
         3+NUGCmFU6lsS95lSOwdvkEky70L0flXkHwCemEwAHNmT/1Co0cEho1wp3kaouqW+J/j
         gr8g==
X-Gm-Message-State: AOAM531YGUsHOvCp6JbZ/JH3LEQ3/quSRY2zb+MlgNFwkMiVpj1XEL2C
        DeU6K9D3VuKhq1YNoHp5diqId8Zoefs=
X-Google-Smtp-Source: ABdhPJxVoSxX2N3tawtWC/yLdMqtT4pktyn2twbJ8qTyWyZpqmkc6sC5zihRJLY5WtskmmQJi5EWrw==
X-Received: by 2002:a05:600c:2116:: with SMTP id u22mr3778571wml.82.1594725365560;
        Tue, 14 Jul 2020 04:16:05 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:16:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Prasad Sahu <rsahu@apm.com>, Loc Ho <lho@apm.com>
Subject: [PATCH 14/17] dma: xgene-dma: Provide descriptions for 'dev' and 'clk' in device's ddata
Date:   Tue, 14 Jul 2020 12:15:43 +0100
Message-Id: <20200714111546.1755231-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/dma/xgene-dma.c:310: warning: Function parameter or member 'dev' not described in 'xgene_dma'
 drivers/dma/xgene-dma.c:310: warning: Function parameter or member 'clk' not described in 'xgene_dma'

Cc: Prasad Sahu <rsahu@apm.com>
Cc: Loc Ho <lho@apm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/xgene-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index cd60fa6d67501..4f733d37a22e2 100644
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -287,6 +287,8 @@ struct xgene_dma_chan {
 
 /**
  * struct xgene_dma - internal representation of an X-Gene DMA device
+ * @dev: reference to this device's struct device
+ * @clk: reference to this device's clock
  * @err_irq: DMA error irq number
  * @ring_num: start id number for DMA ring
  * @csr_dma: base for DMA register access
-- 
2.25.1

