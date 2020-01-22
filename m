Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C28C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 06:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0D12467A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 06:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="EHsTER7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgAVG5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 01:57:18 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:30892 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgAVG5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 01:57:17 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 482bn71Kscz9v1G1;
        Wed, 22 Jan 2020 07:57:15 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=EHsTER7Z; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id OVFmCX_L5Lgn; Wed, 22 Jan 2020 07:57:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 482bn707RTz9v1G0;
        Wed, 22 Jan 2020 07:57:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579676235; bh=CBx7iS06BSIP6qNB7l3ahv3OsouitLiZYefJlZ5dcu8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EHsTER7Z4Oqsp2+hty+bZTYAq8pwQujk5eElZEjELZauCDitzjjH1brzpv/wO7gNp
         zjVa610e+LoXEkBmEtVGNxrUCBuQ81/RVZwXAv0nB3xNteJHEf/0PK2i2dpoUNGNsd
         dZTnPsMHvWIQAB0dbbrapwoR0Q2lLT0ClO+/dDpY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C4D468B7EC;
        Wed, 22 Jan 2020 07:57:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qVDc0MUIikwf; Wed, 22 Jan 2020 07:57:15 +0100 (CET)
Received: from [172.25.230.100] (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9AD258B776;
        Wed, 22 Jan 2020 07:57:15 +0100 (CET)
Subject: Re: GCC bug ? Re: [PATCH v2 10/10] powerpc/32s: Implement Kernel
 Userspace Access Protection
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, ruscur@russell.cc,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1552292207.git.christophe.leroy@c-s.fr>
 <a2847248a92cb1641b1740fa121c5a30593ae662.1552292207.git.christophe.leroy@c-s.fr>
 <87ftqfu7j1.fsf@concordia.ellerman.id.au>
 <a008a182-f1db-073c-7d38-27bfd1fd8676@c-s.fr>
 <20200121195501.GJ3191@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8501a33e-6c76-b6bd-9d8e-985313f94579@c-s.fr>
Date:   Wed, 22 Jan 2020 07:57:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200121195501.GJ3191@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 21/01/2020 à 20:55, Segher Boessenkool a écrit :
> On Tue, Jan 21, 2020 at 05:22:32PM +0000, Christophe Leroy wrote:
>> g1() should return 3, not 5.
> 
> What makes you say that?
> 
> "A return of 0 does not indicate that the
>   value is _not_ a constant, but merely that GCC cannot prove it is a
>   constant with the specified value of the '-O' option."
> 

GCC doc also says:

"if you use it in an inlined function and pass an argument of the 
function as the argument to the built-in, GCC never returns 1 when you 
call the inline function with a string constant"

Does GCC considers (void*)0 as a string constant ?

Christophe
