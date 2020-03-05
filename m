Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75583C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 23:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFEF2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 23:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgCEXCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 18:02:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51650 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgCEXCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 18:02:24 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j9zVN-0007Il-JA; Fri, 06 Mar 2020 00:02:13 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D6D06104085; Fri,  6 Mar 2020 00:02:12 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 15/16] x86/entry: Switch page fault exceptions to idtentry_simple
In-Reply-To: <afe4d10f-7976-5972-4152-fb641ed352bb@kernel.org>
References: <20200225223321.231477305@linutronix.de> <20200225224145.657687951@linutronix.de> <afe4d10f-7976-5972-4152-fb641ed352bb@kernel.org>
Date:   Fri, 06 Mar 2020 00:02:12 +0100
Message-ID: <877dzycsnf.fsf@nanos.tec.linutronix.de>
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

> On 2/25/20 2:33 PM, Thomas Gleixner wrote:
>> Convert page fault exceptions to IDTENTRY_CR2:
>>   - Implement the C entry point with DEFINE_IDTENTRY
>>   - Emit the ASM stub with DECLARE_IDTENTRY
>>   - Remove the ASM idtentry in 64bit
>>   - Remove the CR2 read from 64bit
>>   - Remove the open coded ASM entry code in 32bit
>>   - Fixup the XEN/PV code
>>   - Remove the old prototyoes
>
> $SUBJECT says idtentry_simple.  I think you meant IDTENTRY_CR2.

Yes.

> (I typed this a while ago and apparently failed to hit send.  I'm not
> sure it's still relevant.)

No, as we agreed to create raw IDTENTRY points for stuff which does not
fall into the trivial category.

I've reworked the mess, but now I'm tripping over the brilliant stuff in
that async PF code. The rcu_irq_enter()/exit() dance there is really
great and of course done unconditionally even if called from the VM exit
PF handling code. Oh well...

Thanks,

        tglx
