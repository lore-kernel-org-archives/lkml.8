Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD86AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C7420738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bt6juGPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgHUKhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgHUKhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:37:00 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD09C061388
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:37:00 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh1so682874plb.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HTg8ZbMrnEBX6XZbAtw/YXsu/7D2NGL6yCO27qDzwAM=;
        b=Bt6juGPbmaC1G1f3JZE/oHm9QQwPgDr5UQ3A7XNqPAM2EqDMqIbJMMvaI9zGbtYzSb
         FoDLRkep+6Ob8+bLttjezio5g1YDbu5a1XhpuBYQHRjlyT0md+Rpi9mrpHWs8KjxgFfc
         /NJMwiegqrTm2yh5Xue70gONScaWg/TFqN59o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HTg8ZbMrnEBX6XZbAtw/YXsu/7D2NGL6yCO27qDzwAM=;
        b=tx9FOJeaOW5Fk6gTvcCZxtijxXOX4TtJ4Utfas0nGACJXqe991XIKFMxXZXQoodoDW
         UvCjBwuq7JYMZbf/w7GjFQ95YEgEe63jY5RPNGjbMwmlPoCFeIKMQlU1cToeDtkC/oQn
         7kwxodCpVyQksjL4DcokOIOWue6+YMUkppEqaJz7eiSK8FoAosS+f2ZkDazNlnApb3C3
         taNtTXQu22hWhoPUDWj6TCCVKynB40fottPeqPq6c0hWL8tdXXVSdSUB+2tMQC69kTlR
         UwEKOAzddSZz0siEApkLs0bXEy5CzBq3aGJYIKlbIMKFPp6cZnPY/Tu9ZCjSQ2TRzVjv
         xgRg==
X-Gm-Message-State: AOAM53365rf45y/0doWoSuydYPU7DIZSpcnKDre3ZowVQnX+4tYbc5cf
        VCTJf+xCiElEjm7CL0fB5s15vQ==
X-Google-Smtp-Source: ABdhPJzN6nDyZup0sLKds7ZZBQYp8QWOg0gvyO+9HOXmutY4wIibEnN9fBRxqOPj3PZtKkGjIYQvxw==
X-Received: by 2002:a17:902:ead2:: with SMTP id p18mr1917778pld.259.1598006219865;
        Fri, 21 Aug 2020 03:36:59 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:eeb1:d7ff:fe57:b7e5])
        by smtp.gmail.com with ESMTPSA id y20sm2081525pfn.183.2020.08.21.03.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:36:59 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 08/17] dt-bindings: media: document mediatek,mt8183-vcodec-enc
Date:   Fri, 21 Aug 2020 19:35:59 +0900
Message-Id: <20200821103608.2310097-9-acourbot@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200821103608.2310097-1-acourbot@chromium.org>
References: <20200821103608.2310097-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8183's encoder is similar to MT8173's.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/media/mediatek-vcodec.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
index 99214faede90..8217424fd4bd 100644
--- a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
+++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
@@ -4,8 +4,9 @@ Mediatek Video Codec is the video codec hw present in Mediatek SoCs which
 supports high resolution encoding and decoding functionalities.
 
 Required properties:
-- compatible : "mediatek,mt8173-vcodec-enc" for encoder
-  "mediatek,mt8173-vcodec-dec" for decoder.
+- compatible : "mediatek,mt8173-vcodec-enc" for MT8173 encoder
+  "mediatek,mt8183-vcodec-enc" for MT8183 encoder.
+  "mediatek,mt8173-vcodec-dec" for MT8173 decoder.
 - reg : Physical base address of the video codec registers and length of
   memory mapped region.
 - interrupts : interrupt number to the cpu.
-- 
2.28.0.297.g1956fa8f8d-goog

