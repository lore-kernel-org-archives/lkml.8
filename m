Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E154C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3883420759
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lsjiIug4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbgF3G2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730311AbgF3G2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 02:28:14 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114A6C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 23:28:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d194so6088488pga.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 23:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WrH62sNOsIyA+bZUWvdaT8mtXVgNLKJ4Ma1LMcNUAKU=;
        b=lsjiIug4X6wJnLGMoqdnf2EtlRQdyHztqYifj+F9DWxMaUDWjC6VtcPJIP78h0kPu1
         KmgKxbrCDYhjm7+oQxOXI8pq0zvO3C6GktlJ4Th7zd1Zs3SF0kSjfa05rZ5kXqTVDJtP
         SfRHve4FD0yo4vE1OSWND44Ixw6FZ9l9ufmSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WrH62sNOsIyA+bZUWvdaT8mtXVgNLKJ4Ma1LMcNUAKU=;
        b=nWKSgr23dxnYk/TmNjhjveSFaQ+tPVRjQs/hyowV3WsyS3mlNpHcjxrD89Xkh/EtKJ
         YGcU176Rid/C4eKzYrsofdFPp3PWF/drDQCn619E4W5/m3r714DoRcKeni2vBUej+8DR
         M50tiTDq4zTxG1oj/UVnRtEbcycca2Zu5dWDRwm7Bu+RSZeIwZTBehn0N8uniRMQ/Gdj
         6t1c0rIddnW0FTnzfADzYgnoY+Hpmubi7Cr0ue1D88PjGsAEyy5e06VpK3Lt6wKMicqV
         KebOttr4N7kreXoAb6PZ0UaFLT93WpORxUUfrhvStsNs8663RK/QkN70Ob9bYkyLGqZW
         1XUw==
X-Gm-Message-State: AOAM531ucYFz/qdhXn5JhevE7C7ssO0C4bG1usdUUG5OHU/nrK+whUJE
        bjy9SvVCE6zR87tdqY/LfAHSrg==
X-Google-Smtp-Source: ABdhPJz3j1bYUqaPRUaPXgTjd0S72OVpblIcbiEiGszIAsdQ2p3a/yRuBNlTRr46ige0lND/m0u8rA==
X-Received: by 2002:a05:6a00:1511:: with SMTP id q17mr17923876pfu.16.1593498493649;
        Mon, 29 Jun 2020 23:28:13 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:93d9:de4d:e834:3086])
        by smtp.gmail.com with ESMTPSA id d1sm1463366pfq.113.2020.06.29.23.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 23:28:12 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rui Wang <gtk_ruiwang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH 9/9] dt-bindings: media: document mediatek,mt8183-vcodec-dec
Date:   Tue, 30 Jun 2020 15:27:11 +0900
Message-Id: <20200630062711.4169601-10-acourbot@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200630062711.4169601-1-acourbot@chromium.org>
References: <20200630062711.4169601-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8183's decoder is instantiated similarly to MT8173's.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 Documentation/devicetree/bindings/media/mediatek-vcodec.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
index 8093335afecb..b844800e0153 100644
--- a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
+++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
@@ -7,6 +7,7 @@ Required properties:
 - compatible : "mediatek,mt8173-vcodec-enc" for MT8173 encoder
   "mediatek,mt8183-vcodec-enc" for MT8183 encoder.
   "mediatek,mt8173-vcodec-dec" for MT8173 decoder.
+  "mediatek,mt8183-vcodec-dec" for MT8183 decoder.
 - reg : Physical base address of the video codec registers and length of
   memory mapped region.
 - interrupts : interrupt number to the cpu.
-- 
2.27.0.212.ge8ba1cc988-goog

