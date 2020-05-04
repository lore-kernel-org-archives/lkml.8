Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73297C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5D420661
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NpY8F90B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgEDMpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 08:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728108AbgEDMoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:44:55 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597FEC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 05:44:54 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id a4so1816248pgc.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 05:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6xeLFFRxjayddvBRhnid9ILi0KvAvgA9E5JIow98J+k=;
        b=NpY8F90BRltGb4GXWEpu15PIYA39hWgN/vjRE9Ek/b/9GW9wzoD3cKzg1ORQbVdpzg
         efo1I3GN7J7X33UTFoMJ/eu2PsADoTAYvDaOMlTjW8elrMi4BiFGa8nRmECVckYCnT1C
         7KCADcckuDMNWkx0X4b8cBJVDqkY/JjcvnQio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6xeLFFRxjayddvBRhnid9ILi0KvAvgA9E5JIow98J+k=;
        b=WwTXzfVnqXznGYZ3ml9C5Ha4MFAwcKTKrUmSEyh4//20gwAn8gMvc+r+nhEjyDdYdp
         cSCPqmcpOGr7oGy+8JH0ZFD229Gz9s1SMW8B8BuSlStSvnGE4GS9HtsfJmyE3l3eoUlX
         k6rV+xYcPMA5Y6S6+knO90P0CN1cd3Q6acf7t/T1VtavNe8VuuBlcdY8aklu9yoyz6N/
         nUJrqELJYm+YIhW8WRZMiuYPTcTFJY+1UO/pxTJQes3+KrzSVqdsdGPDRe4oClKyC+CW
         jn6eOIz3nd3Z0ZJSVCfyJNsglxhOXGPe1Hgox5/j1vBcOP8a7A3EXxFWMGxZV7bvDf23
         XOEA==
X-Gm-Message-State: AGi0PubaCMx/gxNUbx66ZOZaVgwgr+kZ7sXD4U54/tA+17I6Xp3UI6NA
        7aie9iEuXuBnsxQP3yWg8fcRmA==
X-Google-Smtp-Source: APiQypIsMuPoACD4kDg+3c6GSsELr2TwlWwMVfHmHQccbvWxqpghPB7vzmBRwg1sRRP95stLAqZs3A==
X-Received: by 2002:a63:1e18:: with SMTP id e24mr16016160pge.296.1588596293785;
        Mon, 04 May 2020 05:44:53 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id a99sm7154563pje.35.2020.05.04.05.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 05:44:53 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Qianqian Yan <qianqian.yan@mediatek.com>,
        devicetree@vger.kernel.org, gtk_ruiwang <gtk_ruiwang@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: mt8173: fix vcodec-enc clock
Date:   Mon,  4 May 2020 20:44:43 +0800
Message-Id: <20200504124442.208004-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the assigned-clock-parents to higher frequency clock to avoid h264
encode timeout:

[  134.763465] mtk_vpu 10020000.vpu: vpu ipi 4 ack time out !
[  134.769008] [MTK_VCODEC][ERROR][18]: vpu_enc_send_msg() vpu_ipi_send msg_id c002 len 32 fail -5
[  134.777707] [MTK_VCODEC][ERROR][18]: vpu_enc_encode() AP_IPIMSG_ENC_ENCODE 0 fail

venc_sel is the clock used by h264 encoder, and venclt_sel is the clock
used by vp8 encoder. Assign venc_sel to vcodecpll_ck and venclt_sel to
vcodecpll_370p5.

    vcodecpll                         1482000000
       vcodecpll_ck                    494000000
          venc_sel                     494000000
...
       vcodecpll_370p5                 370500000
          venclt_sel                   370500000

Fixes: fbbad0287cec ("arm64: dts: Using standard CCF interface to set vcodec clk")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index a212bf124e81..d0e9a2aada2e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -1422,8 +1422,8 @@ vcodec_enc: vcodec@18002000 {
 				      "venc_lt_sel";
 			assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>,
 					  <&topckgen CLK_TOP_VENC_LT_SEL>;
-			assigned-clock-parents = <&topckgen CLK_TOP_VENCPLL_D2>,
-						 <&topckgen CLK_TOP_UNIVPLL1_D2>;
+			assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL>,
+						 <&topckgen CLK_TOP_VCODECPLL_370P5>;
 		};
 
 		jpegdec: jpegdec@18004000 {
-- 
2.26.2.526.g744177e7f7-goog

