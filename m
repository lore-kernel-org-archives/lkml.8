Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F197BC2BA1A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 09:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A3F206E9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 09:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585992197;
	bh=UugXHomrGMjeaRYQYJLHjXdfqAsEeVXQa5Ng6EM0r5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0z0lmshur+Q92GiBIdpN3lgfrO3cB6gPYd9FZKBSqT+Slct7uXq8L8XrWbxTcNNVT
	 rOCJiqhbvd5AEXb+SSq7BzriKRvMCKnuq19GHTVHoylBgT9z7VyKPYdULcLYAKtHm2
	 R7ONNezicVmxqwgk3FUxxpMNUZIodjSP1bVdsIMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDDJXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 05:23:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgDDJXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 05:23:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 560A720719;
        Sat,  4 Apr 2020 09:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585992192;
        bh=UugXHomrGMjeaRYQYJLHjXdfqAsEeVXQa5Ng6EM0r5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yWURUNjFaeHvQQ/R6RNuQ39Te/lVsOuy3a9WytDhxZXtvo8CNRp7lPS0n23w3NFy6
         8FJ/DZTG6L/BOWmfFDCYAah6m7PB7TFcVXBmJ9BlA4UAYojUt8q7oaH8LQXbs+8Nll
         krjMmOS0fcqK4V5uqFlpjg7V4lkN1b0AcN6w+5kQ=
Date:   Sat, 4 Apr 2020 11:23:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     madhuparnabhowmik10@gmail.com
Cc:     hariprasad.kelam@gmail.com, colin.king@canonical.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, andrianov@ispras.ru,
        stern@rowland.harvard.edu
Subject: Re: [PATCH] usb: host: u132-hcd: Remove u132_static_list and list
 head u132_list
Message-ID: <20200404092308.GB1110038@kroah.com>
References: <20200403181816.8115-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403181816.8115-1-madhuparnabhowmik10@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 11:48:16PM +0530, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> u132_static_list is a global list protected by u132_module_lock.
> It is read in the u132_hcd_exit() function without holding the lock
> thus may lead to data race.
> However, it turns out that this list isn't used for anything useful
> and thus it is okay to get rid of it.
> Thus, remove the u132_static_list from u132-hcd module.
> Also remove struct list_head u132_list from struct u132.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> ---
>  drivers/usb/host/u132-hcd.c | 10 ----------
>  1 file changed, 10 deletions(-)

Please properly version your patches, otherwise I have no idea what
changed from the previous one, nor do I know which patch to take over
which.

The instructions for how to do this is in the documentation.  Please fix
up and resend so I have a chance to know what to do...

thanks,

greg k-h
