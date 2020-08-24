Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F134DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29EF20656
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgHXVSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:18:41 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:46752 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXVSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:18:40 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id D265F1A4018B; Mon, 24 Aug 2020 14:18:39 -0700 (PDT)
Date:   Mon, 24 Aug 2020 14:18:39 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     trix@redhat.com
Cc:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: storage: initialize variable
Message-ID: <20200824211839.6c7m7yhgd7ffq3g3@shells.gnugeneration.com>
References: <20200824211027.11543-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824211027.11543-1-trix@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 02:10:27PM -0700, trix@redhat.com wrote:
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
> So set partial on entry to 0.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/usb/storage/transport.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
> index 238a8088e17f..044429717dcc 100644
> --- a/drivers/usb/storage/transport.c
> +++ b/drivers/usb/storage/transport.c
> @@ -414,6 +414,9 @@ static int usb_stor_bulk_transfer_sglist(struct us_data *us, unsigned int pipe,
>  {
>  	int result;
>  
> +	if (act_len)
> +		*act_len = 0;
> +
>  	/* don't submit s-g requests during abort processing */
>  	if (test_bit(US_FLIDX_ABORTING, &us->dflags))
>  		return USB_STOR_XFER_ERROR;

At a glance this seems odd to me.  If the caller insists on ignoring
the return value, shouldn't it just initialize partial to zero?

In my experience it's generally frowned upon for functions to store
results in error paths.

Regards,
Vito Caputo
