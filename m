Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE54C433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30DCD2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbgG1QjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:39:13 -0400
Received: from elvis.franken.de ([193.175.24.41]:52168 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731423AbgG1QjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:39:12 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1k0SdC-00058I-00; Tue, 28 Jul 2020 18:39:10 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id D13B8C0A99; Tue, 28 Jul 2020 14:33:23 +0200 (CEST)
Date:   Tue, 28 Jul 2020 14:33:23 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 2/2] MIPS: ingenic: Enable JZ4780_NEMC manually
Message-ID: <20200728123323.GA14660@alpha.franken.de>
References: <20200728104503.23655-1-krzk@kernel.org>
 <20200728104503.23655-2-krzk@kernel.org>
 <B4F6EQ.WB2WZOY40FDR@crapouillou.net>
 <20200728111935.GA26683@kozik-lap>
 <20200728113702.GB13443@alpha.franken.de>
 <20200728120035.GA28766@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200728120035.GA28766@kozik-lap>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 02:00:35PM +0200, Krzysztof Kozlowski wrote:
> On Tue, Jul 28, 2020 at 01:37:02PM +0200, Thomas Bogendoerfer wrote:
> > On Tue, Jul 28, 2020 at 01:19:35PM +0200, Krzysztof Kozlowski wrote:
> > > On Tue, Jul 28, 2020 at 01:12:11PM +0200, Paul Cercueil wrote:
> > > > Hi Krzysztof,
> > > > 
> > > > Le mar. 28 juil. 2020 à 12:45, Krzysztof Kozlowski <krzk@kernel.org> a écrit
> > > > :
> > > > > The CONFIG_JZ4780_NEMC was previously a default on MIPS but now it has
> > > > > to be enabled manually.
> > > > > 
> > > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > 
> > > > I think you should swap the two so that there are no problems when
> > > > bisecting.
> > > 
> > > Good point. I was thinking that it will go via some of MIPS trees and
> > > the patch #1 will just wait a cycle.  However with acks, I can take it
> > > through drivers/memory tree.
> > 
> > I've acked the patch.
> > 
> > Thomas.
> 
> Thanks but now I noticed that one of changed configs
> (arch/mips/configs/rs90_defconfig) is only in MIPS tree.
> 
> I think it is easier then to take the patch #2 (configs) via MIPS and
> wait with #1 for the next cycle or also take it via MIPS if it applies
> cleanly.

ok, I'll take it.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
