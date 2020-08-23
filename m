Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CB7C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 00:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE90207C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 00:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgHWAtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 20:49:04 -0400
Received: from netrider.rowland.org ([192.131.102.5]:50219 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725768AbgHWAtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 20:49:04 -0400
Received: (qmail 292705 invoked by uid 1000); 22 Aug 2020 20:49:03 -0400
Date:   Sat, 22 Aug 2020 20:49:03 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     trix@redhat.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: storage: initialize variable
Message-ID: <20200823004903.GB292576@rowland.harvard.edu>
References: <20200822211839.5117-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200822211839.5117-1-trix@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 02:18:39PM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis reports this representative problem
> 
> transport.c:495:15: warning: Assigned value is garbage or
>   undefined
>         length_left -= partial;
>                    ^  ~~~~~~~
> partial is set only when usb_stor_bulk_transfer_sglist()
> is successful.
> 
> So initialize to partial to 0.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/usb/storage/transport.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
> index 238a8088e17f..ce920851b1f2 100644
> --- a/drivers/usb/storage/transport.c
> +++ b/drivers/usb/storage/transport.c
> @@ -461,7 +461,7 @@ static int usb_stor_bulk_transfer_sglist(struct us_data *us, unsigned int pipe,
>  int usb_stor_bulk_srb(struct us_data* us, unsigned int pipe,
>  		      struct scsi_cmnd* srb)
>  {
> -	unsigned int partial;
> +	unsigned int partial = 0;
>  	int result = usb_stor_bulk_transfer_sglist(us, pipe, scsi_sglist(srb),
>  				      scsi_sg_count(srb), scsi_bufflen(srb),
>  				      &partial);
> @@ -484,7 +484,7 @@ int usb_stor_bulk_transfer_sg(struct us_data* us, unsigned int pipe,
>  		void *buf, unsigned int length_left, int use_sg, int *residual)
>  {
>  	int result;
> -	unsigned int partial;
> +	unsigned int partial = 0;
>  
>  	/* are we scatter-gathering? */
>  	if (use_sg) {

Yes, this is a bug.  But the right way to fix it is to change 
usb_stor_bulk_transfer_sglist(): Make it store 0 to *act_len at the 
start.

That way you change only one localized piece of code, instead of 
changing multiple callers and leaving a possibility of more errors being 
added in the future.

Alan Stern
