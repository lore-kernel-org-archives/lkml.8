Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D322C2D0F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 01:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5492072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 01:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733182AbgDBBbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 21:31:46 -0400
Received: from smtprelay0003.hostedemail.com ([216.40.44.3]:35042 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732462AbgDBBbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 21:31:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 0FB2E1802914A;
        Thu,  2 Apr 2020 01:31:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: magic31_e7601e651344
X-Filterd-Recvd-Size: 4003
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu,  2 Apr 2020 01:31:39 +0000 (UTC)
Message-ID: <aac1e71953b564d48f2d1288e50924ebd7e3e98a.camel@perches.com>
Subject: Re: [PATCH v4 08/25] ocxl: Emit a log message showing how much LPC
 memory was detected
From:   Joe Perches <joe@perches.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Alastair D'Silva <alastair@d-silva.org>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
        =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
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
Date:   Wed, 01 Apr 2020 18:29:42 -0700
In-Reply-To: <CAPcyv4j4_owxEVjanwH5TiuMMJB3CaMannDzpXnaHedX7LuarQ@mail.gmail.com>
References: <20200327071202.2159885-1-alastair@d-silva.org>
         <20200327071202.2159885-9-alastair@d-silva.org>
         <CAPcyv4j4_owxEVjanwH5TiuMMJB3CaMannDzpXnaHedX7LuarQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-01 at 01:49 -0700, Dan Williams wrote:
> On Sun, Mar 29, 2020 at 10:23 PM Alastair D'Silva <alastair@d-silva.org> wrote:
> > This patch emits a message showing how much LPC memory & special purpose
> > memory was detected on an OCXL device.
[]
> > diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
[]
> > @@ -568,6 +568,10 @@ static int read_afu_lpc_memory_info(struct pci_dev *dev,
> >                 afu->special_purpose_mem_size =
> >                         total_mem_size - lpc_mem_size;
> >         }
> > +
> > +       dev_info(&dev->dev, "Probed LPC memory of %#llx bytes and special purpose memory of %#llx bytes\n",
> > +                afu->lpc_mem_size, afu->special_purpose_mem_size);
> 
> A patch for a single log message is too fine grained for my taste,
> let's squash this into another patch in the series.

Is the granularity of lpc_mem_size actually bytes?
Might this be better as KiB or something using functions

Maybe something like:

unsigned long si_val(unsigned long val)
{
	static const char units[] = "BKMGTPE";
	const char *unit = units;

	while (!(val & 1023) && unit[1]) {
		val >>= 10;
		unit++;
	}

	return val;
}

char si_type(unsigned long val)
{
	static const char units[] = "BKMGTPE";
	const char *unit = units;

	while (!(val & 1023) && unit[1]) {
		val >>= 10;
		unit++;
	}

	return *unit;
}

so this could be something like:

       dev_info(&dev->dev, "Probed LPC memory of %#llu%c and special purpose memory of %#llu%c\n",
                si_val(afu->lpc_mem_size), si_type(afu->lpc_mem_size),
		si_val(afu->special_purpose_mem_size), si_type(afu->special_purpose_mem_size));



