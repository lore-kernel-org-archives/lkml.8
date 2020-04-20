Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4724C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F2120B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="fh40y2Pd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgDTQ4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:56:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:3186 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgDTQ4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:56:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 495XsT6wDXz9txcv;
        Mon, 20 Apr 2020 18:56:29 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=fh40y2Pd; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id nNmy_Vhczuai; Mon, 20 Apr 2020 18:56:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 495XsT4Kfcz9txcy;
        Mon, 20 Apr 2020 18:56:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587401789; bh=usLVyQ1i3vxK52F4YKCMy41TaFB5bkHhiCfUJVY8FVI=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=fh40y2PdM4eMmOE5xyPMHpkCVsV+urGCCgbjPcxtvx1/HDN8b397qxFMW9ZWWx3S6
         sE7ojoIZleUJf+wF7jYX/zN37+NQ3V8YGFVxobl8ji58S6zTA8F6tcy4YkGuekOysb
         H82DPIFsSf+q2UEA7UK0u4yfpHkIhIAF5sCmFx4I=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6B3938B784;
        Mon, 20 Apr 2020 18:56:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NzI7ICPy3Q2D; Mon, 20 Apr 2020 18:56:35 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1B2848B78A;
        Mon, 20 Apr 2020 18:56:35 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E71B5657AE; Mon, 20 Apr 2020 16:56:34 +0000 (UTC)
Message-Id: <f6397e32f9ac69cc8ddd1d566cc385165ced21c8.1587401492.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1587401492.git.christophe.leroy@c-s.fr>
References: <cover.1587401492.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 7/7] [NOT TO BE MERGED] Export sysrq_mask
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com,
        luto@kernel.org
Date:   Mon, 20 Apr 2020 16:56:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/tty/sysrq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 5e0d0813da55..a0760bcd7a97 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -74,6 +74,7 @@ int sysrq_mask(void)
 		return 1;
 	return sysrq_enabled;
 }
+EXPORT_SYMBOL_GPL(sysrq_mask);
 
 /*
  * A value of 1 means 'all', other nonzero values are an op mask:
-- 
2.25.0

