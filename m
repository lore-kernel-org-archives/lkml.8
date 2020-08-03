Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CEBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A2B207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgHCTfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:35:54 -0400
Received: from smtprelay0052.hostedemail.com ([216.40.44.52]:52322 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726906AbgHCTfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 15:35:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id DDA80180A9F5C;
        Mon,  3 Aug 2020 19:35:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: silk24_410b3b026fa0
X-Filterd-Recvd-Size: 2397
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon,  3 Aug 2020 19:35:51 +0000 (UTC)
Message-ID: <69b4c4838cb743e24a79f81de487ac2e494843ef.camel@perches.com>
Subject: Re: [PATCH] gve: Fix the size used in a 'dma_free_coherent()' call
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     csully@google.com, sagis@google.com, jonolson@google.com,
        davem@davemloft.net, lrizzo@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Mon, 03 Aug 2020 12:35:49 -0700
In-Reply-To: <3a25ddc6-adaa-d17d-50f4-8f8ab2ed25eb@wanadoo.fr>
References: <20200802141523.691565-1-christophe.jaillet@wanadoo.fr>
         <20200803084106.050eb7f6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
         <3a25ddc6-adaa-d17d-50f4-8f8ab2ed25eb@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-03 at 21:19 +0200, Christophe JAILLET wrote:
> Le 03/08/2020 à 17:41, Jakub Kicinski a écrit :
> > On Sun,  2 Aug 2020 16:15:23 +0200 Christophe JAILLET wrote:
> > > Update the size used in 'dma_free_coherent()' in order to match the one
> > > used in the corresponding 'dma_alloc_coherent()'.
> > > 
> > > Fixes: 893ce44df5 ("gve: Add basic driver framework for Compute Engine Virtual NIC")
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > 
> > Fixes tag: Fixes: 893ce44df5 ("gve: Add basic driver framework for Compute Engine Virtual NIC")
> > Has these problem(s):
> > 	- SHA1 should be at least 12 digits long
> > 	  Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
> > 	  or later) just making sure it is not set (or set to "auto").
> > 
> 
> Hi,
> 
> I have git 2.25.1 and core.abbrev is already 12, both in my global 
> .gitconfig and in the specific .git/gitconfig of my repo.
> 
> I would have expected checkpatch to catch this kind of small issue.
> Unless I do something wrong, it doesn't.
> 
> Joe, does it make sense to you and would one of the following patch help?

18 months ago I sent:

https://lore.kernel.org/lkml/40bfc40958fca6e2cc9b86101153aa0715fac4f7.camel@perches.com/


