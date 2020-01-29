Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71C7C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23DC20732
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580295016;
	bh=jHwJpm2yRmwh7TjlKXTA2UFU1Yy6KXRu81Yj3516AGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fZuQ+1ONcWWze5ngWh+7uZOGQLmr6DyyiaMJv/pJ4qDTQPTo3u43yn/UMC9zC5Z6m
	 R4OFMze29tieLTeZAe8J/3zuyLxhajXjQEdiM30DPKXrzXZ2g25EEvQHPjhCXoMQE6
	 6hypOrMUXARUzCq3LVnozwRfQwVpI15aJTJvamFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgA2KuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:50:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgA2KuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:50:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85E1720720;
        Wed, 29 Jan 2020 10:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580295015;
        bh=jHwJpm2yRmwh7TjlKXTA2UFU1Yy6KXRu81Yj3516AGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fjCiN/BJOb2/B7vg2e94h8DAzpYS3l38HMIdqnZ0MvLsLuQHXGF6CJ5LiGWk7Uy4n
         skUSY0DwR78Yh17dtmt5PHQnlqrlBCKpZ/rjIqjPXikOg1KWUUffnnvkONMO0jSVct
         r8eKt+0D1j/6ya7l0kBtiyMAQQbpZNhAP0Odd9dU=
Date:   Wed, 29 Jan 2020 11:50:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pragat Pandya <pragat.pandya@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, valdis.kletnieks@vt.edu,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 09/22] staging: exfat: Rename variable "Size" to "size"
Message-ID: <20200129105012.GA3884393@kroah.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
 <20200127101343.20415-10-pragat.pandya@gmail.com>
 <20200127115741.GA1847@kadam>
 <287916429826dd2f14d82f9b7b6b15a9cace2734.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <287916429826dd2f14d82f9b7b6b15a9cace2734.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 04:10:39PM +0530, Pragat Pandya wrote:
> On Mon, 2020-01-27 at 14:57 +0300, Dan Carpenter wrote:
> > On Mon, Jan 27, 2020 at 03:43:30PM +0530, Pragat Pandya wrote:
> > > Change all the occurences of "Size" to "size" in exfat.
> > > 
> > > Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
> > > ---
> > >  drivers/staging/exfat/exfat.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/staging/exfat/exfat.h
> > > b/drivers/staging/exfat/exfat.h
> > > index 52f314d50b91..a228350acdb4 100644
> > > --- a/drivers/staging/exfat/exfat.h
> > > +++ b/drivers/staging/exfat/exfat.h
> > > @@ -233,7 +233,7 @@ struct date_time_t {
> > >  
> > >  struct part_info_t {
> > >  	u32      offset;    /* start sector number of the partition */
> > > -	u32      Size;      /* in sectors */
> > > +	u32      size;      /* in sectors */
> > >  };
> > 
> > We just renamed all the struct members of this without changing any
> > users.  Which suggests that this is unused and can be deleted.
> > 
> > regards,
> > dan carpenter
> > 
> Can I just drop this commit from this patchset and do a separate patch
> to remove the unused structure?

Drop this one, and the other ones that touch this structure, and do a
separate patch.  This series needs fixing up anyway, I can't take it
as-is.

thanks,

greg k-h
