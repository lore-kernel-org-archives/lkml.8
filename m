Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0745DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2C5206B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="jPJ5U7XU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgCMTYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:24:30 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:57969 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgCMTYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:24:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48fFxm37jMz9vBSq;
        Fri, 13 Mar 2020 20:24:28 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=jPJ5U7XU; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id sCJ1qMKipF5m; Fri, 13 Mar 2020 20:24:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48fFxm0bJGz9vBSn;
        Fri, 13 Mar 2020 20:24:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584127468; bh=oGg/6CLsP2vrCX0e3mcJfJmLT7XtQfwgp1ayZajashg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jPJ5U7XUrUkIOsgNWrVah/vvDWsI/iScNnGEWDpajpQzDQRAAje+IkPbeWn9gudEr
         y3IukLpqbN22allFMj8Faqt9/8lT0e45T7nOvaYtRwaQjFMzm9X661bMWCEk81T7H5
         1eGp3SxT6nNRK7DajxdHffUR4+BL1Ekzp8i14rH4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C81328B8D1;
        Fri, 13 Mar 2020 20:24:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id cH60zKUXPUZZ; Fri, 13 Mar 2020 20:24:27 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 51D528B8CE;
        Fri, 13 Mar 2020 20:24:26 +0100 (CET)
Subject: Re: [PATCH v2] powerpc/fsl-85xx: fix compile error
To:     =?UTF-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Richard Fontana <rfontana@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com, trivial@kernel.org
References: <AIkAvQC8CBiKb1HKth-6ZqrH.3.1584123458318.Hmail.wenhu.wang@vivo.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <6eba5d46-bb3a-03bb-376d-2a6e684d018e@c-s.fr>
Date:   Fri, 13 Mar 2020 20:24:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <AIkAvQC8CBiKb1HKth-6ZqrH.3.1584123458318.Hmail.wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 13/03/2020 à 19:17, 王文虎 a écrit :
> 发件人：Christophe Leroy <christophe.leroy@c-s.fr>
> 发送日期：2020-03-14 01:45:11
> 收件人：WANG Wenhu <wenhu.wang@vivo.com>,Benjamin Herrenschmidt <benh@kernel.crashing.org>,Paul Mackerras <paulus@samba.org>,Michael Ellerman <mpe@ellerman.id.au>,Richard Fontana <rfontana@redhat.com>,Kate Stewart <kstewart@linuxfoundation.org>,Allison Randal <allison@lohutok.net>,Thomas Gleixner <tglx@linutronix.de>,linuxppc-dev@lists.ozlabs.org,linux-kernel@vger.kernel.org
> 抄送人：kernel@vivo.com,trivial@kernel.org
> 主题：Re: [PATCH v2] powerpc/fsl-85xx: fix compile error>
>>
>> Le 13/03/2020 à 18:19, WANG Wenhu a écrit :
>>> Include "linux/of_address.h" to fix the compile error for
>>> mpc85xx_l2ctlr_of_probe() when compiling fsl_85xx_cache_sram.c.
>>>
>>>     CC      arch/powerpc/sysdev/fsl_85xx_l2ctlr.o
>>> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c: In function ‘mpc85xx_l2ctlr_of_probe’:
>>> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:90:11: error: implicit declaration of function ‘of_iomap’; did you mean ‘pci_iomap’? [-Werror=implicit-function-declaration]
>>>     l2ctlr = of_iomap(dev->dev.of_node, 0);
>>>              ^~~~~~~~
>>>              pci_iomap
>>> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:90:9: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
>>>     l2ctlr = of_iomap(dev->dev.of_node, 0);
>>>            ^
>>> cc1: all warnings being treated as errors
>>> scripts/Makefile.build:267: recipe for target 'arch/powerpc/sysdev/fsl_85xx_l2ctlr.o' failed
>>> make[2]: *** [arch/powerpc/sysdev/fsl_85xx_l2ctlr.o] Error 1
>>>
>>> Fixes: commit 6db92cc9d07d ("powerpc/85xx: add cache-sram support")
>>
>> Shouldn't you Cc stable as well ?
> Pretty sure if it makes a difference(that I did not recognize).
> Does the inconsistency of Cc lead to a failure on classification
> or something else which may confuse you?

See 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/process/submitting-patches.rst?h=v5.1.9#n299

>>
>>> Signed-off-by: WANG Wenhu <wenhu.wang@vivo.com>
>>> ---
>>
>> What's the difference between v1 and v2 ?
> The label field modification: "Fixed" -> "Fixes", which now is
> identified successfully. Really sorry for the fault on v1.

Ok. Usually people tell here (just below the ---) what is the difference 
between the different versions. It helps people understand what the 
changes are.

Christophe
