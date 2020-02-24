Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A13C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089C220675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+VFg7nl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgBXGvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 01:51:46 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:46893 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBXGvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 01:51:45 -0500
Received: by mail-il1-f195.google.com with SMTP id t17so6794542ilm.13
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 22:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t9K0w7u9UlRucKDFse4Bnnz0TkvNHleyC4BCsa1RzrM=;
        b=r+VFg7nlYKjyz4ZE6FQLUysVX5WdvVgRm6WOY41svQjomwf0VXKN3PmH633+9Q2lI7
         rsia25DTZrqeYZUzqIELM0ZPs9xk9RrR1zjvbYreOc8hFnT5pfTuk8+8G3Z3+v2ZKC0g
         3+Uda6+pEZA47fwhjkuOGRiku+Z0p1HVHFqY54Xx1Th+9vhrJ/qnxiXHBlAOCapn0INg
         RIE2UbkfnEyHpOODwAIrese+8kda1BNJDaAH9nXkUn/5vKE97Jm60mZbshpHsb7scDjj
         jyhU99uHJmzK+BJhulAarPgiDvpWVdszTMddDibKFZjPLLrV/FmHpUdCY0G0wQkUeVCh
         oz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t9K0w7u9UlRucKDFse4Bnnz0TkvNHleyC4BCsa1RzrM=;
        b=aVZ5UBwNsI9PgwLGajRrh1IaSWxEbe/LjEjw2fPH1Xwh0EwlXML023cK21NgozMv/u
         p/7QhkfA0TqX8Vfcxg3e5HTJTCHyq/TPUfoe764u6tVENJ1N4KsNs6ARleKX3PeUsjXF
         jNq8e1+j8aqRchK1i0N9ct/DidVivNDeQFl+4kViCJ9+fJ99Eq30XFlSsv96Tc2layi0
         Pc7yhu44zdzhKDvQyrZEcKRcegWgakF38uylJLmzJOQ53yDTBJEDsLW40eJ4LW/Y/7LD
         vHIG4rer8MjeS3uEkYnotoHmb1BkEwGzeZK1MzdO2gw8mqq91FLEf0d3WehgzdjYbWCN
         AMJg==
X-Gm-Message-State: APjAAAVKiCUsE0kJa2KOu/o62W5EPkqVYFq0WnhnpKMI/R9F1/sGkatb
        Jcw4+v20T03GX3fk3JWq4BYptFg5eYIvAq86sv0/13JxKhXWSA==
X-Google-Smtp-Source: APXvYqx+mUK6hh9BaSPGa0Msc1oHfQvPgztYvcYPrv+S9n6RraKbcSZyrnA+OcHji1IbgLT+tKjr35qmWcvjk1TYbOw=
X-Received: by 2002:a92:d7c1:: with SMTP id g1mr59552764ilq.192.1582527104859;
 Sun, 23 Feb 2020 22:51:44 -0800 (PST)
MIME-Version: 1.0
References: <20200221032720.33893-1-alastair@au1.ibm.com> <CAPcyv4j2hut1YDrotC=QkcM+S0SZwpd9_4hD2aChn+cKD+62oA@mail.gmail.com>
 <240fbefc6275ac0a6f2aa68715b3b73b0e7a8310.camel@au1.ibm.com>
 <20200224043750.GM24185@bombadil.infradead.org> <83034494d5c3da1fa63b172e844f85d0fec7910a.camel@au1.ibm.com>
In-Reply-To: <83034494d5c3da1fa63b172e844f85d0fec7910a.camel@au1.ibm.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Mon, 24 Feb 2020 17:51:33 +1100
Message-ID: <CAOSf1CHYEJf02EV0kYMk+D9s=4PiTXSM1eFcRGYe7XJrHvtAtA@mail.gmail.com>
Subject: Re: [PATCH v3 00/27] Add support for OpenCAPI Persistent Memory devices
To:     "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
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

On Mon, Feb 24, 2020 at 3:43 PM Alastair D'Silva <alastair@au1.ibm.com> wrote:
>
> On Sun, 2020-02-23 at 20:37 -0800, Matthew Wilcox wrote:
> > On Mon, Feb 24, 2020 at 03:34:07PM +1100, Alastair D'Silva wrote:
> > > V3:
> > >   - Rebase against next/next-20200220
> > >   - Move driver to arch/powerpc/platforms/powernv, we now expect
> > > this
> > >     driver to go upstream via the powerpc tree
> >
> > That's rather the opposite direction of normal; mostly drivers live
> > under
> > drivers/ and not in arch/.  It's easier for drivers to get overlooked
> > when doing tree-wide changes if they're hiding.
>
> This is true, however, given that it was not all that desirable to have
> it under drivers/nvdimm, it's sister driver (for the same hardware) is
> also under arch, and that we don't expect this driver to be used on any
> platform other than powernv, we think this was the most reasonable
> place to put it.

Historically powernv specific platform drivers go in their respective
subsystem trees rather than in arch/ and I'd prefer we kept it that
way. When I added the papr_scm driver I put it in the pseries platform
directory because most of the pseries paravirt code lives there for
some reason; I don't know why. Luckily for me that followed the same
model that Dan used when he put the NFIT driver in drivers/acpi/ and
the libnvdimm core in drivers/nvdimm/ so we didn't have anything to
argue about. However, as Matthew pointed out, it is at odds with how
most subsystems operate. Is there any particular reason we're doing
things this way or should we think about moving libnvdimm users to
drivers/nvdimm/?

Oliver
