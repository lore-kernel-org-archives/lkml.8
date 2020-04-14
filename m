Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553C5C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F4E20768
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q60rX2pT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438234AbgDNPSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407323AbgDNPRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:17:51 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47F1C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 08:17:51 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nu11so5329965pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 08:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dJ2gNbqVeV+hSWe91DtMlcIeX11rcaXW3r4FdWfxGYg=;
        b=q60rX2pT/kSNyqXq1zY0YNp3nDuRWTEvtlfwSYVdmAmcPMbWysamMjc0m5EFxe2/oF
         XQz+nS0rTtaEkabC2KU0gsxFvv7gT+eK3B0kdl45ueoLWikYNAluQC3+u0YuHV/qxjZu
         cemXxKaCyiY0RZW6X/IW45+ZqzLU2l9pMivLPMyE3tNv/WP+1VmMv6IhVEhQOjA5S05A
         NXICwUWeXGz7Xj/eFSvbnZmMlk4UOuwaMepjlo+eg11VPIBbNhjdHT4Ue0krYm1gcxPt
         rfXWpPKwz4SdB9/xejf7nyigopz8ZnBItAfDQUjvJAtzkjXgdp9sHrGHMzlwsyffCB/4
         +meQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dJ2gNbqVeV+hSWe91DtMlcIeX11rcaXW3r4FdWfxGYg=;
        b=KAmuIiwCNVSXYYtE04GRXEbBMtQc5vaunDNwNChl0WMvujXgAZOoKZFexIa+7dCHOS
         bBcBI1JvEZV7r9fMqi6qChwVno3fuy7IPllVFk9tFXh7QU9ZQYLPLoHLYlfxxEiswvgB
         Q85wtIlb14LpkgOU7tws/bgRpiGhppjCh2TIpgYtKq0g5JsPk6SszAnEmVtIwj8EQDnK
         cvqds3k6MA8sJaai9UkDUnk7Y7iVXGJE4lUX9br/VV3fBVq8GC7ZIZYqCr04dNjGGB8E
         fU5Ol+TH2kWYa6WbbiccgGMJwdolTgno1lBNhNeo/uMylJwxaY5NMfleNHvi/ktRgXZd
         PSJg==
X-Gm-Message-State: AGi0PuY3zZ0AaTw5CVm/+uTSArni1CegyuoG/YOudHkhN1qQGl6p27Gf
        R0dXq9VIRXWc5yYhe4uU2Ww=
X-Google-Smtp-Source: APiQypLxLCyrfW0NagMyb2018P8jP6K/vZqSVtb2ts5tCcdoQlpub1U0h+VU6zqXUT4UODDJuW3ncw==
X-Received: by 2002:a17:902:6503:: with SMTP id b3mr457263plk.20.1586877471101;
        Tue, 14 Apr 2020 08:17:51 -0700 (PDT)
Received: from localhost ([183.82.185.98])
        by smtp.gmail.com with ESMTPSA id 198sm11641428pfa.87.2020.04.14.08.17.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 08:17:50 -0700 (PDT)
Date:   Tue, 14 Apr 2020 20:47:48 +0530
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
Message-ID: <20200414151748.GA5624@afzalpc>
References: <20200331093241.3728-1-tesheng@andestech.com>
 <CAK8P3a3LokurC0n9XiwtPQh9ZgQcswMKY4b+TEsQh1VgYDNeWA@mail.gmail.com>
 <20200408035118.GA1451@andestech.com>
 <CAK8P3a1JS3_2fWrhNTZx0eTWjJa-GTb4AscTPqydpSP5EB15Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1JS3_2fWrhNTZx0eTWjJa-GTb4AscTPqydpSP5EB15Yw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ rmk

Hi Arnd,

On Wed, Apr 08, 2020 at 04:40:17PM +0200, Arnd Bergmann wrote:

> No code yet, so far not much more than the ideas that I listed. We
> are currently looking for someone interested in doing the work
> or maybe sponsoring it if they have a strong interest.

If no one have yet taken it up, i am interested in doing the work, i
will sponsor myself :). i will proceed at a slow pace without derailing
my other things normal.

To keep expectations realistic: i have not yet taken task of this
complexity, it is more of a learning for me. My familiarity with Linux
at the ARM architecture level is mostly on no-MMU (Cortex-M), have not
worked so far seriously on MMU Linux at the ARM architectural level,
though used to go through ARM ARM v7-AR at times.

i have a few 32-bit ARM Cortex-A (A5, A8 & A9) boards, maximum RAM 1G,
none have LPAE, seems i have to buy one for this purpose.

And if someone else wants to do it, i will not take it up.

Regards
afzal
