Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CA3C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 06:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8721B2065F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 06:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgGLGcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 02:32:50 -0400
Received: from smtprelay0115.hostedemail.com ([216.40.44.115]:54016 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727777AbgGLGct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 02:32:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 84F7C837F24A;
        Sun, 12 Jul 2020 06:32:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bead16_0f1504526edd
X-Filterd-Recvd-Size: 1575
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sun, 12 Jul 2020 06:32:47 +0000 (UTC)
Message-ID: <866325009f9ae73b3a563dd745f901260a372242.camel@perches.com>
Subject: Re: [PATCH] net: sky2: switch from 'pci_' to 'dma_' API
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        mlindner@marvell.com, stephen@networkplumber.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Sat, 11 Jul 2020 23:32:45 -0700
In-Reply-To: <8a3e5514-9cc9-18f3-9a98-81007419a20a@wanadoo.fr>
References: <20200711204944.259152-1-christophe.jaillet@wanadoo.fr>
         <2181026e68d2948c396cc7a7b6bfb7146c1cd5f6.camel@perches.com>
         <8a3e5514-9cc9-18f3-9a98-81007419a20a@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-07-12 at 08:29 +0200, Christophe JAILLET wrote:
> Le 11/07/2020 à 23:20, Joe Perches a écrit :
> > On Sat, 2020-07-11 at 22:49 +0200, Christophe JAILLET wrote:
> > > The wrappers in include/linux/pci-dma-compat.h should go away.
> > why?
> > 
> > 
>  From Christoph Hellwig 
> https://marc.info/?l=kernel-janitors&m=158745678307186&w=4

There's no why there.
There's just an assertion a wrapper should "go away".

"the wrappers in include/linux/pci-dma-compat.h should go away"

wrappers aren't all bad.

