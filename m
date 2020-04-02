Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76245C2D0F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 03:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD1F20784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 03:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1BLyfPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbgDBDuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 23:50:16 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:34641 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732498AbgDBDuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 23:50:15 -0400
Received: by mail-il1-f194.google.com with SMTP id t11so2283818ils.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 20:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=un3fCtdFL30YthKT96CUaub/mKOgXUtAMj2aFT/0PG4=;
        b=j1BLyfPilq3TJB3KimcIBBGzUr9NSBHL9CZX0ZLvnEhr10RUE+BzgwAVbkboZvzJbw
         p3BYhlMqx54KQgTKkG5lwMplSjQXdoNkXd6tEJKK3Ow86YPUz9oF50vYJT+DfEqEOxYC
         9orFV88QTGN5X23IO494ia9LQ6tqUZLtLTwAChrveledyaZs21kUVGzJaxM2U41am4FJ
         Yzm4Yffn1e/pPB99dk1RtDx+wheEOC6UxXljP5f2wz0KZBjj7tsaeqI0Zzkl2tGQPABp
         D6g9lryQGxQKow4hC6WDUEqU58ef+Z9XAu/Dw2FHqwgyQtnWJzmpiAtoYyW7fB3tXiP9
         JaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=un3fCtdFL30YthKT96CUaub/mKOgXUtAMj2aFT/0PG4=;
        b=IxEeqz/ob6CtiffJMn1CYX79bmL491+cMVthUHcYYQo3VeSluriowBg6fWaosJbiRW
         I7aRe1TVd5UUTBY568ZKcMVgLe7rZcA+S2XDXl+INb38gg1tZ+WIKNDETE3gHyKO62A5
         LRsGFZ97tTm9rwTwftgA4nFA5NSFAQEeGNplJ/rUvtI7N7RsHs005BVY1YdtrCbd3/Hz
         eM7xkt6+btAS/TjEW3X2eo/36VKssLgorwYcKLssqLYWYN99r54Lj6IpfGFc35CqT9mE
         DX58MGqWf/vuFSJ7crAnZjT5t6OJwJrW1VSK6g14Lai4kHF4m+RRpA2n1ZaIx8eejxaH
         0R+Q==
X-Gm-Message-State: AGi0PubGAxsDmHpvPMmxDJf37CnFqpEpPvayT10OuRhdSu2+qmWpe79i
        3309ygUKWuTXdmvNRLAGZ54wZN22uilv+cI+L+Y=
X-Google-Smtp-Source: APiQypJyEN+5v6EGwS7GGD77C8TR5iHpI3+yZLJ2qJhUBFcMxf+gIEB07Pj3Y1zyNjFY+2mASs/kfz/PFBneqBUdOvU=
X-Received: by 2002:a92:39cc:: with SMTP id h73mr1225341ilf.298.1585799414632;
 Wed, 01 Apr 2020 20:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200327071202.2159885-1-alastair@d-silva.org>
 <CAPcyv4iJYZBVhV1NW7EB6-EwETiUAy6r1iiE+F+HvFXfGZt9Aw@mail.gmail.com>
 <2d6901d60877$16aa7a90$43ff6fb0$@d-silva.org> <87imiituxm.fsf@mpe.ellerman.id.au>
In-Reply-To: <87imiituxm.fsf@mpe.ellerman.id.au>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Thu, 2 Apr 2020 14:50:03 +1100
Message-ID: <CAOSf1CHdpFyT_6zetKM6eHDK3AT8-UNTzjdd2y+QqYT2AO9VDw@mail.gmail.com>
Subject: Re: [PATCH v4 00/25] Add support for OpenCAPI Persistent Memory devices
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Alastair D'Silva" <alastair@d-silva.org>,
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

On Thu, Apr 2, 2020 at 2:42 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> "Alastair D'Silva" <alastair@d-silva.org> writes:
> >> -----Original Message-----
> >> From: Dan Williams <dan.j.williams@intel.com>
> >>
> >> On Sun, Mar 29, 2020 at 10:23 PM Alastair D'Silva <alastair@d-silva.org>
> >> wrote:
> >> >
> >> > *snip*
> >> Are OPAL calls similar to ACPI DSMs? I.e. methods for the OS to invoke
> >> platform firmware services? What's Skiboot?
> >>
> >
> > Yes, OPAL is the interface to firmware for POWER. Skiboot is the open-source (and only) implementation of OPAL.
>
>   https://github.com/open-power/skiboot
>
> In particular the tokens for calls are defined here:
>
>   https://github.com/open-power/skiboot/blob/master/include/opal-api.h#L220
>
> And you can grep for the token to find the implementation:
>
>   https://github.com/open-power/skiboot/blob/master/hw/npu2-opencapi.c#L2328

I'm not sure I'd encourage anyone to read npu2-opencapi.c. I find it
hard enough to follow even with access to the workbooks.

There's an OPAL call API reference here:
http://open-power.github.io/skiboot/doc/opal-api/index.html

Oliver
