Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CA5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 139CC206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594647281;
	bh=4/Ii7OKEjNLUXwutSsdeNHRAyBRktKgtQ/LgJoyu5I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WdVLZbe4N3ZpnDxrVWxuT6vF81dA2Aa4vj/KJOHexe5vaJhH8CgQ8fsVJ3bdSzF61
	 8gbdFAw+OB1bmJcg6er/II3DgI0gFIleO/fCvR8xeNBp1Vzm5kHaf7OE0mfFSCXjJg
	 MBxMJlxgmAuhzMIotmqScemdb4JfFQjnG1gM9nBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgGMNej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729805AbgGMNej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:34:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E374206F0;
        Mon, 13 Jul 2020 13:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594647279;
        bh=4/Ii7OKEjNLUXwutSsdeNHRAyBRktKgtQ/LgJoyu5I4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hLXxOMZIOTP7DENp/wJEFJfOmC48+2ZItUXBDkgUnH8GGoypLax1l1mSeUiXSOgxb
         9I7cdjPG2jQ+eQTEzsgn/JSWSUtImKliX6xzfMhJoh2FG7pKhcHnmd+PZL1GZpbNDa
         eFznIwS50H3XkJZ2lnn4JdEjOsAb2RWyBQesLRNk=
Date:   Mon, 13 Jul 2020 15:34:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] Staging: comedi: driver: Remove condition with no effect
Message-ID: <20200713133438.GA3122574@kroah.com>
References: <20200712070628.GA18340@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712070628.GA18340@saurav>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 12:36:28PM +0530, Saurav Girepunje wrote:
> Remove below warning in das1800.c
> WARNING: possible condition with no effect (if == else)
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/staging/comedi/drivers/das1800.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/das1800.c b/drivers/staging/comedi/drivers/das1800.c
> index f16aa7e9f4f3..7ab72e83d3d0 100644
> --- a/drivers/staging/comedi/drivers/das1800.c
> +++ b/drivers/staging/comedi/drivers/das1800.c
> @@ -1299,12 +1299,6 @@ static int das1800_attach(struct comedi_device *dev,
>  			outb(DAC(i), dev->iobase + DAS1800_SELECT);
>  			outw(0, dev->iobase + DAS1800_DAC);
>  		}
> -	} else if (board->id == DAS1800_ID_AO) {
> -		/*
> -		 * 'ao' boards have waveform analog outputs that are not
> -		 * currently supported.
> -		 */
> -		s->type		= COMEDI_SUBD_UNUSED;

What gave that warning?  The comment should show you why this is good to
keep as-is, right?

thanks,

greg k-h
