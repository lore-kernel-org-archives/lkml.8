Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAD9C5519A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 04:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1DDD206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 04:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgD0EuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 00:50:00 -0400
Received: from baldur.buserror.net ([165.227.176.147]:35002 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbgD0EuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 00:50:00 -0400
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1jSvgG-0007p7-BQ; Sun, 26 Apr 2020 23:47:44 -0500
Message-ID: <35c53c47c4b8cc648f56144306c21224163f1e72.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?=E7=8E=8B=E6=96=87=E8=99=8E?= <wenhu.wang@vivo.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kernel@vivo.com, robh@kernel.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>
Date:   Sun, 26 Apr 2020 23:47:43 -0500
In-Reply-To: <20200421093427.GC725219@kroah.com>
References: <20200420145128.GA4131449@kroah.com>
         <AB6A-gBhCLyx5bgBRPuIiqp1.3.1587460187094.Hmail.wenhu.wang@vivo.com>
         <20200421093427.GC725219@kroah.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, wenhu.wang@vivo.com, arnd@arndb.de, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kernel@vivo.com, robh@kernel.org, christophe.leroy@c-s.fr, mpe@ellerman.id.au, rdunlap@infradead.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v2,RESEND] misc: new driver sram_uapi for user level
 SRAM access
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-21 at 11:34 +0200, Greg KH wrote:
> On Tue, Apr 21, 2020 at 05:09:47PM +0800, 王文虎 wrote:
> > Hi, Greg, Arnd,
> > 
> > Thank you for your comments first, and then really very very very sorry
> > for driving Greg to sigh and I hope there would be chance to share Moutai
> > (rather than whisky, we drink it much, a kind of Baijiu), after the virus.
> > 
> > Back to the comments, I'd like to do a bit of documentation or explanation
> > first,
> > which should have been done early or else there would not be so much to
> > explain:
> > 1. What I have been trying to do is to access the Freescale Cache-SRAM
> > device form
> > user level;
> > 2. I implemented it using UIO, which was thought of non-proper;
> 
> I still think that using uio is the best way to do this, and never said
> it was "non-proper".  All we got bogged down in was the DT
> representation of stuff from what I remember.  That should be worked
> through.

The hardware is already reperesented in the DT (the various "fsl,<chip>-l2-
cache-controller" nodes).  What is there to "work through"?

I didn't say UIO was "non-proper" though I did question whether it was the
best fit.  We don't need the IRQ stuff, and we do want some means of
allocating multiple regions to different users (at least, that seems to be a
requirement for Wenhu, and it leaves open the possibility of a kernel driver
allocating some SRAM for itself which appears to be what
arch/powerpc/sysdev/fsl_85xx_cache_sram.c was originally meant for) and I
don't see how you'd do that through UIO.

So that leaves either a separate interface for dynamic region allocation (in
which case why not map through that interface), static allocation via
boot/module parameters which you didn't like, or abusing the device tree with
something that's not hardware description (why don't we replace kmalloc with
some device tree nodes while we're at it).

-Scott


