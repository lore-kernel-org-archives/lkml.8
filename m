Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0783C33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80C72082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579295664;
	bh=OS7yVO2N6BDDdHCe/tuw7AF3sNjZ1YfY9NXe0Sml+nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G0X2h86sTlmPv0h768ize4/iwUkgSuOaUxOtKid2XOF2HNHxl30tdDAfaDlqO9bQE
	 y2wXEFmMKPwE1Y9duA4DcYL1VzzGgCiLN2CxTs34z1R+yAlWcc9x1yDllNokt3zHBw
	 xV7v58TwuedRJVoj15uyNmIjAqdXpssMekSOvanA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgAQVOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:14:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgAQVOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 16:14:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7190820748;
        Fri, 17 Jan 2020 21:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579295662;
        bh=OS7yVO2N6BDDdHCe/tuw7AF3sNjZ1YfY9NXe0Sml+nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y74wESVeAfeNLVHeRVBf/+nfKeyMgbscXlK4eJ6NVy4KMvwkUF9e04+4DegV98Oje
         aiw2NOlFvwFSeT2VOWw/h53pmLOJY9Bjlcd6UBajXgFwSqxMlib/fQf/RqnFDkZNCs
         ZNjGlyPzHp4FqcL3o0hvZ/80ZByIBTYbrP3t0350=
Date:   Fri, 17 Jan 2020 22:14:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware_loader: load files from the mount namespace of
 init
Message-ID: <20200117211419.GA2042215@kroah.com>
References: <bb46ebae-4746-90d9-ec5b-fce4c9328c86@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb46ebae-4746-90d9-ec5b-fce4c9328c86@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 08:36:13PM +0200, Topi Miettinen wrote:
> Hi,
> 
> I have an experimental setup where almost every possible system service
> (even early startup ones) runs in separate namespace, using a dedicated,
> minimal file system. In process of minimizing the contents of the file
> systems with regards to modules and firmware files, I noticed that in my
> system, the firmware files are loaded from three different mount namespaces,
> those of systemd-udevd, init and systemd-networkd. The logic of the source
> namespace is not very clear, it seems to depend on the driver, but the
> namespace of the current process is used.
> 
> So, this patch tries to make things a bit clearer and changes the loading of
> firmware files only from the mount namespace of init. This may also improve
> security, though I think that using firmware files as attack vector could be
> too impractical anyway.

I like this, but:

> Later, it might make sense to make the mount namespace configurable, for
> example with a new file in
> /proc/sys/kernel/firmware_config/. That would allow a dedicated file system
> only for firmware files and those need not be present anywhere else. This
> configurability would make more sense if made also for kernel modules and
> /sbin/modprobe. Modules are already loaded from init namespace
> (usermodehelper uses kthreadd namespace) except when directly loaded by
> systemd-udevd.

I think you answered your question of why firmware is loaded from the
namespace of systemd-udevd at times, it happens due to a module being
asked to be loaded which then called out and asked for firmware as part
of its probe process.

Now saying that the firmware load namespace is going to be tied always
to the modprobe namespace is problematic, as we can't guarantee that
will always happen for all bus and driver types.

So resetting this all back to the init namespace seems to make sense to
me, and odds are it will not break anything.

But, as you are adding a new firmware feature, any chance you can write
an additional test to the firmware self-tests so that we can verify that
this really is working the way you are saying it does, so we can trust
it and verify it doesn't break in the future?

thanks,

greg k-h
