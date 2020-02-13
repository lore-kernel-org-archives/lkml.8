Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF24C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 23:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0A724680
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 23:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581637648;
	bh=3GXtknHF3JASE9dw9OBZQlRxMhhyboJ6+p8mE7+CiLo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0Ndc3XKplr4N4PPm4J/Dps4zZtk+pSAVLx2dniLQILVuEjueoVrxj12DCJqARZUNZ
	 QKNSt1fpN2gZHY1LvNufAnnZpb88NVNqDMdWaIPiEKDipm70Hx1vilghTG8naWXviW
	 OoK8dHDwaSAYfhFp2PXtEd8PwrQHeZ8h9HjVyeuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgBMXr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 18:47:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbgBMXr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 18:47:27 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1FAA24673;
        Thu, 13 Feb 2020 23:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581637646;
        bh=3GXtknHF3JASE9dw9OBZQlRxMhhyboJ6+p8mE7+CiLo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uvMd4N3l6RjqDiO/3MvjwBzx6bC1PnUt1vHOFFtiZ2Oeo4gtXwZdfk8luoriP1DaS
         aNQctdL+kGypwT/okptaE/SHhnw8rbdPRFuMn9Oo46W5OMe3EZupNDZiKzkZp5bZY3
         FOIKNzGaytRWPNcjdQ5EMMjlX39CuSOyordL2uno=
Received: by mail-qt1-f172.google.com with SMTP id d9so5769331qte.12;
        Thu, 13 Feb 2020 15:47:26 -0800 (PST)
X-Gm-Message-State: APjAAAWcodEF9nkttni0P9UbnOqQu1O62fQzcw6nrcxCkAZrtg5PW+II
        NtYBnblgJYfAL414lv233dwwvSS9plA3r8tJAQ==
X-Google-Smtp-Source: APXvYqwR09pfxPU5HyaUV4ckdgYJfPycI3viAcm/O8sJO+4/HHsGty1R7h1ZxUA+Kn+mfM/ZF8341OIcyV+H1uPgmC0=
X-Received: by 2002:ac8:59:: with SMTP id i25mr498799qtg.110.1581637645982;
 Thu, 13 Feb 2020 15:47:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581497860.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1581497860.git.michal.simek@xilinx.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 13 Feb 2020 17:47:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJeXJ6zWvEUi=gyOV0eCcXsvNmkK9EstC9hg9AKfMXnKw@mail.gmail.com>
Message-ID: <CAL_JsqJeXJ6zWvEUi=gyOV0eCcXsvNmkK9EstC9hg9AKfMXnKw@mail.gmail.com>
Subject: Re: [PATCH 00/10] Hi,
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Cornelia Huck <cohuck@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mubin Sayyed <mubinusm@xilinx.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Will Deacon <will@kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 2:58 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
>
> I am sending this series as before SMP support.
> Most of these patches are clean ups and should be easy to review them. I
> expect there will be more discussions about SMP support.

While not really related to adding SMP, any chance you or someone
could look at moving microblaze PCI support to drivers/pci/? I suspect
much of the code should drop out as we have common helpers for much of
it now. That would leave only powerpc and mips for DT+PCI platforms.

Rob
