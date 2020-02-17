Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563EDC35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5D02070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Jkfz6bJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgBQGps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:45:48 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:36272 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgBQGps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:45:48 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48LZHp5ycKz9tyTQ;
        Mon, 17 Feb 2020 07:45:42 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Jkfz6bJu; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 2CQ5mQXasQID; Mon, 17 Feb 2020 07:45:42 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48LZHp4Ys7z9tyTL;
        Mon, 17 Feb 2020 07:45:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581921942; bh=EaltpDTgnTrDBrsgY6UJWwdsZ8tEVbQgtxpz7LvsQrs=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Jkfz6bJu21tolva67YXh2dk19yfmBfDCJTRJwnnZdeKJSj2QkUXlcEAPDSQqDVduo
         PPmHS5kfH8tLAt5DnL9UwxC4nWXDOogfv4OMZXGRl9BNZ2g1VYBb+M5199VUcWsmbj
         1RZ2vD+qrTlc0QaZPEdth7m+baweLU1QKzSHI/cI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0942F8B79C;
        Mon, 17 Feb 2020 07:45:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zPiOIOz8XNJK; Mon, 17 Feb 2020 07:45:46 +0100 (CET)
Received: from [172.25.230.102] (unknown [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D32F58B755;
        Mon, 17 Feb 2020 07:45:46 +0100 (CET)
Subject: Re: [PATCH v7 4/4] powerpc: Book3S 64-bit "heavyweight" KASAN support
To:     Michael Neuling <mikey@neuling.org>,
        Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        kasan-dev@googlegroups.com, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
References: <20200213004752.11019-1-dja@axtens.net>
 <20200213004752.11019-5-dja@axtens.net>
 <66bd9d8eb682cda2d22bea0fd4035ea8e0a3c1fb.camel@neuling.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <a060e08e-c119-0d37-d220-409b3d7539d3@c-s.fr>
Date:   Mon, 17 Feb 2020 07:45:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <66bd9d8eb682cda2d22bea0fd4035ea8e0a3c1fb.camel@neuling.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/02/2020 à 00:08, Michael Neuling a écrit :
> Daniel.
> 
> Can you start this commit message with a simple description of what you are
> actually doing? This reads like you've been on a long journey to Mordor and
> back, which as a reader of this patch in the long distant future, I don't care
> about. I just want to know what you're implementing.
> 
> Also I'm struggling to review this as I don't know what software or hardware
> mechanisms you are using to perform sanitisation.

KASAN is standard, it's simply using GCC ASAN in kernel mode, ie kernel 
is built with -fsanitize=kernel-address 
(https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html)

You have more details there: 
https://www.kernel.org/doc/html/latest/dev-tools/kasan.html

Christophe
