Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4E5C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADD6206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="E4jQh+u/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgBLOYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:24:40 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:26186 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbgBLOYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:24:40 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48Hhjc2VPgz9txMl;
        Wed, 12 Feb 2020 15:24:36 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=E4jQh+u/; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id vgRppl4aZR85; Wed, 12 Feb 2020 15:24:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48Hhjc1JJvz9txMj;
        Wed, 12 Feb 2020 15:24:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581517476; bh=igqAQ6RyNRhDBT/cqa7dKxQJPcmonCFpfGNLvOYs5Ag=;
        h=From:Subject:To:Cc:Date:From;
        b=E4jQh+u/E2Y2/69w0EdD7SYH455XnezpEG1HAgq2DEV4PDSPitdhFI8oyHoI9VzBy
         R0F1q3WUTgldY3k0NYDh6shv/9PlBFzYD/EvuYk0rvwInhtsnxW251BU6mjk0MGU63
         2Dz00a7ahBfUa8gYFCt53SmqAN0Sk6MQjMjZ8bEc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 66A498B81A;
        Wed, 12 Feb 2020 15:24:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id j91gDLBU-b-L; Wed, 12 Feb 2020 15:24:37 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2D1F38B80D;
        Wed, 12 Feb 2020 15:24:37 +0100 (CET)
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [Regression 5.6-rc1][Bisected b6231ea2b3c6] Powerpc 8xx doesn't boot
 anymore
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Li Yang <leoyang.li@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Scott Wood <oss@buserror.net>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <0d45fa64-51ee-0052-cb34-58c770c5b3ce@c-s.fr>
Date:   Wed, 12 Feb 2020 14:24:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

Kernel 5.6-rc1 silently fails on boot.

I bisected the problem to commit b6231ea2b3c6 ("soc: fsl: qe: drop 
broken lazy call of cpm_muram_init()")

I get a bad_page_fault() for an access at address 8 in 
cpm_muram_alloc_common(), called from cpm_uart_console_setup() via 
cpm_uart_allocbuf()

Reverting the guilty commit on top of 5.6-rc1 is not trivial.

In your commit text you explain that cpm_muram_init() is called via 
subsys_initcall. But console init is done before that, so it cannot work.

Do you have a fix for that ?

Thanks
Christophe

NB: Next time, can you please copy powerpc mailing list when changing 
such core parts of powerpc CPUs ?
