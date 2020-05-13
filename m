Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6AEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CD7E20671
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390395AbgEMTCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390253AbgEMTCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:02:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A84C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:02:32 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYwe9-0002kw-GE; Wed, 13 May 2020 21:02:25 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D2E86100605; Wed, 13 May 2020 21:02:24 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2 0/3] x86/idt: Minor alloc_intr_gate() sanitization
In-Reply-To: <87imh0kn5t.fsf@vitty.brq.redhat.com>
References: <20200428093824.1451532-1-vkuznets@redhat.com> <87imh0kn5t.fsf@vitty.brq.redhat.com>
Date:   Wed, 13 May 2020 21:02:24 +0200
Message-ID: <87imgz1wvz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:
> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
>
>> This series is a successor of "[PATCH] x86/idt: Keep spurious entries unset
>> in system_vectors".
>>
>> The original issue I tried to address was that /proc/interrupts output
>> was always containing all possible system vectors, including non allocated
>> ones (e.g. 'Hypervisor callback interrupts' on bare metal). Thomas
>> suggested to expand this cosmetic change to making alloc_intr_gate()
>> __init.
>>
>> Vitaly Kuznetsov (3):
>>   x86/xen: Split HVM vector callback setup and interrupt gate allocation
>>   x86/idt: Annotate alloc_intr_gate() with __init
>>   x86/idt: Keep spurious entries unset in system_vectors
>>
>
> Ping?

It's in my pile and I just did not come around to merge it.

Thanks,

        tglx
