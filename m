Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB999C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 19:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F7B25234
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 19:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgFUT37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 15:29:59 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:16996 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbgFUT37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 15:29:59 -0400
Received: from xps-7390 (cpe-23-242-39-94.socal.res.rr.com [23.242.39.94])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 49qjKx3yTpz1h7Y;
        Sun, 21 Jun 2020 15:29:57 -0400 (EDT)
Date:   Sun, 21 Jun 2020 12:29:56 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Commit 25f12ae45fc1 ("maccess: rename probe_kernel_address to
 get_kernel_nofault") causing several OOPSes
In-Reply-To: <CAHk-=whj7YBvNT3FPHc8oUqwRhjbRkJESnUx6bbpA5ys6W9ujw@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2006211226240.9484@xps-7390>
References: <alpine.DEB.2.22.394.2006181751270.9276@xps-7390> <20200619065007.GA3041@lst.de> <alpine.DEB.2.22.394.2006182351090.9276@xps-7390> <20200619074233.GA3723@lst.de> <alpine.DEB.2.22.394.2006200640370.2845@xps-7390>
 <CAHk-=whj7YBvNT3FPHc8oUqwRhjbRkJESnUx6bbpA5ys6W9ujw@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, Jun 20, 2020 at 6:46 AM Kenneth R. Crudup <kenny@panix.com> wrote:

> > So, be totally surprised :) I've just booted with "maccess: rename
> > probe_kernel_address to get_kernel_nofault" intact and your probe_roms.c
> > patch with no issues.
> > (Perhaps there's some sort of compiler optimization going on?)

On Sat, 20 Jun 2020, Linus Torvalds wrote:


> I'm staring at that opatch and not seeing how it could _possibly_ make
> any difference in code generation.

> Which is the obvious next step: would you mind compiling that file
> with and without the patch and sending me the two object files?

It looks like you had already, do you still need me to do this?

FWIW, here's my gcc info:

$  gcc --version
gcc (Ubuntu 9.3.0-13ubuntu1) 9.3.0

OH- I did change arch/x86/Makefile in my own builds- maybe this could matter?
Doubtful, but I could test later tonight or tomorrow (gotta do some ;l work in the
meantime).

----
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 00e378de8bc0..37aff76f3067 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -123,7 +123,8 @@ else
         cflags-$(CONFIG_MPSC) += $(call cc-option,-march=nocona)

         cflags-$(CONFIG_MCORE2) += \
-                $(call cc-option,-march=core2,$(call cc-option,-mtune=generic))
+                $(call cc-option,-march=icelake-client,$(call cc-option,-mtune=native)) \
+                $(call cc-option,-mtune=icelake-client,$(call cc-option,-mtune=native))
        cflags-$(CONFIG_MATOM) += $(call cc-option,-march=atom) \
                $(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
         cflags-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=generic)
----

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Orange County CA
