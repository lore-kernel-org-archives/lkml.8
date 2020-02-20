Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F391DC11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30E2206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgBTXEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:04:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44613 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBTXEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 18:04:23 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j4urk-0001Jy-ST; Fri, 21 Feb 2020 00:04:21 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 4BCBA100E35; Fri, 21 Feb 2020 00:04:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH] x86/entry/32: Add missing ASM_CLAC in general_protection entry
In-Reply-To: <CAMzpN2ie64-TOJ5MJ+MFQ22GxXcjAgthJBV046OOPjvcMAseNw@mail.gmail.com>
References: <87zhdeq4qu.fsf@nanos.tec.linutronix.de> <CAMzpN2ie64-TOJ5MJ+MFQ22GxXcjAgthJBV046OOPjvcMAseNw@mail.gmail.com>
Date:   Fri, 21 Feb 2020 00:04:20 +0100
Message-ID: <87r1yooo7f.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst <brgerst@gmail.com> writes:

> On Wed, Feb 19, 2020 at 4:58 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> All exception entry points must have ASM_CLAC right at the
>> beginning. The general_protection entry is missing one.
>>
>> Fixes: e59d1b0a2419 ("x86-32, smap: Add STAC/CLAC instructions to 32-bit kernel entry")
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Cc: stable@vger.kernel.org
>> ---
>>  arch/x86/entry/entry_32.S |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> --- a/arch/x86/entry/entry_32.S
>> +++ b/arch/x86/entry/entry_32.S
>> @@ -1681,6 +1681,7 @@ SYM_CODE_START(int3)
>>  SYM_CODE_END(int3)
>>
>>  SYM_CODE_START(general_protection)
>> +       ASM_CLAC
>>         pushl   $do_general_protection
>>         jmp     common_exception
>>  SYM_CODE_END(general_protection)
>
> How about moving ASM_CLAC to common_exception instead?  That would
> save a few bytes (kernel text + alternatives), and the AC bit has no
> effect on kernel stack pushes.

Agreed, but that's a seperate cleanup. The fix is the right thing also
for backports.

Aisde of that this mindlessly copied code will be gone in the
foreseeable future. Just lacks some testing and changelog writing :)

Thanks,

        tglx
