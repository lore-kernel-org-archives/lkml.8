Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED030C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C392F207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589789079;
	bh=555gxxgYUK0BvSeivXlIOSabu1asOA3rSNZFxdShzxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=caPAcg4R2Jb759fuwTQ42DocZtLHbbu7bILrnq76aHAWi3rMM+3lfuWX3dGj8ReJk
	 PC+xAF7XW0oNXWaqIVemuh4uZpyJQx4fJXeeKRd8hnDMKMVz3dYWmHZbilSzwWCzoN
	 7T8fvwevDuLTHNa/AjaV8FhVKGzqiiT08wPhIVM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgERIEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 04:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgERIEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 04:04:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11F1F20787;
        Mon, 18 May 2020 08:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589789077;
        bh=555gxxgYUK0BvSeivXlIOSabu1asOA3rSNZFxdShzxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zri4cu81dSmr76md7C8TlE8G25BRE/variqhiTaYE97z5z6mZ0sEN/jdwoHI/P0rj
         sNZowRUGTHD6TI4G3mziRWNMzgcVmWvQmELQFARqErlq749+wixGdRK4WSXV6tqzfA
         oGSOGM8dO4RU+4yNJW+we9KtH2TuzlsY7JT4E71s=
Date:   Mon, 18 May 2020 10:04:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        John Stultz <john.stultz@linaro.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] driver core: Expose device link details in sysfs
Message-ID: <20200518080435.GA3133037@kroah.com>
References: <20200518070607.104611-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518070607.104611-1-saravanak@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 12:06:07AM -0700, Saravana Kannan wrote:
> It's helpful to be able to look at device link details from sysfs. So,
> expose it in sysfs.
> 
> Say device-A is supplier of device-B. These are the additional files
> this patch would create:
> 
> /sys/class/devlink/device-A:device-B/
> 	flags
> 	supplier/ -> .../device-A/
> 	consumer/ -> .../device-B/
> 
> /sys/devices/.../device-A/
> 	consumer:device-B/ -> /sys/class/devlink/device-A:device-B/
> 
> /sys/devices/.../device-B/
> 	supplier:device-A/ -> /sys/class/devlink/device-A:device-B/
> 
> That way:
> To get a list of all the device link in the system:
> ls /sys/class/devlink/
> 
> To get the consumer names and links of a device:
> ls -d /sys/devices/.../device-X/consumer:*
> 
> To get the supplier names and links of a device:
> ls -d /sys/devices/.../device-X/supplier:*
> 
> For now, I'm just exporting "flags", supplier and consumer for each
> device link. But the goal is to expand it to "state", etc once the
> overall idea is accepted.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> Greg/Rafael,
> 
> Wanted to check if both of you are okay with the overall idea of
> exporting device link details through sysfs and if using a "struct
> device" is how you'd like to do it. I think this information would be
> helpful in debugging all kinds of suspend/resume, probe and power issues
> in a production system. I didn't want to spend more time on this patch
> before I got your okays.
> 
> I'm not too familiar with the right way to do kobjs and symlinks in
> sysfs -- so apologies any crazy code. But overall, the patch does create
> the layout I describe above and seems to work.

Looks sane to me, nice work.

> I could also remove kref and switch to using link_dev to keep track of
> refcount and releasing stuff, but I wasn't sure if we really needed the
> srcu implementation or not. So didn't remove it in this series and left
> it as is.

I would just leave that alone for now, as that would be a different
change here, right?

thanks,

greg k-h
