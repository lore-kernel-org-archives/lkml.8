Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C91C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F812464B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="SD6U3h6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394780AbgAPR7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:59:54 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:43863 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394768AbgAPR7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:59:51 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 47zBmN5N54z9v4gc;
        Thu, 16 Jan 2020 18:59:48 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=SD6U3h6U; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id EJWppnBr9WvY; Thu, 16 Jan 2020 18:59:48 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47zBmN44pnz9v4gT;
        Thu, 16 Jan 2020 18:59:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579197588; bh=IindQu42iENkFluTxFQueQVsDRT1L9tio2zY26H9ooU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SD6U3h6UXcUuVSAFLlW6xTpgLah4GnfwkGmyYPfYMJEZ80vWz5QKjLUAJrqbLUTPG
         FHu5B9HP7RgOIk7EhNh31YeJb4FEx+y8aJnktskyHe7iF3+iFf5JvawY+g5g9uqjxF
         PgKwNxeR1X6+lUsmGgkzOI/BXQUo3iKSj9by4vDk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 43AEF8B82C;
        Thu, 16 Jan 2020 18:59:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id x7-gj-n_L5z9; Thu, 16 Jan 2020 18:59:50 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BFD998B82A;
        Thu, 16 Jan 2020 18:59:49 +0100 (CET)
Subject: Re: [PATCH vdsotest] Use vdso wrapper for gettimeofday()
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <0eddeeb64c97b8b5ce0abd74e88d2cc0303e49c6.1579090596.git.christophe.leroy@c-s.fr>
 <871rrzjq5j.fsf@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <01e576b8-fe93-1026-5b39-f878297d6835@c-s.fr>
Date:   Thu, 16 Jan 2020 18:59:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <871rrzjq5j.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/01/2020 à 17:56, Nathan Lynch a écrit :
> Hi Christophe,
> 
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> To properly handle errors returned by gettimeofday(), the
>> DO_VDSO_CALL() macro has to be used, otherwise vdsotest
>> misinterpret VDSO function return on error.
>>
>> This has gone unnoticed until now because the powerpc VDSO
>> gettimeofday() always succeed, but while porting powerpc to
>> generic C VDSO, the following has been encountered:
> 
> Thanks for this, I'll review it soon.
> 
> Can you point me to patches for the powerpc generic vdso work?
> 

Sure.

v3 is at 
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=152867

I added you in v4 destinees.

Christophe
