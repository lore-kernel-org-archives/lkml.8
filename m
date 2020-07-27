Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DCAC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478D520838
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgG0WVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:21:49 -0400
Received: from ms.lwn.net ([45.79.88.28]:57956 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgG0WVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 18:21:48 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6464444A;
        Mon, 27 Jul 2020 22:21:48 +0000 (UTC)
Date:   Mon, 27 Jul 2020 16:21:47 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     davem@davemloft.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
        trivial@kernel.org
Subject: Re: [PATCH] devices.txt: document rfkill allocation
Message-ID: <20200727162147.1fd9de0f@lwn.net>
In-Reply-To: <20200726075327.GA25647@duo.ucw.cz>
References: <20200726075327.GA25647@duo.ucw.cz>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jul 2020 09:53:27 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Document rfkill allocation.
> 
> Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
> 
> diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
> index 2a97aaec8b12..763fedd94d7d 100644
> --- a/Documentation/admin-guide/devices.txt
> +++ b/Documentation/admin-guide/devices.txt
> @@ -375,8 +375,9 @@
>  		239 = /dev/uhid		User-space I/O driver support for HID subsystem
>  		240 = /dev/userio	Serio driver testing device
>  		241 = /dev/vhost-vsock	Host kernel driver for virtio vsock
> +		242 = /dev/rfkill	Turning off radio transmissions (rfkill)
>  
> -		242-254			Reserved for local use
> +		243-254			Reserved for local use
>  		255			Reserved for MISC_DYNAMIC_MINOR

Applied, thanks.

jon
