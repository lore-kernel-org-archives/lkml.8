Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914AFC3567B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C6A2469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="uAn0b8d7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgB0RBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:01:41 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45141 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbgB0RBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:01:40 -0500
Received: by mail-ot1-f66.google.com with SMTP id 59so3546648otp.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 09:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6h30Tw2mjD0V+USDZTW8hFhBkYs512Lqr51yu3+ofs=;
        b=uAn0b8d75rtFVOIdOZnsmQfugjpQalJefb4ste8jolUNr1Yv8HzUsChA5IZdX6dVwd
         XioJKiTWbGnDtU4IboFdBuWNdSUJyhqOywZAqPHtfAPsP5EE2Vctx7h4d3HzmAz8kJg2
         QEZGCgmxda9Q1U7l8UKx5rYUE8e0CalNOfmq1Gr0p48T3nigCDKHxAA95PerIyA9cG+e
         dR6hBEjqTyDoYw9c1pPJAGrnBH4XrcTdP2uQp8VES5MNja8u2NBJLM/amQM8kZtjM4o2
         775/8oUqrrg44OGDHSVN//FW3bxKZ/Q8bzo3dFUV9T7ZLLB9OUQvlYn0dAJ0bMRvvuyk
         8XAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6h30Tw2mjD0V+USDZTW8hFhBkYs512Lqr51yu3+ofs=;
        b=Ka+QSw15241HXa3mxsJOVzvxqb8VvxkDS8pka06q2kKqmt1HASBciLeKgTr2/87VaD
         soTrWFYzs7rXmjX5Y2awBuSVEwisX1QRZ762VVfi8Ng3pjZ1BRi21uGTAhlB/B4ml81u
         FGE/3sGzq5Obsy8Vl40z5stzRqFMhodkBRsE/AnTVw/3XJ8XfYZecbevSlOXvezJ1lkj
         s0GeFaCTas0ksh3i5cqZnKacOU4oc91iExRx5di1QmuMtvqd7BQzMstnPDEBo5PfdrJD
         y+bBajp1Aa2wNNdA5/3PSo6YZM/CCR+R2bzpXjRGUr6aMVmQiixhP1qg7/FDZ7eaaaA/
         P6+w==
X-Gm-Message-State: APjAAAW6Bgzz3Um1lQkBQR9J61Z3ynIfefMIBfcu/p3umx7pinrpQqhl
        +qja+Oy7RmS+eB12xI/DmqvedUFeezpTEG2hF0yN4Q==
X-Google-Smtp-Source: APXvYqyXwQILrbtHCsUHMWn42meoZX0KXIZsOEVsgrRpEJ3IcJaY2hGUVFuyZ1kdlGiQhmRiXVOeUC0xDwMJYMZQufs=
X-Received: by 2002:a9d:64d8:: with SMTP id n24mr525264otl.71.1582822896420;
 Thu, 27 Feb 2020 09:01:36 -0800 (PST)
MIME-Version: 1.0
References: <20200221032720.33893-1-alastair@au1.ibm.com> <20200221032720.33893-15-alastair@au1.ibm.com>
In-Reply-To: <20200221032720.33893-15-alastair@au1.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 27 Feb 2020 09:01:25 -0800
Message-ID: <CAPcyv4iJahL8w3mjfS3C6Pb5PgAsN9+7=FDVgtndU2oHmYYUgQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/27] powerpc/powernv/pmem: Add support for Admin commands
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

On Thu, Feb 20, 2020 at 7:28 PM Alastair D'Silva <alastair@au1.ibm.com> wrote:
>
> From: Alastair D'Silva <alastair@d-silva.org>
>
> This patch requests the metadata required to issue admin commands, as well
> as some helper functions to construct and check the completion of the
> commands.

What are the admin commands? Any pointer to a spec? Why does Linux
need to support these commands?
