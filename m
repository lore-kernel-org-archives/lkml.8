Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FC5C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3711F204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599227327;
	bh=pM3S1MrLDgxr104HS1EiOao8hUpIKJ+xLNu70rNDZ4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S4lcSqOkBz7NNBmwXNNW6dhIC/gli3mJQK+QzRW7NFy4dDLFEks7DL6BKNVtgmMoE
	 S0OIrYTx9EZ0wlAoCd0+uaH897w4shsAFS5VzWLEAv8J5XvrA/sOEdOnkri+yYXUuT
	 iNlkO7bxeXEMPQ9MsBwRGakj1TvsOlzJ5W9N1Ijc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbgIDNsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:48:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730212AbgIDNp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:45:28 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A15F2078E;
        Fri,  4 Sep 2020 13:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599226661;
        bh=pM3S1MrLDgxr104HS1EiOao8hUpIKJ+xLNu70rNDZ4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c5YhjmlfONEW+0oM0PU7iT2RQQ/O0HgsobSnWJotCpmKCHu8ihA+BysrVWSjDJSGi
         2FIIwYnC+katYJvnZakhX3/tuHEpncjwR/D38szuzqtAIDaqtjIKhNtbKxo2HPv3gf
         Wz+MTZJbAOsFkANYFcPSyq0h2mglcioAr2CgwTP8=
Date:   Fri, 4 Sep 2020 15:38:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Antoni Przybylik <antoni.przybylik@wp.pl>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: gdm724x: gdm_tty: replaced macro with a
 function
Message-ID: <20200904133803.GA3165130@kroah.com>
References: <20200902161627.64686-1-antoni.przybylik@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902161627.64686-1-antoni.przybylik@wp.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 06:16:27PM +0200, Antoni Przybylik wrote:
> Changed return type to bool and removed inline specifier. Also added
>  static specifier.
> 
> Signed-off-by: Antoni Przybylik <antoni.przybylik@wp.pl>
> ---
>  drivers/staging/gdm724x/gdm_tty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You sent 2 patches with the identical subject line, yet they did
different things :(

Please fix them both up and resend.

thanks,

greg k-h
