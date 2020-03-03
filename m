Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE1FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EF22146E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgMEOedX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgCCGwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 01:52:51 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36098 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgCCGwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:52:50 -0500
Received: by mail-pl1-f194.google.com with SMTP id g12so892818plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 22:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oX1y8GGFSSoL7MJBqOmt9bqjO2DIfXS/JFi378HqNJU=;
        b=MgMEOedXPOf45Nouii7bB4oC99d14VM7O6RLPA2ewohE/4xlxu4lY+4suP3aYRf3aD
         Dp1bYGb12tqHwQDClpN0YD2p2Cd+8xw9S/10ruBMKKxmVkrp3lGtTTr9JfYX9i33J82I
         yyF0NIfaoJMcc3/wSAjDfZdEBSDTrNHH/3oNqsF6RjlZxWIhZDnSi551i2aTAGg5/7G5
         sQQ6bysLD9O0LWCB1htpbwbBNA5A8J24870teVBp/g+VnIrKokOnwXb2cE1voUqnCxxi
         WpfbOrv7io9ufRx8/z919QT7pYRl94OwPDE2/QWmrbkAj0/FZMD2WzukgE0FiMc63vq0
         7f7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oX1y8GGFSSoL7MJBqOmt9bqjO2DIfXS/JFi378HqNJU=;
        b=b4m9E5wNxgpEuDlNRFV9iHEJpclEpFxKrva2/Oxi1JDiQ7KRvQD7ZEG2ZOqYUiO315
         rx+nLFnashFRZjCwBlgZTyi/dAhIdGkgzBMYgzRVY5JbvTXn2YsPTQE7ZujczAcU4XTa
         e/yXnLtfLrZtwOS+xzevk8lcXdbN2Ly0towRLR4lOU8gS+Eea7SkjWoLRhs/s9SiXUcM
         DdZBgo/XD5tpqSB4WEzS4whD1Ux3gPJ+FGXXewBbjbDTxvcE0d5cXEfNMZb7EbxNvDEK
         zMdcVAupe+yEWwmz00JMB1h2Sef+RCDH6C8rlVVy876WL1hSp5GJBl79Cep1/XWprbTt
         LhjA==
X-Gm-Message-State: ANhLgQ2u3oB07mdOC1EuiHDd6lZClnlasjF9e2HKsiUSAEJxcExWBRzG
        NQeaXU9/d3hGaohCR1mOEXAuSizg
X-Google-Smtp-Source: ADFU+vvDNb8nO5dFdp/Qn+gAtxGwt7UKdHdx6mKCWKfRZSMnUZxgVFvvZPs3RxqlzExO76SzX/a36Q==
X-Received: by 2002:a17:902:6ac7:: with SMTP id i7mr2849117plt.66.1583218369041;
        Mon, 02 Mar 2020 22:52:49 -0800 (PST)
Received: from ZB-PF114XEA.360buyad.local ([103.90.76.242])
        by smtp.gmail.com with ESMTPSA id t11sm22780754pgi.15.2020.03.02.22.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 22:52:48 -0800 (PST)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        zhenzhong.duan@gmail.com, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/2] x86/boot: Add -Wunused to KBUILD_CFLAGS
Date:   Tue,  3 Mar 2020 14:52:09 +0800
Message-Id: <20200303065210.1279-2-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303065210.1279-1-zhenzhong.duan@gmail.com>
References: <20200303065210.1279-1-zhenzhong.duan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compile warning option in arch/x86/boot/compressed is different from
other part of the kernel for some history reason. But "-Wunused" is
safe to be added to point out unused variable issue.

Link: https://lore.kernel.org/patchwork/patch/1175001/#1379873
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/boot/compressed/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 26050ae0b27e..cb9743ec453a 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -37,7 +37,7 @@ KBUILD_CFLAGS += $(call cc-option,-ffreestanding)
 KBUILD_CFLAGS += $(call cc-option,-fno-stack-protector)
 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
-KBUILD_CFLAGS += -Wno-pointer-sign
+KBUILD_CFLAGS += -Wno-pointer-sign -Wunused
 KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
-- 
2.17.1

