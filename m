Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FE6C4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE3E24689
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cftMV6Mw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgBZOPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:15:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55991 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727196AbgBZOPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582726540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YYiCS+eVcBTRrN3rvxTuVWGNNaComENKS9pPobuvmFM=;
        b=cftMV6MwSQWVmU5FPbuZCQ/30+rMNnURJyvDUr44gGUxK6eKAM6Ll6h/w4A+ABObAhILzS
        8HmkN+cJrAI6az00/IjVdXVY+IAAbxpgm2he3ePc4K9CsHZjJCg6iAeb5qtS5r9OvwRCog
        GpJD9g+nedK/J/zkSLsMohXz0brwh5c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-4OI28YrhOUmjxY_Ewb49Ww-1; Wed, 26 Feb 2020 09:15:32 -0500
X-MC-Unique: 4OI28YrhOUmjxY_Ewb49Ww-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBEAA8C8B4B;
        Wed, 26 Feb 2020 14:15:27 +0000 (UTC)
Received: from localhost (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 60C9560BE1;
        Wed, 26 Feb 2020 14:15:26 +0000 (UTC)
Date:   Wed, 26 Feb 2020 22:15:23 +0800
From:   'Baoquan He' <bhe@redhat.com>
To:     Greg Kurz <groug@kaod.org>
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
        =?iso-8859-1?Q?'C=E9dric?= Le Goater' <clg@kaod.org>,
        'Anju T Sudhakar' <anju@linux.vnet.ibm.com>,
        'Hari Bathini' <hbathini@linux.ibm.com>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Nicholas Piggin' <npiggin@gmail.com>,
        'Masahiro Yamada' <yamada.masahiro@socionext.com>,
        'Alexey Kardashevskiy' <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 04/27] ocxl: Remove unnecessary externs
Message-ID: <20200226141523.GI4937@MiWiFi-R3L-srv>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-5-alastair@au1.ibm.com>
 <20200226081447.GH4937@MiWiFi-R3L-srv>
 <4d49801d5ec7e$7a3e8610$6ebb9230$@d-silva.org>
 <20200226100102.0aab7dda@bahia.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200226100102.0aab7dda@bahia.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/26/20 at 10:01am, Greg Kurz wrote:
> On Wed, 26 Feb 2020 19:26:34 +1100
> "Alastair D'Silva" <alastair@d-silva.org> wrote:
>=20
> > > -----Original Message-----
> > > From: Baoquan He <bhe@redhat.com>
> > > Sent: Wednesday, 26 February 2020 7:15 PM
> > > To: Alastair D'Silva <alastair@au1.ibm.com>
> > > Cc: alastair@d-silva.org; Aneesh Kumar K . V
> > > <aneesh.kumar@linux.ibm.com>; Oliver O'Halloran <oohall@gmail.com>;
> > > Benjamin Herrenschmidt <benh@kernel.crashing.org>; Paul Mackerras
> > > <paulus@samba.org>; Michael Ellerman <mpe@ellerman.id.au>; Frederic
> > > Barrat <fbarrat@linux.ibm.com>; Andrew Donnellan <ajd@linux.ibm.com=
>;
> > > Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org>; Dan Williams <dan.j.williams@intel.co=
m>;
> > > Vishal Verma <vishal.l.verma@intel.com>; Dave Jiang
> > > <dave.jiang@intel.com>; Ira Weiny <ira.weiny@intel.com>; Andrew Mor=
ton
> > > <akpm@linux-foundation.org>; Mauro Carvalho Chehab
> > > <mchehab+samsung@kernel.org>; David S. Miller <davem@davemloft.net>=
;
> > > Rob Herring <robh@kernel.org>; Anton Blanchard <anton@ozlabs.org>;
> > > Krzysztof Kozlowski <krzk@kernel.org>; Mahesh Salgaonkar
> > > <mahesh@linux.vnet.ibm.com>; Madhavan Srinivasan
> > > <maddy@linux.vnet.ibm.com>; C=E9dric Le Goater <clg@kaod.org>; Anju=
 T
> > > Sudhakar <anju@linux.vnet.ibm.com>; Hari Bathini
> > > <hbathini@linux.ibm.com>; Thomas Gleixner <tglx@linutronix.de>; Gre=
g
> > > Kurz <groug@kaod.org>; Nicholas Piggin <npiggin@gmail.com>; Masahir=
o
> > > Yamada <yamada.masahiro@socionext.com>; Alexey Kardashevskiy
> > > <aik@ozlabs.ru>; linux-kernel@vger.kernel.org; linuxppc-
> > > dev@lists.ozlabs.org; linux-nvdimm@lists.01.org; linux-mm@kvack.org
> > > Subject: Re: [PATCH v3 04/27] ocxl: Remove unnecessary externs
> > >=20
> > > On 02/21/20 at 02:26pm, Alastair D'Silva wrote:
> > > > From: Alastair D'Silva <alastair@d-silva.org>
> > > >
> > > > Function declarations don't need externs, remove the existing one=
s so
> > > > they are consistent with newer code
> > > >
> > > > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > > > ---
> > > >  arch/powerpc/include/asm/pnv-ocxl.h | 32 ++++++++++++++---------=
------
> > > >  include/misc/ocxl.h                 |  6 +++---
> > > >  2 files changed, 18 insertions(+), 20 deletions(-)
> > > >
> > > > diff --git a/arch/powerpc/include/asm/pnv-ocxl.h
> > > > b/arch/powerpc/include/asm/pnv-ocxl.h
> > > > index 0b2a6707e555..b23c99bc0c84 100644
> > > > --- a/arch/powerpc/include/asm/pnv-ocxl.h
> > > > +++ b/arch/powerpc/include/asm/pnv-ocxl.h
> > > > @@ -9,29 +9,27 @@
> > > >  #define PNV_OCXL_TL_BITS_PER_RATE       4
> > > >  #define PNV_OCXL_TL_RATE_BUF_SIZE
> > > ((PNV_OCXL_TL_MAX_TEMPLATE+1) * PNV_OCXL_TL_BITS_PER_RATE / 8)
> > > >
> > > > -extern int pnv_ocxl_get_actag(struct pci_dev *dev, u16 *base, u1=
6
> > > *enabled,
> > > > -			u16 *supported);
> > >=20
> > > It works w or w/o extern when declare functions. Searching 'extern'
> > > under include can find so many functions with 'extern' adding. Do w=
e have
> > a
> > > explicit standard if we should add or remove 'exter' in function
> > declaration?
> > >=20
> > > I have no objection to this patch, just want to make clear so that =
I can
> > handle
> > > it w/o confusion.
> > >=20
> > > Thanks
> > > Baoquan
> > >=20
> >=20
> > For the OpenCAPI driver, we have settled on not having 'extern' on
> > functions.
> >=20
> > I don't think I've seen a standard that supports or refutes this, but=
 it
> > does not value add.
> >=20
>=20
> FWIW this is a warning condition for checkpatch:
>=20
> $ ./scripts/checkpatch.pl --strict -f include/misc/ocxl.h

Good to know, thanks.

I didn't know checkpatch.pl can run on header file directly. Tried to
check patch with '--strict -f', the below info doesn't appear. But it
does give out below information when run on header file.

>=20
> [...]
>=20
> CHECK: extern prototypes should be avoided in .h files
> #176: FILE: include/misc/ocxl.h:176:
> +extern int ocxl_afu_irq_alloc(struct ocxl_context *ctx, int *irq_id);
>=20
> [...]
>=20

