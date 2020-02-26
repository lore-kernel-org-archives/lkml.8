Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46372C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B6F24656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="EBCfj8g9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgBZMEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 07:04:40 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:33768 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbgBZMEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:04:39 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48SDxc4p9rz9txW1;
        Wed, 26 Feb 2020 13:04:36 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=EBCfj8g9; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id nDphmj0PYDWa; Wed, 26 Feb 2020 13:04:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48SDxc3Y7cz9txVB;
        Wed, 26 Feb 2020 13:04:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582718676; bh=iBDRtJqj8+RLwsXxk1q4sBZWsYibq9STHtiaZIrsCtU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EBCfj8g9ufMcIT4ZxPebcV0g3e6XcAaolPUUeOeqW/yxxKiLGcaPVw6IpPU/+y6cf
         cJ9JdkH/qMfJG05Fcc9il87lfraXy3f97IX2TpXyIBUZr/UNsqHjBs7QZapc4DjLwe
         rM9XWNOIIUuw+J097cF6p21X6CBD94jw8TyES8Ks=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BCF8D8B844;
        Wed, 26 Feb 2020 13:04:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id n5azio8iaWTP; Wed, 26 Feb 2020 13:04:37 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F2C3D8B776;
        Wed, 26 Feb 2020 13:04:36 +0100 (CET)
Subject: Re: [RFC PATCH v2 04/12] powerpc/ptrace: split out VSX related
 functions.
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, mikey@neuling.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1561735587.git.christophe.leroy@c-s.fr>
 <920fe735d5f3dd882331b36a895bb756bd415fe7.1561735587.git.christophe.leroy@c-s.fr>
 <875zfw1cmo.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <34ecb581-d7e7-c5f3-8f5e-9de91e435cea@c-s.fr>
Date:   Wed, 26 Feb 2020 13:04:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <875zfw1cmo.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 24/02/2020 à 11:51, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> diff --git a/arch/powerpc/kernel/ptrace/ptrace-novsx.c b/arch/powerpc/kernel/ptrace/ptrace-novsx.c
>> new file mode 100644
>> index 000000000000..55fbbb4aa9d7
>> --- /dev/null
>> +++ b/arch/powerpc/kernel/ptrace/ptrace-novsx.c
>> @@ -0,0 +1,83 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/sched.h>
>> +#include <linux/mm.h>
>> +#include <linux/smp.h>
>> +#include <linux/errno.h>
>> +#include <linux/ptrace.h>
>> +#include <linux/regset.h>
>> +#include <linux/tracehook.h>
>> +#include <linux/elf.h>
>> +#include <linux/user.h>
>> +#include <linux/security.h>
>> +#include <linux/signal.h>
>> +#include <linux/seccomp.h>
>> +#include <linux/audit.h>
>> +#include <trace/syscall.h>
>> +#include <linux/hw_breakpoint.h>
>> +#include <linux/perf_event.h>
>> +#include <linux/context_tracking.h>
>> +#include <linux/nospec.h>
>> +
>> +#include <linux/uaccess.h>
>> +#include <linux/pkeys.h>
>> +#include <asm/page.h>
>> +#include <asm/pgtable.h>
>> +#include <asm/switch_to.h>
>> +#include <asm/tm.h>
>> +#include <asm/asm-prototypes.h>
>> +#include <asm/debug.h>
>> +#include <asm/hw_breakpoint.h>
> 
> I suspect we probably don't need all those headers anymore. But I guess
> we'll clean them up in future, as it's very tedious work to trim the list.

Ok, I did it.

> 
>> +
>> +#include <kernel/ptrace/ptrace-decl.h>
> 
> It's preferable to use:
> 
> #include "ptrace-decl.h"
> 

Ok, done.

Christophe
