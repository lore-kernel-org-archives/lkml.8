Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01F7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B3A22B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbgGaP6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:58:20 -0400
Received: from elvis.franken.de ([193.175.24.41]:56730 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387504AbgGaP6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 11:58:19 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1k1XQH-0000Ng-00; Fri, 31 Jul 2020 17:58:17 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 900BEC0B21; Fri, 31 Jul 2020 17:45:39 +0200 (CEST)
Date:   Fri, 31 Jul 2020 17:45:39 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] of_address: Guard of_bus_pci_get_flags with CONFIG_PCI
Message-ID: <20200731154539.GA16683@alpha.franken.de>
References: <20200730005614.32302-1-jiaxun.yang@flygoat.com>
 <CAL_JsqKPO155zVMqvWbGd84e1Ypk1SJDySU8YCRRA+uy7wtcHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKPO155zVMqvWbGd84e1Ypk1SJDySU8YCRRA+uy7wtcHA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 08:27:55AM -0600, Rob Herring wrote:
> On Wed, Jul 29, 2020 at 7:04 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> >
> > After 2f96593ecc37 ("of_address: Add bus type match for pci ranges parser"),
> > the last user of of_bus_pci_get_flags when CONFIG_PCI is disabled had gone.
> >
> > This caused unused function warning when compiling without CONFIG_PCI.
> > Fix by guarding it with CONFIG_PCI.
> >
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Fixes: 2f96593ecc37 ("of_address: Add bus type match for pci ranges parser")
> > ---
> >  drivers/of/address.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Rob Herring <robh@kernel.org>

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
