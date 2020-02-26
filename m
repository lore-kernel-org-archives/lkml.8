Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70554C4BA2D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5191424653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgBZWbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:31:45 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:45530 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgBZWbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:31:44 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 2482A2A0A1;
        Wed, 26 Feb 2020 17:31:42 -0500 (EST)
Date:   Thu, 27 Feb 2020 09:31:44 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Greg Ungerer <gerg@linux-m68k.org>
cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 06/18] m68k: Replace setup_irq() by request_irq()
In-Reply-To: <a682c89d-baf2-3d3c-647f-a07b2a146c9f@linux-m68k.org>
Message-ID: <alpine.LNX.2.22.394.2002270908380.8@nippy.intranet>
References: <cover.1582471508.git.afzal.mohd.ma@gmail.com> <00b0bf964278dd0bb3e093283994399ff796cca5.1582471508.git.afzal.mohd.ma@gmail.com> <73c3ad08-963d-fea2-91d7-b06e4ef8d3ef@linux-m68k.org> <alpine.LNX.2.22.394.2002261151220.9@nippy.intranet>
 <caa5686a-5be3-5848-fdee-36f54237ccb6@linux-m68k.org> <alpine.LNX.2.22.394.2002261637400.8@nippy.intranet> <a682c89d-baf2-3d3c-647f-a07b2a146c9f@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020, Greg Ungerer wrote:

> On 26/2/20 4:39 pm, Finn Thain wrote:
> > 
> > If -EBUSY means the end user has misconfigured something, printing
> > "request_irq failed" would be helpful. But does that still happen?
> 
> I have seen it many times. Its not at all difficult to get interrupt 
> assignments wrong, duplicated, or otherwise mistaken when creating 
> device trees. Not so much m68k/coldfire platforms where they are most 
> commonly hard coded.
> 

I was thinking of end users and production builds. You seem to be 
concerned about developers. Catering to developers argues for pr_debug() 
here, if anything.

You say you've seen -16 errors "many times". Have you also seen -22? Did 
the ability to distinguish these values help you to fix your device tree?

> > ...
> > 
> > BTW, one of the benefits of "%s: request_irq failed" is that a 
> > compilation unit with multiple request_irq calls permits the compiler 
> > to coalesce all duplicated format strings. Whereas, that's not 
> > possible with "foo: request_irq failed" and "bar: request_irq failed".
> 
> Given the wide variety of message text used with failed request_irq() 
> calls it would be shear luck that this matched anything else. A quick 
> grep shows that "%s: request_irq() failed\n" has no other exact matches 
> in the current kernel source.
> 

You are overlooking the patches in this series that produce multiple 
identical format strings.

And the present lack of consistency isn't a great argument for more 
inconsistency IMO.
