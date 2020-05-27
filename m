Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D4DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF3620663
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403877AbgE0Rnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:43:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:55236 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391453AbgE0Rnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:43:50 -0400
IronPort-SDR: fIIk39CfVew+EtQ4MMiIUrL4J5TzT31e7/Flafig/FBzfdkMY04pLtsOS/9zhPBDGvTwYyjgDh
 Juwk2WtQxuIQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 10:43:49 -0700
IronPort-SDR: erCG3ZktNKXYIFXv/NSmpD059H/RNZTYzSIAgOSgKlAvKp9gpKWE1C52DzlE0zrVNloApSqvco
 /MQ8H14Jnkcg==
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400"; 
   d="scan'208";a="442612545"
Received: from igherghx-mobl.ger.corp.intel.com ([10.252.8.19])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 10:43:47 -0700
Message-ID: <561ea2aabf919ef332ec0165351791f6148e8597.camel@linux.intel.com>
Subject: Re: [PATCH 1/1] soc: keembay: Add Keem Bay IMR driver
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "pavel@ucw.cz" <pavel@ucw.cz>, "robh@kernel.org" <robh@kernel.org>,
        "Murphy, Paul J" <paul.j.murphy@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 27 May 2020 18:43:43 +0100
In-Reply-To: <CAK8P3a2MzqF3P8nY3hAUaAXhTV8ZGQd187UDbNV1GBdu+_z5-g@mail.gmail.com>
References: <cover.1587485099.git.daniele.alessandrelli@intel.com>
         <13ca92165fab2827b6d439661e75f5b91ef083c2.1587485099.git.daniele.alessandrelli@intel.com>
         <20200501081002.GA1055721@kroah.com>
         <f60aece195cd0700728fc38b0398949a82b72fc3.camel@linux.intel.com>
         <20200524212851.GG1192@bug>
         <CAK8P3a225pqBfzQ19e6Gt0s_tYBp29xLb8EG==hhz=1wc7aVCA@mail.gmail.com>
         <ac0534138facc25c4cbcbbff68fc0ba3c2de87b6.camel@linux.intel.com>
         <CAK8P3a2MzqF3P8nY3hAUaAXhTV8ZGQd187UDbNV1GBdu+_z5-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-05-27 at 16:33 +0200, Arnd Bergmann wrote:
> On Wed, May 27, 2020 at 3:31 PM Alessandrelli, Daniele
> <daniele.alessandrelli@intel.com> wrote:
> > > > Alternatively, take that memory off the "memory available"
> > > > maps,
> > > > and only re-add it once
> > > > it is usable.
> > > > 
> > > > Anything else is dangerous.
> > 
> > That sounds like an interesting solution, thanks!
> > 
> > Do you know any code that I can use as a reference?
> > 
> > Since, the protected memory is just a few megabytes large, I guess
> > that
> > in theory we could just have U-Boot mark it as reserved memory and
> > forget about it; but if there's a way to re-add it back once in
> > Linux
> > that would be great.
> 
> Adding it back later on with a loadable device driver should
> not be a problem, as this is not a violation of the boot protocol.

Cool, I'll try to do that then, thanks!

I see two ways to do that though:

1. Create a device driver that gets a reference to the memory region
from its DT node and then re-adds the memory to the pool of available
memory.

2. Use a special "compatible" string for my memory region and create a
driver to handle it.

However, I think that in the second case the driver must be builtin.
Would that be okay?

Also, from a quick look, it seems that I can re-add that memory back by
calling memblock_free() (or a similar memblock_* function). Am I on the
right track?

> 
> > > Agreed, this sounds like an incompatible extension of the boot
> > > protocol that we should otherwise not merge.
> > > 
> > > However, there is also a lot of missing information here, and it
> > > is
> > > always possible they are trying to something for a good reason.
> > > As long as the problem that the bootloader is trying to solve is
> > > explained well enough in the changelog, we can discuss it to see
> > > how it should be done properly.
> > 
> > Apologies, I should have provided more information. Here it is :)
> > 
> > Basically, at boot time U-Boot code and core memory (.text, .data,
> > .bss, etc.) is protected by this Isolated Memory Region (IMR) which
> > prevents any device or processing units other than the ARM CPU to
> > access/modify the memory.
> > 
> > This is done for security reasons, to reduce the risks that a
> > potential
> > attacker can use "hijacked" HW devices to interfere with the boot
> > process (and break the secure boot flow in place).
> > 
> > Before booting the Kernel, U-Boot sets up a new IMR to protect the
> > Kernel image (so that the kernel can benefit of a similar
> > protection)
> > and then starts the kernel, delegating to the kernel the task of
> > switching off the U-Boot IMR.
> > 
> > U-Boot doesn't turn off its own IMR because doing so would leave a
> > (tiny) window in which the boot execution flow is not protected.
> > 
> > If you have any additional questions or feedback, just let me know.
> 
> Thank you for the detailed explanation. I've never seen this done
> in the Linux boot flow, but I can see how it helps prevent certain
> kinds of attacks.
> 
> It seems that just reserving the u-boot area and optionally
> freeing it later from a driver solves most of your problem.
> I have one related question though: if the kernel itself is
> protected, does that mean that any driver that does a DMA
> to statically allocated memory inside of the kernel is broken
> as well? I think this is something that a couple of USB drivers
> do, though it is fairly rare. Does u-boot protect both only
> the executable sections of the kernel or also data, and does
> the hardware block both read and write on the IMR, or just
> writes?

Yes, you're very right. Drivers that do DMA transfers to statically
allocated memory inside the kernel will be broken.

We are currently seeing this with our eMMC driver.

Current solution is to add the eMMC controller to the list of allowed
"agents" for the IMR. This will reduce the level of protection, but
since we expect to have only a few of these exceptions (since, as you
pointed out, drivers that do DMA to static kernel memory seem to be
quite rare), we think that there is still value in having the Kernel
IMR.

Do you see any issue with this?

Regards,
Daniele

