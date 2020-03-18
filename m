Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C6DC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B5120772
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="XYtuqdKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCRNbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 09:31:21 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:38141 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbgCRNbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:31:20 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48j9sx40glz9v1vc;
        Wed, 18 Mar 2020 14:31:17 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=XYtuqdKJ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id gQE5nnNjFsjF; Wed, 18 Mar 2020 14:31:17 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48j9sx2wRxz9v1vY;
        Wed, 18 Mar 2020 14:31:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584538277; bh=G84lL0LtzEaL0veVBFRjgIHIWAwVKkwsmezTFwoIHwc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XYtuqdKJfkDzgOIYvHzljLu5MuAZuNLqYbq/2GyY4aFFvNS3/PYaHG3Hn92Yd4hty
         daB23nJXA5GEbk8J3vAS/pKkGE/8ZaQ1E2wCiSBk8BCoyoWnubsQCpeJAyBASccwDl
         XEw+boI+iSQSpSuY3REOY4mBwjroCqcZzFM9txgM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AFE0F8B78A;
        Wed, 18 Mar 2020 14:31:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LmKV_rQvLy0e; Wed, 18 Mar 2020 14:31:18 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B97EE8B75B;
        Wed, 18 Mar 2020 14:31:17 +0100 (CET)
Subject: Re: [PATCH 14/15] powerpc/watchpoint/xmon: Don't allow breakpoint
 overwriting
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, apopple@linux.ibm.com,
        paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com>
 <20200309085806.155823-15-ravi.bangoria@linux.ibm.com>
 <b6892b22-c521-207e-e5fd-ca66c774b314@c-s.fr>
 <56ee9190-2363-efbe-fd94-0b42194e6586@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <79b77ffc-afac-b8ff-20d8-35a48860e526@c-s.fr>
Date:   Wed, 18 Mar 2020 14:31:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <56ee9190-2363-efbe-fd94-0b42194e6586@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 18/03/2020 à 13:37, Ravi Bangoria a écrit :
> 
> 
> On 3/17/20 4:40 PM, Christophe Leroy wrote:
>>
>>
>> Le 09/03/2020 à 09:58, Ravi Bangoria a écrit :
>>> Xmon allows overwriting breakpoints because it's supported by only
>>> one dawr. But with multiple dawrs, overwriting becomes ambiguous
>>> or unnecessary complicated. So let's not allow it.
>>
>> Could we drop this completely (I mean the functionnality, not the patch).
> 
> Not sure I follow. Isn't the same thing I'm doing?
> 

Yes, I think I misunderstood the patch. That seems ok.

Christophe
