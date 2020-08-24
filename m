Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE9AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4014F22B40
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgHXQJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:09:41 -0400
Received: from elvis.franken.de ([193.175.24.41]:60794 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgHXQJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:09:33 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1kAF2I-0000tt-00; Mon, 24 Aug 2020 18:09:30 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 29165C0DBF; Mon, 24 Aug 2020 18:08:58 +0200 (CEST)
Date:   Mon, 24 Aug 2020 18:08:58 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Paravirt: remove remaining pieces of paravirt
Message-ID: <20200824160858.GA7827@alpha.franken.de>
References: <20200822080251.65555-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200822080251.65555-1-tsbogend@alpha.franken.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 10:02:51AM +0200, Thomas Bogendoerfer wrote:
> Commit 35546aeede8e ("MIPS: Retire kvm paravirt") removed
> kvm paravirt support, but missed arch/mips/include/mach-paravirt.
> Remove it as well.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  .../asm/mach-paravirt/cpu-feature-overrides.h      | 35 ---------------
>  arch/mips/include/asm/mach-paravirt/irq.h          | 19 --------
>  .../include/asm/mach-paravirt/kernel-entry-init.h  | 52 ----------------------

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
