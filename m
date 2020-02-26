Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C72C4BA1E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B744224656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgBZR4n convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:56:43 -0500
Received: from 11.mo1.mail-out.ovh.net ([188.165.48.29]:53561 "EHLO
        11.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgBZR4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:56:43 -0500
X-Greylist: delayed 4197 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Feb 2020 12:56:41 EST
Received: from player157.ha.ovh.net (unknown [10.108.42.142])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id E6D5E1A4165
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 15:21:35 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player157.ha.ovh.net (Postfix) with ESMTPSA id 898E0FCD5725;
        Wed, 26 Feb 2020 14:20:52 +0000 (UTC)
Date:   Wed, 26 Feb 2020 15:20:50 +0100
From:   Greg Kurz <groug@kaod.org>
To:     'Baoquan He' <bhe@redhat.com>
Cc:     Alastair D'Silva <alastair@d-silva.org>,
        'Alastair D'Silva' <alastair@au1.ibm.com>,
        "'Aneesh Kumar K . V'" <aneesh.kumar@linux.ibm.com>,
        'Oliver O'Halloran' <oohall@gmail.com>,
        'Benjamin Herrenschmidt' <benh@kernel.crashing.org>,
        'Paul Mackerras' <paulus@samba.org>,
        'Michael Ellerman' <mpe@ellerman.id.au>,
        'Frederic Barrat' <fbarrat@linux.ibm.com>,
        'Andrew Donnellan' <ajd@linux.ibm.com>,
        'Arnd Bergmann' <arnd@arndb.de>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Dan Williams' <dan.j.williams@intel.com>,
        'Vishal Verma' <vishal.l.verma@intel.com>,
        'Dave Jiang' <dave.jiang@intel.com>,
        'Ira Weiny' <ira.weiny@intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>,
        "'David S. Miller'" <davem@davemloft.net>,
        'Rob Herring' <robh@kernel.org>,
        'Anton Blanchard' <anton@ozlabs.org>,
        'Krzysztof Kozlowski' <krzk@kernel.org>,
        'Mahesh Salgaonkar' <mahesh@linux.vnet.ibm.com>,
        'Madhavan Srinivasan' <maddy@linux.vnet.ibm.com>,
        =?UTF-8?B?J0PDqWRyaWM=?= Le Goater' <clg@kaod.org>,
        'Anju T Sudhakar' <anju@linux.vnet.ibm.com>,
        'Hari Bathini' <hbathini@linux.ibm.com>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Nicholas Piggin' <npiggin@gmail.com>,
        'Masahiro Yamada' <yamada.masahiro@socionext.com>,
        'Alexey Kardashevskiy' <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 04/27] ocxl: Remove unnecessary externs
Message-ID: <20200226152050.45547219@bahia.home>
In-Reply-To: <20200226141523.GI4937@MiWiFi-R3L-srv>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
        <20200221032720.33893-5-alastair@au1.ibm.com>
        <20200226081447.GH4937@MiWiFi-R3L-srv>
        <4d49801d5ec7e$7a3e8610$6ebb9230$@d-silva.org>
        <20200226100102.0aab7dda@bahia.home>
        <20200226141523.GI4937@MiWiFi-R3L-srv>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Ovh-Tracer-Id: 9146529370105485748
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrleeggdeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqheftdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrudehjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020 22:15:23 +0800
'Baoquan He' <bhe@redhat.com> wrote:

> On 02/26/20 at 10:01am, Greg Kurz wrote:
> > On Wed, 26 Feb 2020 19:26:34 +1100
> > "Alastair D'Silva" <alastair@d-silva.org> wrote:
> > 
> > > > -----Original Message-----
> > > > From: Baoquan He <bhe@redhat.com>
> > > > Sent: Wednesday, 26 February 2020 7:15 PM
> > > > To: Alastair D'Silva <alastair@au1.ibm.com>
> > > > Cc: alastair@d-silva.org; Aneesh Kumar K . V
> > > > <aneesh.kumar@linux.ibm.com>; Oliver O'Halloran <oohall@gmail.com>;
> > > > Benjamin Herrenschmidt <benh@kernel.crashing.org>; Paul Mackerras
> > > > <paulus@samba.org>; Michael Ellerman <mpe@ellerman.id.au>; Frederic
> > > > Barrat <fbarrat@linux.ibm.com>; Andrew Donnellan <ajd@linux.ibm.com>;
> > > > Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org>; Dan Williams <dan.j.williams@intel.com>;
> > > > Vishal Verma <vishal.l.verma@intel.com>; Dave Jiang
> > > > <dave.jiang@intel.com>; Ira Weiny <ira.weiny@intel.com>; Andrew Morton
> > > > <akpm@linux-foundation.org>; Mauro Carvalho Chehab
> > > > <mchehab+samsung@kernel.org>; David S. Miller <davem@davemloft.net>;
> > > > Rob Herring <robh@kernel.org>; Anton Blanchard <anton@ozlabs.org>;
> > > > Krzysztof Kozlowski <krzk@kernel.org>; Mahesh Salgaonkar
> > > > <mahesh@linux.vnet.ibm.com>; Madhavan Srinivasan
> > > > <maddy@linux.vnet.ibm.com>; Cédric Le Goater <clg@kaod.org>; Anju T
> > > > Sudhakar <anju@linux.vnet.ibm.com>; Hari Bathini
> > > > <hbathini@linux.ibm.com>; Thomas Gleixner <tglx@linutronix.de>; Greg
> > > > Kurz <groug@kaod.org>; Nicholas Piggin <npiggin@gmail.com>; Masahiro
> > > > Yamada <yamada.masahiro@socionext.com>; Alexey Kardashevskiy
> > > > <aik@ozlabs.ru>; linux-kernel@vger.kernel.org; linuxppc-
> > > > dev@lists.ozlabs.org; linux-nvdimm@lists.01.org; linux-mm@kvack.org
> > > > Subject: Re: [PATCH v3 04/27] ocxl: Remove unnecessary externs
> > > > 
> > > > On 02/21/20 at 02:26pm, Alastair D'Silva wrote:
> > > > > From: Alastair D'Silva <alastair@d-silva.org>
> > > > >
> > > > > Function declarations don't need externs, remove the existing ones so
> > > > > they are consistent with newer code
> > > > >
> > > > > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > > > > ---
> > > > >  arch/powerpc/include/asm/pnv-ocxl.h | 32 ++++++++++++++---------------
> > > > >  include/misc/ocxl.h                 |  6 +++---
> > > > >  2 files changed, 18 insertions(+), 20 deletions(-)
> > > > >
> > > > > diff --git a/arch/powerpc/include/asm/pnv-ocxl.h
> > > > > b/arch/powerpc/include/asm/pnv-ocxl.h
> > > > > index 0b2a6707e555..b23c99bc0c84 100644
> > > > > --- a/arch/powerpc/include/asm/pnv-ocxl.h
> > > > > +++ b/arch/powerpc/include/asm/pnv-ocxl.h
> > > > > @@ -9,29 +9,27 @@
> > > > >  #define PNV_OCXL_TL_BITS_PER_RATE       4
> > > > >  #define PNV_OCXL_TL_RATE_BUF_SIZE
> > > > ((PNV_OCXL_TL_MAX_TEMPLATE+1) * PNV_OCXL_TL_BITS_PER_RATE / 8)
> > > > >
> > > > > -extern int pnv_ocxl_get_actag(struct pci_dev *dev, u16 *base, u16
> > > > *enabled,
> > > > > -			u16 *supported);
> > > > 
> > > > It works w or w/o extern when declare functions. Searching 'extern'
> > > > under include can find so many functions with 'extern' adding. Do we have
> > > a
> > > > explicit standard if we should add or remove 'exter' in function
> > > declaration?
> > > > 
> > > > I have no objection to this patch, just want to make clear so that I can
> > > handle
> > > > it w/o confusion.
> > > > 
> > > > Thanks
> > > > Baoquan
> > > > 
> > > 
> > > For the OpenCAPI driver, we have settled on not having 'extern' on
> > > functions.
> > > 
> > > I don't think I've seen a standard that supports or refutes this, but it
> > > does not value add.
> > > 
> > 
> > FWIW this is a warning condition for checkpatch:
> > 
> > $ ./scripts/checkpatch.pl --strict -f include/misc/ocxl.h
> 
> Good to know, thanks.
> 
> I didn't know checkpatch.pl can run on header file directly. Tried to
> check patch with '--strict -f', the below info doesn't appear. But it

Hmm... -f is to check a source file, not a patch... What did you try
exactly ?

> does give out below information when run on header file.
> 
> > 
> > [...]
> > 
> > CHECK: extern prototypes should be avoided in .h files
> > #176: FILE: include/misc/ocxl.h:176:
> > +extern int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id);
> > 
> > [...]
> > 
> 

