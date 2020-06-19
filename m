Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D5AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2C12168B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592583619;
	bh=LMSFAzpwIgroVpYfzbA+wI0NHZjv6JmhpGwIKtr8Ywk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LsT02NvcQbWY/KbuubZXZBtVQm5gFWVeMNR+mP9TnmIvBFgKSUkQpckGEE+5ixyaP
	 pLTxO4RS1vpdJFe5yom/+QRN9wNmTF1PzwfDKig78iMA7x0YcPjpeRAqQARocSg3dr
	 T4xHKstTbpDCLkSfD4Vpbh2wCZ4OoGsjbLdBPgCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390720AbgFSPBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:01:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390634AbgFSPAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:00:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BB3721527;
        Fri, 19 Jun 2020 15:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578837;
        bh=LMSFAzpwIgroVpYfzbA+wI0NHZjv6JmhpGwIKtr8Ywk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hc165DH9NTwwQNbrP5d/pYglCKGofa9wnCK8XJw8vEpcbF4uAHZ1mPRihj/2/cqBp
         HUOXzd6nis7pAWyQplFVgEFCipoWwUPcYoUHPth07qYa6mgbvosqRFgANEil5UQ67z
         7qRdQQoVBbW5haCYm85groku7T7ud59OG6CmnE1w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YuanJunQing <yuanjunqing66@163.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 175/267] MIPS: Fix IRQ tracing when call handle_fpe() and handle_msa_fpe()
Date:   Fri, 19 Jun 2020 16:32:40 +0200
Message-Id: <20200619141657.185191355@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YuanJunQing <yuanjunqing66@163.com>

[ Upstream commit 31e1b3efa802f97a17628dde280006c4cee4ce5e ]

Register "a1" is unsaved in this function,
 when CONFIG_TRACE_IRQFLAGS is enabled,
 the TRACE_IRQS_OFF macro will call trace_hardirqs_off(),
 and this may change register "a1".
 The changed register "a1" as argument will be send
 to do_fpe() and do_msa_fpe().

Signed-off-by: YuanJunQing <yuanjunqing66@163.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/genex.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 6c257b52f57f..7fad007fe025 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -477,20 +477,20 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	.endm
 
 	.macro	__build_clear_fpe
+	CLI
+	TRACE_IRQS_OFF
 	.set	push
 	/* gas fails to assemble cfc1 for some archs (octeon).*/ \
 	.set	mips1
 	SET_HARDFLOAT
 	cfc1	a1, fcr31
 	.set	pop
-	CLI
-	TRACE_IRQS_OFF
 	.endm
 
 	.macro	__build_clear_msa_fpe
-	_cfcmsa	a1, MSA_CSR
 	CLI
 	TRACE_IRQS_OFF
+	_cfcmsa	a1, MSA_CSR
 	.endm
 
 	.macro	__build_clear_ade
-- 
2.25.1



