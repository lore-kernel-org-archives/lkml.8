Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33653C2D0EF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 09:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E3DD214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 09:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgDRJo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 05:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725887AbgDRJo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 05:44:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16C2C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 02:44:58 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jPk1w-0006ZA-G8; Sat, 18 Apr 2020 11:44:56 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id EE06E101304; Sat, 18 Apr 2020 11:44:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marc Dionne <marc.c.dionne@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Subject: Re: FreeNAS VM disk access errors, bisected to commit 6f1a4891a592
In-Reply-To: <CAB9dFdvJE0LhQsxdUTKmOxp_q1xF1Bpe9E-dNp1Pxg3T0B1xPQ@mail.gmail.com>
References: <CAB9dFdtBqrcmKcV=zxPyV5uNB7WeKOqqC4k5KtY+9vxS9ooKoA@mail.gmail.com> <87d085zwy9.fsf@nanos.tec.linutronix.de> <CAB9dFdvJE0LhQsxdUTKmOxp_q1xF1Bpe9E-dNp1Pxg3T0B1xPQ@mail.gmail.com>
Date:   Sat, 18 Apr 2020 11:44:55 +0200
Message-ID: <87sgh1xh48.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc,

Marc Dionne <marc.c.dionne@gmail.com> writes:
> On Fri, Apr 17, 2020 at 5:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> That makes me assume that the staged approach of changing affinity for
>> this non-maskable MSI mess makes your particular hypervisor unhappy.
>>
>> Are there any messages like this:
>>
>>  "do_IRQ: 0.83 No irq handler for vector"
>
> I haven't seen those although I only have a VNC console that scrolls
> by rather fast.
> I did see a report from someone running Ubuntu 18.04 which had this
> after the initial errors:
>
>   do_IRQ: 2.35 No irq handler for vector
>   ata1.00: revalidation failed (error=-5)

I expected that and it points to an issue on the HV side either in
affinity management or in the local APIC emulation. 

Thanks,

        tglx
