Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B7BC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3184B246A0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="KPfzjDQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgB0RCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:02:37 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41018 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgB0RCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:02:36 -0500
Received: by mail-oi1-f196.google.com with SMTP id i1so3989797oie.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 09:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/jADGYHp0JHjLbfNvifObEsHN9b9nWgTjEodPO7hm0=;
        b=KPfzjDQtTnijJToFyDXktoC2udwyOzB0B5n85vP7uYekSEu8BkMpLT/ZI8CK3gNjgz
         S4lijftXsqXG4e0UvQY/lM0ScFXNOzHZ8nfP6HW//fgk3or+XDKKdQ3oUsEwbm9kjbSt
         YvZJdY2AqXxidZDU2pvSxjgcEExZaJPMc5a8U6aBVjmcc0vMBekyiq3voRqtqk0KSPAx
         RFvfSk+LlSSPZbVx4Jl7Nqwk1QcuKaWmy4niKZ4SeXt+CXOmgUmLp6ojW6ui9knkVAbw
         O56thY8gft/GhQJUltLLBZzs0iZAZiPm7sIaskKsb2nHEkfDNZ+AvKn6WunU3y1NY3xL
         bvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/jADGYHp0JHjLbfNvifObEsHN9b9nWgTjEodPO7hm0=;
        b=KXGhfN/0RMmOWWl/a9M7wlCrQwPxmCSScyq7KbY8lBIu7T6j0bxrLb2Q+/mV3SIYTC
         tM7IblN6wSsgjniJy9bwnNuGKN7tBgpiafb8338TsgHtvEbVJVz05jHzrHByP8KLlkgh
         k3RuvbGMDby1+YdOHHPnxpZEIYgQTNvgN8Ijr08cK+d+Jd+9h3IHwEfvYxdDUxHFhEWF
         jzVCaiLsq1h3NycMoXDToodYMkZY3X+5dx747+rhqfCgwg5BF+mhHBo724Q1bhs/weHX
         yY1t6ccaq5pHekkwpAnAA/TKqlgBgCqT6OP63DvWB2iUQ1i45FmejlMNJmjd2nTAAY40
         L99w==
X-Gm-Message-State: APjAAAVJx69iHf/b00RhyGPjlZgwhTssw64YzSHdgLyhqxRt7ScseC01
        3sM9fyZaZyKlrOGxvO987/0p+CqrEioDNCYl2ahcsw==
X-Google-Smtp-Source: APXvYqypU1i0qqgWCthMIeErQC/uy0wM3eA252xRldHq9XOYpqruxDhwC/BTw+uhQHICN4k+v1Tc+9XvQsy7JvHRZsw=
X-Received: by 2002:aca:aa0e:: with SMTP id t14mr4256386oie.149.1582822956078;
 Thu, 27 Feb 2020 09:02:36 -0800 (PST)
MIME-Version: 1.0
References: <20200221032720.33893-1-alastair@au1.ibm.com> <20200221032720.33893-16-alastair@au1.ibm.com>
In-Reply-To: <20200221032720.33893-16-alastair@au1.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 27 Feb 2020 09:02:25 -0800
Message-ID: <CAPcyv4jiXZrTNTOb8aY8nehVBphCOKbtDKK9ouddiHnEZSYW3A@mail.gmail.com>
Subject: Re: [PATCH v3 15/27] powerpc/powernv/pmem: Add support for near
 storage commands
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
> Similar to the previous patch, this adds support for near storage commands.

Similar comment as the last patch. This changelog does not give the
reviewer any frame of reference to review the patch.
