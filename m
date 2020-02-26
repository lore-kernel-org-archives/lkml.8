Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE077C4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 00:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7481C2465D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 00:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="1rFC1q7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgBZAco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 19:32:44 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45477 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgBZAcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 19:32:43 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so1305798otp.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 16:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f70455Z6ta/EJCB61dHVpdnNh4osTmAbssLK2ZDouI8=;
        b=1rFC1q7eiqEoo/Ct8CLTc8uB6k3LoZ19oRJxA++l0zQgLc/UuThtXzQMgIWfj0sABp
         Tu/rBPamdN1eVJvSLzs32HeQA4BVe2YUCQ1Tn2metD9qEWM0OzwmfiMBaESZbeWmVueY
         31XvzUzGzkYQ+M5LGVFUZzc+9QGaHPlVPsaxO62G1PTIwMacG1h2AXJ7RsfUhr9pAPYS
         pAFjp6krJgYzuaxPTz+vUaSvelbdMaNAu5U4sM+5GFJ8T583/KnVxZ7l59pGq8Zx1N55
         /0KS/3htbv5/xl4ByvCEOahacZfCCi1uloIgUD+0kK2IgnIpjShkvcodpT/EheCpFi3J
         eEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f70455Z6ta/EJCB61dHVpdnNh4osTmAbssLK2ZDouI8=;
        b=gLXeFCZcS/eziiWtt2o9JQakl4+PP8cASYBkL5wzZVSF1hp0dx3OWgfRfJyW9FjVqd
         FJWerAX7Z8XsBCBFBEdtwA9D0tzNMLy4Mvnws1y7jyLg/Kx1u4+bSRXMvpxlY1Ra7fz6
         CJFUTR2u8zFwyRWoTSVzHQtEs0iecUX25nfqb0r8/qROdI+rgBz9MkbC8FplEBLuP56y
         lqlFssGV+ja0X2JZrVfFDpBojdz/QTOw9jR/UmyQSgWYBCFE6seI2kFkAok7gaGMCbEz
         ae433r6YbgaePPw2Q0wtrL2/z5oCnBPpEvZUJt6XzF+uRcPCJO/DXUsb8CvtYk5Zi2YN
         dsqg==
X-Gm-Message-State: APjAAAUodE3fZsSdEFW351GHLeY5a+ihLB2ohQKW/OsVw+3GlLgecC+5
        2zjN0JKLBCv6ws4B0YC0Riqk77to+L4lGb8buIalDg==
X-Google-Smtp-Source: APXvYqyAsJnZlWJOpclJB6h8LyKxIkm6H51Qk8MIk/UhPC9KtK1RQif8usKO+skdYm0o9lQhxq1Hc5Wd2TvdmbQAZxU=
X-Received: by 2002:a9d:64d8:: with SMTP id n24mr886741otl.71.1582677162325;
 Tue, 25 Feb 2020 16:32:42 -0800 (PST)
MIME-Version: 1.0
References: <20200221032720.33893-1-alastair@au1.ibm.com> <CAPcyv4j2hut1YDrotC=QkcM+S0SZwpd9_4hD2aChn+cKD+62oA@mail.gmail.com>
 <240fbefc6275ac0a6f2aa68715b3b73b0e7a8310.camel@au1.ibm.com>
 <20200224043750.GM24185@bombadil.infradead.org> <83034494d5c3da1fa63b172e844f85d0fec7910a.camel@au1.ibm.com>
 <CAOSf1CHYEJf02EV0kYMk+D9s=4PiTXSM1eFcRGYe7XJrHvtAtA@mail.gmail.com> <b981f4e6cc308a617e7944e3ce23009e804cfdbf.camel@au1.ibm.com>
In-Reply-To: <b981f4e6cc308a617e7944e3ce23009e804cfdbf.camel@au1.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 25 Feb 2020 16:32:31 -0800
Message-ID: <CAPcyv4g_762vho=L21BuO=97zr9Cq14np88bnFieiYN25BvJtA@mail.gmail.com>
Subject: Re: [PATCH v3 00/27] Add support for OpenCAPI Persistent Memory devices
To:     "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     "Oliver O'Halloran" <oohall@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
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
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 4:14 PM Alastair D'Silva <alastair@au1.ibm.com> wrote:
>
> On Mon, 2020-02-24 at 17:51 +1100, Oliver O'Halloran wrote:
> > On Mon, Feb 24, 2020 at 3:43 PM Alastair D'Silva <
> > alastair@au1.ibm.com> wrote:
> > > On Sun, 2020-02-23 at 20:37 -0800, Matthew Wilcox wrote:
> > > > On Mon, Feb 24, 2020 at 03:34:07PM +1100, Alastair D'Silva wrote:
> > > > > V3:
> > > > >   - Rebase against next/next-20200220
> > > > >   - Move driver to arch/powerpc/platforms/powernv, we now
> > > > > expect
> > > > > this
> > > > >     driver to go upstream via the powerpc tree
> > > >
> > > > That's rather the opposite direction of normal; mostly drivers
> > > > live
> > > > under
> > > > drivers/ and not in arch/.  It's easier for drivers to get
> > > > overlooked
> > > > when doing tree-wide changes if they're hiding.
> > >
> > > This is true, however, given that it was not all that desirable to
> > > have
> > > it under drivers/nvdimm, it's sister driver (for the same hardware)
> > > is
> > > also under arch, and that we don't expect this driver to be used on
> > > any
> > > platform other than powernv, we think this was the most reasonable
> > > place to put it.
> >
> > Historically powernv specific platform drivers go in their respective
> > subsystem trees rather than in arch/ and I'd prefer we kept it that
> > way. When I added the papr_scm driver I put it in the pseries
> > platform
> > directory because most of the pseries paravirt code lives there for
> > some reason; I don't know why. Luckily for me that followed the same
> > model that Dan used when he put the NFIT driver in drivers/acpi/ and
> > the libnvdimm core in drivers/nvdimm/ so we didn't have anything to
> > argue about. However, as Matthew pointed out, it is at odds with how
> > most subsystems operate. Is there any particular reason we're doing
> > things this way or should we think about moving libnvdimm users to
> > drivers/nvdimm/?
> >
> > Oliver
>
>
> I'm not too fussed where it ends up, as long as it ends up somewhere :)
>
> From what I can tell, the issue is that we have both "infrastructure"
> drivers, and end-device drivers. To me, it feels like drivers/nvdimm
> should contain both, and I think this feels like the right approach.
>
> I could move it back to drivers/nvdimm/ocxl, but I felt that it was
> only tolerated there, not desired. This could be cleared up with a
> response from Dan Williams, and if it is indeed dersired, this is my
> preferred location.

Apologies if I gave the impression it was only tolerated. I'm ok with
drivers/nvdimm/ocxl/, and to the larger point I'd also be ok with a
drivers/{acpi => nvdimm}/nfit and {arch/powerpc/platforms/pseries =>
drivers/nvdimm}/papr_scm.c move as well to keep all the consumers of
the nvdimm related code together with the core.
