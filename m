Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739A9C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2939C2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599494300;
	bh=vyE2X1zQKzP1YNOY504/+A2IyiOqZJITaebb9PZflls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rjm8Ds1uB9lswVf/NAL1lYr65hYxKn3fd+3tJoVI0kbCPmzbM3aAn7ufx5KBAlX5Y
	 taifN5eXB3kT7xTFR/YZU62croWr7fSLln2qvLoPWnQTdGshNLCkcU9ae8qt8wnViI
	 2SkPMfvjRPb7o3V7RbLio81tkOYQ4lGTtDF40/1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgIGP6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:58:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730010AbgIGOua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:50:30 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02CC821481;
        Mon,  7 Sep 2020 14:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599489714;
        bh=vyE2X1zQKzP1YNOY504/+A2IyiOqZJITaebb9PZflls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c6hSYHs20N7asJxie1tfww4JQBkA2E6D0wkvqfpBxR6REkJBlWNdSnD0BGokzdT4l
         8FQxIwgIf1zsTzXYN8FnnKoBqJnlW6WjlPKXiD9ZcSdMdk6dD4ajO6FaxA1iJCtkaB
         l0gAZvE0zqwF3JbPujEb6oKOdpp5kkpqGisnALyw=
Date:   Mon, 7 Sep 2020 16:42:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
        stern@rowland.harvard.ed, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, alsa-devel@alsa-project.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Eli Billauer <eli.billauer@gmail.com>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Tsoy <alexander@tsoy.me>,
        "Geoffrey D. Bennett" <g@b4.vu>, Jussi Laako <jussi@sonarnerd.net>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Dmitry Panchenko <dmitry@d-systems.ee>,
        Chris Wulff <crwulff@gmail.com>,
        Jesus Ramos <jesus-ramos@live.com>
Subject: Re: [PATCH 01/10] USB: move snd_usb_pipe_sanity_check into the USB
 core
Message-ID: <20200907144209.GA3751762@kroah.com>
References: <20200902110115.1994491-1-gregkh@linuxfoundation.org>
 <20200902110115.1994491-2-gregkh@linuxfoundation.org>
 <s5hh7sg9rgq.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hh7sg9rgq.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 04:35:33PM +0200, Takashi Iwai wrote:
> On Wed, 02 Sep 2020 13:01:03 +0200,
> Greg Kroah-Hartman wrote:
> > 
> > snd_usb_pipe_sanity_check() is a great function, so let's move it into
> > the USB core so that other parts of the kernel, including the USB core,
> > can call it.
> > 
> > Name it usb_pipe_type_check() to match the existing
> > usb_urb_ep_type_check() call, which now uses this function.
> > 
> > Cc: Jaroslav Kysela <perex@perex.cz>
> > Cc: Takashi Iwai <tiwai@suse.com>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: Eli Billauer <eli.billauer@gmail.com>
> > Cc: Emiliano Ingrassia <ingrassia@epigenesys.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Alexander Tsoy <alexander@tsoy.me>
> > Cc: "Geoffrey D. Bennett" <g@b4.vu>
> > Cc: Jussi Laako <jussi@sonarnerd.net>
> > Cc: Nick Kossifidis <mickflemm@gmail.com>
> > Cc: Dmitry Panchenko <dmitry@d-systems.ee>
> > Cc: Chris Wulff <crwulff@gmail.com>
> > Cc: Jesus Ramos <jesus-ramos@live.com>
> > Cc: linux-usb@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: alsa-devel@alsa-project.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Reviewed-by: Takashi Iwai <tiwai@suse.de>

Thanks for the reviews of all of these.

greg k-h
