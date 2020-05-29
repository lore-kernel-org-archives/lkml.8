Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A14EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A9F3208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lnfWLNTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgE2Lz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 07:55:59 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:48634 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725865AbgE2Lz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:55:58 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A3F3C40926;
        Fri, 29 May 2020 11:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1590753357; bh=Dfq6lwwFSUj6yhixC7HC3wj+k/9vWHYyBBePg4pROUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lnfWLNTzm2zxsgJbXVIrsGD9VLE6s4aloIATJH8KQGf+RHE7TObrPmT0XF9Sx1CtJ
         85Llme5jRD6e1LNAJM6G6Xvzzoo0FTaIXgHrnrBihGuRVtCZl9y5wXxg4yhSFpEI62
         miEN7uesQGhxjCXzzKbigyoOJbqaa1P75ESscXpttqyx2FOweHTZBKS7u1u55UJqZN
         qxsHDHULxe+sbjhIVEw9O/ATaptfhH8T3RiCl2U/gr46d6Nw+sR8G/Oe4C1nzvS9ia
         FAlo6eb0g4xX2Ddz4PEbzVazI8/EzJcubxoq7jq6u6chdyIi+bBw5r44/inAoKPZ0r
         9bv9nx9pU4q9g==
Received: from paltsev-e7480.internal.synopsys.com (ru20-e7250.internal.synopsys.com [10.225.50.16])
        by mailhost.synopsys.com (Postfix) with ESMTP id 78BF5A006B;
        Fri, 29 May 2020 11:55:53 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 2/3] ARC: ARCv2: support loop buffer (LPB) disabling
Date:   Fri, 29 May 2020 14:55:33 +0300
Message-Id: <20200529115534.22883-4-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200529115534.22883-1-Eugeniy.Paltsev@synopsys.com>
References: <20200529115534.22883-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On HS cores, loop buffer (LPB) is programmable in runtime and can
be optionally disabled.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/Kconfig       | 6 ++++++
 arch/arc/kernel/head.S | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 2d4f85dc914e..270504d4fdf5 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -471,6 +471,12 @@ config ARC_IRQ_NO_AUTOSAVE
 	  This is programmable and can be optionally disabled in which case
 	  software INTERRUPT_PROLOGUE/EPILGUE do the needed work
 
+config ARC_LPB_DISABLE
+	bool "Disable loop buffer (LPB)"
+	help
+	  On HS cores, loop buffer (LPB) is programmable in runtime and can
+	  be optionally disabled.
+
 endif # ISA_ARCV2
 
 endmenu   # "ARC CPU Configuration"
diff --git a/arch/arc/kernel/head.S b/arch/arc/kernel/head.S
index 6eb23f1545ee..17fd1ed700cc 100644
--- a/arch/arc/kernel/head.S
+++ b/arch/arc/kernel/head.S
@@ -59,6 +59,14 @@
 	bclr	r5, r5, STATUS_AD_BIT
 #endif
 	kflag	r5
+
+#ifdef CONFIG_ARC_LPB_DISABLE
+	lr	r5, [ARC_REG_LPB_BUILD]
+	breq    r5, 0, 1f		; LPB doesn't exist
+	mov	r5, 1
+	sr	r5, [ARC_REG_LPB_CTRL]
+1:
+#endif /* CONFIG_ARC_LPB_DISABLE */
 #endif
 	; Config DSP_CTRL properly, so kernel may use integer multiply,
 	; multiply-accumulate, and divide operations
-- 
2.21.3

