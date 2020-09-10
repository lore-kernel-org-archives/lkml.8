Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E0AC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 04:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74A4C21D46
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 04:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NRiAcWHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgIJELh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgIJELN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 00:11:13 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C1CC061786
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 21:11:13 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c3so269327plz.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 21:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SjTp1hGds9ZwoOkcpeoGQakZnJuh6PzHnYd7zFegRU8=;
        b=NRiAcWHkL9seEwOjmyIZa3MCaZMmxBU6gYtM36EnQkvpXPeKcxLiCF/OKJTBvSJ+e9
         Jk44zmGowKGaPR4fIlaRKZhunvN6QMSFIzxG0PZ74x8bt2El2eBZRz7pVHbyykM5Acow
         vDBOeXBT0yHaRFahCLTwhTSWPFU+gcQiUKzBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SjTp1hGds9ZwoOkcpeoGQakZnJuh6PzHnYd7zFegRU8=;
        b=SqkEbH7eIAwWS90QRHFy+GcXKwf8d8xcuJ8LmP8VGZTlknTaStNw4h9EW5yguAdIk+
         S2QVgr1aNtGk8tEDdz3J5LVc+KGd3Hb8cf5h2i/qmuO8z5FQzAXX7tB+EQ50tkRA5GrO
         WaDiK2U6p12MfPxpd7xc7lilKCryV/zCanK2ZNoAyVhZTTX/m8FdjLONlQ9mmfk9S1Pv
         Qh94R/eCZqaSG1Og1aCkumvWsmOYtNbPOG4gvWy9zLeN1Ph7xgPGHhZiWWTTf/LLhPKX
         kcDdLzzMRyo0/nN1Wv0eDKqd9INHfCbZtTVkc5jHcdOyPQWlPqL/ZlTT1i4QkNLqAs/o
         ES+A==
X-Gm-Message-State: AOAM531I02emWRqHJrzdp0rS/4azj0f5ESFr1ZXiIjKLTN5+aR4n9D6l
        cffwvL5bxI7elv/XFjBOtDBC9g==
X-Google-Smtp-Source: ABdhPJy/kt256pAD+9kwVUTT8gpc//AaRJDaKiqodWQDyyYH+29li3hwTA00uoaR3VXRStW5UdRJ1g==
X-Received: by 2002:a17:90a:8593:: with SMTP id m19mr3592561pjn.104.1599711068389;
        Wed, 09 Sep 2020 21:11:08 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id z11sm4266169pfc.181.2020.09.09.21.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 21:11:07 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/2] Add 36bit dma support to mediatek spi-nor controller.
Date:   Thu, 10 Sep 2020 12:10:59 +0800
Message-Id: <20200910041101.1695195-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt8192-nor has 36bit addressing support, this patch adds 36bit address
handlings to spi-mtk-nor.

Ikjoon Jang (2):
  dt-bindings: spi: add mt8192-nor compatible string
  spi: spi-mtk-nor: support 36bit dma addressing to mediatek spi-nor

 .../bindings/spi/mediatek,spi-mtk-nor.yaml    |  1 +
 drivers/spi/spi-mtk-nor.c                     | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.28.0.526.ge36021eeef-goog

