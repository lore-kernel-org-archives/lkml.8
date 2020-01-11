Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEADC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 20:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D65208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 20:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578772939;
	bh=rZ14m4/Xf8VG4iosR3a8Y22bJ5hwOmuW1l+ZW+ePd1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RgFPmqzwp8HqeAOlE10BRpCTSLQQDmc7ewXYRjdflizZyVi0wbPKa1KDwJnBla49Q
	 ehjxKHRSBiDqBXlBsIevo//ncruUuTpCr4ibTCvY0LbBkbmbKbKk2KejaZTu5LpKg6
	 5CyYvnqGgiDyr/2w9ycchuOLAB+eSIDpMiY26R38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbgAKUCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 15:02:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731181AbgAKUCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 15:02:17 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D42F20866;
        Sat, 11 Jan 2020 20:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578772936;
        bh=rZ14m4/Xf8VG4iosR3a8Y22bJ5hwOmuW1l+ZW+ePd1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UrMJyuogI5VRAPX0mxzxAMSLAxpgCDFCAlr/CeXQZN+uFrTkORsB4v9uuH8Hokoc+
         RrQvapZDxRiebeTh+sTP/iyr7fjBBItBfF/YOlz+47HVBaQfWHVtKUZFuJuFCPlPH7
         9jMcJg6jgIQ0IvgG/90pn1N2eU4/KjQn9G84udJM=
Date:   Sat, 11 Jan 2020 21:01:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Colin King <colin.king@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/misc: ti-st: remove redundant assignment to
 variable i
Message-ID: <20200111200136.GC438314@kroah.com>
References: <20191202151352.55139-1-colin.king@canonical.com>
 <20191203072824.GA1765@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203072824.GA1765@kadam>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 10:28:24AM +0300, Dan Carpenter wrote:
> On Mon, Dec 02, 2019 at 03:13:52PM +0000, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The variable i is being initialized with a value that is never
> > read and it is being updated later with a new value in a for-loop.
> > The initialization is redundant and can be removed.
> > 
> > Addresses-Coverity: ("Unused value")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/misc/ti-st/st_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
> > index 2ae9948a91e1..6255d9b88122 100644
> > --- a/drivers/misc/ti-st/st_core.c
> > +++ b/drivers/misc/ti-st/st_core.c
> > @@ -736,7 +736,7 @@ static int st_tty_open(struct tty_struct *tty)
> >  
> >  static void st_tty_close(struct tty_struct *tty)
> >  {
> > -	unsigned char i = ST_MAX_CHANNELS;
> > +	unsigned char i;
> >  	unsigned long flags = 0;
> 
> I'm surprised that flags doesn't generate a warning as well.

Yes, flags should be not initialized as well.

Colin, can you resend a v2 with that added?

thanks,

greg k-h
