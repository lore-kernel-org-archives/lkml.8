Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F70DC3B190
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 23:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159B3217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 23:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581635769;
	bh=rW08PkD3bawUM51fT0UhBV73+zvSaOHJyfIyp4noBW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VKgUknxqPUjdJrYdJ8t8d2+1xigKJ/4QQfZCwPmf/4ujBWD7ifx9qEgGkWpyEIu5l
	 5OV8koYkmb+bQkE+2wHz5Qa/mMOvUpeiy4fTqsJyTripDtmioywlT1F57sYoWKQBB1
	 /M7vNAdC6yelvrck2jUgbYPDJyz1JWM1glDVWq/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgBMXQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 18:16:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgBMXQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 18:16:08 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B61F12082F;
        Thu, 13 Feb 2020 23:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581635767;
        bh=rW08PkD3bawUM51fT0UhBV73+zvSaOHJyfIyp4noBW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kdg999VNPM1iC6IuaSDxMUOa24uhFRFAt+35VJB19HfiOWKXGs3WhX2daWE/UNRMs
         9EgHu/utY9lmsSEt9xIDnvZYcBTvNJXQKzVlpHC8mrXIauC6eD25KryhrrcOETwCn2
         kgQxl1Gn5DvIVYeRZ8vkcXS4Lp7R5S6YWgmuwNW8=
Date:   Thu, 13 Feb 2020 15:16:07 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tyler Hicks <tyhicks@canonical.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH] Documentation/process: Swap out the ambassador for
 Canonical
Message-ID: <20200213231607.GA3925051@kroah.com>
References: <20200213214842.21312-1-tyhicks@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213214842.21312-1-tyhicks@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 09:48:42PM +0000, Tyler Hicks wrote:
> John Johansen will take over as the process ambassador for Canonical
> when dealing with embargoed hardware issues.

Can I get an ack from John to "prove" he is ok with this horrible task?  :)

thanks,

greg k-h
