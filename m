Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63083C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBC920719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgCXSHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:07:40 -0400
Received: from elvis.franken.de ([193.175.24.41]:60751 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbgCXSHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 14:07:39 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jGnxb-0002Bo-01; Tue, 24 Mar 2020 19:07:31 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 74B47C09A5; Tue, 24 Mar 2020 19:07:18 +0100 (CET)
Date:   Tue, 24 Mar 2020 19:07:18 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Huacai Chen <chenhc@lemote.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 00/11] Modernize Loongson64 Machine v6
Message-ID: <20200324180718.GB8911@alpha.franken.de>
References: <20190827085302.5197-1-jiaxun.yang@flygoat.com>
 <20200324153624.23109-1-jiaxun.yang@flygoat.com>
 <20200324154747.18e8ccd5@why>
 <8C3E32B2-11DB-40A6-A19E-162B8E42330C@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8C3E32B2-11DB-40A6-A19E-162B8E42330C@flygoat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 11:51:18PM +0800, Jiaxun Yang wrote:
> >How do you want to get these merged? I can take the first 6 patches
> >through the irqchip tree, and leave the rest to go via the MIPS tree.
> >
> >Otherwise, if you plan to have the whole thing go via the MIPS tree,
> >please add my:
> >
> >Reviewed-by: Marc Zyngier <maz@kernel.org>
> >
> >to patches 1, 2, 4 and 6.
> >
> >Please let me know quickly, as I'd like to close the irqchip tree
> >tomorrow.
> 
> I'd prefer all go through MIPS tree.
> 
> Thomas, could you please help with that?

I'm fine taking them. Could you please add Signed-offs from your
co-developer and look at the remaining checkpatch warnings ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
