Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57268C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BBBB206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597735846;
	bh=Zii/iidjf7sBtv2hMWeEW5aoRhsRt7licNkclEoHalQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MFWqsCqUVPeXdf4VaLQe+RSTW22ejB4peJyCCMQmIj9cpAnsecQRW0ltUNR6tZVru
	 SyA5gmdXKf7EKggC0oYJWWUstXwfUSD55j6K/wxyP8yUbUnlV8dK4qTq6vMJWhNR3Q
	 mJXIWzjZEtzapup5JgQ6xAo9hyjodC8pLajsYLKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHRHap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgHRHao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:30:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0D8A206B5;
        Tue, 18 Aug 2020 07:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597735844;
        bh=Zii/iidjf7sBtv2hMWeEW5aoRhsRt7licNkclEoHalQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=upwVUrQlyfYcs8wgdKov1dmuqlL2PsTH6A8esdjI78GAemOn894tzbyi6+zcc6lax
         k3AXikO5RYWKF/I0fOMO70UsEPQgeZSs9iWusEpjhJ4jsem5pl2z5/4MoRjEYIFNc8
         /3VUkRIafk7PqopN5DucRjegZXbWhCzb9nrxraE8=
Date:   Tue, 18 Aug 2020 09:31:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: renesas-xhci: remove version check
Message-ID: <20200818073108.GE9254@kroah.com>
References: <20200818071739.789720-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818071739.789720-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:47:39PM +0530, Vinod Koul wrote:
> Some devices in wild are reporting bunch of firmware versions, so remove
> the check for versions in driver
> 
> Reported by: Anastasios Vacharakis <vacharakis@gmail.com>
> Reported by: Glen Journeay <journeay@gmail.com>
> Fixes: 2478be82de44 ("usb: renesas-xhci: Add ROM loader for uPD720201")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=208911
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
> Changes in v3:
>  - drop additional firmware versions and remove the check
> 
> Greg, this fixes regression for folks with preprogrammed controllers
> please mark as stable material

You could have done so by putting "Cc: stable..." in the s-o-b of the
kernel, why force me to do that by hand?

thanks,

greg k-h
