Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA5FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528E4207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Vsp7iefS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbgDCE1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 00:27:42 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36207 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgDCE1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 00:27:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48tn3F11cNz9sRR;
        Fri,  3 Apr 2020 15:27:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1585888059;
        bh=P6pDV2mWC3/QGwHFGntoCWhQeeo1qFFM1tqWOPVJ5GQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Vsp7iefSuq2qUc2BqgDgoqQSz9nPDU/JrItc+oEyG61KFugv7uQPx8toJGFzcyDE9
         fbHOnTwHuQ5nU9Y2XDcNSY0Z2d2hDCzlqQhElxnt0lWMHCdM5Xj8YLhG/Gvt02ZsjQ
         H2QG7o77rzF7weuVSVcwCohP50hpM4jeI0X/jbE8sTucOI8vacLjjbZb6LfDQZrQvF
         s44uAO8q4NgYv5YD8W76eyM++ks7SvH51Mshmbfai8akqeelai+Lq2HG+OMgjeqjzs
         QWv7sKW0TVJeK8e+qAjnA0G4PeqL7511jU+g7m3hAZHA3+DqAaMDtXDp7bogX/2lG5
         13TfLzlBAQuTQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alastair D'Silva <alastair@d-silva.org>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
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
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH v4 03/25] powerpc/powernv: Map & release OpenCAPI LPC memory
In-Reply-To: <f763d9d8487e77006b233bc16e0883f956850b6c.camel@kernel.crashing.org>
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-4-alastair@d-silva.org> <CAPcyv4iGEHJpZctEm+Do1-kOZBUDeKKcREr=BqcK4kCvLWhAQQ@mail.gmail.com> <f763d9d8487e77006b233bc16e0883f956850b6c.camel@kernel.crashing.org>
Date:   Fri, 03 Apr 2020 15:27:46 +1100
Message-ID: <87v9mhry65.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> On Wed, 2020-04-01 at 01:48 -0700, Dan Williams wrote:
>> > 
>> > +u64 pnv_ocxl_platform_lpc_setup(struct pci_dev *pdev, u64 size)
>> > +{
>> > +       struct pci_controller *hose = pci_bus_to_host(pdev->bus);
>> > +       struct pnv_phb *phb = hose->private_data;
>> 
>> Is calling the local variable 'hose' instead of 'host' on purpose?
>
> Haha that's funny :-)
>
> It's an oooooooold usage that comes iirc from sparc ? or maybe alpha ?

Yeah it was alpha, I found it in the history tree:

  https://github.com/mpe/linux-fullhistory/blob/1928de59ba4209dc5e9f2cef63560c09ba0df73b/arch/alpha/kernel/mcpcia.c

And airlied found an old manual which confirms it:

  The TIOP module interfaces the AlphaServer 8000 system bus to four I/O channels, called "hoses."

  https://www.hpl.hp.com/hpjournal/dtj/vol7num1/vol7num1art4.pdf


So at least now we know where it comes from.

It's also used widely in mips, microblaze, sh and a little bit in drm.

cheers
