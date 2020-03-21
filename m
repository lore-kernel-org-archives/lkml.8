Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4169C43332
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 11:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A67A20754
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 11:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584788536;
	bh=r5lN5VjYmFqP9Ll27OwvfZvHkuA6f9d2W+KuXcYOUyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tdKn65Ae2vq7G6ee2jcvfM0rWAJpcnR5+dV6uMUoKSIRoTb4xnzWQwj5VeLYrRXY1
	 jIh0G1jy/rrqI6hQ69L086fIjdi52ZyZG2WBXqIi1zwweioH7zVik72B53MGxztGlL
	 bhYm5FHbFDoi4DESgc8Sw2j5EOAbx7eo+7gVLX+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgCULCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 07:02:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbgCULCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 07:02:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE09120663;
        Sat, 21 Mar 2020 11:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584788534;
        bh=r5lN5VjYmFqP9Ll27OwvfZvHkuA6f9d2W+KuXcYOUyM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZfR5H4WxwoXnxV9XqAGVXuz1Y5PtvbcNGIEmt7NExb93oi6D2l2H/Mp+MloaMainU
         Y5bj4HmB6TaGdv32XokbM9Tf7aMUpl9SLaVIlu86mKUK8jzs1AuMwCow9D+2rH7JyP
         wEKIfEaty8hnpdgtRo12koIe0pDjzioV10tJ3Rns=
Date:   Sat, 21 Mar 2020 11:02:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: core: Make mlock internal to the iio core
Message-ID: <20200321110210.635224c4@archlinux>
In-Reply-To: <5e72484b.1c69fb81.53f77.5a16@mx.google.com>
References: <5e72484b.1c69fb81.53f77.5a16@mx.google.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Mar 2020 21:41:51 +0530
Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:

> "mlock" should ideally only be used by the iio core. The mlock
> implementation may change in the future which means that no driver
> should be explicitly using mlock.
> 
> Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
Good idea.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  include/linux/iio/iio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index eed58ed2f368..e975020abaa6 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -492,7 +492,7 @@ struct iio_buffer_setup_ops {
>   * @buffer:		[DRIVER] any buffer present
>   * @buffer_list:	[INTERN] list of all buffers currently attached
>   * @scan_bytes:		[INTERN] num bytes captured to be fed to buffer demux
> - * @mlock:		[DRIVER] lock used to prevent simultaneous device state
> + * @mlock:		[INTERN] lock used to prevent simultaneous device state
>   *			changes
>   * @available_scan_masks: [DRIVER] optional array of allowed bitmasks
>   * @masklength:		[INTERN] the length of the mask established from

