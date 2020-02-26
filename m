Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBA6C4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC88C21556
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgBZUPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:15:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59428 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgBZUPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 15:15:23 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j735M-0005eC-Mq; Wed, 26 Feb 2020 21:15:12 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 1BD5C104099; Wed, 26 Feb 2020 21:15:12 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 05/15] x86/entry: Provide IDTEnTRY_SYSVEC
In-Reply-To: <49a8589f-de01-d08a-69f0-b98106e8b715@kernel.org>
References: <20200225224719.950376311@linutronix.de> <20200225231609.412892623@linutronix.de> <49a8589f-de01-d08a-69f0-b98106e8b715@kernel.org>
Date:   Wed, 26 Feb 2020 21:15:12 +0100
Message-ID: <87h7zdp0kv.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:

> On 2/25/20 2:47 PM, Thomas Gleixner wrote:
>> Provide a IDTENTRY variant for system vectors to consolidate the differnt
>> mechanisms to emit the ASM stubs for 32 an 64 bit.
>
> $SUBJECT has an obvious typo.

Indeed.

>> --- a/arch/x86/entry/entry_32.S
>> +++ b/arch/x86/entry/entry_32.S
>> @@ -1261,6 +1261,10 @@ SYM_CODE_START_LOCAL(asm_\cfunc)
>>  SYM_CODE_END(asm_\cfunc)
>>  .endm
>>  
>> +.macro idtentry_sysvec vector cfunc
>> +	idtentry \vector asm_\cfunc \cfunc has_error_code=0
>> +.endm
>
> irq_stack?

System vectors have never used irq stacks.

Thanks,

        tglx
