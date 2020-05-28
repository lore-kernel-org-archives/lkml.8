Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F112DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB885212CC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389699AbgE1M1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:27:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:16903 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389675AbgE1M1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:27:48 -0400
IronPort-SDR: 2/IcI2OulU+JkRWr4ee1//DzNP1rDu5GlecFYz2P5gt6Oqy5g+LtiGPdQ9B+puqGjNZwEZmDGg
 v6gHTE7CMDzg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 05:27:47 -0700
IronPort-SDR: MypxDfRB2sIs9htk4yaWbvhBd0aSzxNRN/zYKyd8SIU1VEb5RwfVdabVJJ3mjW5Z5NcGn5h4BM
 ZOWQwuVFk+VQ==
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="442931475"
Received: from cmccarth-mobl.ger.corp.intel.com ([10.252.7.149])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 05:27:43 -0700
Message-ID: <0d5fd14a0641b5ac2ed880da1b03458608116058.camel@linux.intel.com>
Subject: Re: [PATCH 1/1] soc: keembay: Add Keem Bay IMR driver
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "pavel@ucw.cz" <pavel@ucw.cz>, "robh@kernel.org" <robh@kernel.org>,
        "Murphy, Paul J" <paul.j.murphy@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 28 May 2020 13:27:40 +0100
In-Reply-To: <CAK8P3a0OK+BRF2t=8V6Pa95b6Ldcfn3AP1VM+GSsruGRVH=MXQ@mail.gmail.com>
References: <cover.1587485099.git.daniele.alessandrelli@intel.com>
         <13ca92165fab2827b6d439661e75f5b91ef083c2.1587485099.git.daniele.alessandrelli@intel.com>
         <20200501081002.GA1055721@kroah.com>
         <f60aece195cd0700728fc38b0398949a82b72fc3.camel@linux.intel.com>
         <20200524212851.GG1192@bug>
         <CAK8P3a225pqBfzQ19e6Gt0s_tYBp29xLb8EG==hhz=1wc7aVCA@mail.gmail.com>
         <ac0534138facc25c4cbcbbff68fc0ba3c2de87b6.camel@linux.intel.com>
         <CAK8P3a2MzqF3P8nY3hAUaAXhTV8ZGQd187UDbNV1GBdu+_z5-g@mail.gmail.com>
         <561ea2aabf919ef332ec0165351791f6148e8597.camel@linux.intel.com>
         <CAK8P3a0OK+BRF2t=8V6Pa95b6Ldcfn3AP1VM+GSsruGRVH=MXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-05-27 at 20:59 +0200, Arnd Bergmann wrote:
> On Wed, May 27, 2020 at 7:43 PM Daniele Alessandrelli
> <daniele.alessandrelli@linux.intel.com> wrote:
> > On Wed, 2020-05-27 at 16:33 +0200, Arnd Bergmann wrote:
> > > On Wed, May 27, 2020 at 3:31 PM Alessandrelli, Daniele <
> > > daniele.alessandrelli@intel.com> wrote:
> > > 
> > > Adding it back later on with a loadable device driver should
> > > not be a problem, as this is not a violation of the boot
> > > protocol.
> > 
> > Cool, I'll try to do that then, thanks!
> > 
> > I see two ways to do that though:
> > 
> > 1. Create a device driver that gets a reference to the memory
> > region
> > from its DT node and then re-adds the memory to the pool of
> > available
> > memory.
> > 
> > 2. Use a special "compatible" string for my memory region and
> > create a
> > driver to handle it.
> 
> I think the first approach is more common.
> 
> > However, I think that in the second case the driver must be
> > builtin.
> > Would that be okay?
> 
> It's better to avoid that.
> 
> > Also, from a quick look, it seems that I can re-add that memory
> > back by
> > calling memblock_free() (or a similar memblock_* function). Am I on
> > the
> > right track?
> 
> I'm not sure if memblock_free() works after early memory
> initialization
> is complete, but I think there is some way to do it later. Maybe try
> memblock_free() first, and then look for something else if it doesn't
> work.
> 

Brilliant. I will create a new patch using the 1st approach and see if
memblock_free() works; if not, I will look for something else.

Thanks a lot for your valuable feedback and advice.

> > > It seems that just reserving the u-boot area and optionally
> > > freeing it later from a driver solves most of your problem.
> > > I have one related question though: if the kernel itself is
> > > protected, does that mean that any driver that does a DMA
> > > to statically allocated memory inside of the kernel is broken
> > > as well? I think this is something that a couple of USB drivers
> > > do, though it is fairly rare. Does u-boot protect both only
> > > the executable sections of the kernel or also data, and does
> > > the hardware block both read and write on the IMR, or just
> > > writes?
> > 
> > Yes, you're very right. Drivers that do DMA transfers to statically
> > allocated memory inside the kernel will be broken.
> > 
> > We are currently seeing this with our eMMC driver.
> > 
> > Current solution is to add the eMMC controller to the list of
> > allowed
> > "agents" for the IMR. This will reduce the level of protection, but
> > since we expect to have only a few of these exceptions (since, as
> > you
> > pointed out, drivers that do DMA to static kernel memory seem to be
> > quite rare), we think that there is still value in having the
> > Kernel
> > IMR.
> > 
> > Do you see any issue with this?
> 
> I think you should try to fix the driver rather than making an
> exception for it.

Yes, we'll look into that.

> Hot-pluggable drivers are a much more interesting
> case I think, because on the one hand you have no idea what
> users might want to plug in legitimately, but on the other hand
> those are also the most likely attack vectors (driver bugs for
> random USB drivers overwriting kernel memory when faced with
> malicious hardware) that this feature is trying to prevent.
> 
> I also wonder whether we should do something in the normal
> iommu code that prevents one from mapping a page that the
> kernel would consider as protected (kernel .text, freed memory,
> ...) into the iommu in the first place.

Sounds like an iteresting security feature; expecially because it would
apply to any hardware.

> 
>         Arnd



