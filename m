Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0101C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C482A2073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583505596;
	bh=Q8hOzHiXsLoUkIZhLZGgf2uaBfqlTNX1s1ICarQV5vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qsO8JCzu1trgJRDhGSPXwBiTU/mcm5toJRJyvsNph10Kqg9x7mAKZXrLZP6SfG5Kg
	 vBjHfd9vQtiJ/xbWn7LTJY9NtJhVXl2D1GCwI4iRHtDrCJko1HmqulRy82wi75VY35
	 6ST5EnyWy/DePhDAjH6KyZABtEhtzHSEoLtYvrWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCFOjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:39:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgCFOjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:39:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 534DD2072D;
        Fri,  6 Mar 2020 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583505593;
        bh=Q8hOzHiXsLoUkIZhLZGgf2uaBfqlTNX1s1ICarQV5vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RDcchDAW9jD+G3zFkyjkgZTsqwnSaIU5oBBgOdKxyz7QbLKhG0iyTSBdW2yhvEFbL
         z6Azf13UK5mHwfq5kxgskmfWwOk+Q0p5de84p3PGgmYwG7ennJYaX53GHI9vu8smaL
         e74w8O0M1Y8QY94m3GyiOcmVTMQy/RlHcEsGzUCo=
Date:   Fri, 6 Mar 2020 15:39:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Angelo Dureghello <angelo.dureghello@timesys.com>
Cc:     linux-kernel@vger.kernel.org, Evgeniy Polyakov <zbr@ioremap.net>
Subject: Re: [PATCH] w1: ds2430: non functional fixes
Message-ID: <20200306143951.GA3830738@kroah.com>
References: <20200305183951.2647785-1-angelo.dureghello@timesys.com>
 <20200305184517.GA2141048@kroah.com>
 <CALJHbkBcv_On-QtoQ-9kecE7f+M_UP350DXTDfNax3eVcZne7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALJHbkBcv_On-QtoQ-9kecE7f+M_UP350DXTDfNax3eVcZne7w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 03:21:23PM +0100, Angelo Dureghello wrote:
> Hi all,
> 
> sorry, no intention to be rude, i replied previously to greg
> (email-bot message) only,
> without including all, just a mistake.
> 
> Was just about asking what to do to fix the issue reported by the bot.

Do what it says, break this up into at different patches (only do one
thing per patch, and fix the subject and changelog text to be contain
the needed information, based on the links to the documentation it
provided you.

thanks,

greg k-h
