Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA6FC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894D62075E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="QwEW7K8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731881AbgCPPFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:05:13 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63866 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731688AbgCPPFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:05:13 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48h03553XYz9v0wQ;
        Mon, 16 Mar 2020 16:05:05 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=QwEW7K8I; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id uqkjpto6xMY0; Mon, 16 Mar 2020 16:05:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48h0353sMXz9v0wL;
        Mon, 16 Mar 2020 16:05:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584371105; bh=4vECZigMBFnrRhGn3xOie0FgGaVr4EeWX/NjITIOAr0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QwEW7K8IxVzr4f0XSkbOw2rbYHAG/jVX500dwR0saNdRrZP3S/oF2OPDcfhHzYR0b
         Pq2kA4CMRggN11Dp5j/YbiwIgrxyVEsIg6Zv6Rju2kWvJkDR9pAus0wGJ5YN7ooFgm
         MTp6v4zFJKvXvKBa6g5Hp+o6M8GDiQgUtODgN4fg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A73A68B837;
        Mon, 16 Mar 2020 16:05:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id HE1ike9e8piw; Mon, 16 Mar 2020 16:05:10 +0100 (CET)
Received: from [172.25.230.100] (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 04B588B828;
        Mon, 16 Mar 2020 16:05:08 +0100 (CET)
Subject: Re: [PATCH 00/15] powerpc/watchpoint: Preparation for more than one
 watchpoint
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
        mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b7148b91-e3db-d48a-7294-5c18fc801933@c-s.fr>
Date:   Mon, 16 Mar 2020 16:05:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/03/2020 à 09:57, Ravi Bangoria a écrit :
> So far, powerpc Book3S code has been written with an assumption of only
> one watchpoint. But future power architecture is introducing second
> watchpoint register (DAWR). Even though this patchset does not enable
> 2nd DAWR, it make the infrastructure ready so that enabling 2nd DAWR
> should just be a matter of changing count.

Some book3s (e300 family for instance, I think G2 as well) already have 
a DABR2 in addition to DABR.
Will this series allow to use it as well ?

Christophe
