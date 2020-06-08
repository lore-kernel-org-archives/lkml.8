Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0E6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D942072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+4fToX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgFHIau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgFHIas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:30:48 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6F1C08C5C3;
        Mon,  8 Jun 2020 01:30:47 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a45so4753047pje.1;
        Mon, 08 Jun 2020 01:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8feILcDA0tIlewM1KO106AZP1TsRZlV0wrLhrdTJ7fk=;
        b=B+4fToX21iv9QoVjppr44/lc3ZFWBQL5JO6a0275yptTgsD+TOR9A/boCycuYUAFMr
         s3DV8OTQT7upBbdc7HXwhLR5Saea1NCSTfOwGRbbDHejss7/uan7AnGazjgLMmJBZKtd
         H9uVZkwQ+qRvuc34NfGPopkwptiy6DJMlnfp/xcPWG3SZh/1+6H70UHL3CJhpeQU23hU
         PObJzAwBoqFTlWdZu8gwUOEVslw0Qy6zIFLfStKtCys1sJOhgVm8KSVcz1ClmdKGpCf6
         WK+OGFNGbBvZuSnIKm/10x51jWms8hcCaxCsZvq9+Mk0vZjbVSskn57LFKSJWZDFzqSO
         BhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8feILcDA0tIlewM1KO106AZP1TsRZlV0wrLhrdTJ7fk=;
        b=aQ27mT3WkH28r0X67ML9jfVhOj0ftSk0YNIEoDLn8z/ChzNQ+HD3Lg2aETbpeeQhW4
         PoOlt3tK+q+iymtW6NelxMnHnqiA2R7ZB84VGdqA7VNBg620KaOxZ2adWPXWHWTv1kqg
         Jm55PzIcVGiYi5rkvj57Klb+vge/GDvXRsjgGhCCdqzS6rcbR/p240RbH5t1dM9otq1+
         PiejicQUgkDcpgHeNRs8l35orff6rwVzhsinlbTFVMMeV2Y1gtV2sssDil/i8NGJFQE+
         pyWsePineE1gOiJ+QuxoHBExrwWPHpAzUnXwvZop+SAM7exgPmH5MKyi4OZUD+KAofpI
         zfxA==
X-Gm-Message-State: AOAM5313cw4ibrfBimLOhwgstbAsZeSB8hQQyuL7fvNCGiNGarfUTHjd
        HHTi0WsGJFzasMMjaSe7mRyecMvPNiw=
X-Google-Smtp-Source: ABdhPJyeHWrRZ7QzXxletY3kLJIxJWIs+gLBJ56sWRWJ2KQLKn7J5lIcB99++scBN53d1bkhC2luYg==
X-Received: by 2002:a17:902:b601:: with SMTP id b1mr20489872pls.39.1591605047030;
        Mon, 08 Jun 2020 01:30:47 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.42])
        by smtp.gmail.com with ESMTPSA id 27sm1210829pjg.19.2020.06.08.01.30.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 01:30:46 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux@armlinux.org.uk,
        vladimir.murzin@arm.com, kstewart@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, tglx@linutronix.de
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH 1/2] ARM: dts: stm32: Setup 4M bytes reserved memory for mmap
Date:   Mon,  8 Jun 2020 16:30:37 +0800
Message-Id: <1591605038-8682-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591605038-8682-1-git-send-email-dillon.minfei@gmail.com>
References: <1591605038-8682-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

To mmap a framebuffer or v4l2 buffer from kernel to userspace on
no-mmu platform, we need rely on 'arm_nommu_dma_ops' from
arch/arm/mm/dma-mapping-nommu.c , so setup 4M bytes memory
reserved for this purpose.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 arch/arm/boot/dts/stm32f469-disco.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 9397db0c43de..082b24ee81f7 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -65,6 +65,20 @@
 		reg = <0x00000000 0x1000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		linux,dma {
+			compatible = "shared-dma-pool";
+			size = <0x400000>;
+			no-map;
+			linux,dma-default;
+		};
+
+	};
+
 	aliases {
 		serial0 = &usart3;
 	};
-- 
2.7.4

