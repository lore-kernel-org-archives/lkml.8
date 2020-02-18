Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E85C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48FF20801
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="BAOtrg4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgBRN6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 08:58:04 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:9312 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgBRN6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:58:04 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48MMr85V3lzB09bJ;
        Tue, 18 Feb 2020 14:58:00 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=BAOtrg4b; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id h_5M-mGxN3t7; Tue, 18 Feb 2020 14:58:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48MMr84Q52zB09bF;
        Tue, 18 Feb 2020 14:58:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582034280; bh=jjEYydTmfEV0X1SMgXKSXhQJXM6uyjyVUc+wPBFARrA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BAOtrg4bVyRJ71DuZiUZ3Z0v0KeHRP1O9NiMSg3rMWsK/OV3zXZ6gk1Dv+rVkOtLS
         VkUgGrgh/kmVg/cefnAZitWtoUJZbRiySbZ4bu3+GEUMVE9g+Sr5HDHk2RB0868STV
         LPojYYpEylAeu+7+R7iV2+ECBhA0agg8qeVlxQ30=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CAD588B813;
        Tue, 18 Feb 2020 14:58:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BkfGkmwtFnEj; Tue, 18 Feb 2020 14:58:01 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 015978B80C;
        Tue, 18 Feb 2020 14:58:00 +0100 (CET)
Subject: Re: [PATCH] powerpc/kprobes: Fix trap address when trap happened in
 real mode
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        stable@kernel.vger.org,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
References: <b1451438f7148ad0e03306a1f1409f4ad1d6ec7c.1581684263.git.christophe.leroy@c-s.fr>
 <20200214225434.464ec467ad9094961abb8ddc@kernel.org>
 <e09d3c42-542e-48c1-2f1e-cfe605b05bec@c-s.fr>
 <20200216213411.824295a321d8fa979dedbbbe@kernel.org>
 <baee8186-549a-f6cf-3619-884b6d708185@c-s.fr>
 <20200217192735.5070f0925c4159ccffa4e465@kernel.org>
 <c6257b49-bf02-d30a-1e2e-99abba5955e6@c-s.fr>
 <20200218094421.6d402de389ce23a55a3ec084@kernel.org>
 <c93c5346-d964-9167-c4dd-3123917344cf@c-s.fr>
 <20200218192905.a3ed969e8565901c4f69fa22@kernel.org>
 <2b3f664e-d4ad-edd3-5bed-a4492f4ed213@c-s.fr>
 <20200218213317.533c78753cefb05bd42cc6ad@kernel.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <e9cb17f4-b698-7d9b-d435-e715ee14c489@c-s.fr>
Date:   Tue, 18 Feb 2020 14:58:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200218213317.533c78753cefb05bd42cc6ad@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 18/02/2020 à 13:33, Masami Hiramatsu a écrit :
> On Tue, 18 Feb 2020 12:04:41 +0100
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>>>> Nevertheless, if one symbol has been forgotten in the blacklist, I think
>>>> it is a problem if it generate Oopses.
>>>
>>> There is a long history also on x86 to make a blacklist. Anyway, how did
>>> you get this error on PPC32? Somewhere would you like to probe and
>>> it is a real mode function? Or, it happened unexpectedly?
>>
>> The first Oops I got was triggered by a WARN_ON() kind of trap in real
>> mode. The trap exception handler called kprobe_handler() which tried to
>> read the instruction at the trap address (which was a real-mode address)
>> so it triggered a Bad Access Fault.
>>
>> This was initially the purpose of my patch.
> 
> OK, then filtering the trap reason in kprobe handler is a bit strange.
> It should be done in the previous stage (maybe in trap.c)

See commit 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.6-rc2&id=6cc89bad60a673a24386f1ada83de8a068a78909

> Can we filter it by exception flag or only by checking the instruction
> which causes the exception, or needs get_kprobe()...?

The trap instruction used by kprobe is also used for other purposes like 
BUG_ON() or WARN_ON(), so needs get_kprobe()



> 
>> After discussion with you, I started looking at what would be the effect
>> of setting a kprobe event in a function which runs in real mode.
> 
> If the kprobe single-stepping (or emulation) works in real mode, just
> ignore the kprobes pre/post_handlers and increment nmissed count.
> 
> If that doesn't work, we have to call a BUG_ON, because we can not
> continue the code execution. And also, you have to find a way to make
> a blacklist for real mode code.

Yes, it has to be done function by function (hoppefully there's not more 
than a dozen).
But I'd like something which can fails gracefully for the functions we 
will forget to mark noprobe.

But as a first step I'd really like a bug fix in 5.6 to avoid Oopsing in 
kprobe_handler() at a non-kprobe trap.

Christophe
