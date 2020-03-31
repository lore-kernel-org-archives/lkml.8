Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E279BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F3C20786
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="t8Aeguib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbgCaP0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:26:43 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:42266 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730105AbgCaP0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:26:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48sCq45DKpz9v1m0;
        Tue, 31 Mar 2020 17:26:40 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=t8Aeguib; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8DExRBZx6m9W; Tue, 31 Mar 2020 17:26:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48sCq445KVz9v1lt;
        Tue, 31 Mar 2020 17:26:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585668400; bh=6GzuXtjCsiw9CH7FF8bJtqgWQkdVh/8g3MNsBbKIqes=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=t8AeguibQXTtwgtxuz/Qgy7l3pQt6IBkAXgo6w01KhY0Rk7YOyeUFk4idt9aVz7se
         cZ8qLc46EDDfvl89JC7LHhD7CZ2R4qRCg7T80nW2Inb2BzTXbxSBornWpCeS4bpIRH
         cC99bCmeL0PNnXHTNazRseiFDfwdchk5rz/eY1XU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2EDFC8B868;
        Tue, 31 Mar 2020 17:26:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 119REg_f9BRk; Tue, 31 Mar 2020 17:26:42 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 560438B752;
        Tue, 31 Mar 2020 17:26:40 +0200 (CEST)
Subject: Re: [PATCH v2 09/11] powerpc/platforms: Move files from 4xx to 44x
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <698e9a42a06eb856eef4501c3c0a182c034a5d8c.1585640941.git.christophe.leroy@c-s.fr>
 <50d0ce1a96fa978cd0dfabde30cf75d23691622a.1585640942.git.christophe.leroy@c-s.fr>
 <CAK8P3a3u4y7Zm8w43QScqUk6macBL1wO3S0qPisf9+d9FqSHfw@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <833d63fe-3b94-a3be-1abb-a629386aa0dd@c-s.fr>
Date:   Tue, 31 Mar 2020 17:26:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3u4y7Zm8w43QScqUk6macBL1wO3S0qPisf9+d9FqSHfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 31/03/2020 à 17:14, Arnd Bergmann a écrit :
> On Tue, Mar 31, 2020 at 9:49 AM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>>
>> Only 44x uses 4xx now, so only keep one directory.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/platforms/44x/Makefile           |  9 +++++++-
>>   arch/powerpc/platforms/{4xx => 44x}/cpm.c     |  0
> 
> No objections to moving everything into one place, but I wonder if the
> combined name should be 4xx instead of 44x, given that 44x currently
> include 46x and 47x. OTOH your approach has the advantage of
> moving fewer files.
> 

In that case, should we also rename CONFIG_44x to CONFIG_4xx ?

Christophe
