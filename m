Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A280C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2882E21744
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596787174;
	bh=UXRsIM8QNpBC80p/onfTXy8WOG3QV+V96BbUa8GXvR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O6VU68ucBqhChRm7ieqB3Y4XlbukxeUv3gu6xfc9RvRbibLY7UdPUBl9s50kPkZ4C
	 kqj3AWPGYMCWJM2c6hyjYvyYLPkCq6joY3Fg1ypPqMXMMtjjpToqTmHtMp2GZfCmdB
	 lcU3upto4VSndzJ9pMYWqKyzfCa5yI9vECVW5V2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgHGH7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgHGH7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:59:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAC1C21744;
        Fri,  7 Aug 2020 07:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596787172;
        bh=UXRsIM8QNpBC80p/onfTXy8WOG3QV+V96BbUa8GXvR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eRY5OHZoalfIHUqyQKgFKaEYHiBxIUPPgbtI5dFbNZd7k0dtHKcL3y8HjqpnKG9RG
         q6Cr1EhzGJyrat06ysAPYhW620HrsFqlS/h6HKXWZg0kdI5rdhW1lTE12gkoHEhRY4
         b3EllKR/fxuJtGauhQbNVq4S/k/JDrt7UieR/ISg=
Date:   Fri, 7 Aug 2020 09:59:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak Kumar Singh <deesin@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, clew@codeaurora.org,
        mathieu.poirier@linaro.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        "open list:REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V7 2/4] rpmsg: Guard against null endpoint ops in destroy
Message-ID: <20200807075946.GA3049898@kroah.com>
References: <1593017121-7953-1-git-send-email-deesin@codeaurora.org>
 <1593017121-7953-3-git-send-email-deesin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593017121-7953-3-git-send-email-deesin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 10:15:19PM +0530, Deepak Kumar Singh wrote:
> From: Chris Lew <clew@codeaurora.org>
> 
> In RPMSG GLINK the chrdev device will allocate an ept as part of the
> rpdev creation. This device will not register endpoint ops even though
> it has an allocated ept. Protect against the case where the device is
> being destroyed.
> 
> Signed-off-by: Chris Lew <clew@codeaurora.org>
> Signed-off-by: Deepak Kumar Singh <deesin@codeaurora.org>
> Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>

Should this be marked for stable kernels?

And if so, what commit does this fix?  Any reason the Fixes: tag was not
used here?

And what happened to this series?  I don't see it in linux-next, did the
maintainer ignore it?

thanks,

greg k-h
