Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBFCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04CFE2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596096819;
	bh=T3biC8fAhba8MjviyL4yDR2M3+hNkwZbDpM/vWpmI00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p2bCs7X6W6Ua7P/aoRWoPXLu8AburpYbjH7l3cM851rljDY3F8FVlT67dXwm8Snew
	 EzPAL4lW2GeNa5/5dTAfHUR+d25EAnquTR5BAJNs085sZq6ylB91P+YpdC4xiM/ORN
	 aAYmW+Kf79a0d43EhMLXp3GBWg9EIKRlk5No8hA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgG3INi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730118AbgG3INV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:13:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1CD62250E;
        Thu, 30 Jul 2020 08:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096797;
        bh=T3biC8fAhba8MjviyL4yDR2M3+hNkwZbDpM/vWpmI00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vU/yDBA39szoRMbGom7ozuJIvFIPNFzLrQ0BLlhx2dTG07enfiuMrySWDyFrAUVar
         BhNT6lE8YWo/s20ztUPeX7hmEfPh74giY181mYbzBjcgg6BXZq793FEe/xqWWhKH+Z
         ay2rNqi+EBk8aq0gvZpcc7QavBvRwuUxH5l1hFk8=
Date:   Thu, 30 Jul 2020 10:06:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sheng Long Wang <china_shenglong@163.com>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, jan.kiszka@siemens.com,
        Wang Sheng Long <shenglong.wang.ext@siemens.com>
Subject: Re: [PATCH] usb-serial:cp210x: add support to software flow control
Message-ID: <20200730080639.GA216353@kroah.com>
References: <20200730075922.28041-1-china_shenglong@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730075922.28041-1-china_shenglong@163.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 03:59:22PM +0800, Sheng Long Wang wrote:
> From: Wang Sheng Long <shenglong.wang.ext@siemens.com>
> 
> When data is transmitted between two serial ports,
> the phenomenon of data loss often occurs. The two kinds
> of flow control commonly used in serial communication
> are hardware flow control and software flow control.
> 
> In serial communication, If you only use RX/TX/GND Pins, you
> can't do hardware flow. So we often used software flow control
> and prevent data loss. The user sets the software flow control
> through the application program, and the application program
> sets the software flow control mode for the serial port
> chip through the driver.
> 
> For the cp210 serial port chip, its driver lacks the
> software flow control setting code, so the user cannot set
> the software flow control function through the application
> program. This adds the missing software flow control.
> 
> Signed-off-by: Wang Sheng Long <shenglong.wang.ext@siemens.com>
> ---
>  drivers/usb/serial/cp210x.c | 118 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 113 insertions(+), 5 deletions(-)

What changed from the previous version of this patch?  That should be
described below the --- line and this is a v2, right?

thanks,

greg k-h
