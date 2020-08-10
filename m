Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F12C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3825520866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgHJROO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 13:14:14 -0400
Received: from smtprelay0069.hostedemail.com ([216.40.44.69]:40336 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725873AbgHJROM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 13:14:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 720C2180A68C0;
        Mon, 10 Aug 2020 17:14:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pull72_170428b26fdb
X-Filterd-Recvd-Size: 1971
Received: from XPS-9350 (unknown [172.58.78.167])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Aug 2020 17:14:09 +0000 (UTC)
Message-ID: <ca88752c86bf8a42f9aa56b69df585542ea26622.camel@perches.com>
Subject: Re: [PATCH] USB: storage: isd200: fix spelling mistake "removeable"
 -> "removable"
From:   Joe Perches <joe@perches.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 10 Aug 2020 10:14:06 -0700
In-Reply-To: <20200810142547.GC299045@rowland.harvard.edu>
References: <20200810083211.48282-1-colin.king@canonical.com>
         <20200810142547.GC299045@rowland.harvard.edu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-10 at 10:25 -0400, Alan Stern wrote:
> On Mon, Aug 10, 2020 at 09:32:11AM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > There is a spelling mistake in a usb_stor_dbg debug message. Fix it.

This is an alternate spelling in a few dictionaries.
Is this an acceptable Briticism?
If so, I suggest no change.

> > diff --git a/drivers/usb/storage/isd200.c b/drivers/usb/storage/isd200.c
[]
> > @@ -1383,7 +1383,7 @@ static int isd200_scsi_to_ata(struct scsi_cmnd *srb, struct us_data *us,
> >  				ATA_CMD_MEDIA_LOCK : ATA_CMD_MEDIA_UNLOCK;
> >  			isd200_srb_set_bufflen(srb, 0);
> >  		} else {
> > -			usb_stor_dbg(us, "   Not removeable media, just report okay\n");
> > +			usb_stor_dbg(us, "   Not removable media, just report okay\n");
> >  			srb->result = SAM_STAT_GOOD;
> >  			sendToTransport = 0;
> >  		}
> > -- 
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

