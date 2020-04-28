Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65585C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28DB4206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NPZ/FQ8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbgD1Suk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:50:40 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37384 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730829AbgD1Suh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:50:37 -0400
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 163B84050C;
        Tue, 28 Apr 2020 18:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1588099837; bh=iaYI21+MnPBrnDuud0zQCEFIVFhiyAVqgsYhvsjm76Q=;
        h=From:To:Cc:Subject:Date:From;
        b=NPZ/FQ8PFcvqtKXrrau3mjBxXZIDkJujA7FKYvL5yahbSevgpngaz3xqVs+YtfCyV
         KpqCZAAEuoPatXb2R4aNoUAUVQB90gKHAXqqF4M86NK0dAz2IZjnU8QGDEEUTclh4O
         g661tyOK/DLjLH4p0N8cdTFo+pYi6l+l+z/Xu18TshwzNDhh0uJdK1X7clP8Q0wNu3
         l2qRXBrTiRo9+qaSrJUQq3BIp5aa4AvprA/PvpW8Vn0mx1WE3DVAUrXFHoPEK2g+jw
         uS0LxTuf3b4AC9zjS3fzaG/qn3MgZaIEzhNg4VS2HWPWYLFfT2ZncaknlM/hXwsDEF
         CW8YJgUaPyOdQ==
Received: from paltsev-e7480.internal.synopsys.com (ru20-e7250.internal.synopsys.com [10.116.33.250])
        by mailhost.synopsys.com (Postfix) with ESMTP id E8392A007C;
        Tue, 28 Apr 2020 18:50:31 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: guard dsp early init against non ARCv2
Date:   Tue, 28 Apr 2020 21:50:24 +0300
Message-Id: <20200428185024.5168-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of today we guard early DSP init code with
ARC_AUX_DSP_BUILD (0x7A) BCR check to verify that we have
CPU with DSP configured. However that's not enough as in
ARCv1 CPU the same BCR (0x7A) is used for checking MUL/MAC
instructions presence.

So, let's guard DSP early init against non ARCv2.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/include/asm/dsp-impl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arc/include/asm/dsp-impl.h b/arch/arc/include/asm/dsp-impl.h
index e1aa212ca6eb..e64d945ae7df 100644
--- a/arch/arc/include/asm/dsp-impl.h
+++ b/arch/arc/include/asm/dsp-impl.h
@@ -15,12 +15,14 @@
 
 /* clobbers r5 register */
 .macro DSP_EARLY_INIT
+#if defined(CONFIG_ISA_ARCV2)
 	lr	r5, [ARC_AUX_DSP_BUILD]
 	bmsk	r5, r5, 7
 	breq    r5, 0, 1f
 	mov	r5, DSP_CTRL_DISABLED_ALL
 	sr	r5, [ARC_AUX_DSP_CTRL]
 1:
+#endif
 .endm
 
 /* clobbers r10, r11 registers pair */
-- 
2.21.1

