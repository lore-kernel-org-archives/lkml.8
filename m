Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5C1C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C122E20578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="cBEVhpXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgBUQYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:24:31 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44167 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgBUQYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:24:31 -0500
Received: by mail-ot1-f65.google.com with SMTP id h9so2463697otj.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2necOtKPRGOvCKSmF/mkYAKx6vUj3EgsCgdFv1SUhI0=;
        b=cBEVhpXst0AzntwHO7MAAC8tPgH/lHhw3JRg1tiTU84YvfHSiop6h5HEb7dD7ijKuo
         Tkw/ZNf20go4KH7TnldYOoZEAs0/HjhdC6mtapS6+Q3y/I7Q+YrEMV84Zr3jKw37sWpE
         U9Jl8f/7cOVM1MQYH54S4Vp6WSWKpzS2B9dUJOJpX4zoeMiFs4UP17D4CccHDAg8ZFR1
         vCZ/8RYSCxh9NQiUxEt36OEadxPUC7ds7oA0vIxw+TkYSm380z9btYwB+23YYwbo8b8g
         7XRdvaaGovLDozll686+2N7fCxFPusnOHgUUDjTiUfiXQ3pTNjxbkIR85nNqgJmQT6GQ
         8i+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2necOtKPRGOvCKSmF/mkYAKx6vUj3EgsCgdFv1SUhI0=;
        b=SpZ6nnb8XIDwVq3qdra1rbGoIN3YFKAB9odgVmxnofusRRu4XBRl14ubyOtSkVjQi6
         qz2CTEdrksd4/02k2PW1Cq8ewSP3jF7XAhdTF/qliDU5wrjikyEQDr0H5B7kg6O0ZuCN
         SImmrbvByWH3ofxFw4r+mQPqTprDpW5TJ/cocVkPAvEVbxnJMSE31doseOMUS1e4HF2s
         AdwQVob+9X6+8MZs42udgORLwNnv8D2ey6LhU+Un01qpJlKIzdhTpQ6O0KL5TY48PFSz
         Se7ZNw+1izhQdRNQOSpYqQOqfxJn5Kg4tJO7VVIqnbuzFi5N9WHPw8ocKUSRPakCkgXE
         DATg==
X-Gm-Message-State: APjAAAVW0l9UhCc33QGJB6nJkU/NkbfTZa7URZ64wXkhbWk/OMA0WQdW
        C03tDyUjrjcQO3iA+YKdgHWbaY2To0/Cp7nG6HMO7XMx
X-Google-Smtp-Source: APXvYqxaf5u3WFzaIFaCrcTuxeBbhT11NwRGTSO9X8QeSchk7dKOD/6D3Clq0uqWRzW41IL9WLcTtDJa9yoQ436XJig=
X-Received: by 2002:a9d:64d8:: with SMTP id n24mr27053866otl.71.1582302269868;
 Fri, 21 Feb 2020 08:24:29 -0800 (PST)
MIME-Version: 1.0
References: <20200221032720.33893-1-alastair@au1.ibm.com> <CAPcyv4j2hut1YDrotC=QkcM+S0SZwpd9_4hD2aChn+cKD+62oA@mail.gmail.com>
In-Reply-To: <CAPcyv4j2hut1YDrotC=QkcM+S0SZwpd9_4hD2aChn+cKD+62oA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 21 Feb 2020 08:24:18 -0800
Message-ID: <CAPcyv4hzZt0oqWN8y_K70h3C1S1jNw6jfNF3jPujCFmLW+MSvw@mail.gmail.com>
Subject: Re: [PATCH v3 00/27] Add support for OpenCAPI Persistent Memory devices
To:     "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
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

On Fri, Feb 21, 2020 at 8:21 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Thu, Feb 20, 2020 at 7:28 PM Alastair D'Silva <alastair@au1.ibm.com> wrote:
> >
> > From: Alastair D'Silva <alastair@d-silva.org>
> >
> > This series adds support for OpenCAPI Persistent Memory devices, exposing
> > them as nvdimms so that we can make use of the existing infrastructure.
>
> A single sentence to introduce:
>
> 24 files changed, 3029 insertions(+), 97 deletions(-)
>
> ...is inadequate. What are OpenCAPI Persistent Memory devices? How do
> they compare, in terms relevant to libnvdimm, to other persistent
> memory devices? What challenges do they pose to the existing enabling?
> What is the overall approach taken with this 27 patch break down? What
> are the changes since v2, v1? If you incorporated someone's review
> feedback note it in the cover letter changelog, if you didn't

Assumptions and tradeoffs the implementation considered are also
critical for reviewing the approach.
