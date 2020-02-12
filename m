Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E818C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C2820873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="YTdEmJUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgBLOuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:50:13 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:56846 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgBLOuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:50:12 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48HjH61MtRz9tyGJ;
        Wed, 12 Feb 2020 15:50:10 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=YTdEmJUk; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 5RjadGcG7HrB; Wed, 12 Feb 2020 15:50:10 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48HjH604Q1z9tyGH;
        Wed, 12 Feb 2020 15:50:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581519010; bh=LBWMl894vJ7EAcT3mNEJhOk9WBnw1O2BGFy/5mVsvQI=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=YTdEmJUkUYPjOWKfvbihiULUY/+lpmDckGhtcE2vkeGLUDUqkzK+jEQuQRd1TAS6s
         7+0PAN2X58D7x8ODTQ1zXc16Kcf3PxXEN1WQgXiihVdoT8z0aNI/GVwlcFFKGKr6eJ
         bZjG/zfT90wiZp7ReSx9vwD5DUC0NjlQGPgX3Wfk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4DD528B81A;
        Wed, 12 Feb 2020 15:50:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BMQgy6qvhP4D; Wed, 12 Feb 2020 15:50:11 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 02CC68B80D;
        Wed, 12 Feb 2020 15:50:10 +0100 (CET)
Subject: Re: [Regression 5.6-rc1][Bisected b6231ea2b3c6] Powerpc 8xx doesn't
 boot anymore
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Li Yang <leoyang.li@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Wood <oss@buserror.net>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <0d45fa64-51ee-0052-cb34-58c770c5b3ce@c-s.fr>
Message-ID: <aee10440-c244-7c93-d3bb-fd29d8a83be4@c-s.fr>
Date:   Wed, 12 Feb 2020 14:50:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0d45fa64-51ee-0052-cb34-58c770c5b3ce@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/12/2020 02:24 PM, Christophe Leroy wrote:
> Hi Rasmus,
> 
> Kernel 5.6-rc1 silently fails on boot.
> 
> I bisected the problem to commit b6231ea2b3c6 ("soc: fsl: qe: drop 
> broken lazy call of cpm_muram_init()")
> 
> I get a bad_page_fault() for an access at address 8 in 
> cpm_muram_alloc_common(), called from cpm_uart_console_setup() via 
> cpm_uart_allocbuf()
> 
> Reverting the guilty commit on top of 5.6-rc1 is not trivial.
> 
> In your commit text you explain that cpm_muram_init() is called via 
> subsys_initcall. But console init is done before that, so it cannot work.
> 
> Do you have a fix for that ?
> 

The following patch allows powerpc 8xx to boot again. Don't know if 
that's the good place and way to do the fix though.

---
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c 
b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index 4cabded8390b..341d682ec6eb 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1351,6 +1351,7 @@ static int __init cpm_uart_console_setup(struct 
console *co, char *options)
  		clrbits32(&pinfo->sccp->scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
  	}

+	cpm_muram_init();
  	ret = cpm_uart_allocbuf(pinfo, 1);

  	if (ret)

---
Christophe
