Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FA1C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96EA420672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="wnZjCqGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgDFSUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:20:43 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:1178 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbgDFSUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:20:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48wzP560d0z9v0BM;
        Mon,  6 Apr 2020 20:20:41 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=wnZjCqGS; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id TwiiTzaOFqWZ; Mon,  6 Apr 2020 20:20:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48wzP54YFjz9v0BL;
        Mon,  6 Apr 2020 20:20:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586197241; bh=thfJd+r+S9lcNOYlrQipQHaWRbxSbp2YiRq9Qz50kIw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=wnZjCqGSm8Bv/Rd1c7fZapIPZo6cm6+pd/Mcc7AiEzSHeWr8QVBNV+qjgj/EqKN93
         4gsW7Md902ze56F4NGoFbK52nCbFxloCOrJRO38XWBivzJ2zTpNYfkr3IpjXDCmqut
         nCKUC0Ram6lpp5Sj0p9hJxGTGcIDs0/hTtGAe3Vg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 88B838B784;
        Mon,  6 Apr 2020 20:20:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rhOAMV4eOYhe; Mon,  6 Apr 2020 20:20:41 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 654148B775;
        Mon,  6 Apr 2020 20:20:40 +0200 (CEST)
Subject: Re: [RFC PATCH v2 05/13] powerpc/syscall: Rename syscall_64.c into
 syscall.c
To:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <029e1064b1ad738785718221ea468c9cfc282457.1586108649.git.christophe.leroy@c-s.fr>
 <cacbc62ded444e26e15ca67e0ec91b05b7de6459.1586108649.git.christophe.leroy@c-s.fr>
 <1586137301.c2ssus5vmb.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1a154868-6849-ebd7-9d38-673d0954c2d7@c-s.fr>
Date:   Mon, 6 Apr 2020 20:20:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1586137301.c2ssus5vmb.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 06/04/2020 à 03:42, Nicholas Piggin a écrit :
> Christophe Leroy's on April 6, 2020 3:44 am:
>> syscall_64.c will be reused almost as is for PPC32.
>>
>> Rename it syscall.c
> 
> Don't mind this, but I wonder if we can rename it to interrupt.c.

Interrupt for me is irq.

Maybe exception.c ?

Exceptions, that's what interrupts and system calls are.

Christophe
