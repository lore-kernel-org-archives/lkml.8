Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7A7C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6342124656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="TVIuVPWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgBZMD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 07:03:57 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:36118 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgBZMD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:03:56 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48SDwn4BNRz9txW1;
        Wed, 26 Feb 2020 13:03:53 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=TVIuVPWY; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id lCvgd2pa5vu2; Wed, 26 Feb 2020 13:03:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48SDwn0prvz9txVB;
        Wed, 26 Feb 2020 13:03:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582718633; bh=YsrrIHLg54stOepFXBRgikAxSaN1wN0118dC6ZDyX+c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TVIuVPWYYObz7bFtspZ7AEeCpP5kxKkwF2WO/rjg4YwesPkasnICmfabfpcWewoGN
         clFqU1YAZrxAsJgFiGuwlGvIyc3k3nHBfxUNDlIZ2GDpp+K93H4h78R9mo7GwbUV2c
         Z1QV6m+Uc1QoXlGM4xholmOsi0WCQ9vYxuWy3dRc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4A9DE8B844;
        Wed, 26 Feb 2020 13:03:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id p6O_in8XQ8e7; Wed, 26 Feb 2020 13:03:54 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6DB5B8B776;
        Wed, 26 Feb 2020 13:03:53 +0100 (CET)
Subject: Re: [RFC PATCH v2 00/12] Reduce ifdef mess in ptrace
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1561735587.git.christophe.leroy@c-s.fr>
 <f62b0f67-c418-3734-0b07-65aea7537a78@c-s.fr>
 <7b86733f81c7e15d81ab14b98c8998011ed54880.camel@neuling.org>
 <5b5d8f61-c9aa-1afd-6001-44a17f00c1a6@c-s.fr>
 <8736b01cjb.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <310bc462-2c07-67f4-5e30-3acb02f25245@c-s.fr>
Date:   Wed, 26 Feb 2020 13:03:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8736b01cjb.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 24/02/2020 à 11:54, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> Le 24/02/2020 à 03:15, Michael Neuling a écrit :
>>> Christophe,
>>>> Le 28/06/2019 à 17:47, Christophe Leroy a écrit :
>>>>> The purpose of this series is to reduce the amount of #ifdefs
>>>>> in ptrace.c
>>>>
>>>> Any feedback on this series which aims at fixing the issue you opened at
>>>> https://github.com/linuxppc/issues/issues/128 ?
>>>
>>> Yeah, sorry my bad. You did all the hard work and I ignored it.
>>>
>>> I like the approach and is a long the lines I was thinking. Putting it in a
>>> ptrace subdir, splitting out adv_debug_regs, TM, SPE, Alitivec, VSX.
>>> ppc_gethwdinfo() looks a lot nicer now too (that was some of the worst of it).
>>>
>>> I've not gone through it with a fine tooth comb though. There is (rightly) a lot
>>> of code moved around which could have introduced some issues.
>>>
>>> It applies on v5.2 but are you planning on updating it to a newer base?
>>>
>>
>> As you noticed there is a lot of code moved around, and rebasing
>> produces a lot of conflicts. So I didn't want to spend hours to rebase
>> and rebase without being sure it was the right approach.
>>
>> Now that I got a positive feedback I'll consider rebasing it, hopping
>> that Michael will pick it up.
> 
> I would love to.
> 

Great.

Just sent v3 out.

Christophe
