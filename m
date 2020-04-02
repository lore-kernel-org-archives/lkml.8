Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E288AC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 04:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0FC20757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 04:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="BHYxjj87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgDBEeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 00:34:00 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:60628 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgDBEeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 00:34:00 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id 010C02DC3330;
        Thu,  2 Apr 2020 15:33:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1585802039;
        bh=WyxkApmW2+/IWEqXKjwy7I58nLQNzwtikErBlXfDT3Q=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=BHYxjj87wP/IsQs6UieDA8cxeJBZxTxKiSxENghzcmzSMZpSPhsAQQNVkHBCh/rfB
         g7ScGNmMgJ7TS1WAS8eRSlAlB/0Frr6pvG3vhjFR0f1uqYXfGiFITdSo5QG8C2DIsZ
         egC8SaZKrXrEf4Jz53nJWQoXMN602ZUir1fDzeogqVfh8ndQgtWVImAG76Mb9r3ycs
         u1GX8A3IMfWuGyThtQ7dbfhSafC/ftvCHMkyeL3L7t0GAaX8zstriWiChEa/m74230
         4UWgA2ZNOXQ1B9ZJ/j3a7p7NaT3hmM6a4gFROh3gnorICAPY8P+n6M2noyxaDe8pr9
         lQr7CiTU27DEK/GR/yTDRUncYTn/rvArwvxVAsL2CqIMn97cu0iIDtPUaVvFtGBhuc
         mKJnISs7kAV7HYQ+3GuwzPaGBpgip6Putd5qmUY5EYVd0D3UPKNCSMnk8nRbfa9UHz
         MAr514VjrJNrc9bjWIlTBWIUTr68ptMZE+KIx42jjSMcILhYAkBVitC8UcZSoejF14
         MkO8kx+nwuCWs8zlTy79mK4KG76AiKxv24+67Y+OluJWLkTZY19Sto4NeUfpWtM1HH
         hrWuh2Gq2HwbwPM42+wEyE8mnZEicC17Te6snoR1CUo+UwUEHoWgJmSf76Mv4zfE9i
         JKLM9Nqj9TrfJlG6dIWn3tC8=
Received: from Hawking (ntp.lan [10.0.1.1])
        (authenticated bits=0)
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id 0324Xi8h089946
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Apr 2020 15:33:46 +1100 (AEDT)
        (envelope-from alastair@d-silva.org)
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     "'Dan Williams'" <dan.j.williams@intel.com>
Cc:     "'Aneesh Kumar K . V'" <aneesh.kumar@linux.ibm.com>,
        "'Oliver O'Halloran'" <oohall@gmail.com>,
        "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>,
        "'Paul Mackerras'" <paulus@samba.org>,
        "'Michael Ellerman'" <mpe@ellerman.id.au>,
        "'Frederic Barrat'" <fbarrat@linux.ibm.com>,
        "'Andrew Donnellan'" <ajd@linux.ibm.com>,
        "'Arnd Bergmann'" <arnd@arndb.de>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Vishal Verma'" <vishal.l.verma@intel.com>,
        "'Dave Jiang'" <dave.jiang@intel.com>,
        "'Ira Weiny'" <ira.weiny@intel.com>,
        "'Andrew Morton'" <akpm@linux-foundation.org>,
        "'Mauro Carvalho Chehab'" <mchehab+samsung@kernel.org>,
        "'David S. Miller'" <davem@davemloft.net>,
        "'Rob Herring'" <robh@kernel.org>,
        "'Anton Blanchard'" <anton@ozlabs.org>,
        "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Mahesh Salgaonkar'" <mahesh@linux.vnet.ibm.com>,
        "'Madhavan Srinivasan'" <maddy@linux.vnet.ibm.com>,
        "=?utf-8?Q?'C=C3=A9dric_Le_Goater'?=" <clg@kaod.org>,
        "'Anju T Sudhakar'" <anju@linux.vnet.ibm.com>,
        "'Hari Bathini'" <hbathini@linux.ibm.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Greg Kurz'" <groug@kaod.org>,
        "'Nicholas Piggin'" <npiggin@gmail.com>,
        "'Masahiro Yamada'" <yamada.masahiro@socionext.com>,
        "'Alexey Kardashevskiy'" <aik@ozlabs.ru>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        "'linuxppc-dev'" <linuxppc-dev@lists.ozlabs.org>,
        "'linux-nvdimm'" <linux-nvdimm@lists.01.org>,
        "'Linux MM'" <linux-mm@kvack.org>
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-3-alastair@d-silva.org> <CAPcyv4h9uDxHDb0iN+zwhPB=By8Ps8cwTyipf6b64v+ruzhchg@mail.gmail.com>
In-Reply-To: <CAPcyv4h9uDxHDb0iN+zwhPB=By8Ps8cwTyipf6b64v+ruzhchg@mail.gmail.com>
Subject: RE: [PATCH v4 02/25] mm/memory_hotplug: Allow check_hotplug_memory_addressable to be called from drivers
Date:   Thu, 2 Apr 2020 15:33:43 +1100
Message-ID: <2e7501d608a7$ea00cd10$be026730$@d-silva.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-au
Thread-Index: AQJ5L4Hn/mp5p0p1jYAFWLJ+xmWSbgIN9vctASc14KCnBUc6gA==
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Thu, 02 Apr 2020 15:33:54 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Dan Williams <dan.j.williams@intel.com>
> Sent: Wednesday, 1 April 2020 7:48 PM
> To: Alastair D'Silva <alastair@d-silva.org>
> Cc: Aneesh Kumar K . V <aneesh.kumar@linux.ibm.com>; Oliver O'Halloran
> <oohall@gmail.com>; Benjamin Herrenschmidt
> <benh@kernel.crashing.org>; Paul Mackerras <paulus@samba.org>; Michael
> Ellerman <mpe@ellerman.id.au>; Frederic Barrat =
<fbarrat@linux.ibm.com>;
> Andrew Donnellan <ajd@linux.ibm.com>; Arnd Bergmann
> <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> Vishal Verma <vishal.l.verma@intel.com>; Dave Jiang
> <dave.jiang@intel.com>; Ira Weiny <ira.weiny@intel.com>; Andrew Morton
> <akpm@linux-foundation.org>; Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org>; David S. Miller <davem@davemloft.net>;
> Rob Herring <robh@kernel.org>; Anton Blanchard <anton@ozlabs.org>;
> Krzysztof Kozlowski <krzk@kernel.org>; Mahesh Salgaonkar
> <mahesh@linux.vnet.ibm.com>; Madhavan Srinivasan
> <maddy@linux.vnet.ibm.com>; C=C3=A9dric Le Goater <clg@kaod.org>; Anju =
T
> Sudhakar <anju@linux.vnet.ibm.com>; Hari Bathini
> <hbathini@linux.ibm.com>; Thomas Gleixner <tglx@linutronix.de>; Greg
> Kurz <groug@kaod.org>; Nicholas Piggin <npiggin@gmail.com>; Masahiro
> Yamada <yamada.masahiro@socionext.com>; Alexey Kardashevskiy
> <aik@ozlabs.ru>; Linux Kernel Mailing List =
<linux-kernel@vger.kernel.org>;
> linuxppc-dev <linuxppc-dev@lists.ozlabs.org>; linux-nvdimm <linux-
> nvdimm@lists.01.org>; Linux MM <linux-mm@kvack.org>
> Subject: Re: [PATCH v4 02/25] mm/memory_hotplug: Allow
> check_hotplug_memory_addressable to be called from drivers
>=20
> On Sun, Mar 29, 2020 at 10:23 PM Alastair D'Silva =
<alastair@d-silva.org>
> wrote:
> >
> > When setting up OpenCAPI connected persistent memory, the range =
check
> > may not be performed until quite late (or perhaps not at all, if the
> > user does not establish a DAX device).
> >
> > This patch makes the range check callable so we can perform the =
check
> > while probing the OpenCAPI Persistent Memory device.
> >
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
> > ---
> >  include/linux/memory_hotplug.h | 5 +++++
> >  mm/memory_hotplug.c            | 4 ++--
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/memory_hotplug.h
> > b/include/linux/memory_hotplug.h index f4d59155f3d4..9a19ae0d7e31
> > 100644
> > --- a/include/linux/memory_hotplug.h
> > +++ b/include/linux/memory_hotplug.h
> > @@ -337,6 +337,11 @@ static inline void __remove_memory(int nid, u64
> > start, u64 size) {}  extern void set_zone_contiguous(struct zone
> > *zone);  extern void clear_zone_contiguous(struct zone *zone);
> >
> > +#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
> > +int check_hotplug_memory_addressable(unsigned long pfn,
> > +                                    unsigned long nr_pages); #endif
> > +/* CONFIG_MEMORY_HOTPLUG_SPARSE */
>=20
> Let's move this to include/linux/memory.h with the other
> CONFIG_MEMORY_HOTPLUG_SPARSE declarations, and add a dummy
> implementation for the CONFIG_MEMORY_HOTPLUG_SPARSE=3Dn case.
>=20
> Also, this patch can be squashed with the next one, no need for it to =
be
> stand alone.
>=20

Ok

>=20
> > +
> >  extern void __ref free_area_init_core_hotplug(int nid);  extern int
> > __add_memory(int nid, u64 start, u64 size);  extern int =
add_memory(int
> > nid, u64 start, u64 size); diff --git a/mm/memory_hotplug.c
> > b/mm/memory_hotplug.c index 0a54ffac8c68..14945f033594 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -276,8 +276,8 @@ static int check_pfn_span(unsigned long pfn,
> unsigned long nr_pages,
> >         return 0;
> >  }
> >
> > -static int check_hotplug_memory_addressable(unsigned long pfn,
> > -                                           unsigned long nr_pages)
> > +int check_hotplug_memory_addressable(unsigned long pfn,
> > +                                    unsigned long nr_pages)
> >  {
> >         const u64 max_addr =3D PFN_PHYS(pfn + nr_pages) - 1;
> >
> > --
> > 2.24.1
> >

--=20
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva     msn: alastair@d-silva.org
blog: http://alastair.d-silva.org    Twitter: @EvilDeece
=20


