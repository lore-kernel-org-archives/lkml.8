Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEE8C33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 21:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4485E20665
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 21:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="AKigSPzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgAWVts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 16:49:48 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42408 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbgAWVts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 16:49:48 -0500
Received: by mail-oi1-f193.google.com with SMTP id 18so4410920oin.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 13:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S935iTNsR30a4CSNLom2KZfe2GAU9enVCcRjMbR4lpE=;
        b=AKigSPzM1pExN/0OUORy7NpgODYyQ4J3t8r/+dJLxrjRj6ZgcGmzkknMRn5g54jugV
         PuPjFHoT8J762NdoRQVHcHl9aReYnbqomBumabhWbyCGFZ3akBYIa+Oo2ZAyxeNPEUG6
         slSOLUOGXe0plcCeEtyTizIlDOrUNqXRHiyll5b912xeRne4Brkv3g2Yj5DnnnWMx9xf
         nOQ+q3+Roi/lwXJJNqrhQmJ7M+daSkVy5CUvw9WY97DQv/1645/V+S819BZ4sC9JHHJB
         FhR+LdjY2IZ9E5Xk/eA4jTuxHrwwKXTVcvl+QK/5vMd9aUzZIaBey7OBVe4+f9tunZmO
         QNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S935iTNsR30a4CSNLom2KZfe2GAU9enVCcRjMbR4lpE=;
        b=TYxvQV0/k/7GYrgwnMtDIGOZWexfiwbjuE+ijqSrGHUf5RBoQVhafD0PAn0nXmImuw
         /rAuphEvoLwBJDxa+dkEiU9+f9GaKCIVR4yXB07np+Yk6H3SKVNtrQF4GvGFyLZGeePz
         FPJ0TvoG4u8A4r21KEz1mKEQ+E1ZQsXLYqunoyk3rvpNdG5wJ8H4yk+3chZfYUmpyH2H
         UdzzVneBzmnoirqP18Q684XidgHTJYQZ8fHIe7sXUw/QK5ArLPgpNmSVCUDPK1UaXFJd
         kt8dU4tGSd7NQG4wgIiusAeqVWmDBeiHxJZ9+gHF3xDdLCW1kR297NyVfSkapeI2ttU+
         9h/w==
X-Gm-Message-State: APjAAAWqq3VWsxGeOOGYNmTJtsovV3XWsqZDOE/bWDGwhjDlktzG8Os8
        Eop35KckXzzca7FcQIn7EamZ5JyVO+ycr2N7ghEuLQ==
X-Google-Smtp-Source: APXvYqx4QUtx9s2lROgpkdUqlxbaltm1ZPSPZIGO6zsZcw5gUbC6uA34HmB9vJLOfKcAsmsAfZMR+8aobM49R/8fTys=
X-Received: by 2002:aca:1103:: with SMTP id 3mr32140oir.70.1579816187113; Thu,
 23 Jan 2020 13:49:47 -0800 (PST)
MIME-Version: 1.0
References: <20191203034655.51561-1-alastair@au1.ibm.com> <20191203034655.51561-3-alastair@au1.ibm.com>
 <CAPcyv4hhK1dyqqe=CwnGfd=hRdUJn0pL6scCUgCz2R+bijZvYg@mail.gmail.com>
In-Reply-To: <CAPcyv4hhK1dyqqe=CwnGfd=hRdUJn0pL6scCUgCz2R+bijZvYg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 23 Jan 2020 13:49:36 -0800
Message-ID: <CAPcyv4in5yHD3i2nYgaJsNKkVAJf4h4N+HUbhkmWjXzVK2jN=w@mail.gmail.com>
Subject: Re: [PATCH v2 02/27] nvdimm: remove prototypes for nonexistent functions
To:     "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
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
        Linux MM <linux-mm@kvack.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add Aneesh ]


On Tue, Dec 3, 2019 at 4:10 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Dec 2, 2019 at 7:48 PM Alastair D'Silva <alastair@au1.ibm.com> wrote:
> >
> > From: Alastair D'Silva <alastair@d-silva.org>
> >
> > These functions don't exist, so remove the prototypes for them.
> >
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
> > ---
>
> This was already merged as commit:
>
>     cda93d6965a1 libnvdimm: Remove prototypes for nonexistent functions
>
> You should have received a notification from the patchwork bot that it
> was already accepted.
>
> What baseline did you use for this submission?

I never got an answer to this, and I have not seen any updates. Can I
ask you to get an initial review from Aneesh who has been doing good
work in the nvdimm core, and then we can look to get this in the
pipeline for the v5.7 kernel?
