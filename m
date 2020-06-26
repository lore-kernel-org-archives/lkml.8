Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94063C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C959207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgFZEme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 00:42:34 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63168 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgFZEme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:42:34 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49tPPd6JH3z9tyRn;
        Fri, 26 Jun 2020 06:42:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id MBV5M8yzvnDA; Fri, 26 Jun 2020 06:42:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49tPPd5Q6gz9tyRl;
        Fri, 26 Jun 2020 06:42:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C02178B778;
        Fri, 26 Jun 2020 06:42:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id cRNfEGUo6HPJ; Fri, 26 Jun 2020 06:42:30 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 03DFA8B75E;
        Fri, 26 Jun 2020 06:42:29 +0200 (CEST)
Subject: Re: [klibc] process '/usr/bin/rsync' started with executable stack
To:     Kees Cook <keescook@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ben Hutchings <ben@decadent.org.uk>
Cc:     Christian Kujau <lists@nerdbynature.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
        klibc@lists.zytor.com, "H. Peter Anvin" <hpa@zytor.com>
References: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org>
 <20200624165148.GD31008@kadam> <202006241238.E9CB1CE85B@keescook>
 <20200625100429.GB2571@kadam> <202006251253.2893D4F67@keescook>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <46c65832-6677-f644-30f5-d7554826c9c4@csgroup.eu>
Date:   Fri, 26 Jun 2020 06:42:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <202006251253.2893D4F67@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 25/06/2020 à 22:20, Kees Cook a écrit :
> On Thu, Jun 25, 2020 at 01:04:29PM +0300, Dan Carpenter wrote:
>> On Wed, Jun 24, 2020 at 12:39:24PM -0700, Kees Cook wrote:
>>> On Wed, Jun 24, 2020 at 07:51:48PM +0300, Dan Carpenter wrote:
>>>> In Debian testing the initrd triggers the warning.
>>>>
>>>> [   34.529809] process '/usr/bin/fstype' started with executable stack
>>>
>>> Where does fstype come from there? I am going to guess it is either
>>> busybox or linked against klibc?
>>>
>>> klibc has known problems with executable stacks due to its trampoline
>>> implementation:
>>> https://wiki.ubuntu.com/SecurityTeam/Roadmap/ExecutableStacks
>>
>> Yeah.  It comes from klibc-utils.
> 
> This is exactly what I was worried about back in Feb:
> https://lore.kernel.org/lkml/202002251341.48BC06E@keescook/
> 
> This warning, combined with klibc-based initrds, makes the whole thing
> pointless because it will always warn once on boot for the klibc stack,
> and then not warn about anything else after that.
> 
> It looks like upstream klibc hasn't been touched in about 4 years, and
> it's been up to Ben to keep it alive in Debian.
> 
> A couple ideas, in order of my preference:
> 
> 1) stop using klibc-utils[1]. initramfs-tools-core is the only thing with a
>     dependency on klibc-utils. Only a few things are missing from busybox.

Does busybox cleanly build with klibc lib ?
If it does, is the result as small ?

> 
> 2) make the warning rate-limited instead?
> 
> 3) fix the use of trampolines in klibc

That's done, see 
https://git.kernel.org/pub/scm/libs/klibc/klibc.git/commit/?id=9d8d648e604026b32cad00a84ed6c29cbd157641

Discussed here 
https://lists.zytor.com/archives/klibc/2020-February/004271.html

Christophe

> 
> Thoughts?
> 
> -Kees
> 
> 
> [1] Ben appears well aware of this idea, as he suggested it in 2018. :)
>      https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=887159
> 
