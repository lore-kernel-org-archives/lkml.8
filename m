Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1AEC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 167E1208CA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgIBPni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:43:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:61753 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgIBPnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:43:32 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BhSrw4krPz9txTB;
        Wed,  2 Sep 2020 17:43:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id nFwfpdFhuBJU; Wed,  2 Sep 2020 17:43:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BhSrw21Q6z9txS3;
        Wed,  2 Sep 2020 17:43:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BEA7E8B7EF;
        Wed,  2 Sep 2020 17:43:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tsIuuS3JiTII; Wed,  2 Sep 2020 17:43:29 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3A79A8B7EA;
        Wed,  2 Sep 2020 17:43:28 +0200 (CEST)
Subject: Re: [PATCH 2/2] powerpc/vdso32: link vdso64 with linker
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20200901222523.1941988-1-ndesaulniers@google.com>
 <20200901222523.1941988-3-ndesaulniers@google.com>
 <b2066ccd-2b81-6032-08e3-41105b400f75@csgroup.eu>
 <20200902141431.GV28786@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <0c895acf-b6d7-baaf-d613-236f8be8e1fe@csgroup.eu>
Date:   Wed, 2 Sep 2020 17:43:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200902141431.GV28786@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 02/09/2020 à 16:14, Segher Boessenkool a écrit :
> Hi!
> 
> On Wed, Sep 02, 2020 at 06:46:45AM +0000, Christophe Leroy wrote:
>> ld crashes:
>>
>>    LD      arch/powerpc/kernel/vdso32/vdso32.so.dbg
>> /bin/sh: line 1: 23780 Segmentation fault      (core dumped)
>> ppc-linux-ld -EB -m elf32ppc -shared -soname linux-vdso32.so.1
>> --eh-frame-hdr --orphan-handling=warn -T
>> arch/powerpc/kernel/vdso32/vdso32.lds
>> arch/powerpc/kernel/vdso32/sigtramp.o
>> arch/powerpc/kernel/vdso32/gettimeofday.o
>> arch/powerpc/kernel/vdso32/datapage.o
>> arch/powerpc/kernel/vdso32/cacheflush.o
>> arch/powerpc/kernel/vdso32/note.o arch/powerpc/kernel/vdso32/getcpu.o -o
>> arch/powerpc/kernel/vdso32/vdso32.so.dbg
>> make[4]: *** [arch/powerpc/kernel/vdso32/vdso32.so.dbg] Error 139
>>
>>
>> [root@localhost linux-powerpc]# ppc-linux-ld --version
>> GNU ld (GNU Binutils) 2.26.20160125
> 
> [ Don't build as root :-P ]
> 
> Try with a newer ld?  If it still happens with current versions, please
> open a bug report?  https://sourceware.org/bugzilla

Yes it works with 2.30 and 2.34
But minimum for building kernel is supposed to be 2.23

Christophe
