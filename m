Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7953C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 23:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819372173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 23:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgA1XtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 18:49:21 -0500
Received: from smtprelay0163.hostedemail.com ([216.40.44.163]:52785 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726293AbgA1XtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 18:49:21 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id DF2BE40D6;
        Tue, 28 Jan 2020 23:49:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: baby58_342707bfef54f
X-Filterd-Recvd-Size: 3762
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Jan 2020 23:49:18 +0000 (UTC)
Message-ID: <60cd544bfba4251cf656f377c20ccf8b470a92dc.camel@perches.com>
Subject: Re: [PATCH][next][V2] i2c: xiic: fix indentation issue
From:   Joe Perches <joe@perches.com>
To:     Colin Ian King <colin.king@canonical.com>,
        Peter Rosin <peda@axentia.se>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Johan Hovold <johan@kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jan 2020 15:48:13 -0800
In-Reply-To: <3b287fb5-e344-c13a-2803-09c2958b9b0d@canonical.com>
References: <20200127102303.44133-1-colin.king@canonical.com>
         <2dd84ab2-a7a3-fdd8-6bd6-07f1b3d5cd00@xilinx.com>
         <20200127120535.GC1847@kadam>
         <89661e5e-7662-81a5-ec36-57367825de5e@canonical.com>
         <35ed6501-3b26-36a9-d332-d4ed3366ebd8@axentia.se>
         <3b287fb5-e344-c13a-2803-09c2958b9b0d@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-28 at 23:10 +0000, Colin Ian King wrote:
> On 28/01/2020 21:45, Peter Rosin wrote:
> > On 2020-01-27 13:08, Colin Ian King wrote:
> > > On 27/01/2020 12:05, Dan Carpenter wrote:
> > > > On Mon, Jan 27, 2020 at 12:03:02PM +0100, Michal Simek wrote:
> > > > > On 27. 01. 20 11:23, Colin King wrote:
> > > > > > From: Colin Ian King <colin.king@canonical.com>
> > > > > > 
> > > > > > There is a statement that is indented one level too deeply, remove
> > > > > > the extraneous tab.
> > > > > > 
> > > > > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > > > > ---
> > > > > > V2: fix type in commit message
> > > > > > ---
> > > > > >  drivers/i2c/busses/i2c-xiic.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> > > > > > index b17d30c9ab40..90c1c362394d 100644
> > > > > > --- a/drivers/i2c/busses/i2c-xiic.c
> > > > > > +++ b/drivers/i2c/busses/i2c-xiic.c
> > > > > > @@ -261,7 +261,7 @@ static int xiic_clear_rx_fifo(struct xiic_i2c *i2c)
> > > > > >  		xiic_getreg8(i2c, XIIC_DRR_REG_OFFSET);
> > > > > >  		if (time_after(jiffies, timeout)) {
> > > > > >  			dev_err(i2c->dev, "Failed to clear rx fifo\n");
> > > > > > -				return -ETIMEDOUT;
> > > > > > +			return -ETIMEDOUT;
> > > > > >  		}
> > > > > >  	}
> > > > > >  
> > > > > > 
> > > > > 
> > > > > As was suggested by Peter you should also add Fixes: <sha1> ("patch
> > > > > subject")
> > > > > 
> > > > 
> > > > It's not really a bugfix, it's just a cleanup.
> > > 
> > > I'm surprised i wasn't asked for a bug number too.
> > 
> > Very funny.
> 
> Apologies for being flippant. I didn't mean to offend. My bad #1.
> 
> > I realize that you, the three complainers (Johan, Dan and Colin), together
> > have almost 10000 commits. So, I feel a bit outranked.
> > 
> > However, this ridicule is unfair.

It's not unfair.

In _no_ sense is a whitespace only change a valid reason
to use a "Fixes:" tag.

A whitespace only coding-style issue is _not_ a bug.

From submitting-patches:

If your patch fixes a bug in a specific commit, e.g. you found an issue using
``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
the SHA-1 ID, and the one line summary.


