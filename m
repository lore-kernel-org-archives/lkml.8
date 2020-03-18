Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF70DC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB4120663
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgCRQOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 12:14:53 -0400
Received: from smtprelay0091.hostedemail.com ([216.40.44.91]:37834 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726473AbgCRQOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 12:14:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 22426181D3030;
        Wed, 18 Mar 2020 16:14:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: size14_d38f1d1e6128
X-Filterd-Recvd-Size: 2078
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 18 Mar 2020 16:14:50 +0000 (UTC)
Message-ID: <1bcfc53c523f120a4cf0f19490de506c5704d306.camel@perches.com>
Subject: Re: [PATCH] bnx2x: fix spelling mistake "pauseable" -> "pausable"
From:   Joe Perches <joe@perches.com>
To:     Colin Ian King <colin.king@canonical.com>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-everest-linux-l2@marvell.com,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Mar 2020 09:13:02 -0700
In-Reply-To: <7ce6d58f-a2d0-7173-0163-f1e3b5f93e65@canonical.com>
References: <20200317182921.482606-1-colin.king@canonical.com>
         <8d9544fe6d413cdd600504e48f301e023b99e17b.camel@perches.com>
         <7ce6d58f-a2d0-7173-0163-f1e3b5f93e65@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-18 at 09:16 +0000, Colin Ian King wrote:
> On 18/03/2020 03:37, Joe Perches wrote:
> > On Tue, 2020-03-17 at 18:29 +0000, Colin King wrote:
> > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > Bulk rename of variables and literal strings. No functional
> > > changes.
> > 
> > I'm not sure either spelling is a "real" word and
> > pauseable seems more intelligible and less likely
> > to be intended to be a typo of "possible" to me.
> 
> It's indeed of marginal benefit. However..
> 
> https://www.yourdictionary.com/pausable

Then again there's this:
https://www.spellcheck.net/misspelled-words/pausable

Correct spelling for PAUSABLE
        
            We think the word pausable is a misspelling.

and

https://www.anagrammer.com/crossword/answer/pausable

The word PAUSABLE is NOT valid in any word game. (Sorry, you cannot play
PAUSABLE in Scrabble, Words With Friends etc) 
    

                
        

