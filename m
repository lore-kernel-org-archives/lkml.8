Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77C4C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B8720873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="IP/xBWIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgBLOmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:42:19 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:53024 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbgBLOmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:42:19 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48Hj5z3w9sz9txMT;
        Wed, 12 Feb 2020 15:42:15 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=IP/xBWIV; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0Ney07egoNwa; Wed, 12 Feb 2020 15:42:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48Hj5z2j1Fz9txMJ;
        Wed, 12 Feb 2020 15:42:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581518535; bh=bAr/TswE2VMMLEod6DbaygLv0bA44xApmo6eiBQt5Jk=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=IP/xBWIVg6C7582meI+344Quc+xiKXsWItN6OAWoIW8toFDgjZ1/WnTo8jE2wN11m
         7bXAxtyVtcj9urCyggEQk5hwZgA4Qy1JsuKqNH6cC/0iL7o+254hArKUUI2i2h5ErG
         mksQxhyyADuNDqTLMJbtTGdGL48y1XiICT34J3aY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CFC528B81A;
        Wed, 12 Feb 2020 15:42:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id huEqZ1_u6whj; Wed, 12 Feb 2020 15:42:16 +0100 (CET)
Received: from [172.25.230.102] (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A92268B80D;
        Wed, 12 Feb 2020 15:42:16 +0100 (CET)
Subject: Re: [Regression 5.6-rc1][Bisected b6231ea2b3c6] Powerpc 8xx doesn't
 boot anymore
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Li Yang <leoyang.li@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Wood <oss@buserror.net>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <0d45fa64-51ee-0052-cb34-58c770c5b3ce@c-s.fr>
Message-ID: <1dee8082-e98e-c767-a8db-405a4fee7b2e@c-s.fr>
Date:   Wed, 12 Feb 2020 15:42:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <0d45fa64-51ee-0052-cb34-58c770c5b3ce@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 12/02/2020 à 15:24, Christophe Leroy a écrit :
> Hi Rasmus,
> 

[...]

> 
> NB: Next time, can you please copy powerpc mailing list when changing 
> such core parts of powerpc CPUs ?

Apologise for that comment, in fact I was part of the recipients so it 
didn't land in my linuxppc mailbox.

Seems like I missed that series.
