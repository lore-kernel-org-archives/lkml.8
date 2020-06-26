Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D1AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84132080C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgFZIgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:36:31 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:60394 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFZIga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:36:30 -0400
Received: from xps-7390 (cpe-23-242-39-94.socal.res.rr.com [23.242.39.94])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 49tVbc6GHczxrj;
        Fri, 26 Jun 2020 04:36:28 -0400 (EDT)
Date:   Fri, 26 Jun 2020 01:36:26 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Commit 25f12ae45fc1 ("maccess: rename probe_kernel_address to
 get_kernel_nofault") causing several OOPSes
In-Reply-To: <CAHk-=wjDfQZN8BeM-21vZ=ALa5jaJSRjRei+_0ET9uruwaYwaw@mail.gmail.com>
Message-ID: <alpine.DEB.2.23.453.2006260127210.3063@xps-7390>
References: <alpine.DEB.2.22.394.2006181751270.9276@xps-7390> <20200619065007.GA3041@lst.de> <alpine.DEB.2.22.394.2006182351090.9276@xps-7390> <20200619074233.GA3723@lst.de> <alpine.DEB.2.22.394.2006200640370.2845@xps-7390>
 <CAHk-=whj7YBvNT3FPHc8oUqwRhjbRkJESnUx6bbpA5ys6W9ujw@mail.gmail.com> <alpine.DEB.2.22.394.2006211226240.9484@xps-7390> <CAHk-=wjDfQZN8BeM-21vZ=ALa5jaJSRjRei+_0ET9uruwaYwaw@mail.gmail.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 21 Jun 2020, Linus Torvalds wrote:

> For me that patch makes no difference.

So ... it looks like this original issue (random crashes if this commit was
made and the ROMs thing isn't patched) is a red herring.

For some time now, my Thunderbolt adapter (Lenovo 2nd-Gen TB dock) sometimes
... "acts up" on reboots/powerons with my laptop (Dell XPS 13 2-in-1) if I
boot with it connected- I'll get random disconnects and/or lack of external
video and/or its internal devices will drop offline. I suspect these crashes
were related to the PCIe scribbling(?) somewhere(?) (even though I have IOMMU
turned on). I can't track it down, and I think the issue may lie somewhere
either with the Thunderbolt subsystem (my TB domain UUID gets regenerated on
every boot and is always changing) or a bug in this Dell's BIOS (probably
the likely culprit).

... in any case, I booted a fresh branch that does contain the commit in the
 Subject: line, and w/o Christoph's ROMs patch and as long as I don't boot
with the TB adapter attached (or from a cold boot- SOMEtimes) it seems to
work. So, my apologies for wasting everyone's time.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Orange County CA
