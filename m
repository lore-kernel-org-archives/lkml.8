Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65223C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 14:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415F2206F0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 14:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujlgKrQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgECOuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 10:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbgECOuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 10:50:20 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FC9C061A0E
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 07:50:20 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f8so5751733plt.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 07:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GyoGOzeD/a39cCWOQMMMe9JJ2IxthRQrhCJp6EhH6sw=;
        b=ujlgKrQf5btOCO6PolxwyEVhyNozCdLOhTU/xCGHbmnPKLTfSgTNMBBIdE0gSX8OCG
         Ofm0JPJqx28y/LinlsX4uamV7kHkGJH/6on+zgn7Gyj1+9uN0lWyRxLx7EK93DLZMLEW
         LUx7HhaILJLARKsg8X3+ENZm7stknFaBDqmsVtywNtF9YyUYUK0bBVvzEKOiSvKfsTx1
         7Up5g6xBOyY/2cevb5B28L3epRJggDc6PnM5AHfuRQYajNlsDo7HNgu5whz1QSDcI402
         0xaF4IUiAttPZ9KNw28KKxiH2I19TvPIUgk4mxyKudJPYFaroz6fWoqT2UVhrTacl6p2
         BFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GyoGOzeD/a39cCWOQMMMe9JJ2IxthRQrhCJp6EhH6sw=;
        b=rK6++YW4uJiI1KfkTlBZ8eqeFzz+4o0+DoaIad15LRJq4vXvsBbR3RhqQ+d9PYmzhk
         s9WazcojcIa8QJpAq04yv+NEyu1ej7quYqS7VQyhOncqhQ6AG+CjL8NOjiuecS8T0Czi
         UQKMv+soo0n4RoYdjnYH1cEkaEg3u0ObstrZaJsS818R/U+m42hyvUQezi8o2Aa3EJsy
         q8cV5cFLGsTBBlCGbLDrey7O7zIa1e0BOLa/HRAhAAyF6RTLTZG3zEtJ4PPqWZIBp3UR
         xSDXxfH0qugIe3R0jmJLYjcVwpIHHX7cBUjrwFBv2OE+rCepUFfmjdFWl/qi4zqPPgJi
         duFg==
X-Gm-Message-State: AGi0PuajFgGNdVMs1YGEmNeTqBM03FYH+QEY79PkymQmHiJjDKtOYYOm
        jQKAv6mXrpbmMaJ8A+s69/I=
X-Google-Smtp-Source: APiQypLYm1usbcTW1iyjm1GtL5I5xK4c6Ln/FpiQ2309PIozohJP0Ky/7RTsQY1knxwBKNVHF29h5Q==
X-Received: by 2002:a17:90a:1941:: with SMTP id 1mr11565348pjh.65.1588517420237;
        Sun, 03 May 2020 07:50:20 -0700 (PDT)
Received: from localhost ([183.82.183.160])
        by smtp.gmail.com with ESMTPSA id w2sm6547666pfc.194.2020.05.03.07.50.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 May 2020 07:50:19 -0700 (PDT)
Date:   Sun, 3 May 2020 20:20:17 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>
Cc:     Alan Kao <alankao@andestech.com>, Eric Lin <tesheng@andestech.com>,
        Gary Guo <gary@garyguo.net>, alex@ghiti.fr,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>, atish.patra@wdc.com,
        yash.shah@sifive.com, Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Greentime Hu <green.hu@gmail.com>, zong.li@sifive.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 0/3] Highmem support for 32-bit RISC-V
Message-ID: <20200503145017.GA5074@afzalpc>
References: <20200331093241.3728-1-tesheng@andestech.com>
 <CAK8P3a3LokurC0n9XiwtPQh9ZgQcswMKY4b+TEsQh1VgYDNeWA@mail.gmail.com>
 <20200408035118.GA1451@andestech.com>
 <CAK8P3a1JS3_2fWrhNTZx0eTWjJa-GTb4AscTPqydpSP5EB15Yw@mail.gmail.com>
 <20200414151748.GA5624@afzalpc>
 <CAK8P3a0JW9x-Wk9Ec3+zLjPHbWAvPQx8MF-xe-PnWUgEjRAuTg@mail.gmail.com>
 <20200415135407.GA6553@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415135407.GA6553@afzalpc>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

> On Tue, Apr 14, 2020 at 09:29:46PM +0200, Arnd Bergmann wrote:

> > Another thing to try early is to move the vmlinux virtual address
> > from the linear mapping into vmalloc space. This does not require
> > LPAE either, but it only works on relatively modern platforms that
> > don't have conflicting fixed mappings there.

i have started by attempting to move static kernel mapping from lowmem
to vmalloc space. At boot the execution so far has went past assembly
& reached C, to be specific, arm_memblock_init [in setup_arch()],
currently debugging the hang that happens after that point. To make
things easier in the beginning, ARM_PATCH_PHYS_VIRT is disabled &
platform specific PHYS_OFFSET is fed, this is planned to be fixed once
it boots.

[ i will probably start a new thread or hopefully RFC on LAKML ]

Regards
afzal
