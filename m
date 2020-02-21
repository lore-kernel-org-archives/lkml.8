Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E21DC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A4220578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="macUat4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgBUQWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:22:03 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46410 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbgBUQWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:22:02 -0500
Received: by mail-ot1-f66.google.com with SMTP id g64so2437368otb.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UESijwJloetNY8FQMqP4NxBHBgGttqQPvE09CZ9ft1c=;
        b=macUat4OhBw9DARYl7llLCgFZklb66CEJoh9cIMr3g6yESO7cALxWGslA+R7qYKrGs
         fnmKfZrgf4oKCpJCyarWrJ4UiLB6zsowKF7ZaP0X5hmt/PWvNfkyVseLF0OX092PDlNh
         jqCgungkXvg9muNuvc5UtdxiEdiRd0oLyrZ/CRtK1Bzzz9Flyiem04hAk0SnwwqncSRj
         n0Fom0Ouu0dm1sw7gA89tp1HgNtirvu3zy3vksqHoGrMdeXGvWUKxjkOg4Wc2zD/XO1c
         7fzVCJned9Xt5eFtyLaspUTh2m87sc7K+o9d2P0JWiSzZMGN6vItAdbq1RvCK9sWLksv
         9zPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UESijwJloetNY8FQMqP4NxBHBgGttqQPvE09CZ9ft1c=;
        b=LNXZa09RqwxuCvvcauenHjs6KxwZJYXPqxZ8SycIrmsinQjnKuUyAIVwyJWRY3Ym4k
         4MOWtbfqjZwa12GwA1229jnlw6jBUOlxfE7dhyL4rD7FDzcHYqyl2vcS4wVBtXM4PgyW
         2eWhX2HzvQMioyID8ErpbP3t1lnkeGgx6R5Azd98uzAMeuYMP9tE+qtthA1h2P+6V8m1
         mPUB/Sj9j3CqSxJ+/YunD/0YTYDWMI1RWUWXH+z4P6wM5XNiE+1PmT0MnVJzunfYY51d
         sCHlJoCU2wgdbpDQ8hyepDc7l0vi3UyOfZFHyCg4btHzxw1ny/6lyUd/qyyGvS4wbt2H
         /R4A==
X-Gm-Message-State: APjAAAXLnXNqSsSRsM3fHCx4Wk04/+huAb8kU3P39eygV0zsI018U0yj
        f4SP+4Di5Tvp4wWg0/gzO9E7pLeoJdTZppeTaqoDuA==
X-Google-Smtp-Source: APXvYqxUQtP3b4zLuYjsw3PWW1Xh6/3l8dvciMnwM+axT86fN3Vik9tAcpduTQUxrlW/YBnslPiYEUOP0aEHD0RypMw=
X-Received: by 2002:a05:6830:134c:: with SMTP id r12mr6522827otq.126.1582302121655;
 Fri, 21 Feb 2020 08:22:01 -0800 (PST)
MIME-Version: 1.0
References: <20200221032720.33893-1-alastair@au1.ibm.com>
In-Reply-To: <20200221032720.33893-1-alastair@au1.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 21 Feb 2020 08:21:50 -0800
Message-ID: <CAPcyv4j2hut1YDrotC=QkcM+S0SZwpd9_4hD2aChn+cKD+62oA@mail.gmail.com>
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

On Thu, Feb 20, 2020 at 7:28 PM Alastair D'Silva <alastair@au1.ibm.com> wrote:
>
> From: Alastair D'Silva <alastair@d-silva.org>
>
> This series adds support for OpenCAPI Persistent Memory devices, exposing
> them as nvdimms so that we can make use of the existing infrastructure.

A single sentence to introduce:

24 files changed, 3029 insertions(+), 97 deletions(-)

...is inadequate. What are OpenCAPI Persistent Memory devices? How do
they compare, in terms relevant to libnvdimm, to other persistent
memory devices? What challenges do they pose to the existing enabling?
What is the overall approach taken with this 27 patch break down? What
are the changes since v2, v1? If you incorporated someone's review
feedback note it in the cover letter changelog, if you didn't
incorporate someone's feedback note that too with an explanation.

In short, provide a bridge document for someone familiar with the
upstream infrastructure, but not necessarily steeped in powernv /
OpenCAPI platform details, to get started with this code.

For now, no need to resend the whole series, just reply to this
message with a fleshed out cover letter and then incorporate it going
forward for v4+.
