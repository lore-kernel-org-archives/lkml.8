Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	PDS_HP_HELO_NORDNS,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,SPOOFED_FREEMAIL_NO_RDNS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40409 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729852AbgCKQcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:32:53 -0400
Date: Wed, 11 Mar 2020 22:02:49 +0530
From: afzal mohammed <afzal.mohd.ma@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Nathan Chancellor <natechancellor@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH v4] MIPS: Replace setup_irq() by request_irq()
Message-ID: <20200311163249.GA4984@afzalpc>
References: <20200304203144.GA4323@alpha.franken.de>
 <20200305115759.3186-1-afzal.mohd.ma@gmail.com>
 <20200311053126.GA48442@ubuntu-m2-xlarge-x86>
 <20200311090308.GA5060@afzalpc>
 <20200311104217.GA10615@alpha.franken.de>
 <20200311131210.GA5115@afzalpc>
 <20200311160307.GA15464@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311160307.GA15464@alpha.franken.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Wed, Mar 11, 2020 at 05:03:07PM +0100, Thomas Bogendoerfer wrote:
> On Wed, Mar 11, 2020 at 06:42:10PM +0530, afzal mohammed wrote:

> > If IRQF_SHARED is passed, it exepcts a non-NULL dev_id, here it is
> > NULL, setup_irq() doesn't have any check like that.
> 
> so request_irq() is not a 1:1 replacement for our current setup_irq().
> Or put it the another way our setup_irq() might be buggy, when used for
> shared interrupts.

AFAIU, this causes problems only while freeing irq, but not sure. Seems
it is not happening with any of the cases in the diff.

> > So i think proper solution is to add a non NULL dev_id, as removing
> > IRQF_SHARED might affect some platforms that might be using that
> > interrupt line shared.
> > 
> > Patch with non-NULL dev_id below, it works w/ Nathan's test case.
> 
> I'm not sure, I like the adding of string pointers as dev_id arguments
> in your patch. How can we make sure they are unique enough for the use
> case ? I guess using handler as dev_id does a better job here.

There was one prior similar usage using string pointers, another way i
have seen is using irq no. itself, but then it has to be typecasted,
in file arch/mips/txx9/generic/pci.c,

        request_irq(irq, &i8259_interrupt, IRQF_SHARED,
                "cascade(i8259)", (void *)(long)irq);

[ but i think that double casting is not required, only (void *) might
suffice ]

If you prefer handler function pointer, i will use that.

> And before doing that, lets clean up some of the IRQF_SHARED usage first.
> All sni IRQF_SHARED can go away, the interrupt lines are exclusive there. 
> 
> loongson2ef/lemote-2f/irq.c: looks like the only user of
> LOONGSON_NORTH_BRIDGE_IRQ, so IRQF_SHARED could go as well.
> Could someone confirm that ?
> 
> All other need to stay, IMHO.

Okay, i am venturing into MIPS the first time as part of this patch
series, so no MIPS specific knowledge, just let me know
loongson2ef/lemote-2f case as well, i will prepare patch accordingly. 

> And v4 is already in mips-next, so I need an incremental patch please.

Okay, i already sent a patch, it crossed your mail, i will make a new
patch based on the outcome of the discusson here.

Since there is some issue w/ lore.kernel.org, i send it again, but
both are not seen in archives.

Regards
afzal

