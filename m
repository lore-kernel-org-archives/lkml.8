Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CBFC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 12:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81ABB206D7
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 12:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgCHMOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 08:14:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56572 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgCHMOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 08:14:14 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jAuor-0005jp-I8; Sun, 08 Mar 2020 13:14:09 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 0841F104096; Sun,  8 Mar 2020 13:14:09 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Joe Jin <joe.jin@oracle.com>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] genirq/debugfs: add new config option for trigger interrupt from userspace
In-Reply-To: <84d0b879-cd4b-57c4-5ad3-57eab7694d45@oracle.com>
References: <44a7007d-9624-8ac7-e0ab-fab8bdd39848@oracle.com> <006a08b8bfb991853ede8c9d1e29d6a7@kernel.org> <a4b3b41b-b0b9-03cd-c394-05d8f0bfc5f4@oracle.com> <bd3f06814b4319ddaaee2bf142aaf465@kernel.org> <84d0b879-cd4b-57c4-5ad3-57eab7694d45@oracle.com>
Date:   Sun, 08 Mar 2020 13:14:08 +0100
Message-ID: <87r1y382nj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe,

Joe Jin <joe.jin@oracle.com> writes:
> On 2/28/20 11:54 AM, Marc Zyngier wrote:
>> On 2020-02-28 19:13, Joe Jin wrote:
>>>> On 2020-02-28 05:42, Joe Jin wrote:
>>>>> commit 536e2e34bd00 ("genirq/debugfs: Triggering of interrupts from
>>>>> userspace") is allowed developer inject interrupts via irq debugfs, which
>>>>> is very useful during development phase, but on a production system, this
>>>>> is very dangerous, add new config option, developers can enable it as
>>>>> needed instead of enabling it by default when irq debugfs is enabled.
>>>>
>>>> I don't really mind the patch (although it could be more elegant), but in
>>>> general I object to most debugfs options being set on a production kernel.
>>>> There is way too much information in most debugfs backends to be comfortable
>>>> with it, and you can find things like page table dumps, for example...
>>>
>>> We should not enable any debug option on production system, actual customer
>>> want to resize their BM or VM, cpu offline may lead system not works properly,
>>> and if we knew more details of IRQ info it will be very help to identify
>>> if it caused by IRQ/vectors, this is the motivation of we want to enable it
>>> on production kernel.
>> 
>> If something doesn't work properly, then you are still debugging, AFAICT.
>
> Yes you're right, there are various reasons to led the problem such like
> bad mapping, interrupts lost, vectors used up .... irq debugfs is help to
> identify which part caused the problem, and it help to save troubleshooting
> time :-)

Just picking out individual interfaces is going to create a whack a mole
game and a boat load of config options to disable these. That's really
not the way to go.

The right thing to do is to have ONE config switch which disables all
write interfaces at once by refusing the write right in the debugfs
entry point. 

Of course there might be a few debugfs files which need write access
even in that case, but that's easy enough to fix by marking them as
explicitely allowed.

Thanks,

        tglx


