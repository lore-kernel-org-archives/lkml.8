Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A8EC10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E522221D56
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMyvOyKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgCKLVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:21:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46142 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgCKLVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:21:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id y30so1016638pga.13;
        Wed, 11 Mar 2020 04:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZLOM3TZpFx1G0FHmz3svWf38OoZ6qU4SfqgmqviPrrA=;
        b=nMyvOyKn06Eu05BjFvjKHdDoGwU5OqfzypV+TNaTCAA6ghis9R4087GZKFVCDp0rD5
         /6PkMMMNG/CN2oWPce4JJBu/28jlkGMz/BkV8FjtsuA64I1YuO1hKihDe92A8NLIKNW8
         a5lX05gGYB/LQX2RUU35tSazpeA9/dat72/c8m1jm40V3I/7I2+PjsOoLr2NLFLpE3mu
         zOmCxoyWkZGEkPhvEXZtH0Fh8gURctH2Eh4AmwMOpUtcWCWhS5jTQQPPHb6uMPz5+Hqb
         n/ccwUfzJU6MYBuzY0VqXvZS/7UG7lxWvm93eEcI+LZnCDrgLeh7kFTOnEZzad8vTZ4M
         sS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZLOM3TZpFx1G0FHmz3svWf38OoZ6qU4SfqgmqviPrrA=;
        b=Q4gV7XIFKng+ELLWwHERbuSRA7cwEKVEWvld0T3KxFs2A8PAy98JBHvkUQ0MNrJcka
         GbBpcNgV71chauPplsTx7+tRF68raMxn8K0HVMckrmzTjkitB6SlvPvv7Pxo4Sq3jI+t
         u69xbgM9M0tNdrljfsnjV4hF3IbmeH45qdFg33q53Y1nKSnUxDsO9PQL5vFtaqhyu22S
         Wf0L6MitUMMozI93kWcTKWuziqOoXov+8xES8vwWVmJjTkWYE1kzStqX98l/i2YoAbh9
         vC6QXOfapneP8/bitN2ESdycNZpCX0F3wni89lcuzqX0usbZ1NbMc1AJgnHUUsUZYkuO
         N5kw==
X-Gm-Message-State: ANhLgQ0Kv5gxl0TVY2CtYaqcUo/9gZkVLBwt2X/G+n+EVjuRekJ8wY3p
        jz6/OSwYkLPFyCIEyQ9JYrg=
X-Google-Smtp-Source: ADFU+vv+UdmZRNokjNxVghhbKD3QdqV2SqqxUwK/IWZx3ccnP2eMqufHRoP5QNbhibLWisVn7B6jqA==
X-Received: by 2002:a63:6d4e:: with SMTP id i75mr2319830pgc.443.1583925706451;
        Wed, 11 Mar 2020 04:21:46 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id x16sm24277019pfq.40.2020.03.11.04.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 04:21:45 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [RESEND PATCH] arm64: dts: specify console via command line
Date:   Wed, 11 Mar 2020 19:21:20 +0800
Message-Id: <20200311112120.30890-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The SPRD serial driver need to know which serial port would be used as
console in an early period during initialization, otherwise console
init would fail since we added this feature[1].

So this patch add console to command line via devicetree.

[1] https://lore.kernel.org/lkml/20190826072929.7696-4-zhang.lyra@gmail.com/

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
I guess no comments on this, so resending this and add soc@kernel.org,
hope Arnd or Olof can help to merge into arch_arm tree.

Thanks,
Chunyan
---
 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts b/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
index 2047f7a74265..510f65f4d8b8 100644
--- a/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
+++ b/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
@@ -28,7 +28,7 @@
 
 	chosen {
 		stdout-path = "serial1:115200n8";
-		bootargs = "earlycon";
+		bootargs = "earlycon console=ttyS1";
 	};
 };
 
-- 
2.20.1

