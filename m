Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AC0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D52C20674
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgGGVSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:18:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:58260 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgGGVSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:18:06 -0400
IronPort-SDR: s08QEwv3Tis1s8fIIQmxFOmcNfS/oOHKSwOobsijONUi75HG3JuO37qapZ/eA9hLKG9XNUjZlr
 fIajMym15BCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="135156634"
X-IronPort-AV: E=Sophos;i="5.75,325,1589266800"; 
   d="scan'208";a="135156634"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 14:18:05 -0700
IronPort-SDR: TIfrxbVcaGC/Pu9TN9IpJNJmxgIP0bJlPax8eK6fgIyhwWU8XtEYaojbmBgmUfe0DnbAXgdFqg
 Zsv/bEV3x8FA==
X-IronPort-AV: E=Sophos;i="5.75,325,1589266800"; 
   d="scan'208";a="427613055"
Received: from andreead-mobl1.ti.intel.com ([10.252.18.211])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 14:18:01 -0700
Message-ID: <08b2713a6f87f78746c22e7168f4813eb753bb0e.camel@linux.intel.com>
Subject: Re: [PATCH 0/7] Add initial Keem Bay SoC / Board support
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Paul Murphy <paul.j.murphy@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Date:   Tue, 07 Jul 2020 22:17:59 +0100
In-Reply-To: <CABb+yY0eUG=bxrQHP9-5gHk7SYF=c+EE+0LGKhnpxgfr078n6w@mail.gmail.com>
References: <20200616155613.121242-1-daniele.alessandrelli@linux.intel.com>
         <CABb+yY0eUG=bxrQHP9-5gHk7SYF=c+EE+0LGKhnpxgfr078n6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-07-05 at 23:36 -0500, Jassi Brar wrote:
> On Tue, Jun 16, 2020 at 10:56 AM Daniele Alessandrelli
> <daniele.alessandrelli@linux.intel.com> wrote:
> > Hi,
> > 
> > This patch-set adds initial support for a new Intel Movidius SoC
> > code-named
> > Keem Bay. The SoC couples an ARM Cortex A53 CPU with an Intel
> > Movidius VPU.
> > 
> > This initial patch-set enables only the minimal set of components
> > required to
> > make the Keem Bay EVM board boot into initramfs.
> > 
> > Brief summary of the patch-set:
> > * Patches 1-2 add the Keem Bay SCMI Mailbox driver (needed to
> > enable SCMI in
> >   Keem Bay)
> > * Patch 3 adds the ARCH_KEEMBAY config option
> > * Patches 4-7 add minimal device tree for Keem Bay SoC and Keem Bay
> > EVM
> >   (together with information about the SoC maintainers)
> > 
> Please break this into two patchsets - first enabling platform
> support
> and second adding mailbox support.

Thanks for your feedback Jassi. I will split the patcheset into two
different patchsets.

Just one question: should I remove the mailbox and scmi nodes from the
soc DT or can I keep them there even if the mailbox driver is not
available yet?

> 
> thanks.

