Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C56C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2626D207DA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591167028;
	bh=3l7TMZy0dkIcAxTaqluxLc6yZSpowQHh7l0jSHXXhjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EKPIFp/suYY3Pst+XYRHIgp2kHtwg5rMU8+13lDYndTMOGqmJevOeWjzQZD75R0du
	 AhxY08HwXAz9zi+GTCvDZdkHi8P9s+mbBeHqxv0rpTnfBxH23qSXFT/S2nxLkUe7WQ
	 7Rt+uFam5c2LrBQjP5/brUOmwTC4xSr2IB6Nexr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgFCGu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 02:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgFCGu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 02:50:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18B5D2068D;
        Wed,  3 Jun 2020 06:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591167026;
        bh=3l7TMZy0dkIcAxTaqluxLc6yZSpowQHh7l0jSHXXhjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zt5wWn8k8xqW8a7aqFKlDhp0W7XsKc9rm9ancnmCAsW3pxTs0oBfoxOCAuU2ZybWw
         pPBePWbiFZCbUWuiJdegf+TO3xZM8xrkDo9tUbPOqAKIqdP6etuiAGAWlICj01cX1s
         FH64hh6B64ddM7UHr2aCuNB2psSg8bGA9oFzsa5s=
Date:   Wed, 3 Jun 2020 08:50:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "wanghai (M)" <wanghai38@huawei.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        linuxppc-dev@lists.ozlabs.org,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Ian Munsie <imunsie@au1.ibm.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cxl: Fix kobject memory leak in cxl_sysfs_afu_new_cr()
Message-ID: <20200603065024.GA587198@kroah.com>
References: <b9791ff3-8397-f6e9-ca88-59c9bbe8c78f@web.de>
 <25ad528b-beaf-820f-9738-ea304dcbc0d7@huawei.com>
 <20200603061443.GB531505@kroah.com>
 <20ae5516-7e41-f706-46ba-955e1936f183@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20ae5516-7e41-f706-46ba-955e1936f183@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 02:34:07PM +0800, wanghai (M) wrote:
> 
> 在 2020/6/3 14:14, Greg Kroah-Hartman 写道:
> > On Wed, Jun 03, 2020 at 09:42:41AM +0800, wanghai (M) wrote:
> > > 在 2020/6/3 1:20, Markus Elfring 写道:
> > > > > Fix it by adding a call to kobject_put() in the error path of
> > > > > kobject_init_and_add().
> > > > Thanks for another completion of the exception handling.
> > > > 
> > > > Would an other patch subject be a bit nicer?
> > > Thanks for the guidance, I will perfect this description and send a v2
> > Please note that you are responding to someone that a lot of kernel
> > developers and maintainers have blacklisted as being very annoying and
> > not helpful at all.
> > 
> > Please do not feel that you need to respond to, or change any patch in
> > response to their emails at all.
> > 
> > I strongly recommend you just add them to your filters to not have to
> > see their messages.  That's what I have done.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > .
> 
> Okay, so I don’t have to send the v2 patch.

No, all should be fine, I'll review the patch when after 5.8-rc1 is out,
and if I find any problems with it, will let you know then.

thanks,

greg k-h
