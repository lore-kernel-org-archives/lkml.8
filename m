Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A42C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6034920738
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="NIYyPwlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgDUG4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 02:56:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:49149 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgDUG4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 02:56:49 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 495vW20DBVz9v16V;
        Tue, 21 Apr 2020 08:56:46 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=NIYyPwlg; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 46KdLJppvgXh; Tue, 21 Apr 2020 08:56:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 495vW15Gmwz9v16T;
        Tue, 21 Apr 2020 08:56:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587452205; bh=KQZJC6KX1xpBYQjH9gTCok37HzkmIIMid4Gimdkdk0o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NIYyPwlgeGjxnLgTYHY6DhRJMQYOTm1aESrLGiO/ANRDXn4gnetiIbleE+xtmS+80
         gnd1a2nd+DGOAQvjUZaUurJ1ZceeONg2tg0bqPwSNpQz8L9pkXInLTRSPOfMAFh2Jq
         qa3sR9Wz4Sf9NxKAQppJEgwrgv2S8Ut9sLmNq0Xw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BC2518B783;
        Tue, 21 Apr 2020 08:56:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Afw_vswuFQPo; Tue, 21 Apr 2020 08:56:46 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 060D98B774;
        Tue, 21 Apr 2020 08:56:44 +0200 (CEST)
Subject: Re: [PATCH v7 0/7] powerpc: switch VDSO to C implementation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>
References: <cover.1587401492.git.christophe.leroy@c-s.fr>
 <CAK8P3a11t=piuDq+TuGMo0xDiN06OLMxsym0PGiWNv5qYSUXLQ@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <268ff4cf-2f30-fead-fef5-e8e5f8f17aba@c-s.fr>
Date:   Tue, 21 Apr 2020 08:56:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a11t=piuDq+TuGMo0xDiN06OLMxsym0PGiWNv5qYSUXLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 20/04/2020 à 21:57, Arnd Bergmann a écrit :
> On Mon, Apr 20, 2020 at 6:56 PM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>>
>> This is the seventh version of a series to switch powerpc VDSO to
>> generic C implementation.
>>
>> Main changes since v6 are:
>> - Added -fasynchronous-unwind-tables in CFLAGS
>> - Split patch 2 in two parts
>> - Split patch 5 (which was patch 4) in two parts
>>
>> This series applies on today's powerpc/merge branch.
>>
>> See the last two patches for details on changes and performance.
>>
>> Christophe Leroy (7):
>>    powerpc/vdso64: Switch from __get_datapage() to get_datapage inline
>>      macro
>>    powerpc/vdso: Remove __kernel_datapage_offset and simplify
>>      __get_datapage()
>>    powerpc/vdso: Remove unused \tmp param in __get_datapage()
>>    powerpc/processor: Move cpu_relax() into asm/vdso/processor.h
>>    powerpc/vdso: Prepare for switching VDSO to generic C implementation.
>>    powerpc/vdso: Switch VDSO to generic C implementation.
> 
> This all looks fine, but I'm a bit puzzled why you don't add a
> clock_gettime64() implementation in the same series. Isn't
> that the main purpose of doing all that work?

Yes that was one of the objective, be able to add that as a second step.
First objective was adding the missing clocks and increasing 
maintainability.

I can add a patch for that now, it looks easy, but how do I test it ? 
vdsotest from Nathan doesn't seem to test that.

> 
> Without it, any 32-bit user space has to go through the system call
> for time()/getttimeofday()/clock_gettime() when built with a
> modern libc.
> 

How modern ? I have glibc 2.28, the only symbols it seems to know are 
(extracted with 'strings') :

__vdso_clock_gettime
__vdso_time
__vdso_get_tbfreq
__vdso_getcpu
__vdso_clock_getres
__vdso_sigtramp32
__vdso_sigtramp_rt32
__vdso_gettimeofday

Christophe
