Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C752C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3ADF2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578657069;
	bh=5VnBWlpMBpMuScJ4e9HWCpCMFraJwy9/+ewY+OyPWzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RUqni0v1NXqJ5EqGCZKv5HiPPhE6p4I5IYedLvfBqgyoho/U9TtsIgxJ0r+bFskmc
	 RjH2SCoSbK3bYYhCORCGd0V7fFi8yEo+hOeWFQAEittg/G5Pz8obpiOi1j113FjU5m
	 JRR8OG9WOFHYZdQ9856HWHtCOR4y1/iiRe7Cv76c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgAJLvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 06:51:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727689AbgAJLvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:51:08 -0500
Received: from localhost (83-84-126-242.cable.dynamic.v4.ziggo.nl [83.84.126.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 087252077C;
        Fri, 10 Jan 2020 11:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578657067;
        bh=5VnBWlpMBpMuScJ4e9HWCpCMFraJwy9/+ewY+OyPWzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nl6Sc3yLv2vL4XrBvEbVsSXjsVvNvudmPJV1LaDWG6qnrY1+6nbV9lFMBQY3n0Lza
         5YdVaVlWFfbvvzIIRGpYfZaVNp/2vmCUGkTg/TiuvwjAQADB3BqXbETWg8arikFn/j
         lZdu+4QaOrzOeInDOnQiHOCULlvhz+nfCW4Ty9uU=
Date:   Fri, 10 Jan 2020 12:51:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 118/219] rfkill: allocate static minor
Message-ID: <20200110115104.GA899301@kroah.com>
References: <20191229162508.458551679@linuxfoundation.org>
 <20191229162526.353368525@linuxfoundation.org>
 <20200110110033.GA11563@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110110033.GA11563@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 12:00:33PM +0100, Pavel Machek wrote:
> On Sun 2019-12-29 18:18:40, Greg Kroah-Hartman wrote:
> > From: Marcel Holtmann <marcel@holtmann.org>
> > 
> > [ Upstream commit 8670b2b8b029a6650d133486be9d2ace146fd29a ]
> > 
> > udev has a feature of creating /dev/<node> device-nodes if it finds
> > a devnode:<node> modalias. This allows for auto-loading of modules that
> > provide the node. This requires to use a statically allocated minor
> > number for misc character devices.
> > 
> > However, rfkill uses dynamic minor numbers and prevents auto-loading
> > of the module. So allocate the next static misc minor number and use
> > it for rfkill.
> 
> Is this good idea for stable?

Yes.

> I don't see this major/minor allocated in devices.txt in
> mainline. Should something like this be added?
> 
> Signed-off-by: Pavel Machek <pavel@denx.de>

Good idea, can you resend this as a "real" patch so that I can apply it?

thanks,

greg k-h
