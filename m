Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C52AC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 19:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F063720735
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 19:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNaqQKaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387883AbgEWTtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 15:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbgEWTtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 15:49:17 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F31BC061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 12:49:17 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id z26so2866525oog.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 12:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xgndOloRKNtdK78AcW7sPC8a95QIlm+mmZmaumtncUc=;
        b=HNaqQKaQLUq/APhlvRG5lP97ykP8CBcnuAYjOTG7XC4H2V0b5eeS37jqC7zF6xLlYm
         foOBDqbvVO2DAq8XZA6JpiXF3NIubfy+UV3xLKrKl4UH2Oi/uoEKDJ2N4bGt2zhddAmb
         bbkbXOUBbEtGl4ygvFnj2jcUabvJadmQdd7MM0UjJ43zZeVv4KuM+nulK3xCoeQaNJyi
         9S2/7/6ibmJnAOjqDkKDG+5n4wnwYYfad2zUihlZmcHbw1j9Y2kvjIo8GP0pVZ2IAd7n
         51+4Fh28KADZOpOkrkL7ZZXthJrwEePYdArCTEYp0YjAS1sGMU6vzwfl5/fM0KmCRl4s
         K7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xgndOloRKNtdK78AcW7sPC8a95QIlm+mmZmaumtncUc=;
        b=MYpfu6k09Znbal4DSmJYme9L1tAY9BnOruKKP7VkeFZykZYFIOSNmkAoC0xHPZktQr
         EIIdfwl1MldCCbZ2Djfkae6FkWEpz8ykgBufOpexN1bTwHLZDm/Fqx3zwOd5nd5oPC0b
         F82P9bg0WlDlU5cb6/JrK0kctWsYJ5Ec0wKcRsH4hgvBEOkjuBpUcGSLY0WOSx2+TBfW
         0byFdZjSXgR2v95ojxL0fdXUxwXKpCPEC94mbqARyLr1/udWzkaGTvgrJIM/8zZYw8u1
         lwIGtvQt5E4bjwgpnZrP3frI8fV570p2vw/itgDbFRq+JvMn821TKDYE/tOFNuSV0sJu
         kNLA==
X-Gm-Message-State: AOAM533hW9wOVlAuP3Wn2sy88qMCizjm4llA7V4ZIwttSJvzo+REgqqm
        I6Hj30NckLi/w+jkXL+OzKFsNze4
X-Google-Smtp-Source: ABdhPJynQMgmdSbexmBIKI9HyUyaz2y7BNMfUh8s5jiveBpjiP3p1GJ3PwgKIWZsbD1dcAVcgSl1xw==
X-Received: by 2002:a4a:9624:: with SMTP id q33mr8038927ooi.53.1590263356529;
        Sat, 23 May 2020 12:49:16 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id t13sm447468oie.34.2020.05.23.12.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2020 12:49:15 -0700 (PDT)
Subject: Re: Kernel bug in 5.7 for PPC32 on PowerBook G4 - bisected to commit
 697ece7
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <2c361d8e-5e2a-cdd9-da8e-aa49a4f93cfd@lwfinger.net>
 <3e3e2343-d674-02e0-7b23-81636b472641@csgroup.eu>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <94639869-c744-2879-9203-21cea664a563@lwfinger.net>
Date:   Sat, 23 May 2020 14:49:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3e3e2343-d674-02e0-7b23-81636b472641@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/20 12:30 PM, Christophe Leroy wrote:
> Hi Larry,
> 
> Le 23/05/2020 à 19:24, Larry Finger a écrit :
>> Hi Christophe,
>>
>> Although kernel 5.7.0-rc2 appeared to boot cleanly, it failed on my G4 when I 
>> tried to generate a new kernel. The following BUG message is logged:
>>
> 
> [...]
> 
>>
>> This problem was bisected to commit 697ece7 ("powerpc/32s: reorder Linux PTE 
>> bits to better match Hash PTE bits").
> 
> Being reversed in new -rc , see 
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/87sgfsf4hs.fsf@mpe.ellerman.id.au/ 

Christophe,

Thanks for the update.

Larry


