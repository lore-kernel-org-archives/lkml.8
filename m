Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6E8C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 272F22077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587650575;
	bh=jKdXPUomqfZR0CqCjjcKzi+o77O8b/Frc0oIadgk3+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hbiwK8fNvkhQiXxdbHNwlXTT9D14lyISxfe4GyY1DtQAuURi411gugZS6TOGuejed
	 Kr+uxWtFdhgR+byksbVWXOG50OzIz7PUZLBVo9dwxv7skreM8xVXyZlZdIga2g419J
	 n5Bd/2gsqm09gEOui7gw7EB9hhpJxfnW+44Di05U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgDWOCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:02:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgDWOCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:02:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6B0E2077D;
        Thu, 23 Apr 2020 14:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587650572;
        bh=jKdXPUomqfZR0CqCjjcKzi+o77O8b/Frc0oIadgk3+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SxOVyaMp+5hLzmoT3fvEm2np4mKUcJF7r6hO4laKl4PUTZtZiE4wzGV/0oBMWYUJa
         mY8Zu08rJoA3kIqNAT6/rB16VniJGe/R3g8hFpC8DQXFY5OzqQC80300hXmKbf39E3
         0UqrEFaBEBrcPX3sv4YZkT02dj5+w835zeP6D4kM=
Date:   Thu, 23 Apr 2020 16:02:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zenyu@tuta.io
Cc:     johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] greybus: fix typo in GREYBUS help text
Message-ID: <20200423140250.GA4127839@kroah.com>
References: <M4NtmuK--3-2@tuta.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <M4NtmuK--3-2@tuta.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 10:28:10AM +0200, zenyu@tuta.io wrote:
> From: Zenyu Sy <zenyu@tuta.io>
> 
> Fix the article typo "an" -> "a" in Kconfig
> 
> Signed-off-by: Zenyu Sy <zenyu@tuta.io>
> ---
> base-commit: f5e94d10e4c468357019e5c28d48499f677b284f
> drivers/greybus/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/greybus/Kconfig b/drivers/greybus/Kconfig
> index b84fcaf8b..56cbd87fc 100644
> --- a/drivers/greybus/Kconfig
> +++ b/drivers/greybus/Kconfig
> @@ -3,7 +3,7 @@ menuconfig GREYBUS
>         tristate "Greybus support"
>         depends on SYSFS
>         ---help---
> -         This option enables the Greybus driver core.  Greybus is an
> +         This option enables the Greybus driver core.  Greybus is a
>           hardware protocol that was designed to provide Unipro with a
>           sane application layer.  It was originally designed for the
>           ARA project, a module phone system, but has shown up in other
> --
> 2.26.0

You can't send patches in html format, please use git send-email to do
this properly.

thanks,

greg k-h
