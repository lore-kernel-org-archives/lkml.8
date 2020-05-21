Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D069C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B7C2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590054171;
	bh=HLNBPlMIwcyPLxoXQ3ROr7zGCgI47fgKzS7fsLAAHnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oEagyGx14aDBZULiCLAYAPF6K6XuQT2X47+8H+N6xiz+FXmnPYwD2r/2yuJ7e5ctU
	 LAjO+DMzPh0nyblx9MzKTLseZFr5oKL8SjcPbXeOD3Ciu1IlKyiYK5ZuFPSUFXm6jY
	 RMzMJRD7YPWihiyuoTJ2grSc5CfK9BIaGVBdftrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgEUJmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728789AbgEUJmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:42:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52E0820721;
        Thu, 21 May 2020 09:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590054169;
        bh=HLNBPlMIwcyPLxoXQ3ROr7zGCgI47fgKzS7fsLAAHnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JAO8ol+vUu00FCzxprbBF8gkgEhqxuQb/PPWFKSvajF9lFxezKDlFTvKujh3Sq06J
         tltLMIywU2yZlJLJqAu5nz1nJR5GDyQt5j6gPilCVbsA7iRCJ6oErk9ZKJqJ/E+7+7
         DEHf5hm7RHianqFiuncmVk8tLeBE33e+nBV6EW0U=
Date:   Thu, 21 May 2020 11:42:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v2 0/4] driver core: Add device link related sysfs files
Message-ID: <20200521094247.GA2861894@kroah.com>
References: <20200520034824.79049-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520034824.79049-1-saravanak@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 08:48:20PM -0700, Saravana Kannan wrote:
> With fw_devlink and with sync_state() callback features, there's a lot
> of device/device link related information that's not available in sysfs.
> 
> Exposing these details to user space can be very useful in understanding
> suspend/resume issues, runtime pm issues, probing issues, figuring out
> the modules that'd be needed for first stage init, etc. In fact, an
> earlier verion of this series was very helpful in debugging and
> validating the recent memory leak fix[1].
> 
> This series combines combines a bunch of patches I've sent before.
> 
> I'm aware that I haven't added documentation for patch 1/2. I'm waiting
> on review to make sure the file location, name and values don't change
> before I add the documentation.

You mean patch 2/4, right?

> This series is based on driver-core-next and [1] cherry-picked on top of
> it.

I've taken patch 1 now, as it was easy to review :)

I'll wait for the next series with the documentation update before going
further.

thanks,

greg k-h
