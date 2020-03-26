Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083A4C2D0ED
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC58B20714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgCZTdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:33:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:43848 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbgCZTdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:33:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AA01AAAC7;
        Thu, 26 Mar 2020 19:33:13 +0000 (UTC)
Date:   Thu, 26 Mar 2020 20:33:11 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc:     Allison Randal <allison@lohutok.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Russell Currey <ruscur@russell.cc>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] powerpc/64: Fix section mismatch warnings.
Message-ID: <20200326193311.GL25468@kitsune.suse.cz>
References: <20200326163742.28990-1-msuchanek@suse.de>
 <1585245057.hh0vutz28g.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585245057.hh0vutz28g.naveen@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 11:22:03PM +0530, Naveen N. Rao wrote:
> Michal Suchanek wrote:
> > Fixes the following warnings:
> > 
> > WARNING: vmlinux.o(.text+0x2d24): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init()
> > The function __boot_from_prom() references
> > the function __init prom_init().
> > This is often because __boot_from_prom lacks a __init
> > annotation or the annotation of prom_init is wrong.
> > 
> > WARNING: vmlinux.o(.text+0x2fd0): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel()
> > The function start_here_common() references
> > the function __init start_kernel().
> > This is often because start_here_common lacks a __init
> > annotation or the annotation of start_kernel is wrong.
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  arch/powerpc/kernel/head_64.S | 4 ++++
> >  1 file changed, 4 insertions(+)
> 
> Michael committed a similar patch just earlier today:
> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=6eeb9b3b9ce588f14a697737a30d0702b5a20293

Missed it because it did not reach master yet.

Thanks

Michal
