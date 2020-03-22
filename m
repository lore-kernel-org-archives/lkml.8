Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A3AC43332
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 07:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0458520774
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 07:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584863935;
	bh=eWjdMSV3Xt1zzPnKPS1H2YP8+k8sOMZZteG9XBHhj7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1y1QQjCTVYvOA/79w90XXk5Xr1bB0XKx+pTD/cCW3neRrM+8xzq7wYH3B6rHZGxuI
	 kVxy6lHkPKZhMUcv96CwShyQ5Wc2BAH4wj0b1aOge+zl8SvH6UgEXZYeCVF/J8vusK
	 wciukGqP7Hyr6ey3G0VR05G3/49kRx8bFJyYJteE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgCVH6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 03:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgCVH6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 03:58:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 990FB206F8;
        Sun, 22 Mar 2020 07:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584863933;
        bh=eWjdMSV3Xt1zzPnKPS1H2YP8+k8sOMZZteG9XBHhj7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bVGZ7shbaQ5BLOwPtynGKZyTw/ZRjcMkgWzPSoWdH5CweCwAr1Ax55WFQBS2Z3+Ij
         2vQwzICdeKtApLnSiY0U2MlWvW/OE+s78vRX7N6izBB7HsCDBnyGX8w2bU+UVYhY3i
         UvtJx37pR3IP/JZq1tY2UPmsj0ICqWwOeiyTYrGM=
Date:   Sun, 22 Mar 2020 08:58:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiujun Huang <anenbupt@gmail.com>
Cc:     syzbot <syzbot+df767d588771697b0433@syzkaller.appspotmail.com>,
        andreyknvl@google.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tranmanphong@gmail.com
Subject: Re: WARNING in hwahc_probe
Message-ID: <20200322075850.GA68214@kroah.com>
References: <0000000000001a033405a15e3acb@google.com>
 <CADG63jBdvJMAem7_VF3GbCUSXGRuFrrv6_GqFc=KcKkxcNebCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADG63jBdvJMAem7_VF3GbCUSXGRuFrrv6_GqFc=KcKkxcNebCA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 03:53:44PM +0800, Qiujun Huang wrote:
> The return value of snprintf is longer than expected if the string is
> truncated. Bytes need to be checked here.
> 
> diff --git a/drivers/staging/wusbcore/host/hwa-hc.c
> b/drivers/staging/wusbcore/host/hwa-hc.c
> index 8d959e9..1475a48 100644
> --- a/drivers/staging/wusbcore/host/hwa-hc.c
> +++ b/drivers/staging/wusbcore/host/hwa-hc.c

This file is no longer in the linux-next tree and will be deleted in the
next kernel release.

Also, no one has this hardware so there's no real security issue here at
all.

And finally, you forgot a signed-off-by line on your patch :(

thanks,

greg k-h
