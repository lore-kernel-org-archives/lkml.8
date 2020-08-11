Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC92EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1622076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgHKNsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 09:48:21 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:1630 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728532AbgHKNsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 09:48:16 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BQvKy5jqDz9vCqH;
        Tue, 11 Aug 2020 15:48:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id T6AfGy8k89Hu; Tue, 11 Aug 2020 15:48:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BQvKy4SfWz9vCqD;
        Tue, 11 Aug 2020 15:48:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3FD6A8BB86;
        Tue, 11 Aug 2020 15:48:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id K8SJqBJ0A9aJ; Tue, 11 Aug 2020 15:48:08 +0200 (CEST)
Received: from [172.25.230.100] (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DD8758BB80;
        Tue, 11 Aug 2020 15:48:07 +0200 (CEST)
Subject: Re: [RFC PATCH v1] power: don't manage floating point regs when no
 FPU
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <95c00a811897f6d9176d30bf2ac92dab8c9c8e95.1596816789.git.christophe.leroy@csgroup.eu>
 <87o8nh9yjd.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <9edf75a2-103d-ea01-2f53-dbb467047d13@csgroup.eu>
Date:   Tue, 11 Aug 2020 15:48:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87o8nh9yjd.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/08/2020 à 14:07, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> There is no point in copying floating point regs when there
>> is no FPU and MATH_EMULATION is not selected.
> 
> Yeah I guess you're right. I've never touched a system with neither, but
> if such a thing exists then it does seem silly to copy regs around that
> can't be used.

Yes that exists, because glibc implements floating point emulation and 
it is definitely more efficient to rely of glibc emulation than kernel one.

>>   10 files changed, 44 insertions(+), 1 deletion(-)
> 
> In general this looks fine.
> 
> It's a bit #ifdef heavy. Maybe some of those can be cleaned up a bit
> with some wrapper inlines?
> 

Yes I'll try and respin, as part of a series I'm preparing to switch the 
32 bits signal code to using user_access_begin() logic and 
unsafe_put_user() and friends to reduce KUAP unlock/lock.

Christophe
