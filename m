Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03661C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 11:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D071C206D3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 11:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388109AbgDBLsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 07:48:45 -0400
Received: from 20.mo1.mail-out.ovh.net ([188.165.45.168]:60602 "EHLO
        20.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387477AbgDBLsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 07:48:45 -0400
X-Greylist: delayed 2268 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Apr 2020 07:48:44 EDT
Received: from player697.ha.ovh.net (unknown [10.110.208.99])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id 256871B9F36
        for <linux-kernel@vger.kernel.org>; Thu,  2 Apr 2020 13:10:55 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player697.ha.ovh.net (Postfix) with ESMTPSA id AEBE3110DE660;
        Thu,  2 Apr 2020 11:10:14 +0000 (UTC)
Date:   Thu, 2 Apr 2020 13:10:12 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Oliver O'Halloran <oohall@gmail.com>,
        Alastair D'Silva <alastair@d-silva.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH v4 00/25] Add support for OpenCAPI Persistent Memory
 devices
Message-ID: <20200402131012.579c7bf7@bahia.lan>
In-Reply-To: <87bloatd6e.fsf@mpe.ellerman.id.au>
References: <20200327071202.2159885-1-alastair@d-silva.org>
        <CAPcyv4iJYZBVhV1NW7EB6-EwETiUAy6r1iiE+F+HvFXfGZt9Aw@mail.gmail.com>
        <2d6901d60877$16aa7a90$43ff6fb0$@d-silva.org>
        <87imiituxm.fsf@mpe.ellerman.id.au>
        <CAOSf1CHdpFyT_6zetKM6eHDK3AT8-UNTzjdd2y+QqYT2AO9VDw@mail.gmail.com>
        <87bloatd6e.fsf@mpe.ellerman.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14428970257110833585
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -51
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrtdeggdefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgihhthhhusgdrihhonecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Apr 2020 21:06:01 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> "Oliver O'Halloran" <oohall@gmail.com> writes:
> > On Thu, Apr 2, 2020 at 2:42 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >> "Alastair D'Silva" <alastair@d-silva.org> writes:
> >> >> -----Original Message-----
> >> >> From: Dan Williams <dan.j.williams@intel.com>
> >> >>
> >> >> On Sun, Mar 29, 2020 at 10:23 PM Alastair D'Silva <alastair@d-silva.org>
> >> >> wrote:
> >> >> >
> >> >> > *snip*
> >> >> Are OPAL calls similar to ACPI DSMs? I.e. methods for the OS to invoke
> >> >> platform firmware services? What's Skiboot?
> >> >
> >> > Yes, OPAL is the interface to firmware for POWER. Skiboot is the open-source (and only) implementation of OPAL.
> >>
> >>   https://github.com/open-power/skiboot
> >>
> >> In particular the tokens for calls are defined here:
> >>
> >>   https://github.com/open-power/skiboot/blob/master/include/opal-api.h#L220
> >>
> >> And you can grep for the token to find the implementation:
> >>
> >>   https://github.com/open-power/skiboot/blob/master/hw/npu2-opencapi.c#L2328
> >
> > I'm not sure I'd encourage anyone to read npu2-opencapi.c. I find it
> > hard enough to follow even with access to the workbooks.
> 
> Compared to certain firmwares that run on certain other platforms it's
> actually pretty readable code ;)
> 

Forth rocks ! ;-)

> > There's an OPAL call API reference here:
> > http://open-power.github.io/skiboot/doc/opal-api/index.html
> 
> Even better.
> 
> cheers

