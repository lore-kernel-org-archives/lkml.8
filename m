Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6F9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98ED9208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvAAbM3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgFQQaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:30:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32327 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726873AbgFQQaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592411418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1gl38ZIWtqPJzo0qG7cpW4/TOD8j71KgD8Itx/SdC58=;
        b=DvAAbM3a/BsOk431epaaWOXmRAuh4AJNGAoVjOfOLucTIZeIdYnvoSb6COPEApEs7r+RE3
        6vqO17mmH6OFnnZsdru4Plj/wmbiHMmqI1Ba9LWNrqZYor4wRH0Jq8wNq2vluqwV9ud84r
        vIi2RUYi+l6F1tjT/ZFw6JK5ZYRS3K4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-TCGmiqeLOzyLqF3Wr-QGiA-1; Wed, 17 Jun 2020 12:30:16 -0400
X-MC-Unique: TCGmiqeLOzyLqF3Wr-QGiA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46C9010753F5;
        Wed, 17 Jun 2020 16:30:09 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C7985C1D4;
        Wed, 17 Jun 2020 16:30:09 +0000 (UTC)
Date:   Wed, 17 Jun 2020 12:30:08 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: dm ioctl: Use struct_size() helper
Message-ID: <20200617163008.GA12083@redhat.com>
References: <20190828183825.GA4216@embeddedor>
 <885e7ea3-b29a-eba0-569e-64760102016e@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <885e7ea3-b29a-eba0-569e-64760102016e@embeddedor.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16 2020 at  6:06pm -0400,
Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:

> Hi all,
> 
> Friendly ping: who can take this?
> 
> It's been almost a year... and I just noticed there was a problem
> with the email addresses back then...
> 
> I just fixed the issue and this patch should now appear on
> dm-devel@redhat.com and LKML.

I don't see any resubmit from you on either list.  But I've applied the
fix by hand and attributed it to you.

Thanks,
Mike


> On 8/28/19 13:38, Gustavo A. R. Silva wrote:
> > One of the more common cases of allocation size calculations is finding
> > the size of a structure that has a zero-sized array at the end, along
> > with memory for some number of elements for that array. For example:
> > 
> > struct dm_target_deps {
> > 	...
> >         __u64 dev[0];   /* out */
> > };
> > 
> > Make use of the struct_size() helper instead of an open-coded version
> > in order to avoid any potential type mistakes.
> > 
> > So, replace the following form:
> > 
> > sizeof(*deps) + (sizeof(*deps->dev) * count)
> > 
> > with:
> > 
> > struct_size(deps, dev, count)
> > 
> > This code was detected with the help of Coccinelle.
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > ---
> >  drivers/md/dm-ioctl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> > index fb6f8fb1f13d..b2d52cec70d4 100644
> > --- a/drivers/md/dm-ioctl.c
> > +++ b/drivers/md/dm-ioctl.c
> > @@ -1446,7 +1446,7 @@ static void retrieve_deps(struct dm_table *table,
> >  	/*
> >  	 * Check we have enough space.
> >  	 */
> > -	needed = sizeof(*deps) + (sizeof(*deps->dev) * count);
> > +	needed = struct_size(deps, dev, count);
> >  	if (len < needed) {
> >  		param->flags |= DM_BUFFER_FULL_FLAG;
> >  		return;
> > 
> 

