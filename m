Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F24EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67185206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgHYAfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 20:35:04 -0400
Received: from netrider.rowland.org ([192.131.102.5]:54197 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727846AbgHYAfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:35:03 -0400
Received: (qmail 350796 invoked by uid 1000); 24 Aug 2020 20:35:01 -0400
Date:   Mon, 24 Aug 2020 20:35:01 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     trix@redhat.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: storage: initialize variable
Message-ID: <20200825003501.GA350601@rowland.harvard.edu>
References: <20200824211027.11543-1-trix@redhat.com>
 <20200824211839.6c7m7yhgd7ffq3g3@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824211839.6c7m7yhgd7ffq3g3@shells.gnugeneration.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 02:18:39PM -0700, Vito Caputo wrote:
> On Mon, Aug 24, 2020 at 02:10:27PM -0700, trix@redhat.com wrote:
> > From: Tom Rix <trix@redhat.com>
> > 
> > clang static analysis reports this representative problem
> > 
> > transport.c:495:15: warning: Assigned value is garbage or
> >   undefined
> >         length_left -= partial;
> >                    ^  ~~~~~~~
> > partial is set only when usb_stor_bulk_transfer_sglist()
> > is successful.
> > 
> > So set partial on entry to 0.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Tom Rix <trix@redhat.com>
> > ---
> >  drivers/usb/storage/transport.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
> > index 238a8088e17f..044429717dcc 100644
> > --- a/drivers/usb/storage/transport.c
> > +++ b/drivers/usb/storage/transport.c
> > @@ -414,6 +414,9 @@ static int usb_stor_bulk_transfer_sglist(struct us_data *us, unsigned int pipe,
> >  {
> >  	int result;
> >  
> > +	if (act_len)
> > +		*act_len = 0;
> > +
> >  	/* don't submit s-g requests during abort processing */
> >  	if (test_bit(US_FLIDX_ABORTING, &us->dflags))
> >  		return USB_STOR_XFER_ERROR;
> 
> At a glance this seems odd to me.  If the caller insists on ignoring
> the return value, shouldn't it just initialize partial to zero?

In this case, the callers are not the final consumers of the return 
value or of partial.  They merely copy those values back up to _their_ 
callers, and those copy operations are what the static analyzer objects 
to.

> In my experience it's generally frowned upon for functions to store
> results in error paths.

I don't see any reason for such an attitude, at least not here.  It 
makes perfectly good sense, if an error prevents transmission of an 
entire data buffer, to store the amount of data that did get 
transmitted.

Alan Stern
