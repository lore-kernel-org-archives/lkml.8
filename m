Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C16C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF83920785
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584555825;
	bh=aZEDZJRdrXhE++b4T7A09QeifAD5cam+S1ZxdnS3pkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MWpd15VBYv1fFNZHOlknH1KWATMmZUJIqH373ocXx1yb8Y3pM8rbxZuRNVS4NTJyd
	 +ibQs2r+h2KZM9xeVjatcWZL40mx7FbS2NJlXdCCuUAyz77WAm4eppXFOmMmZzL3pV
	 itkOiN7woWj4zSXwGXeqWjkVPnLqVLTFRyjt8C44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCRSXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:23:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgCRSXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:23:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69E1A2077E;
        Wed, 18 Mar 2020 18:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584555823;
        bh=aZEDZJRdrXhE++b4T7A09QeifAD5cam+S1ZxdnS3pkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nCEGogAGA0oyySUCABWIV7CNnFz/PEdTbzV5FyZ6IYymyFiZPAdeNG2hbcHE13lGM
         jhsV0G4iIvYyPJ9b4nuOdz3SnpXh+3epIidbNmtfZc3OAlHHbeYAorcTocoWGhizGd
         vOfrAhn/INttfPs2++1NwDyoFBVgtho/+55WtUwg=
Date:   Wed, 18 Mar 2020 19:23:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] coresight: cti: Initial CoreSight CTI Driver
Message-ID: <20200318182341.GB3235688@kroah.com>
References: <20200309161748.31975-1-mathieu.poirier@linaro.org>
 <20200309161748.31975-2-mathieu.poirier@linaro.org>
 <20200318132241.GB2789508@kroah.com>
 <20200318181226.GA18359@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318181226.GA18359@xps15>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 12:12:26PM -0600, Mathieu Poirier wrote:
> > And shouldn't this just be a single value, this looks like it is 2
> > values in one line, that then needs to be parsed, is that to be
> > expected?
> 
> There is no shortage of files under /sys/device/ with output that needs parsing,

Then they need to be fixed.  Seriously, we've been doing this and
fighting this for 15 years, not giving up yet! :)


> but this can be split in two entries.

Please do.

> > Where is the documentation for this new sysfs file?
> 
> All the documentation for sysfs files are lumped together in a single patch [1]
> that is also part of this set.
> 
> [1]. https://lkml.org/lkml/2020/3/9/643

As I reported in the other email, that is not the correct format to use.

> 
> > 
> > > +const struct attribute_group *coresight_cti_groups[] = {
> > > +	&coresight_cti_group,
> > > +	NULL,
> > > +};
> > 
> > ATTRIBUTE_GROUPS()?
> 
> As with all the other coresight devices, groups are communicated to
> coresight_register() and added to the csdev->dev in that function.

Ah, ok, missed that, sorry.

> > > +static struct amba_driver cti_driver = {
> > > +	.drv = {
> > > +		.name	= "coresight-cti",
> > > +		.owner = THIS_MODULE,
> > 
> > Aren't amba drivers smart enough to set this properly on their own?
> > {sigh}
> 
> Would you mind indicating where?  builtin_amba_driver() calls
> amba_driver_register() and  that doesn't set the owner field.

Yes, it doesn't, I'm saying that the amba bus code should be fixed, not
that this is a bug here, just complaining in general :)

thanks,

greg k-h
