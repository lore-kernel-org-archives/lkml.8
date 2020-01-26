Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DADC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 18:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA8F2071A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 18:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580063438;
	bh=IeQGexIT5WZnRinFdIJYWHpbxRm7H11XzhptV9yLbpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1zMfDnMoaf1BYexwUcSU1KA7u5n1ZagHzxi2D8QmKaucZff/nL0ky0qzNuMJRQVW5
	 vSisVwvT81DxQ28H0Ig7s1xuqBj5rMdEJy0SwFbkuC/xW65xvK0qmkb+Xge2CElDV7
	 yb1ZJY13qZQdAlulgkcvXRcWSW+Clp8HiRcSyyPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAZSai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 13:30:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbgAZSah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 13:30:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA16C206F0;
        Sun, 26 Jan 2020 18:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580063437;
        bh=IeQGexIT5WZnRinFdIJYWHpbxRm7H11XzhptV9yLbpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OyPqZHwyhFaf1WhFfb67oyG03LfqZktOW7s0kdsxcEOx7zEeXVF8nz0yXZJkBIoLA
         +GB5nza4xPb4Ddkh/gzf9xNsoiMpp6kBYW/xBo8QGnUtT6/gfWQSJGrCeUG51U9lq+
         sbbX8jgApxNQZ8Q8n9duXUENZPQ+m/FaBDP6Y4Go=
Date:   Sun, 26 Jan 2020 19:30:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: greybus: fix fw is NULL but dereferenced.
Message-ID: <20200126183034.GA4086664@kroah.com>
References: <20200126083130.GA17725@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126083130.GA17725@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 02:01:30PM +0530, Saurav Girepunje wrote:
> Fix the warning reported by cocci check.

What is "cocci check"?

> Changes:
> 

Why add that line?

> In queue_work fw dereference before it actually get assigned.
> move queue_work before gb_bootrom_set_timeout.
> 
> As gb_bootrom_get_firmware () return NEXT_REQ_READY_TO_BOOT
> only when there is no error and offset + size is actually equal
> to fw->size. So initialized next_request to NEXT_REQ_GET_FIRMWARE
> for return in other case.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/staging/greybus/bootrom.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

As Johan said, there are a lot of really bad "static checking"
tools out there that can not properly parse C code.  Always verify by
hand what the tools said is wrong, really is an issue before sending a
patch out for something that is not correct.  This looks like you need
to use a better tool.

greg k-h
