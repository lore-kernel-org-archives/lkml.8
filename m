Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662E2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D3720578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597691849;
	bh=XPZYl87iBLU/pIelDeSdz+Pkk/v/wT9X5KhsNXGFJJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=03IQrpv3E121ha2klKyhdEFuysd/0v6GMBre+oX1SF/NNoIJcCvgzd7bja8eyqQD8
	 cOJYZjKDsYBHeQvzbVptLPR5hqQnkPjxUu8b/GOmLAkllvD7eFuc90DEc5PMRqW70z
	 DsKC1bqNXEWlYOAvr+GKfWzTH6uUSSd2Ppcfewzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392243AbgHQTR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:17:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730614AbgHQPin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:38:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D0B622DD6;
        Mon, 17 Aug 2020 15:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678722;
        bh=XPZYl87iBLU/pIelDeSdz+Pkk/v/wT9X5KhsNXGFJJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vUKeyCkrKnhqkqKWnHwKy48M+9Zo7H4qvlx7ULHdyO7bAHwBQbY6AOlq389oC/aXW
         vI0DUi15G2/p52VqlcxkoPtQl052hLJnBie8G5rfr6ko0QH9yiQCIIyCpoQQTr1YlX
         nySD3McNPf4vkni0mKCbncLf/GtgErL4EMWRBfvQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Huacai Chen <chenhc@lemote.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.8 432/464] MIPS: VZ: Only include loongson_regs.h for CPU_LOONGSON64
Date:   Mon, 17 Aug 2020 17:16:25 +0200
Message-Id: <20200817143854.473210762@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huacai Chen <chenhc@lemote.com>

commit cf99c505cf7a5b6d3deee91e3571871f20320d31 upstream.

Only Loongson64 platform has and needs loongson_regs.h, including it
unconditionally will cause build errors.

Fixes: 7f2a83f1c2a941ebfee5 ("KVM: MIPS: Add CPUCFG emulation for Loongson-3")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Message-Id: <1596891052-24052-1-git-send-email-chenhc@lemote.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kvm/vz.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/kvm/vz.c
+++ b/arch/mips/kvm/vz.c
@@ -29,7 +29,9 @@
 #include <linux/kvm_host.h>
 
 #include "interrupt.h"
+#ifdef CONFIG_CPU_LOONGSON64
 #include "loongson_regs.h"
+#endif
 
 #include "trace.h"
 


