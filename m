Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD076C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9606B2068F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387642AbgGaP6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:58:24 -0400
Received: from elvis.franken.de ([193.175.24.41]:56742 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387634AbgGaP6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 11:58:21 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1k1XQH-0000Ng-01; Fri, 31 Jul 2020 17:58:17 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id A855FC0B3C; Fri, 31 Jul 2020 17:45:58 +0200 (CEST)
Date:   Fri, 31 Jul 2020 17:45:58 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-rpi-kernel@lists.infradead.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: address: Fix parser address/size cells initialization
Message-ID: <20200731154558.GB16683@alpha.franken.de>
References: <20200731100248.26982-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731100248.26982-1-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 12:02:48PM +0200, Nicolas Saenz Julienne wrote:
> bus->count_cells() parses cells starting from the node's parent. This is
> not good enough for parser_init() which is generally parsing a bus node.
> 
> Revert to previous behavior using of_bus_n_*_cells().
> 
> Fixes: 2f96593ecc37 ("of_address: Add bus type match for pci ranges parser")
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/of/address.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
