Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0007FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2FAB20723
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390040AbgEYLGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 07:06:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:24620 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389897AbgEYLGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:06:48 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49VvRf46Bwz9v09n;
        Mon, 25 May 2020 13:06:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id FYfwzWS7jhgs; Mon, 25 May 2020 13:06:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49VvRf348Qz9v09m;
        Mon, 25 May 2020 13:06:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ED4B38B7C4;
        Mon, 25 May 2020 13:06:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id drtm2HkzvJ5l; Mon, 25 May 2020 13:06:44 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6BE988B7C3;
        Mon, 25 May 2020 13:06:44 +0200 (CEST)
Subject: Re: [PATCH v4 07/45] powerpc/ptdump: Limit size of flags text to 1/2
 chars on PPC32
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1589866984.git.christophe.leroy@csgroup.eu>
 <83a7a0cfca6198e63caf7a16839bd18454961f52.1589866984.git.christophe.leroy@csgroup.eu>
 <87h7w4fvcy.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <e505c554-21b1-3d02-1ea5-c2a214b80ebb@csgroup.eu>
Date:   Mon, 25 May 2020 13:06:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87h7w4fvcy.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 25/05/2020 à 07:15, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> In order to have all flags fit on a 80 chars wide screen,
>> reduce the flags to 1 char (2 where ambiguous).
> 
> I don't love this, the output is less readable. Is fitting on an 80 char
> screen a real issue for you? I just make my terminal window bigger.

I don't have strong opinion about that, and the terminal can be made bigger.
I just don't like how messy it is, some flags are so big that they hide 
other ones and getting it more ordered and more compact helped me during 
all the verifications I did with this series, but we can leave it as is 
if you prefer.

Would you like a v5 without patches 7 and 8 ? Or I can just resend the 
patches that will be impacted, that is 9 and 38 ?

Without the changes I get:

---[ Start of kernel VM ]---
0xc0000000-0xc0ffffff  0x00000000        16M   huge  shared  r    X 
present                  accessed
0xc1000000-0xc7ffffff  0x01000000       112M   huge  shared  rw 
present           dirty  accessed
---[ vmalloc() Area ]---
0xc9000000-0xc9003fff  0x050e4000        16K         shared  rw 
present           dirty  accessed
0xc9008000-0xc900bfff  0x050ec000        16K         shared  rw 
present           dirty  accessed
0xc9010000-0xc9013fff  0xd0000000        16K         shared  rw 
present  guarded  dirty  accessed  no cache
0xc9018000-0xc901bfff  0x050f0000        16K         shared  rw 
present           dirty  accessed

---[ Fixmap start ]---
0xf7f00000-0xf7f7ffff  0xff000000       512K   huge  shared  rw 
present  guarded  dirty  accessed  no cache
---[ Fixmap end ]---
---[ kasan shadow mem start ]---
0xf8000000-0xf8ffffff  0x07000000        16M   huge  shared  rw 
present           dirty  accessed
0xf9000000-0xf91fffff [0x01288000]       16K         shared  r 
present                  accessed
0xf9200000-0xf9203fff  0x050e0000        16K         shared  rw 
present           dirty  accessed


With the change I get.

---[ Start of kernel VM ]---
0xc0000000-0xc0ffffff  0x00000000        16M   h  r   x  p        sh 
    a
0xc1000000-0xc7ffffff  0x01000000       112M   h  rw     p        sh 
d  a
---[ vmalloc() Area ]---
0xc9000000-0xc9003fff  0x050e4000        16K      rw     p        sh 
d  a
0xc9008000-0xc900bfff  0x050ec000        16K      rw     p        sh 
d  a
0xc9010000-0xc9013fff  0xd0000000        16K      rw     p  i  g  sh 
d  a
0xc9018000-0xc901bfff  0x050f0000        16K      rw     p        sh 
d  a

---[ Fixmap start ]---
0xf7f00000-0xf7f7ffff  0xff000000       512K   h  rw     p  i  g  sh 
d  a
---[ Fixmap end ]---
---[ kasan shadow mem start ]---
0xf8000000-0xf8ffffff  0x07000000        16M   h  rw     p        sh 
d  a
0xf9000000-0xf91fffff [0x01288000]       16K      r      p        sh 
    a
0xf9200000-0xf9203fff  0x050e0000        16K      rw     p        sh 
d  a


Christophe

> 
> cheers
> 
> 
>> No cache is 'i'
>> User is 'ur' (Supervisor would be sr)
>> Shared (for 8xx) becomes 'sh' (it was 'user' when not shared but
>> that was ambiguous because that's not entirely right)
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/mm/ptdump/8xx.c    | 33 ++++++++++++++++---------------
>>   arch/powerpc/mm/ptdump/shared.c | 35 +++++++++++++++++----------------
>>   2 files changed, 35 insertions(+), 33 deletions(-)
